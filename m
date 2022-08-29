Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572A5A4F24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiH2O0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiH2O0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:26:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2D68000C;
        Mon, 29 Aug 2022 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661783197; x=1693319197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FyvJKZ/FWxFaZvEWDEmNEu+M3JS/Cae8gERyT2MCqIY=;
  b=N5yb8Z85DEF0u3951mrfp5fvjPOAECwfjaN+J0VuS2gJ3Xo52tmIxGMz
   mSBC8u1Gsly5LIm5b0QJQsdv5R5h4kCSHJ2nV3ABJ5WP3IODIFCreQ/2n
   jEaD6zhdTHbjp2ZuVcWJ8GjFx5bmzf+f6rEQPa2b8c/GuEMnSdqllsXaz
   WZ6Hk86gEf4qgzgEvkN2cRBY73/EgQomwgn0VVjg/6RTJ3viBNKGQKN25
   1/9GcdG2Mz1SiPACloIuLFn3IHAq9z1hyquEaWuuhIQEoojBlpTGK6ech
   DDGH8Zux2TQrFdqO8DOphMKOf6NbffZDvdloCRIGepVijZJMCu1EWOxn1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="358868116"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="358868116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="753644690"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 29 Aug 2022 07:24:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Aug 2022 17:24:13 +0300
Date:   Mon, 29 Aug 2022 17:24:13 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     cgel.zte@gmail.com
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next v3] usb: typec: tcpm: tcpci: Remove the
 unneeded result variable
Message-ID: <YwzMDdzfo58hufmd@kuha.fi.intel.com>
References: <20220829030442.264695-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829030442.264695-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 29, 2022 at 03:04:43AM +0000, cgel.zte@gmail.com wrote:
> From: xupanda <xu.panda@zte.com.cn>

I think that's a pseudonym. Is the name "Xu Panda" (so not
"xupanda")? Please use full real names.

> Return the value regmap_update_bits() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xupanda <xu.panda@zte.com.cn>

I just realised that this is version 3, and this is the third time you
are being asked to check that. You really have to use full real names
here.

Please read this section completely and fix those lines:
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

thanks,

> ---
> chang for v3
>  - re-align continuation line alignment
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index b2bfcebe218f..cd243530264b 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> -	int ret;
>  
> -	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
> -				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
> -	return ret;
> +	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
> +			enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
>  }
>  
>  static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> -- 
> 2.25.1

-- 
heikki
