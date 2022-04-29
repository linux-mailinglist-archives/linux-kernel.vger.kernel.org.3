Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43890514351
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355206AbiD2Hfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbiD2Hfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:35:42 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733CBE9C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:32:24 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 1AC78B00482; Fri, 29 Apr 2022 09:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1651217541; bh=F2FSC0hRsA8+n019LPklPzknF+AllKhEx1dZ7N/lS1I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ruOivHidCS4FDrYYnhBEJ9lBinlWDO0c+g0CSH6FBl5PiaaeHEEC6yXiYfvfbomY0
         C62qJSB1h5UU5wmnrhM1kfHYNYiYuNtlahdLg1PcX0jVqkCsV5BbbX8DxEcP07L+Oc
         sq8x2VbJzHOUtxA+8D1fPX2QjNn8HKKOrs24AFERi3YOkTrwMQ4akgbjj6mQyx7sE+
         qRvMD0Y/L78XE/Lk6Q0M+961wBOBcm470aHMbcQIp5Y7ToMNh9Z3AHt4eXCxQUeE3G
         3yNmq1WY1eCgV7jFL974N1KDQPmf5uhqfblBBFhoQolyfPnfwOsU47qPeWM3PtL9jB
         lDsV5l5+h9Lpw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 1983CB00127;
        Fri, 29 Apr 2022 09:32:21 +0200 (CEST)
Date:   Fri, 29 Apr 2022 09:32:21 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     andrey.konovalov@linux.dev
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 1/2] mm: slab: fix comment for ARCH_KMALLOC_MINALIGN
In-Reply-To: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
Message-ID: <alpine.DEB.2.22.394.2204290930190.317849@gentwo.de>
References: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022, andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
>
> The comment next to the ARCH_KMALLOC_MINALIGN definition says that
> ARCH_KMALLOC_MINALIGN can be defined in arch headers. This is incorrect:
> it's actually ARCH_DMA_MINALIGN that can be defined there.

The section is talking about kmalloc and not general kmem_cache_alloc()
and there was the intention of separating the alignment requirements
between these two groups of caches in the slab allocators.

