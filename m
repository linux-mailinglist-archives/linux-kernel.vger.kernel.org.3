Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20A5276F6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiEOKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEOKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915A765E
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZH6CDzz4xYY;
        Sun, 15 May 2022 20:31:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d2610043419ce3e0e53a85386baf2c3625af5cfb.1647877442.git.christophe.leroy@csgroup.eu>
References: <d2610043419ce3e0e53a85386baf2c3625af5cfb.1647877442.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Simplify flush_tlb_kernel_range()
Message-Id: <165261053042.1047019.17331367437728392692.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:50 +1000
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

On Mon, 21 Mar 2022 16:44:18 +0100, Christophe Leroy wrote:
> In the same spirit as commit 63f501e07a85 ("powerpc/8xx: Simplify TLB
> handling"), simplify flush_tlb_kernel_range() for 8xx.
> 
> 8xx cannot be SMP, and has 'tlbie' and 'tlbia' instructions, so
> an inline version of flush_tlb_kernel_range() for 8xx is worth it.
> 
> With this page, first leg of change_page_attr() is:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Simplify flush_tlb_kernel_range()
      https://git.kernel.org/powerpc/c/9290c379d19774d8de6e2b895d756004dbad9ce5

cheers
