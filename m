Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66838474F32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhLOA1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbhLOA0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB7C061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:26:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJm1C1bz4xhr;
        Wed, 15 Dec 2021 11:26:48 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1f0ede830ccb33a659119a55cb590820c27004db.1638208156.git.christophe.leroy@csgroup.eu>
References: <1f0ede830ccb33a659119a55cb590820c27004db.1638208156.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5 1/5] powerpc/inst: Refactor ___get_user_instr()
Message-Id: <163952787871.919625.8366650351098120185.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 18:49:37 +0100, Christophe Leroy wrote:
> PPC64 version of ___get_user_instr() can be used for PPC32 as well,
> by simply disabling the suffix part with IS_ENABLED(CONFIG_PPC64).
> 
> 

Applied to powerpc/next.

[1/5] powerpc/inst: Refactor ___get_user_instr()
      https://git.kernel.org/powerpc/c/3261d99adba269a024d0e55737beeedec5eba00e
[2/5] powerpc/inst: Define ppc_inst_t
      https://git.kernel.org/powerpc/c/c545b9f040f341038d5228932140fb17e0c156e2
[3/5] powerpc/inst: Define ppc_inst_t as u32 on PPC32
      https://git.kernel.org/powerpc/c/07b863aef5b682a482474b524f3df4957d2862ac
[4/5] powerpc/inst: Move ppc_inst_t definition in asm/reg.h
      https://git.kernel.org/powerpc/c/9b307576f37136d37d5e42b1d8713ec34a601a62
[5/5] powerpc/inst: Optimise copy_inst_from_kernel_nofault()
      https://git.kernel.org/powerpc/c/0d76914a4c99ab5658f3fb07cdf3799d28e2eab3

cheers
