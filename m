Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743B1485828
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiAES0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbiAESZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:25:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8747C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:25:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76717B81CF9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B5DC36AE0;
        Wed,  5 Jan 2022 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641407155;
        bh=etvQ70B7VTyNu3V0pWf5jfwy4CPdXh6nZhHM9S06xJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fpv2cfxgNNW+9zQL2AZr2bFdBg+XEAAXfZYz2uGazv2p+34UlA0W4MPGQb46zLyhX
         Ym1/IzchYFOOsi2YeKfAIhvk/m9Yw7Bm2M8EJ+o+4KScr+dpT+AJbjLJBrCZLB0OSm
         MMGI+BR9JcBv3QksGbKifYRFLdABA+LJrreAxsgN1HWfdoj12b15r3xg1vL2uSUdjB
         u9B32MxzoqScoYrKWJft1WmKAhLOqKoOMz7hnX6VgNboUvfa77kPntunlq/46JFYZ/
         wcSd1vCj7JlYtRhEH7TqosDdL2oKmwfTiI0ZyLKrDOpHrMMsb+WKMIdNEfF+AbZN3a
         vFCGgAKCPK5OQ==
Date:   Wed, 5 Jan 2022 10:25:53 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YdXiscxIceQWw2ZG@google.com>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-5-jaegeuk@kernel.org>
 <f8c0d9f8-6a1f-e7b7-4dd3-fcd31272a0df@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c0d9f8-6a1f-e7b7-4dd3-fcd31272a0df@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05, Chao Yu wrote:
> On 2022/1/5 5:24, Jaegeuk Kim wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
> > use iomap for direct I/O.
> > 
> > Note that this may be used for other things besides direct I/O in the
> > future; however, for now I've only tested it for direct I/O.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Ditto. Thanks,

> 
> Thanks,
