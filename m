Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92284B87A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiBPMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:30:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBPMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD82A4145
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNM292zz4xml;
        Wed, 16 Feb 2022 23:30:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <6c608fd4795e2d8ea1a0a449405a0087f76d8bb3.1642752375.git.christophe.leroy@csgroup.eu>
References: <6c608fd4795e2d8ea1a0a449405a0087f76d8bb3.1642752375.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/lib/sstep: Use l1_dcache_bytes() instead of opencoding
Message-Id: <164501435210.521186.7862995446067984760.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:25:52 +1100
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

On Fri, 21 Jan 2022 08:06:27 +0000, Christophe Leroy wrote:
> Don't opencode dcache size retrieval based on whether that's ppc32 or ppc64.
> 
> Use l1_dcache_bytes()
> 
> 

Applied to powerpc/next.

[1/3] powerpc/lib/sstep: Use l1_dcache_bytes() instead of opencoding
      https://git.kernel.org/powerpc/c/67484e0de9c93b4a9187bb49f45dfdaa8dc03c0b
[2/3] powerpc/lib/sstep: Remove unneeded #ifdef __powerpc64__
      https://git.kernel.org/powerpc/c/7c3bba91999075f4cfcab0542e4eb74d2d63554b
[3/3] powerpc/lib/sstep: use truncate_if_32bit()
      https://git.kernel.org/powerpc/c/6836f099039e6c72fb548bf527345aa4345c3308

cheers
