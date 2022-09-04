Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9765AC402
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiIDKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiIDKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07840558
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B495DB80D66
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 10:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A24C433D7;
        Sun,  4 Sep 2022 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662288748;
        bh=zbvQW9z1WxRiApk2Okw0Th5Lwabd5h5Su7n/5413jKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYUt9NrkPcEfjyx6VSPY4qIyFodZoZ0pOZciEDb09aIXicBTQuq0xgdq/urcE62we
         aROZ9Fal075mTrj3cqqt73vMTXlaZvqiSplombEKxjzsWubMQ24MTRi3SPdCTfH9UX
         JYkKcRxIFVg2NTFh/GxEC1WGlXyM0EREv7BmMiOWdWrSUftIn3t8ZkthWZCyR4b4ke
         298UVwJAJ2mKqSTMQGccWpQgvLszjkFYUahH9/lkk7ANz6PrbxFe6O3LUCXJDF/ozh
         GFMJpCgtvuZafK1mAIQaFyVylvGsMT3JRHVcpGhA+A1A52Swr6PUXv8scihGRpxkj0
         9jyqda/2U1kzw==
Date:   Sun, 4 Sep 2022 13:52:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] memblock_tests: move variable declarations to single
 block
Message-ID: <YxSDX3s1fqPjaOil@kernel.org>
References: <e61431e73977f305fdd027bca99d1dc119e96d84.1662264355.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e61431e73977f305fdd027bca99d1dc119e96d84.1662264355.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 11:24:06PM -0500, Rebecca Mckeever wrote:
> Move variable declarations to a single block at the beginning of each
> testing function.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_api.c      | 57 ++++---------
>  .../memblock/tests/alloc_helpers_api.c        | 32 ++------
>  tools/testing/memblock/tests/alloc_nid_api.c  | 80 +++++--------------
>  3 files changed, 42 insertions(+), 127 deletions(-)

Applied, thanks!

-- 
Sincerely yours,
Mike.
