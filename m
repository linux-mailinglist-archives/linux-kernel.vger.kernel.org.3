Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306C5A7E62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiHaNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiHaNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:12:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD8C697C;
        Wed, 31 Aug 2022 06:12:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHl2r5mBlz4xGF;
        Wed, 31 Aug 2022 23:12:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
In-Reply-To: <20220820165129.1147589-1-masahiroy@kernel.org>
References: <20220820165129.1147589-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: align syscall table for ppc32
Message-Id: <166195152285.42804.18346309084097390915.b4-ty@ellerman.id.au>
Date:   Wed, 31 Aug 2022 23:12:02 +1000
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

On Sun, 21 Aug 2022 01:51:29 +0900, Masahiro Yamada wrote:
> Christophe Leroy reported that commit 7b4537199a4a ("kbuild: link
> symbol CRCs at final link,  removing CONFIG_MODULE_REL_CRCS") broke
> mpc85xx_defconfig + CONFIG_RELOCATABLE=y.
> 
>     LD      vmlinux
>     SYSMAP  System.map
>     SORTTAB vmlinux
>     CHKREL  vmlinux
>   WARNING: 451 bad relocations
>   c0b312a9 R_PPC_UADDR32     .head.text-0x3ff9ed54
>   c0b312ad R_PPC_UADDR32     .head.text-0x3ffac224
>   c0b312b1 R_PPC_UADDR32     .head.text-0x3ffb09f4
>   c0b312b5 R_PPC_UADDR32     .head.text-0x3fe184dc
>   c0b312b9 R_PPC_UADDR32     .head.text-0x3fe183a8
>       ...
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: align syscall table for ppc32
      https://git.kernel.org/powerpc/c/c7acee3d2f128a38b68fb7af85dbbd91bfd0b4ad

cheers
