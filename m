Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686234F16A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376731AbiDDOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376709AbiDDOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:01:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6063F21AA;
        Mon,  4 Apr 2022 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649080778; x=1680616778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKfh241QAD2DpKgQi+tBTRlVd0XcQF1nqdPmMijRJ/I=;
  b=kSJ0wFeixb/C1nNIzNcI8wO/xl6JRyd/i3RZSc8x6W+2NmE2zzsgTNUC
   LSz2gO/M+FNZVO5GC7/cFc6ucPvzwd5ejGNPMJWTG0IMMy60vEOzmWLTu
   HSsLFdD+9IFo0mHDIOA6MUaq+XRhEe+4Ldtxf9m9/pm4ZGoxgBYeexMlp
   dYpJn7fbu+9JjoqSPmIoA9cA2iIEsMCGvcxQBWSnqBu2e9zUAkZeixheN
   T/8vt2GaIzN2JNCCnn/5CKPOrFMXaFjx+mVaD1gr0LIHRe7O/Kb61gS8d
   zV/MX7J1m1/2asvPRpRT//Zu/j+wCi4PB7KgsQrMCPNUiTgUicpIIRJiY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="285468243"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="285468243"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696576079"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 06:59:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 16:59:33 +0300
Date:   Mon, 4 Apr 2022 16:59:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH 5/7] usb: typec: tipd: Provide POWER_SUPPLY_PROP_PRESENT
Message-ID: <Ykr5xT5h/cD+4E0c@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-6-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317154518.4082046-6-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:45:16PM +0100, Sebastian Krzyszkowiak wrote:
> This allows userspace and downstream supplies to know whether
> something is plugged in.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index f3e8f1183f5b..874528b02a99 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -108,6 +108,7 @@ struct tps6598x {
>  static enum power_supply_property tps6598x_psy_props[] = {
>  	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_VOLTAGE_MAX,
>  };
> @@ -756,6 +757,9 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		ret = tps6598x_psy_get_online(tps, val);
>  		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = !!tps->partner;
> +		break;
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  		ret = tps6598x_psy_get_max_current(tps, val);
>  		break;
> -- 
> 2.35.1

-- 
heikki
