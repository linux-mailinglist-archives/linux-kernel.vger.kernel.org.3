Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E454E462D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhK3HLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:11:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44800 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbhK3HLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:11:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85BC5B817B5;
        Tue, 30 Nov 2021 07:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59016C53FC1;
        Tue, 30 Nov 2021 07:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638256106;
        bh=1h2Zuf/FZO+mRNlQJshC6wa2kUBqZ+jCdNBHoqA85ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/4fE1ECbqXJ8nI4PtksBZnLTjKtlAodmV+hnD83Uwc4AYfPkLLXWBjD05sD1grOH
         fBRexLAKfoGE6jesfWcEMQiuL7mDf+v57PD+w96F5mGjsfjMMI8qMl//AfP2pEDC1j
         DDkgBLP9tyM7ZCm6m+M30I2wV4PCVUcT55WjaUh0=
Date:   Tue, 30 Nov 2021 08:08:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     davidcomponentone@gmail.com
Cc:     ducheng2@gmail.com, tzimmermann@suse.de,
        penguin-kernel@i-love.sakura.ne.jp, cssk@net-c.es,
        yang.guang5@zte.com.cn, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fbdev: replace snprintf in show functions with sysfs_emit
Message-ID: <YaXN5apTUfylG2Mp@kroah.com>
References: <0cb7ca73d9cd7162988a22a24cd18bbcd3d8bb27.1638156341.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb7ca73d9cd7162988a22a24cd18bbcd3d8bb27.1638156341.git.yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:05:08AM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/video/fbdev/core/fbcon.c:2680:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/video/fbdev/core/fbcon.c:2655:8-16:
> WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>

As said before, your email does not match these lines, nor was this
reported by this bot, but by the existing tools in the kernel tree.

thanks,

greg k-h
