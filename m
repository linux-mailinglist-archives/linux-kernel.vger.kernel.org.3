Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400694791F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhLQQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbhLQQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:54:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26658C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:54:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAC32B82988
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE57C36AE7;
        Fri, 17 Dec 2021 16:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639760044;
        bh=4qkBQD3tIu/ijOewv4T54vWUsvjDwIv3x7p5rF+QXFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDg9dp3ckWRHa2B0PTZmxS0cj1PM51Z4Aq9UwtNzHkcQpTUannyqHQCzi503/gxHT
         ATbHDuaJ3Bkvq5LFm+eN2tuJZeKfPy1Qe0AaPap8Y7AdxMIAm8cy71Y7VWw+j/bxCU
         TWiYPN6E5fbcpTeHyjeMy3gBfS5J2ZAXx2hR9UpJ4EaUm6vlfNYx3aUUQf/oTlJz+v
         a1mvFjCy9cQO31k9YomJitxAvAENTDn4WuOA2lvGOnoZk+1cj5d4ZtJFq+nouU4MMt
         dyh/d/05Rf63DvJes8weGRzegatEdPpxjEmoTQd/EMkjLaOrAL1DIrf/v1/lS9/4Dw
         dc8K7DhMyES2g==
Date:   Fri, 17 Dec 2021 08:54:03 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] f2fs: Simplify bool conversion
Message-ID: <YbzAq43KYQqYx5ar@google.com>
References: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
 <7e51b00a-ae83-66d1-8f0e-920423ac7fa7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e51b00a-ae83-66d1-8f0e-920423ac7fa7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, Chao Yu wrote:
> On 2021/12/15 10:38, Yang Li wrote:
> > Fix the following coccicheck warning:
> > ./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Thanks for fixing this issue, do you mind merging this fix into original patch?

I applied this separately in order to avoid huge rebase.

> 
> Thanks,
