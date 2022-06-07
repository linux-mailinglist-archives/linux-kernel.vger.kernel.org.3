Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090154032D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbiFGP5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344453AbiFGP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304BB36B51
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE2B5B82172
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B988C385A5;
        Tue,  7 Jun 2022 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654617468;
        bh=iLKqDYEYhp+eqcsdWfLEMP2XRbwgCOgGlSNWpiGM/P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rp+hwJ7lBcWIuwUeHzey8vwqNYVhq24ImKpakJ/D2RkF/zlJ/8w8vsCidTwGMuUH2
         y/msJ314ityDrOSfi/pSz5jq51O6b8RYhgKTMrR+cwrrbjrPUuieogDndoD/ID4ELh
         UYHu6m+1OFv0JxvjeA78Cdvu0rGS/zxyywTp8444=
Date:   Tue, 7 Jun 2022 17:57:46 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Paris Andrea <aparis@student.ethz.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] staging: r8188eu: add multiple blank lines
Message-ID: <Yp91ev9Yj/X+72zC@kroah.com>
References: <f2e69da1c2f14a03bf11e775a3140f5c@student.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e69da1c2f14a03bf11e775a3140f5c@student.ethz.ch>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:36:16PM +0000, Paris  Andrea wrote:
> This patch adds a blank line after three different variable declarations
> 
> in the file rtw_cmd.c in order to fix three related checkpatch warnings.
> 
> 
> Signed-off-by: Andrea Paris <aparis@ethz.ch>
> 
> ---
> Added three blank lines, fixed checkpatch warning
> 
>  drivers/staging/r8188eu/core/rtw_cmd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 06523d91939a..92d5e4534087 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -25,6 +25,7 @@ void rtw_free_evt_priv(struct evt_priv *pevtpriv)
> 
>          while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
>                  void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
> +
>                  if (c2h && c2h != (void *)pevtpriv)
>                          kfree(c2h);
>          }
> @@ -323,6 +324,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>          /* prepare ssid list */
>          if (ssid) {
>                  int i;
> +
>                  for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
>                          if (ssid[i].SsidLength) {
>                                  memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
> @@ -334,6 +336,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>          /* prepare channel list */
>          if (ch) {
>                  int i;
> +
>                  for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
>                          if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
>                                  memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
> --
> 2.25.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
