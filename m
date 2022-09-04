Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD15AC400
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiIDKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIDKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7F40558
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C6260F63
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 10:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B32C433D6;
        Sun,  4 Sep 2022 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662288720;
        bh=bf4utsuDzTnEU/RZQU2jN5PbpySEyH1A9+EneI8CGx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SR1GlqntmeKbwEpn31AJXelaEU/JqWFYxt2fzy8uQJj4xheutigkahO7Rh12hiy0V
         DyySgaOeRlzbwvpO9tt9y5/79SCab4+VWrzV/upnoDVMePc4yOEEKAaRvEsXn1Os0G
         sfe5CmOhLOjXWbWy/2RP7TndVkQZ9orpwwffQpUOa7zEryyJON/8Wzx7g8GJEFoaFS
         fsJU4FJ6Btb/cYDRMiZtw6wMy0KZjh4Y7aS7/ODCdgSIZ2FkBUnfbAsEUuVMHC/DOY
         VrMLwRC83Uk/EFjBAKPVEVh4CtLNHJud9MGrC/uz4Stjbc2yN7Ys3/+2n7YzYuwdP2
         vUOW64N3No0WQ==
Date:   Sun, 4 Sep 2022 13:51:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] memblock tests: remove 'cleared' from comment blocks
Message-ID: <YxSDQTmMVww62uwT@kernel.org>
References: <e8be24137e54e9f81a06af969ded82b319114d7a.1662264347.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8be24137e54e9f81a06af969ded82b319114d7a.1662264347.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 11:23:37PM -0500, Rebecca Mckeever wrote:
> The tests in alloc_nid_api can now run either memblock_alloc_try_nid()
> or memblock_alloc_try_nid_raw(). The comment blocks for these tests
> should not refer to a 'cleared' region since that only applies to
> memblock_alloc_try_nid(). Remove 'cleared' from the comment blocks so
> that the comments are accurate for either memblock function.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_nid_api.c | 22 ++++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied, thanks!

-- 
Sincerely yours,
Mike.
