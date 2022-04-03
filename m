Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518404F087F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiDCI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDCI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:59:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E127B3137A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 01:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D55D8B80C6A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2994CC340ED;
        Sun,  3 Apr 2022 08:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648976256;
        bh=1mCqVCGJhKXscLciRMEdJ4sz7mlkpG1XFYW0ZKNoZOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSLWoII9l3SD8kDLAdJ4Z716719mB9u/n5ufg73vlRYCSSmdcsZXAtaJRMS/YfAy4
         46BMjzQOlfOwLhBbJ/FIOZB2KhwcBg5wRpNm5ERre2OV1IlNvJNZtH7Ed3vNSO78+6
         DSgmm27lAg0hNoagcNSV+j8cdoEAOlzXhr1c9o+Q=
Date:   Sun, 3 Apr 2022 10:57:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8712: Fix Lines shouldn't end with '('
Message-ID: <YklhfWv8DQlBdM0w@kroah.com>
References: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
 <9bb14ea276fd3274900f7aec455174c53ed3a3e9.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb14ea276fd3274900f7aec455174c53ed3a3e9.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 02:28:17PM +0200, Alaa Mohamed wrote:
> Fix " CHECK: Lines should not end with a '(' "
> Reported by checkpatch
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_xmit.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
> index 05ba0ca7d627..d43c097f30c3 100644
> --- a/drivers/staging/rtl8712/rtl8712_xmit.c
> +++ b/drivers/staging/rtl8712/rtl8712_xmit.c
> @@ -638,16 +638,12 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
>  		if (p2ndxmitframe) {
>  			u16 total_length;
>  
> -			total_length = r8712_xmitframe_aggr_next(
> -				pxmitbuf, p2ndxmitframe);
> +			total_length = r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
>  			do {
> -				p2ndxmitframe = dequeue_xframe_ex(
> -					pxmitpriv, phwxmits, hwentry);
> +				p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
>  				if (p2ndxmitframe)
>  					total_length =
> -						r8712_xmitframe_aggr_next(
> -							pxmitbuf,
> -							p2ndxmitframe);
> +						r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);

And now you went over 80 columns :(

You can do this better so that you still wrap lines, but do not trail
with a '(' character.

thanks,

greg k-h
