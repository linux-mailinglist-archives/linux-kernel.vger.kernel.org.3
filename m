Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710D5276FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiEOKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiEOKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9CAE79
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZN5Dpdz4xXS;
        Sun, 15 May 2022 20:31:08 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3c88286b55413730d7784133993a46ef4a3607ce.1646767214.git.christophe.leroy@csgroup.eu>
References: <3c88286b55413730d7784133993a46ef4a3607ce.1646767214.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/6] powerpc/64: Move pci_device_from_OF_node() out of asm/pci-bridge.h
Message-Id: <165261052726.1047019.3527577954247343677.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:47 +1000
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

On Tue, 8 Mar 2022 20:20:20 +0100, Christophe Leroy wrote:
> Move pci_device_from_OF_node() in pci64.c because it needs definition
> of struct device_node and is not worth inlining.
> 
> ppc32.c already has it in pci32.c.
> 
> That way pci-bridge.h doesn't need linux/of.h (Brought by asm/prom.h
> via asm/pci.h)
> 
> [...]

Applied to powerpc/next.

[1/6] powerpc/64: Move pci_device_from_OF_node() out of asm/pci-bridge.h
      https://git.kernel.org/powerpc/c/0aa297e73bba35bedadbd2d452c62d643dfd4a32
[2/6] powerpc: Don't include asm/prom.h in asm/parport.h
      https://git.kernel.org/powerpc/c/07071346bb76f4fbc2c1ca8894ec3d3ad2f22577
[3/6] powerpc: Include asm/reg.h in asm/svm.h
      https://git.kernel.org/powerpc/c/eb4713c40a619046af99586743d48b9b4435d371
[4/6] powerpc: Add missing declaration in asm/drmem.h
      https://git.kernel.org/powerpc/c/669df99c957561dddf580ec269fb4255c41dabc1
[5/6] powerpc: Remove asm/prom.h from all files that don't need it
      https://git.kernel.org/powerpc/c/86c38fec69a461846d84f250f281e8cfbe54b25a
[6/6] powerpc: Add missing headers
      https://git.kernel.org/powerpc/c/e6f6390ab7b9d649c13de2c8a591bce61a10ec3b

cheers
