Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A04D16E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbiCHMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCHMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:11:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CBD3ED19
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:10:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCZ0c0yctz4xcl;
        Tue,  8 Mar 2022 23:10:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ec286d2cc6989668a96f14543275437d2f3f0e3a.1645099283.git.christophe.leroy@csgroup.eu>
References: <ec286d2cc6989668a96f14543275437d2f3f0e3a.1645099283.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc/ftrace: Don't use lmw/stmw in ftrace_regs_caller()
Message-Id: <164674129368.3322453.9191334445476386091.b4-ty@ellerman.id.au>
Date:   Tue, 08 Mar 2022 23:08:13 +1100
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

On Thu, 17 Feb 2022 13:01:56 +0100, Christophe Leroy wrote:
> For the same reason as commit a85c728cb5e1 ("powerpc/32: Don't use
> lmw/stmw for saving/restoring non volatile regs"), don't use
> lmw/stmw in ftrace_regs_caller().
> 
> Use the same macros for PPC32 and PPC64.
> 
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/ftrace: Don't use lmw/stmw in ftrace_regs_caller()
      https://git.kernel.org/powerpc/c/9bdb2eec3dde4d66b71cb4bbaebde0caed2cf0e3
[2/4] powerpc/ftrace: Refactor ftrace_{regs_}caller
      https://git.kernel.org/powerpc/c/228216716cb5f9a19d70bfc40bdc0d6a7fb7e72f
[3/4] powerpc/ftrace: Regroup PPC64 specific operations in ftrace_mprofile.S
      https://git.kernel.org/powerpc/c/a5f04d1f2724db036ba4087873c0691881932bc9
[4/4] powerpc/ftrace: Use STK_GOT in ftrace_mprofile.S
      https://git.kernel.org/powerpc/c/2ca48dbb210767b9e7166d7d47febc8fcd1da6e1

cheers
