Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E4536CFE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiE1Mxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiE1Mxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:53:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7617BBC33
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:53:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L9M6r4GBmz4xYV;
        Sat, 28 May 2022 22:53:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e438c6cc09f94085e56733ed2d6e84333c35292a.1653370913.git.christophe.leroy@csgroup.eu>
References: <e438c6cc09f94085e56733ed2d6e84333c35292a.1653370913.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64s: Only set HAVE_ARCH_UNMAPPED_AREA when CONFIG_PPC_64S_HASH_MMU is set
Message-Id: <165374238716.3058522.2199433261105094724.b4-ty@ellerman.id.au>
Date:   Sat, 28 May 2022 22:53:07 +1000
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

On Tue, 24 May 2022 07:42:05 +0200, Christophe Leroy wrote:
> When CONFIG_PPC_64S_HASH_MMU is not set, slice.c is not built and
> arch_get_unmapped_area() and arch_get_unmapped_area_topdown() are
> not provided because RADIX uses the generic ones.
> 
> Therefore, neither set HAVE_ARCH_UNMAPPED_AREA nor
> HAVE_ARCH_UNMAPPED_AREA_TOPDOWN.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: Only set HAVE_ARCH_UNMAPPED_AREA when CONFIG_PPC_64S_HASH_MMU is set
      https://git.kernel.org/powerpc/c/c85ab4fe33065ca1fdcac26f0c00c837fe727ba7

cheers
