Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C099544FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiFIOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiFIOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:45:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E22A73B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:45:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJn2D62bSz4xZ0;
        Fri, 10 Jun 2022 00:45:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Scott Wood <oss@buserror.net>,
        Frank Rowand <frank.rowand@sony.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        Diana Craciun <diana.craciun@nxp.com>
In-Reply-To: <20220604085050.4078927-1-masahiroy@kernel.org>
References: <20220604085050.4078927-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: get rid of #include <generated/compile.h>
Message-Id: <165478587541.589231.1462511723617855253.b4-ty@ellerman.id.au>
Date:   Fri, 10 Jun 2022 00:44:35 +1000
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

On Sat, 4 Jun 2022 17:50:50 +0900, Masahiro Yamada wrote:
> You cannot include <generated/compile.h> here because it is generated
> in init/Makefile but there is no guarantee that it happens before
> arch/powerpc/mm/nohash/kaslr_booke.c is compiled for parallel builds.
> 
> The places where you can reliably include <generated/compile.h> are:
> 
>   - init/          (because init/Makefile can specify the dependency)
>   - arch/*/boot/   (because it is compiled after vmlinux)
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: get rid of #include <generated/compile.h>
      https://git.kernel.org/powerpc/c/7ad4bd887d27c6b6ffbef216f19c19f8fe2b8f52

cheers
