Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8C4EE800
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbiDAGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiDAGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:01:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72301D67CF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58147B82390
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEDEC2BBE4;
        Fri,  1 Apr 2022 05:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648792794;
        bh=qCcMx9byE4xfXIPUK4SlECAw5kqRNKP8ujTTBZIIvaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7FGfiGuBqwAGGnebrpzucqN/fxAvqT2KNhOzs3rlSnhqM4tMsQKxV/xWzOP4jw31
         CQ2ZyDyKXRRb81fKUCT+GbqRQaaxtN+WYhxVjYXTxTfeniOemoZcE7vlTEwSV6A0c4
         BcW7RgBfnwLxCdXHRpUVV6gFvQ+5MsC4sgSFP6pI=
Date:   Fri, 1 Apr 2022 07:59:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: r8188eu: remove GetHwReg8188EU()
Message-ID: <YkaU11B4MV3EE9oP@kroah.com>
References: <20220331130522.6648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331130522.6648-1-straube.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:05:17PM +0200, Michael Straube wrote:
> This series remove the function GetHwReg8188EU(). This is part of the
> ongoing effort to get rid of the unwanted hal layer.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (5):
>   staging: r8188eu: rename clear_bacon_valid_bit()
>   staging: r8188eu: remove HW_VAR_BCN_VALID from GetHwReg8188EU()
>   staging: r8188eu: remove HW_VAR_CHK_HI_QUEUE_EMPTY from
>     GetHwReg8188EU()
>   staging: r8188eu: remove HW_VAR_FWLPS_RF_ON from GetHwReg8188EU()
>   staging: r8188eu: remove GetHwReg8188EU()
> 
>  drivers/staging/r8188eu/core/rtw_cmd.c        | 14 +++----
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 14 +++++--
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 19 +++++++--
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  6 +--
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 40 -------------------
>  drivers/staging/r8188eu/include/hal_intf.h    |  4 --
>  .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  4 +-
>  8 files changed, 39 insertions(+), 65 deletions(-)

Nice work in getting rid of that mess!
