Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159CD474BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhLNTQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhLNTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:16:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690E8616C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C60C34600;
        Tue, 14 Dec 2021 19:16:23 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v4] arm64: Enable KCSAN
Date:   Tue, 14 Dec 2021 19:16:21 +0000
Message-Id: <163950937456.2458141.12946120390783566637.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211211131734.126874-1-wangkefeng.wang@huawei.com>
References: <20211211131734.126874-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 21:17:34 +0800, Kefeng Wang wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
> 
> Recent GCC version(at least GCC10) made outline-atomics as the
> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o. Disables the out-of-line atomics by
> no-outline-atomics to fix the linker errors.
> 
> [...]

Applied to arm64 (for-next/kcsan), thanks!

[1/1] arm64: Enable KCSAN
      https://git.kernel.org/arm64/c/dd03762ab608

-- 
Catalin

