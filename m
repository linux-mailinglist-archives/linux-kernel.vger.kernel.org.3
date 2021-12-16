Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB74477B07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhLPRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhLPRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:50:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:50:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id D0AD41F46708
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639676999; bh=mb9PXcIJOxFFMiNhPVival7wVtn1t9kxa9+SB/qWAzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXoOO3G0r53PmgAQxgPBsGq8OiP1b73dDUja2Kyxhwyr+UCMEAiNaQwkpoRXpcwNJ
         eRSuBAoQLMjkfUnTAKJ7sZ3F21pdTGCuNx/hIsD9WLwyb7Y+PylMcwFji+am9hOdU2
         0Tqd4pYkhAqLCZpIh8BJSLY8c0dU5NFFC9I4UXQYabQ0RQ7jDSa2vU4INkDcYxLsxl
         TFtCx7tg4B2aNvkh9LKAF3u+cJOeQdMEuDEFaUhtpx8/mv7qxQ2n49kDbiuuX3CV1S
         9F/Atz3wL1TKe/y3qLZbJuaKAq9I/g2iLlvFmkAEayBxHWJxT08JTxxRd3Ou3eukMU
         8R3n4ye6O+q5w==
Date:   Thu, 16 Dec 2021 12:49:53 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm/panfrost: Avoid user size passed to kvmalloc()
Message-ID: <Ybt8QWEAooP++R7a@maud>
References: <20211216161603.983711-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216161603.983711-1-steven.price@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This provides an easy method for user
> space to trigger the OOM killer (by temporarily allocating large amounts
> of kernel memory)

panfrost user space has a lot of easy ways to trigger to the OOM killer
unfortunately .... if this is something we want to fix there are a lot
more patches coming :(
