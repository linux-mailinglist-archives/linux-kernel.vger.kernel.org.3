Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62575485814
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiAESVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:21:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42468 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbiAESVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C650F61893
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49583C36AE3;
        Wed,  5 Jan 2022 18:21:09 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joe Perches <joe@perches.com>, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm64: Drop outdated links in comments
Date:   Wed,  5 Jan 2022 18:21:07 +0000
Message-Id: <164140680919.1009829.13407592428112416247.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215191835.1420010-1-keescook@chromium.org>
References: <20211215191835.1420010-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 11:18:35 -0800, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org links
> with lore"), an effort was made to replace lkml.org links with lore to
> better use a single source that's more likely to stay available long-term.
> However, it seems these links don't offer much value here, so just
> remove them entirely.
> 
> 
> [...]

Applied to arm64 (for-next/misc) but without the arch/arm changes.
Please send them separately to Russell's patch system. Thanks!

[1/1] arm64: Drop outdated links in comments
      https://git.kernel.org/arm64/c/89d30b11507d

-- 
Catalin

