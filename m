Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4B4CA525
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbiCBMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbiCBMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8BBAF1E1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4x36H9z4xvB;
        Wed,  2 Mar 2022 23:46:41 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
References: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc/ftrace: Also save r1 in ftrace_caller()
Message-Id: <164622488126.2052779.3499748574130781194.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:21 +1100
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

On Tue, 15 Feb 2022 19:31:22 +0100, Christophe Leroy wrote:
> Also save r1 in ftrace_caller()
> 
> r1 is needed during unwinding when the function_graph tracer
> is active.
> 
> 

Applied to powerpc/next.

[1/4] powerpc/ftrace: Also save r1 in ftrace_caller()
      https://git.kernel.org/powerpc/c/34d8dac807f0ee3dc42ab45bdb284a3caf2b5ed1
[2/4] powerpc/ftrace: Add recursion protection in prepare_ftrace_return()
      https://git.kernel.org/powerpc/c/df45a55788286c541449d82ee09fef3ac5ff77a1
[3/4] powerpc/ftrace: Have arch_ftrace_get_regs() return NULL unless FL_SAVE_REGS is set
      https://git.kernel.org/powerpc/c/fc75f87337983229b7355d6b77f30fb6e7f359ee
[4/4] powerpc/ftrace: Style cleanup in ftrace_mprofile.S
      https://git.kernel.org/powerpc/c/76b372814b088aeb76f0f753d968c8aa6d297f2a

cheers
