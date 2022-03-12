Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979F94D6E20
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiCLKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiCLKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0C23BF3D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbb1NRlz4xcl;
        Sat, 12 Mar 2022 21:30:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
References: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc: Cleanup asm-prototypes.c
Message-Id: <164708098372.827774.13045777419131446755.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 18:04:02 +0100, Christophe Leroy wrote:
> Last call to sys_swapcontext() from ASM was removed by
> commit fbcee2ebe8ed ("powerpc/32: Always save non volatile GPRs at
> syscall entry")
> 
> sys_debug_setcontext() prototype not needed anymore since
> commit f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch
> to SYSCALL_DEFINE")
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Cleanup asm-prototypes.c
      https://git.kernel.org/powerpc/c/e86debbbb5f89c2575110cfdce89d1820577aa94
[2/4] powerpc/smp: Declare current_set static
      https://git.kernel.org/powerpc/c/e15c703be48edc3b2f96b66d4f548dc88b44266c
[3/4] powerpc/kexec: Declare kexec_paca static
      https://git.kernel.org/powerpc/c/a4abd55a2490fd6407ddb6810e41f64ebd66d3af
[4/4] powerpc: Move C prototypes out of asm-prototypes.h
      https://git.kernel.org/powerpc/c/76222808fc253cb9ea66c3e0e8d1946933f25b70

cheers
