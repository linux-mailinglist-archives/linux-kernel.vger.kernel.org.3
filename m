Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE7565A54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiGDPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiGDPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:48:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41D211E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:47:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0F3D2B;
        Mon,  4 Jul 2022 08:47:59 -0700 (PDT)
Received: from [10.57.41.70] (unknown [10.57.41.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5913F792;
        Mon,  4 Jul 2022 08:47:57 -0700 (PDT)
Message-ID: <f5e4ea47-ea2d-1699-d863-686195021e5d@arm.com>
Date:   Mon, 4 Jul 2022 16:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 0/2] Panfrost driver fixes
Content-Language: en-GB
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
References: <20220630200601.1884120-1-dmitry.osipenko@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220630200601.1884120-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 21:05, Dmitry Osipenko wrote:
> This series fixes two minor bugs in the Panfrost driver.
> 
> Changelog:
> 
> v7: - Factored out Panfrost fixes from [1] since I'll be working on
>       the dma-buf locking in a separate patchset now.
> 
> [1] https://lore.kernel.org/all/20220526235040.678984-1-dmitry.osipenko@collabora.com/
> 
> Dmitry Osipenko (2):
>   drm/panfrost: Put mapping instead of shmem obj on
>     panfrost_mmu_map_fault_addr() error
>   drm/panfrost: Fix shrinker list corruption by madvise IOCTL
> 
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 4 ++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Thanks, I've pushed both to drm-misc-fixes.

Steve
