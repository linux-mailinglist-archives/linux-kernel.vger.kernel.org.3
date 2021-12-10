Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CBF47090A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbhLJSoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:44:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46758 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhLJSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:44:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C277CCE2C89
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DCC00446;
        Fri, 10 Dec 2021 18:40:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Hewenliang <hewenliang4@huawei.com>, wuxu.wu@huawei.com
Subject: Re: [PATCH v3 1/2] arm64: mm: Rename asid2idx() to ctxid2asid()
Date:   Fri, 10 Dec 2021 18:40:53 +0000
Message-Id: <163916163109.780317.2105758416817622025.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c31516eb-6d15-94e0-421c-305fc010ea79@huawei.com>
References: <c31516eb-6d15-94e0-421c-305fc010ea79@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 09:42:25 +0800, Yunfeng Ye wrote:
> The commit 0c8ea531b774 ("arm64: mm: Allocate ASIDs in pairs") introduce
> the asid2idx and idx2asid macro, but these macros are not really useful
> after the commit f88f42f853a8 ("arm64: context: Free up kernel ASIDs if
> KPTI is not in use").
> 
> The code "(asid & ~ASID_MASK)" can be instead by a macro, which is the
> same code with asid2idx(). So rename it to ctxid2asid() for a better
> understanding.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64: mm: Rename asid2idx() to ctxid2asid()
      https://git.kernel.org/arm64/c/a3a5b763410c
[2/2] arm64: mm: Use asid feature macro for cheanup
      https://git.kernel.org/arm64/c/386a74677be1

-- 
Catalin

