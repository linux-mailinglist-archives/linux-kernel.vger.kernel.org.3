Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628104C0E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiBWIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiBWIxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:53:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CBD65780;
        Wed, 23 Feb 2022 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645606396; x=1677142396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gf7fLnuz2/+PWrNrtqGk1PKFdI0hQYHsrfCkNF3N2OE=;
  b=wfa74g05p79C6sjxL3xJ82DiO5q4vDUA2aprhaAcKbq0sipbcQXCuCJV
   UDz7Xo4806bIa+1v5X9/tdXNYEaROAPRUZR+eXa1ePKaA1OAhubZpKYP1
   purYunz0Zl500zH4BtKtISVV7cRteONTGkwwVO2JbFmg07PPSdVZXA0pf
   4FGkpPbi0k0eEValV5eQDH+9khs4ZH2XnSMbHsdodl3G69hkH02q4PDji
   J9Wj3A3JLktAqqQrDiXRyleiSpmFCVwbkl9PHMh1PmxYFyzpj+t2j0lnW
   Q8dZXQDI5xIU3dQrtkaQI0OAX9ieIE8SVZC9OaL8lLLUV3hgFTMGwQu4+
   A==;
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="149703384"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2022 01:53:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Feb 2022 01:53:14 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 23 Feb 2022 01:53:09 -0700
From:   <conor.dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>,
        <krzysztof.kozlowski@canonical.com>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <aou@eecs.berkeley.edu>, <atishp@rivosinc.com>, <brgl@bgdev.pl>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <geert@linux-m68k.org>,
        <ivan.griffin@microchip.com>, <jassisinghbrar@gmail.com>,
        <lee.jones@linaro.org>, <lewis.hanly@microchip.com>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-rtc@vger.kernel.org>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>,
        <robh@kernel.org>, <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Date:   Wed, 23 Feb 2022 08:55:10 +0000
Message-ID: <20220223085509.3664942-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223082018.degrftmxpk5uc6xn@pengutronix.de>
References: <20220223082018.degrftmxpk5uc6xn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 08:20, Uwe Kleine-König wrote:
> On Wed, Feb 23, 2022 at 08:12:49AM +0100, Krzysztof Kozlowski wrote:
> > On 23/02/2022 07:20, Uwe Kleine-König wrote:
> > > On Mon, Feb 14, 2022 at 01:58:35PM +0000, conor.dooley@microchip.com wrote:
> > >> From: Conor Dooley <conor.dooley@microchip.com>
> > >>
> > >> Add device tree bindings for the Microchip fpga fabric based "core" PWM
> > >> controller.
> > >>
> > >> Reviewed-by: Rob Herring <robh@kernel.org>
> > >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > 
> > > I like it:
> > > 
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > nitpick: Put your S-o-b last in the commit log. (This doesn't justify a
> > > resend IMHO)
> > 
> > It should be the opposite - the first. First author signs the patch,
> > then comes review and finally an ack. Putting SoB at then suggests that
> > tags were accumulated before sending patch, out of mailing list.
> 
> well, or in an earlier revision of this patch as is the case here. One
> of the ideas of S-o-b is that the order shows the flow of the patch
> states and if this patch ends in git with:
> 
> 	Referred-by: Rob Herring <robh@kernel.org>
> 	Singed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 	Backed-by: Palmer Dabbelt <palmer@rivosinc.com>
> 	Singed-off-by: Peter Maintainer <pm@example.com>
> 
> I'd expect that Backed-by was added by Peter, not Conor.
> (Modified the tags on purpose to not interfere with b4's tag pickup, I
> guess you humans still get the point.)

I had put the acks after the S-o-B for patches I hadn't changed since the ack,
but I think that may have been a misinterpretation of what was meant by Rob
when he said tags should be in chronological order. Won't do it this way in
the future.

If the remaining patch gets a maintainer ack, the order will be fine I guess
since it'll be Palmer taking it anyway. If there's a v8, I will fix the order.

Thanks,
Conor
