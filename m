Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E685B4CE8D1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 06:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiCFFGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 00:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCFFGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 00:06:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126295623A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 21:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F706116A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 05:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B4CC340EF;
        Sun,  6 Mar 2022 05:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646543109;
        bh=I47xdaRTZGRbePfK73nGU/4F97IW2nPpZekhvmviF3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3EL2dWdIW7VnS9zczF/qyH6WpI5+IKHAieD7FxjLwq6HuKS0Q1CQ+aDBEL9FSGgH
         rJP8+UGMqdl0g+BEnQP8ZyFWHuQGWPjtoEZawGOYFhx2Oqy3BiEEApb054mF4X/HJA
         gMIsaidPs+uaeRNCgI3dodrmC7w4h5E08s1pN69ieYDCTfVFLehzUTSRQzJmZ6QO8a
         lSTolhhY3Iod4UVj8iLT/17fmx/pCv1CFASbTvYGNFcICFGgflyYPOLAhuItMcyrpP
         sZsfUUwZNFbBKFv5g1golIADRmUP+fn5Q26dHuVBE4VIoOe0Cl7rOJ5C0j2TYAvFid
         AEtuShGoqXzrw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com
Subject: Re: [PATCH] memblock tests: Fix testing with 32-bit physical addresses
Date:   Sun,  6 Mar 2022 07:04:20 +0200
Message-Id: <164651169264.2753101.4268768536447974399.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304125249.253578-1-karolinadrobnik@gmail.com>
References: <20220304125249.253578-1-karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 13:52:49 +0100, Karolina Drobnik wrote:
> Building memblock simulator on x86_64 with 32BIT_PHYS_ADDR_T=1
> produces "cast to pointer from integer of different size" warnings.
> Fix them by building the binary in 32-bit environment when using
> 32-bit physical addresses.
> 
> 

Applied, thanks!

[1/1] memblock tests: Fix testing with 32-bit physical addresses
      commit 2a7ceac9e58167fadc3496c5f694543d4bbe03ef

Best regards,
-- 
Sincerely yours,
Mike.
