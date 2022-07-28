Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E60583BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiG1KCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiG1KCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:02:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495742AFE;
        Thu, 28 Jul 2022 03:02:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtmR34rGLz4x1S;
        Thu, 28 Jul 2022 20:02:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659002545;
        bh=sPwx65IXOXOfoP6X8JNfSvi/mfHaolNTY7UuZAPTHxM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bTJwS0MmN71BhGqdr8ToWBSJvA6AplKAolqClqT1iGsuHDBv64mAEpIcQQshIye2q
         HKTuJo6OZRytt6xw62TKmUMiQ8vffCP2zL1Rsa+EXaeUil62i//DyOa1V+g/MTdp/t
         +Lb7zXH4ZernE31Yo+B3raBw+pncu+fIqCuOvfROyGIJe8uNmRYA7JQX0O9MfYdthM
         h70R+U6xgOLRCrQ8OuVyFYHmK1I2DobOEoV8Fbjp++jf48Anjmo8ZMVVFxPPzOR60+
         sgaWV7Gi4u07L+19Pc3c6AZqqXBLbVgn7+L5aSVIZVcdTw55v4L7N7KO701LIXF5XQ
         Wcmys6hA+Olpg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Nicholas Piggin <npiggin@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/3] Documentation: powerpc: documentation fixes for
 Documentation/powerpc/elf_hwcaps.rst
In-Reply-To: <20220728033332.27836-1-bagasdotme@gmail.com>
References: <20220727220050.549db613@canb.auug.org.au>
 <20220728033332.27836-1-bagasdotme@gmail.com>
Date:   Thu, 28 Jul 2022 20:02:22 +1000
Message-ID: <87fsila72p.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:
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
>  Documentation/arm64/elf_hwcaps.rst              |  2 +-
>  Documentation/powerpc/elf_hwcaps.rst            | 17 +++++++----------
>  Documentation/powerpc/index.rst                 |  1 +
>  .../translations/zh_CN/arm64/elf_hwcaps.rst     |  2 +-
>  .../translations/zh_TW/arm64/elf_hwcaps.rst     |  2 +-
>  5 files changed, 11 insertions(+), 13 deletions(-)

Hi Bagas,

I'd actually already fixed these locally, but I'll take your versions
because you went to all the trouble of sending them :)

I've modified patch 2 to only change the powerpc label name, I don't
want to be touching the arm64 documentation this late in the development
cycle.

I've also installed every python package on earth and got my development
machine setup to build the docs again, so hopefully I'll catch errors
like this in future.

cheers
