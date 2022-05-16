Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F64528D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbiEPSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbiEPSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C43E0E9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9BB61493
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FDCC34100;
        Mon, 16 May 2022 18:45:50 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "H . Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Guohanjun <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: (subset) [PATCH -next v4 0/7]arm64: add machine check safe support
Date:   Mon, 16 May 2022 19:45:48 +0100
Message-Id: <165272673863.3711727.11330202585228113786.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420030418.3189040-1-tongtiangen@huawei.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 03:04:11 +0000, Tong Tiangen wrote:
> With the increase of memory capacity and density, the probability of
> memory error increases. The increasing size and density of server RAM
> in the data center and cloud have shown increased uncorrectable memory
> errors.
> 
> Currently, the kernel has a mechanism to recover from hardware memory
> errors. This patchset provides an new recovery mechanism.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[5/7] arm64: mte: Clean up user tag accessors
      https://git.kernel.org/arm64/c/b4d6bb38f9dc

-- 
Catalin

