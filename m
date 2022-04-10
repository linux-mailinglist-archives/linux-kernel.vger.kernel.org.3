Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA874FADD5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiDJMaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiDJMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:30:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B0035AAF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 05:28:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KbrqM5B0Fz4xL4;
        Sun, 10 Apr 2022 22:27:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <89cf27bf43ee07a0b2879b9e8e2f5cd6386a3645.1648366338.git.christophe.leroy@csgroup.eu>
References: <89cf27bf43ee07a0b2879b9e8e2f5cd6386a3645.1648366338.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64: Fix build failure with allyesconfig in book3s_64_entry.S
Message-Id: <164959362678.1306388.2413338700188573457.b4-ty@ellerman.id.au>
Date:   Sun, 10 Apr 2022 22:27:06 +1000
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

On Sun, 27 Mar 2022 09:32:26 +0200, Christophe Leroy wrote:
> Using conditional branches between two files is hasardous,
> they may get linked to far from each other.
> 
> 	arch/powerpc/kvm/book3s_64_entry.o:(.text+0x3ec): relocation truncated
> 	to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common'
> 	defined in .text section in arch/powerpc/kernel/head_64.o
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64: Fix build failure with allyesconfig in book3s_64_entry.S
      https://git.kernel.org/powerpc/c/af41d2866f7d75bbb38d487f6ec7770425d70e45

cheers
