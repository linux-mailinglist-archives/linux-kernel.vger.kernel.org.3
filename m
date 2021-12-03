Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0F467E00
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382770AbhLCTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:22:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60096 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhLCTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:22:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3BC7B82922
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 19:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47693C53FCD;
        Fri,  3 Dec 2021 19:18:35 +0000 (UTC)
Date:   Fri, 3 Dec 2021 19:18:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 4/5] arm64: mm: use IS_ENABLED(CONFIG_KEXEC_CORE)
 instead of #ifdef
Message-ID: <YaptiDlpAGwmvtdH@arm.com>
References: <20211203051157.2160-1-jszhang@kernel.org>
 <20211203051157.2160-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203051157.2160-5-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 01:11:56PM +0800, Jisheng Zhang wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_BLK_DEV_INITRD)", to simplify the
> code and increase compile coverage.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

As long as it still compiles:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
