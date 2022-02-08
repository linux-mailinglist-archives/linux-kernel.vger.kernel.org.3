Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C64AD4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354761AbiBHJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiBHJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:30:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE59C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:30:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB6B614B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA22C004E1;
        Tue,  8 Feb 2022 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644312634;
        bh=p+wZ9FA61c2TpCDag2GOKRF1CT5fzUtmZlu4O3jb2hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvbqgd07MKSZuhkj71ckxzwQhThhQdOUpkRBhHBCUlV6hB13/RICCzjxzi2ELnwbL
         7RBLh4onXANruo+iDyjDIR4vrSX0KC69K5DlLv9UTnaRT1FtoDKuqrdpKEoG6JrWFq
         U5xTVxpIWexi2jvTvwMNTzL41OkzqJzcmgV3GfrU=
Date:   Tue, 8 Feb 2022 10:30:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: r8188eu: remove ishighspeed from dvobj_priv
Message-ID: <YgI4N1X18cr9QApA@kroah.com>
References: <20220206175925.461426-1-martin@kaiser.cx>
 <20220206175925.461426-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206175925.461426-6-martin@kaiser.cx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 06:59:25PM +0100, Martin Kaiser wrote:
> There's no need to store the usb device speed in struct dvobj_priv.
> 
> We can read the speed from struct usb_device. dvobj_priv has a pointer
> to the usb_device.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_iol.c      | 4 +++-
>  drivers/staging/r8188eu/hal/usb_halinit.c   | 4 ++--
>  drivers/staging/r8188eu/include/drv_types.h | 1 -
>  drivers/staging/r8188eu/include/usb_ops.h   | 2 +-
>  drivers/staging/r8188eu/os_dep/usb_intf.c   | 8 --------
>  5 files changed, 6 insertions(+), 13 deletions(-)

This commit did not apply probably due to other changes to the driver at
the same time by other patch series.  Can you rebase it and resend?  The
other 4 were fine and now in my tree.

thanks,

greg k-h
