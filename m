Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470514CA523
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiCBMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiCBMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B85D8AE4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4z1XYWz4xvG;
        Wed,  2 Mar 2022 23:46:43 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
References: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/interrupt: Remove struct interrupt_state
Message-Id: <164622490826.2052779.1956163553651248861.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:48 +1100
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

On Fri, 25 Feb 2022 17:36:22 +0100, Christophe Leroy wrote:
> Since commit ceff77efa4f8 ("powerpc/64e/interrupt: Use new interrupt
> context tracking scheme") struct interrupt_state has been empty and
> unused.
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/interrupt: Remove struct interrupt_state
      https://git.kernel.org/powerpc/c/973e2e6462405d85d3e8bb02d516d5fe6d1193ed

cheers
