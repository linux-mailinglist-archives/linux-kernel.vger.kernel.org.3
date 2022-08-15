Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4313592ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiHOMWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHOMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:22:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23071DA57;
        Mon, 15 Aug 2022 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660566120; x=1692102120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8Tjzo5FTyDnRt521m68Loy/Rs3ab8SDRc0XEsHrHL4=;
  b=D4ASqcix0dQkKKwxQzgRBe042C26V0+ZmaQesjwyupY4m6rEVRAlAEnB
   myT+SphToFZlLY7ewOZ/4C5AVf+370pq9Bjr7I8rSw9fUMgCENGr7xol4
   zC9KrFTfFiATZZ6B0aS19WX/he2wkwm5XqE0ll8RBOTLlbSxCPNKqk/tU
   1YDOR4xIy/iat0Dh5GezG0dUoW5pMP9cH/JWxJeuWwUetKln06yXqfvw8
   kGliRJkKnIBnU29Rz5p/qu1Sdc0i4HYKshT3MNslaPT2lA6tJTNrdFCGK
   zgloWEY8g+7MkZZMfHwsFbtgLu90410u6HlgZOzlYwkjLC/6jppEWpk8/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278905755"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="278905755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="748904715"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 15 Aug 2022 05:21:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Aug 2022 15:21:56 +0300
Date:   Mon, 15 Aug 2022 15:21:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Remove repeated word in comments
Message-ID: <Yvo6ZCxOADzRH7Gf@kuha.fi.intel.com>
References: <20220808154830.10965-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808154830.10965-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 11:48:30AM -0400, shaomin Deng wrote:
> Remove the repeated word "to" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index e1126a6c8e46..ea5a917c51b1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4520,7 +4520,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * The specification suggests that dual mode ports in sink
>  		 * mode should transition to state PE_SRC_Transition_to_default.
>  		 * See USB power delivery specification chapter 8.3.3.6.1.3.
> -		 * This would mean to to
> +		 * This would mean to
>  		 * - turn off VCONN, reset power supply
>  		 * - request hardware reset
>  		 * - turn on VCONN
> -- 
> 2.35.1

-- 
heikki
