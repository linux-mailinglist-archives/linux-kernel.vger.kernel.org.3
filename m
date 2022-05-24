Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F255328A9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiEXLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiEXLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A491553;
        Tue, 24 May 2022 04:15:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7l154dz4yT2;
        Tue, 24 May 2022 21:15:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210924105653.46963-1-krzysztof.kozlowski@canonical.com>
References: <20210924105653.46963-1-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 1/2] powerpc/powermac: add missing g5_phy_disable_cpu1() declaration
Message-Id: <165339059600.1718562.826859123615066589.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:56 +1000
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

On Fri, 24 Sep 2021 12:56:52 +0200, Krzysztof Kozlowski wrote:
> g5_phy_disable_cpu1() is used outside of platforms/powermac/feature.c,
> so it should have a declaration to fix W=1 warning:
> 
>   arch/powerpc/platforms/powermac/feature.c:1533:6:
>     error: no previous prototype for ‘g5_phy_disable_cpu1’ [-Werror=missing-prototypes]
> 
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/powermac: add missing g5_phy_disable_cpu1() declaration
      https://git.kernel.org/powerpc/c/cc025916b12a452df7932da528d25b2ef2b05072
[2/2] powerpc/powermac: constify device_node in of_irq_parse_oldworld()
      https://git.kernel.org/powerpc/c/bb12dd42d20f5513a8d1da225232af0a0743fd79

cheers
