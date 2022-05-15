Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366F5276F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiEOKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiEOKbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67FAE52
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZM5ZdNz4xZq;
        Sun, 15 May 2022 20:31:07 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1647962456.git.christophe.leroy@csgroup.eu>
References: <cover.1647962456.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 0/4] Kill the time spent in patch_instruction()
Message-Id: <165261053687.1047019.4165741740473209888.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:56 +1000
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

On Tue, 22 Mar 2022 16:40:17 +0100, Christophe Leroy wrote:
> This series reduces by 70% the time required to activate
> ftrace on an 8xx with CONFIG_STRICT_KERNEL_RWX.
> 
> Measure is performed in function ftrace_replace_code() using mftb()
> around the loop.
> 
> With the series,
> - Without CONFIG_STRICT_KERNEL_RWX, 416000 TB ticks are measured.
> - With CONFIG_STRICT_KERNEL_RWX, 546000 TB ticks are measured.
> 
> [...]

Patches 1, 3 and 4 applied to powerpc/next.

[1/4] powerpc/code-patching: Don't call is_vmalloc_or_module_addr() without CONFIG_MODULES
      https://git.kernel.org/powerpc/c/cb3ac45214c03852430979a43180371a44b74596
[3/4] powerpc/code-patching: Use jump_label for testing freed initmem
      https://git.kernel.org/powerpc/c/b033767848c4115e486b1a51946de3bee2ac0fa6
[4/4] powerpc/code-patching: Use jump_label to check if poking_init() is done
      https://git.kernel.org/powerpc/c/1751289268ef959db68b0b6f798d904d6403309a

cheers
