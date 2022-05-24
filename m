Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD83853284E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiEXKyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiEXKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:54:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537B69713;
        Tue, 24 May 2022 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653389649; x=1684925649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fH9O4UdqFEL6xKyH3yJM1r2FmPTgxb1CDCnokkfH+pE=;
  b=IO+2zlSDlODm3oQq6ZW4HOm9kL68pWDfbzEYjlyCIedDodQPWsYXBTfA
   f7D1IjpelL3w2TGv840IIpMI+1CSF0dUW9zkdvIc+OGursVXGilk/ckpg
   oDTO9fIzpUrKXRm2j8rAu3m55lzgHadzHRnkuS3WCA+vceHPfjGaUdHkX
   4nmUTw/XhnHbin4WA2sJ5AUSNKFtx3ukTeUirW0B/HwMJIN04mUwfQDiE
   6hq7BzKUT7vIqo4DnDz1E/+mBopLVfn+dcW8EbpXGgmuxIkE1zUb5cjDm
   pe4Ag63nTgoHlkX7fpfs2qVwKpZgY3GW5tTN0Py5sNCWH7Tm4ctnkS2qg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273222378"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273222378"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717121870"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 May 2022 03:54:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 May 2022 13:54:05 +0300
Date:   Tue, 24 May 2022 13:54:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: fix typo in comment
Message-ID: <Yoy5TDJBLMaNUUvl@kuha.fi.intel.com>
References: <20220521111145.81697-52-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-52-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:11:02PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bc2f4ebd1fe..7039383eac6d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -471,7 +471,7 @@ struct tcpm_port {
>  
>  	/*
>  	 * When set, port requests PD_P_SNK_STDBY_MW upon entering SNK_DISCOVERY and
> -	 * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> +	 * the actual current limit after RX of PD_CTRL_PSRDY for PD link,
>  	 * SNK_READY for non-pd link.
>  	 */
>  	bool slow_charger_loop;

-- 
heikki
