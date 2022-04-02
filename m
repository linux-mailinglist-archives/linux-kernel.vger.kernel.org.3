Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9B4F000A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354044AbiDBJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiDBJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835547678
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A637611AA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F67C340EC;
        Sat,  2 Apr 2022 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648890921;
        bh=cmXUTzA3SwdO26GO+w95ET9rjyIfmQ1A+0zYKFbqny8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NP2r0HcjmaX6Gv+hRfR13xNgNH0Mb9CORjNyYVFU/tKWWk5sUVKfZSewk2Sti/Pcz
         FY3gQlHlinVwzr8l9Wqh5vj9MOCJj6NoQ6j5eL7/3ZYcTlZvnZmXJi1t/zg0rA4Q6R
         cBjZ4XyhtVuE5evNfhA/jE6CBzcEB9eyS7Jxy+HI=
Date:   Sat, 2 Apr 2022 11:15:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sathish Kumar <skumark1902@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix multiple blank lines warning
Message-ID: <YkgUJq8fU+CslCEl@kroah.com>
References: <20220401093449.6872-1-skumark1902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401093449.6872-1-skumark1902@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 03:04:49PM +0530, Sathish Kumar wrote:
> This patch fixes the checkpatch.pl warnings like:
> CHECK: Please don't use multiple blank lines
> +
> +
> 
> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_ioctl_rtl.c | 1 -
>  drivers/staging/rtl8712/rtl871x_ioctl_set.c | 1 -
>  drivers/staging/rtl8712/rtl871x_recv.c      | 1 -
>  drivers/staging/rtl8712/rtl871x_security.c  | 1 -
>  4 files changed, 4 deletions(-)

I see 2 patches that do differnet things, yet have the same subject and
changelog text.  Please fix up and resend a v2.

thanks,

greg k-h
