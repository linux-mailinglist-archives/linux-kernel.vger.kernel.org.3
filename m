Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCB585094
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiG2NLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiG2NKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5565AF;
        Fri, 29 Jul 2022 06:10:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSYs5qW8z4x1d;
        Fri, 29 Jul 2022 23:10:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
In-Reply-To: <20220728033332.27836-1-bagasdotme@gmail.com>
References: <20220727220050.549db613@canb.auug.org.au> <20220728033332.27836-1-bagasdotme@gmail.com>
Subject: Re: [PATCH 0/3] Documentation: powerpc: documentation fixes for Documentation/powerpc/elf_hwcaps.rst
Message-Id: <165909979455.253830.7633506902686535863.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:03:14 +1000
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

On Thu, 28 Jul 2022 10:33:30 +0700, Bagas Sanjaya wrote:
> After merging powerpc tree for linux-next integration testing, Stephen
> Rothwell reported htmldocs warnings at [1]. Fix these with self-explanatory
> fixes in the shortlog below.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/20220727220050.549db613@canb.auug.org.au/
> 
> Bagas Sanjaya (3):
>   Documentation: powerpc: fix indentation warnings
>   Documentation: use different label names for each arch's
>     elf_hwcaps.rst
>   Documentation: powerpc: add elf_hwcaps to table of contents
> 
> [...]

Applied to powerpc/next.

[1/3] Documentation: powerpc: fix indentation warnings
      https://git.kernel.org/powerpc/c/4515862b66d3bdaf681cade1c72f047c93d94d01
[2/3] Documentation: use different label names for each arch's elf_hwcaps.rst
      https://git.kernel.org/powerpc/c/0595a216920cb035030c73cec3ab9fe413ef1d77
[3/3] Documentation: powerpc: add elf_hwcaps to table of contents
      https://git.kernel.org/powerpc/c/a05aae92f84ba6d2705f6dac206ef5dcf097ea96

cheers
