Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BBA4DD6D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiCRJLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCRJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:11:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1DC17ECE9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 816DAB82196
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24E3C340EC;
        Fri, 18 Mar 2022 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647594611;
        bh=sRBWaFWpJBtULuRujYkGmhpJV4O9z37g1bx4HWyvXoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9AJ1H53oH0/ly2Qas1KU14ZWyYwT57KMHC/QiJL3IpLCArjQor/IhZHVbymHGOPo
         r5dn4t9uS1MLpW8G5+XVRYLW7fPZVatig9VR4CeX/gS3ELoesYf3zgdBA0zik69Aw+
         s8h3mrGUu35ZcImkDU8lc+krhsKeGPAajoIHuwaI=
Date:   Fri, 18 Mar 2022 10:10:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sathish Kumar <skumark1902@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix CamelCase warnings
Message-ID: <YjRMcEkM/L/nrC2N@kroah.com>
References: <20220318090358.13559-1-skumark1902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318090358.13559-1-skumark1902@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 02:33:58PM +0530, Sathish Kumar wrote:
> This patch fixes the checkpatch.pl warnings like:
> CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
> +   u8 blnEnableRxFF0Filter;
> 
> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h   | 2 +-
>  drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
>  drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index a44d04effc8b..88845b46131f 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -157,7 +157,7 @@ struct _adapter {
>  	struct iw_statistics iwstats;
>  	int pid; /*process id from UI*/
>  	struct work_struct wk_filter_rx_ff0;
> -	u8 blnEnableRxFF0Filter;
> +	u8 bln_enable_rx_ff0_filter;

Why are you keeping the "bln" prefix here?  Why is that still needed?

thanks,

greg k-h
