Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48C465065
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350300AbhLAOwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350126AbhLAOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:52:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC1C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AF54B81FDB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 14:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121FAC53FCC;
        Wed,  1 Dec 2021 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638370127;
        bh=RUBPE8UMp3r+cz50VVEWKL6IJ2CXoZv+mPYQx0EPFMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdu+qnpk5Tvfu2S1aRpERCjBZFWk001/6YHT1BDX1Du/CSqOL5CfFjJemwuiFrBSk
         OytZ4EBdHckCWzqrpGfTYfKkZVS3hl57ECva2DxWKV90iffIxFEtN5Gy0GofX9vtiH
         heJSBdO5nIpDl5HFoDzYcGq0A1VDzUAw5dluRN8pzz2PVjYbZgtyN3JxrLQyKGR+CU
         CkAGbXW37a0IXzhayaTtgBIUvI+VkJvBfGhCWHvEhplG+V6iRWN6uxgCulV0N8R3Pe
         7xHGro0OvX6D19VlhJNdAX/KTuVohdvvXNehOqGk1GQAHxj17mSuoiUVg8/v5e9g1V
         THwJ8xgmvX/pA==
Date:   Wed, 1 Dec 2021 15:48:44 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 0/2] workqueue: Fix hotplug races
Message-ID: <20211201144844.GB628470@lothringen>
References: <20211130000612.591368-1-frederic@kernel.org>
 <YaZTB/XiC6VNMR0d@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZTB/XiC6VNMR0d@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:36:23AM -1000, Tejun Heo wrote:
> On Tue, Nov 30, 2021 at 01:06:10AM +0100, Frederic Weisbecker wrote:
> > While triggering rcutorture splats, I couldn't trace down to the exact
> > cause due to the issue being tracing-unfriendly. But looking at the code,
> > those two potential races look like plausible causes and also after
> > these two patches, I couldn't reproduce the rcutorture issues again (yet...).
> > 
> > Frederic Weisbecker (2):
> >   workqueue: Fix unbind_workers() VS wq_worker_running() race
> >   workqueue: Fix unbind_workers() VS wq_worker_sleeping() race
> 
> Both patches look good to me. Lai, thanks for finding the offending commits.
> Frederic, can you please repost them w/ scheduler folks and tglx cc'd?

Sure, preparing that.

Thanks.

> Thanks.
> 
> -- 
> tejun
