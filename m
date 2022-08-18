Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138AA5986F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbiHRPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbiHRPHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D19C53D;
        Thu, 18 Aug 2022 08:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 142526135F;
        Thu, 18 Aug 2022 15:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20718C433D6;
        Thu, 18 Aug 2022 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660835219;
        bh=WkrNCbKYD3xZKpJJ81qL8Xck1IuTybQeeZNEiImLgSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMDbJXG35jSoumiaoCsmU82g7/aLhi4RiQpct4YTnPDkJaqqXE4mYRFxCzn4ruLzL
         8AHcJr1atGYjPOo28gFL4fz2xH6p0aLhE67gJGgVfq87WuDI7EDyhFy6Xe15zvM6Zt
         esN+nxXBVuQNKf7tqC2jLC7cwwd2qHtT5b+79LKI=
Date:   Thu, 18 Aug 2022 17:06:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] USB: trancevibrator: simplify tv_probe
Message-ID: <Yv5VkNvk6CDBFgNK@kroah.com>
References: <20220812061805.88627-1-dzm91@hust.edu.cn>
 <20220812061805.88627-2-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812061805.88627-2-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:18:02PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> The function tv_probe does not need to invoke kfree when the
> allocation fails. So let's simplify the code of tv_probe.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
> v2->v3: fix the truncated subject of PATCH 2/2.
> v1->v2: no change
> 
>  drivers/usb/misc/trancevibrator.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Note, I would recommend you work on basic "clean up" patches in the
drivers/staging/ directory so as to get experience on how to submit
patches properly before working in other parts of the kernel tree.  That
way subsystems that don't normally take "cleanup" patches don't get
bogged down in basic patch-process issues like this one did.

thanks,

greg k-h
