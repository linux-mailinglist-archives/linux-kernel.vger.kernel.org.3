Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE28585097
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiG2NLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiG2NKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EEC32BAE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSYx1tLKz4x1H;
        Fri, 29 Jul 2022 23:10:45 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Maxime Bizon <mbizon@freebox.fr>,
        linux-kernel@vger.kernel.org
In-Reply-To: <db3fc14f3bfa6215b0786ef58a6e2bc1e1f964d7.1655202804.git.christophe.leroy@csgroup.eu>
References: <db3fc14f3bfa6215b0786ef58a6e2bc1e1f964d7.1655202804.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/32: Call mmu_mark_initmem_nx() regardless of data block mapping.
Message-Id: <165909975216.253830.17486621428279802843.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 12:34:08 +0200, Christophe Leroy wrote:
> mark_initmem_nx() calls either mmu_mark_initmem_nx() or
> set_memory_attr() based on return from v_block_mapped()
> of _sinittext.
> 
> But we can now handle text and data independently, so that
> text may be mapped by block even when data is mapped by pages.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/32: Call mmu_mark_initmem_nx() regardless of data block mapping.
      https://git.kernel.org/powerpc/c/980bbf7ca72012d317617fcdbfabe8708e4cef29
[2/2] powerpc/32: Set an IBAT covering up to _einittext during init
      https://git.kernel.org/powerpc/c/2a0fb3c155c97c75176e557d61f8e66c1bd9b735

cheers
