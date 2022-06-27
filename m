Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEB55D399
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiF0IOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiF0IOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:14:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BB6265;
        Mon, 27 Jun 2022 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656317681; x=1687853681;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qY1j80KT3SlS5urOwaGuqpU9KZ42BFvHtfekqn6Y8R4=;
  b=BbtMdfkvvcj9+uE425RBTGcYnO2MTIbz4bPKmvYkgs4hmDuyx5K+fV8K
   Q+d6yjpeG3xwcZrhIbl3zHSO8OpSZZHpGOcKmtPSWO6w6SOCo57Tn98I8
   hyqWUdNvXe+QbMo24oqcbXro6Isl1sr7/QBcaWUFcGNebAFwrfh8FVwwm
   p2qZT9JDnQpkodv9xSXitVKRiFjvtj4Bd54uj2XHRIVR29kFGUwyd7woK
   YpXsRWazp97jv523cpr+PqPEohxOGMNK64aoEWuySS58BtMlNDGGcBSvG
   zb5G5i1/oZlNZgXwdpSPj5x3x9VfCW3m9t5BucSpsdziDHb3iqjH7S0fl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="367709141"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="367709141"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 01:14:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="646328063"
Received: from gretavix-mobl3.amr.corp.intel.com ([10.249.43.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 01:14:37 -0700
Date:   Mon, 27 Jun 2022 11:14:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 7/8] serial: ar933x: Remove redundant assignment in
 rs485_config
In-Reply-To: <df19d91d-371b-f0e9-e37c-2bde00d2b840@gmx.de>
Message-ID: <033c8d2-3f2e-afe6-2e98-14a61c872b4b@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-8-LinoSanfilippo@gmx.de> <f7beef4-c422-cae3-8e22-8652b407434@linux.intel.com> <df19d91d-371b-f0e9-e37c-2bde00d2b840@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-658645688-1656317683=:1622"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-658645688-1656317683=:1622
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 26 Jun 2022, Lino Sanfilippo wrote:

> On 25.06.22 at 12:14, Ilpo Järvinen wrote:
> > On Wed, 22 Jun 2022, Lino Sanfilippo wrote:
> >
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> In uart_set_rs485_config() the serial core already assigns the passed
> >> serial_rs485 struct to the uart port.
> >>
> >> So remove the assignment in the drivers rs485_config() function to avoid
> >> redundancy.
> >>
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >> ---
> >>  drivers/tty/serial/ar933x_uart.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
> >> index ab2c5b2a1ce8..857e010d01dc 100644
> >> --- a/drivers/tty/serial/ar933x_uart.c
> >> +++ b/drivers/tty/serial/ar933x_uart.c
> >> @@ -591,7 +591,6 @@ static int ar933x_config_rs485(struct uart_port *port,
> >>  		dev_err(port->dev, "RS485 needs rts-gpio\n");
> >>  		return 1;
> >>  	}
> >> -	port->rs485 = *rs485conf;
> >>  	return 0;
> >>  }
> >
> > Hmm, I realize that for some reason I missed cleaning up this particular
> > driver after introducing the serial_rs485 sanitization. It shouldn't need
> > that preceeding if block either because ar933x_no_rs485 gets applied if
> > there's no rts_gpiod so the core clears SER_RS485_ENABLED.
> 
> I think we still need that "if" in case that RS485 was not enabled at driver
> startup (no rs485-enabled-at-boot-time) and no RTS GPIO was defined but then
> RS485 is enabled via TIOCSRS485.
> 
> Maybe in ar933x_uart_probe()
> 
> 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
> 	    !up->rts_gpiod) {
> 		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
> 		port->rs485.flags &= ~SER_RS485_ENABLED;
> 		port->rs485_supported = &ar933x_no_rs485;
> 	}
> 
> should rather be

I think it would be better (and what I should have done while moving the 
check there in the first place but I missed it). In addition, however, it 
would be useful to not print unnecessarily:

> 	if (!up->rts_gpiod) {

if (port->rs485.flags & SER_RS485_ENABLED) {

> 		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
> 		port->rs485.flags &= ~SER_RS485_ENABLED;

}

> 		port->rs485_supported = &ar933x_no_rs485;
> 	}

-- 
 i.

--8323329-658645688-1656317683=:1622--
