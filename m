Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B494757BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhLOL2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLOL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:28:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 455C5B81ED2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF9BC34605;
        Wed, 15 Dec 2021 11:28:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jiri Slaby <jslaby@suse.cz>, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, tabba@google.com, maz@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org
Subject: Re: (subset) [RFC PATCH 0/6] linkage: better symbol aliasing
Date:   Wed, 15 Dec 2021 11:28:05 +0000
Message-Id: <163956767641.2562019.6628259864727549790.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 12:47:09 +0000, Mark Rutland wrote:
> This series aims to make symbol aliasing simpler and more consistent.
> The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> that e.g.
> 
>     SYM_FUNC_START(func)
>     SYM_FUNC_START_ALIAS(alias1)
>     SYM_FUNC_START_ALIAS(alias2)
>         ... asm insns ...
>     SYM_FUNC_END(func)
>     SYM_FUNC_END_ALIAS(alias1)
>     SYM_FUNC_END_ALIAS(alias2)
>     EXPORT_SYMBOL(alias1)
>     EXPORT_SYMBOL(alias2)
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[3/6] arm64: remove __dma_*_area() aliases
      https://git.kernel.org/arm64/c/c2c529b27ceb

-- 
Catalin

