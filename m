Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD11585090
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiG2NLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiG2NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7F4198D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ056Wpz4xG4;
        Fri, 29 Jul 2022 23:10:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/5] powerpc/32: Do not allow selection of e5500 or e6500 CPUs on PPC32
Message-Id: <165909976455.253830.10900913181823665074.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 16:19:29 +0200, Christophe Leroy wrote:
> Commit 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> enlarged the CPU selection logic to PPC32 by removing depend to
> PPC64, and failed to restrict that depend to E5500_CPU and E6500_CPU.
> Fortunately that got unnoticed because -mcpu=8540 will override the
> -mcpu=e500mc64 or -mpcu=e6500 as they are ealier, but that's
> fragile and may no be right in the future.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/32: Do not allow selection of e5500 or e6500 CPUs on PPC32
      https://git.kernel.org/powerpc/c/9be013b2a9ecb29b5168e4b9db0e48ed53acf37c
[2/5] powerpc/32: Don't always pass -mcpu=powerpc to the compiler
      https://git.kernel.org/powerpc/c/446cda1b21d9a6b3697fe399c6a3a00ff4a285f5
[3/5] powerpc/405: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
      https://git.kernel.org/powerpc/c/ff27d9200a98757efc7c2cdf198904fd79cf4ffd
[4/5] powerpc/44x: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
      https://git.kernel.org/powerpc/c/2255411d1d0f0661d1e5acd5f6edf4e6652a345a
[5/5] powerpc/64e: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
      https://git.kernel.org/powerpc/c/d6b551b8f90cc92c7d3c09cf38c748efe305ecb4

cheers
