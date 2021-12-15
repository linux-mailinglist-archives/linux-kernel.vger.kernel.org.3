Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6653E474F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhLOA0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:26:46 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37967 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbhLOA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJf6V6Zz4xQs;
        Wed, 15 Dec 2021 11:26:42 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     arnd@arndb.de, Anders Roxell <anders.roxell@linaro.org>
Cc:     ndesaulniers@google.com, nathan@kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev
In-Reply-To: <20211207110228.698956-1-anders.roxell@linaro.org>
References: <20211207110228.698956-1-anders.roxell@linaro.org>
Subject: Re: [PATCH] powerpc: platforms: cell: pervasive: fix clang -Wimplicit-fallthrough
Message-Id: <163952788002.919625.12030438662288837731.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 12:02:28 +0100, Anders Roxell wrote:
> Clang warns:
> 
> arch/powerpc/platforms/cell/pervasive.c:81:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>         case SRR1_WAKEEE:
>         ^
> arch/powerpc/platforms/cell/pervasive.c:81:2: note: insert 'break;' to avoid fall-through
>         case SRR1_WAKEEE:
>         ^
>         break;
> 1 error generated.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: platforms: cell: pervasive: fix clang -Wimplicit-fallthrough
      https://git.kernel.org/powerpc/c/e89257e28e844f5d1d39081bb901d9f1183a7705

cheers
