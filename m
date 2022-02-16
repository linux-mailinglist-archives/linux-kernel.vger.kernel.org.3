Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C14B87AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiBPMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:30:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiBPMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27C2A4147
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNQ5CMyz4xn3;
        Wed, 16 Feb 2022 23:30:14 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Maxime Bizon <mbizon@freebox.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <43c3c76a1175ae6dc1a3d3b5c3f7ecb48f683eea.1640344012.git.christophe.leroy@csgroup.eu>
References: <43c3c76a1175ae6dc1a3d3b5c3f7ecb48f683eea.1640344012.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/2] powerpc/set_memory: Avoid spinlock recursion in change_page_attr()
Message-Id: <164501434734.521186.493750224564400396.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:25:47 +1100
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

On Fri, 24 Dec 2021 11:07:33 +0000, Christophe Leroy wrote:
> Commit 1f9ad21c3b38 ("powerpc/mm: Implement set_memory() routines")
> included a spin_lock() to change_page_attr() in order to
> safely perform the three step operations. But then
> commit 9f7853d7609d ("powerpc/mm: Fix set_memory_*() against
> concurrent accesses") modify it to use pte_update() and do
> the operation safely against concurrent access.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/set_memory: Avoid spinlock recursion in change_page_attr()
      https://git.kernel.org/powerpc/c/a4c182ecf33584b9b2d1aa9dad073014a504c01f
[2/2] powerpc: Add set_memory_{p/np}() and remove set_memory_attr()
      https://git.kernel.org/powerpc/c/f222ab83df92acf72691a2021e1f0d99880dcdf1

cheers
