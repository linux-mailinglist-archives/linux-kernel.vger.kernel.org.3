Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CEE470909
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245502AbhLJSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:44:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47906 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhLJSoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:44:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CE88B8294B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBC7C00446;
        Fri, 10 Dec 2021 18:40:41 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     rppt@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, will@kernel.org,
        akpm@linux-foundation.org,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>, ardb@kernel.org,
        pasha.tatashin@soleen.com, tabba@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/2] simple optimizations for page_address and
Date:   Fri, 10 Dec 2021 18:40:39 +0000
Message-Id: <163916163109.780317.9196251848909192931.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com> <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 01:05:58 +0800, Rongwei Wang wrote:
> Patch 1/2 mainly to fix the bug when calling kexec_load() originally, but
> because of ignored and link[1] also fixed this bug and had been applied
> to arm64 (for-next/fixes) before us. Anyway, It's nice to unify the use of
> 'pmd_populate_kernel' under arm64.
> 
> Patch 2/2 just make a very simple optimization, reducing
> calls to page_address() in kexec_page_alloc().
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[2/2] arm64: kexec: reduce calls to page_address()
      https://git.kernel.org/arm64/c/7afccde389dc

-- 
Catalin

