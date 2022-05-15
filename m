Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79645276F3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiEOKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiEOKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF19592
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZK1VHPz4xZ2;
        Sun, 15 May 2022 20:31:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a4ca63dd4c4b09e1906d08fb814af5a41d0f3fcb.1644651363.git.christophe.leroy@csgroup.eu>
References: <a4ca63dd4c4b09e1906d08fb814af5a41d0f3fcb.1644651363.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Reduce csum_add() complexity for PPC64
Message-Id: <165261052038.1047019.18164887384692464073.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:40 +1000
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

On Sat, 12 Feb 2022 08:36:17 +0100, Christophe Leroy wrote:
> PPC64 does everything in C, gcc is able to skip calculation
> when one of the operands in zero.
> 
> Move the constant folding in PPC32 part.
> 
> This helps GCC and reduces ppc64_defconfig by 170 bytes.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Reduce csum_add() complexity for PPC64
      https://git.kernel.org/powerpc/c/f206fdd9d41bf7deb96219b8ca3499a5abd79b83

cheers
