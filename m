Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B251DAEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442378AbiEFOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442367AbiEFOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A706AA43
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD106210F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C16C385A8;
        Fri,  6 May 2022 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651848224;
        bh=/+E4zkAHTg5lrUX9NnLf09jIMb1ixSmWqAap21j4v/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNjBYjv6PWJuNxmM1HV1vyAMCzN+ZuknCdI/kJ26bPjErTPEivW+fs806ClyOvW/p
         B6QSQnyXxRkwWiDuX+873mfQNZAS/g4U9kdMSWn1PgDFhEjPaCsIX/KwyQTe4T92hP
         bo2dWL9s+pOCMXLKse40IX2ep124N5vhMmNo+ecQ0mXZIOAjTNPnNp1jWIgUus2ZYG
         +w/XJVgMUfBowHGPdKpg+J+bBh0KkJ2xv801kmK22p7U1kX1qDyf4tA6TWD4BzdI/Y
         Y7nHYINGTRMSSvBH/nmnNoj9n2kwqnve7L3LlWjvzE9eMwGmenVT0urMa1fDbB2bX5
         X3sHmWQCASzYg==
From:   Will Deacon <will@kernel.org>
To:     Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, anup@brainfault.org,
        kernel test robot <lkp@intel.com>, atishp@atishpatra.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>, mark.rutland@arm.com
Subject: Re: [PATCH] perf: RISC-V: Remove non-kernel-doc ** comments
Date:   Fri,  6 May 2022 15:43:30 +0100
Message-Id: <165184132370.732903.14576685532828749182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220322220147.11407-1-palmer@rivosinc.com>
References: <20220322220147.11407-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 15:01:47 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This will presumably trip up some tools that try to parse the comments
> as kernel doc when they're not.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: RISC-V: Remove non-kernel-doc ** comments
      https://git.kernel.org/will/c/c7a9dcea8e98

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
