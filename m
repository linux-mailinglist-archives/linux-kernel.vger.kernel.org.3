Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A75B05F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIGOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:01:58 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D67EF6DFA7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:01:56 -0700 (PDT)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id D18D92409A7;
        Wed,  7 Sep 2022 16:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1662559316;
        bh=P37GJtfC9cpZshVFxKia1PKxLTHUt7UKWeJ5u5EBnPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OD0ueQ69vUXSqom3AvFg+1weMJ+TnRY8GPru9h9cSpQx0RXnXyPSnJ+FSb1QNI4YW
         mHML+s1dzxEMkZ3BYjd3vI764FYlC2n0vSZNRWOT/znePuVQFuW9u/jZlOWwkPam7+
         Fu6Vqrlh5tUQq8TDqd8cbFn84vetWolz2zvKN1W9VM/g6zNhvn129YhaMLMGTr+mvq
         JytZssS86YXKGFuqk4IyjECDin+jO6GKrSmHoUyn0E6ors34UO40ILcuWYF1FuKIxb
         kPBquMun+wVRfV2kJJyJbH1YjFX20CDGZbHw/5m/ICzhK+EwYaPR5clXEK9Bc5tt/b
         8Lda2PWJe/dIg==
Date:   Wed, 7 Sep 2022 16:01:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jsnitsel@redhat.com, haifeng.zhao@linux.intel.com
Subject: Re: [PATCH v4 0/3] iova: Some misc changes
Message-ID: <YxikUvhOiq45dnnj@8bytes.org>
References: <1662557681-145906-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662557681-145906-1-git-send-email-john.garry@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:34:38PM +0800, John Garry wrote:
> John Garry (3):
>   iova: Remove some magazine pointer NULL checks
>   iova: Remove magazine BUG_ON() checks
>   iova: Remove iovad->rcaches check in iova_rcache_get()
> 
>  drivers/iommu/iova.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Applied, thanks.
