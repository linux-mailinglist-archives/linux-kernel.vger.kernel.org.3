Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A03A5653B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiGDLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiGDLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9411463
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fB4CwDz4xZh;
        Mon,  4 Jul 2022 21:36:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <715e644fb3c7d992c0b71f6165ab6cf8c682055a.1655706069.git.christophe.leroy@csgroup.eu>
References: <715e644fb3c7d992c0b71f6165ab6cf8c682055a.1655706069.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove _PAGE_SAO stub for book3e/64
Message-Id: <165693441123.9954.5396439090389348451.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:31 +1000
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

On Mon, 20 Jun 2022 08:21:22 +0200, Christophe Leroy wrote:
> Since commit 634093c59a12 ("powerpc/mm: enable
> ARCH_HAS_VM_GET_PAGE_PROT"), _PAGE_SAO is used only in
> arch/powerpc/mm/book3s64/pgtable.c
> 
> The _PAGE_SAO stub defined as 0 for book3e/64 can be removed.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Remove _PAGE_SAO stub for book3e/64
      https://git.kernel.org/powerpc/c/12a9eddd239e14ccbf0ea50b3504a21bda002ba9

cheers
