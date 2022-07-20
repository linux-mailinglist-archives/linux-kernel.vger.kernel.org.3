Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58E57BF88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiGTVXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiGTVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:34 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE263937;
        Wed, 20 Jul 2022 14:22:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D5D402ED;
        Wed, 20 Jul 2022 21:22:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D5D402ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658352151; bh=Kl3uE6oHnNJDSqZS04F8R5YvaQ8LpdjcxdPR59RBQUY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IOAvDT1AJhiTZ4ANjVdWW62QzMkv0JZTou9CCeqAn5x6YqdFmEflbHQNI9shY2ou2
         4C5ZY1V5p2S8HnB8YbnQ4WU1sUH4xnMUjrTspUDy9NWza2ayZbV8FNExnQcANacmYM
         kXiOVUQ8DASqmDR/Ko9uQbK1vYxuBQF1k0GI8vUZFy85oLxTHxRuLhynwTw2iIAmwI
         gX62oacCzCS0BoxpLWj3CEVSHMfLa49jl/yY9Y3y/7f3LAceA+PSzczr3E4XRnUaym
         b2t4bfiZ+twZESBOs00pGgCmBUORqNfSbypfLrfue96A0L0tDijlLg9D0TUhZ9ygXw
         SHcnafa9M088Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc/vm: move overcommit-accounting doc to admin-guide
In-Reply-To: <20220714055142.214728-1-alexs@kernel.org>
References: <20220714055142.214728-1-alexs@kernel.org>
Date:   Wed, 20 Jul 2022 15:22:30 -0600
Message-ID: <874jzbo4x5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alexs@kernel.org writes:

> From: Alex Shi <alexs@kernel.org>
>
> Since the contents is mainly focus on a sysctl vm.overcommit_memory,
> it's more suitable for admin-guide dir instead of vm/ dir.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/admin-guide/mm/index.rst                          | 1 +
>  Documentation/{vm => admin-guide/mm}/overcommit-accounting.rst  | 0
>  Documentation/admin-guide/sysctl/vm.rst                         | 2 +-
>  Documentation/filesystems/proc.rst                              | 2 +-
>  Documentation/translations/zh_CN/admin-guide/mm/index.rst       | 1 +
>  .../zh_CN/{vm => admin-guide/mm}/overcommit-accounting.rst      | 2 +-
>  Documentation/translations/zh_CN/vm/index.rst                   | 1 -
>  Documentation/vm/index.rst                                      | 1 -
>  8 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/{vm => admin-guide/mm}/overcommit-accounting.rst (100%)
>  rename Documentation/translations/zh_CN/{vm => admin-guide/mm}/overcommit-accounting.rst (97%)

Applied, thanks.

jon
