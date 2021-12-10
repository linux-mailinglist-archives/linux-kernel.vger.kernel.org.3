Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9806470370
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbhLJPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhLJPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:06:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:02:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E27B6B82875
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11473C00446;
        Fri, 10 Dec 2021 15:02:44 +0000 (UTC)
Date:   Fri, 10 Dec 2021 15:02:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, bp@alien8.de,
        broonie@kernel.org, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        mingo@redhat.com, peterz@infradead.org, tabba@google.com,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [RFC PATCH 3/6] arm64: remove __dma_*_area() aliases
Message-ID: <YbNsEedVuV13r9RL@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
 <20211206124715.4101571-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206124715.4101571-4-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:47:12PM +0000, Mark Rutland wrote:
> The __dma_inv_area() and __dma_clean_area() aliases make cache.S harder
> to navigate, but don't gain us anything in practice.
> 
> For clarity, let's remove them along with their redundant comments. The
> only users are __dma_map_area() and __dma_unmap_area(), which need to be
> position independent, and can call __pi_dcache_inval_poc() and
> __pi_dcache_clean_poc() directly.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
