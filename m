Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF044A47B7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376283AbiAaNEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiAaNEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:04:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E457AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97E10B82ABD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBADC340E8;
        Mon, 31 Jan 2022 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643634250;
        bh=TD6/WGLViFunmRccj4Esvf4Me5wXuWjEDYLePglBafw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHZCCUOWu2G3uXD82pFLev/bcqTxB4xy4sWogDOgLqnut+wu21hlSxO2QMsCn1r6Q
         1aWT5cq8Ct2rv7jKeS85epjwJM5GWn7ay/9sPggGm/DCqUKHAF3iMFT+pgH352/PhF
         aPz2l8hqjoPYNCsEPPDpo6K/5uJs+zHk5+4WmlTg=
Date:   Mon, 31 Jan 2022 14:03:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/23] staging: r8188eu: remove unneeded ret variables
Message-ID: <YffeDdW5gPDIXR9f@kroah.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 09:34:06PM +0530, Abdun Nihaal wrote:
> This patchset does the following to functions in ioctl_linux.c:
> - Remove unneeded return variable in some functions.
>   These functions cannot be converted to void either because it is an
>   iw_handler function or the function does return error code.
> - Propagate error code in rtw_p2p_get2 function
> - Convert some functions that always return 0 to return void
> 
> v3 -> v4:
> - Split the changes into smaller patches to make it easier to review
> - Add a new patch to propagate error code in rtw_p2p_get2 function

Much nicer and easier to review, all now queued up, thanks!

greg k-h
