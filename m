Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10456371B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiGAPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011D3FBF7;
        Fri,  1 Jul 2022 08:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FF9623EB;
        Fri,  1 Jul 2022 15:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B666CC341C7;
        Fri,  1 Jul 2022 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656690111;
        bh=ODroCSaMiCiiMuCAo/Z3iSOvHvZXIuLHPYKFNrg/KRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiQ687KcF2DpmTocqn+IqFonoM2D1Iv9qoOOYzswDiwDl8kIZ2Z0qlI0/rhSTau4E
         3NSpFKO6D400f0ml/7ooOyUGCByYYT+YhJkydmYqWcdsZVCgaZyENhgu/3ia78y1dA
         iupUxZqsKuD5IxxerfCRctAPN6rlzunZ45REOCH40ehUKHtZqwoY1wU3Tw8tGwoxrq
         bse6g9NBDfLrf9wgVop19aWpzHH1s7wARLooYxLJqzSbnEopXMrGf6Y1Csttwn6GRo
         aBmHHJm/+DC3rpDQrb7dTqMrxC6c2FPPpw/RfoOuZiNhDzB5pqFluAfLcQUR1oorY6
         gTJldSwi7SSFA==
From:   Will Deacon <will@kernel.org>
To:     linux-trace-devel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Collingbourne <pcc@google.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 0/1] Remove forget_syscall() from start_thread_common()
Date:   Fri,  1 Jul 2022 16:41:28 +0100
Message-Id: <165667517849.792239.13818767623596011011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220608162447.666494-1-flaniel@linux.microsoft.com>
References: <20220608162447.666494-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 17:24:45 +0100, Francis Laniel wrote:
> First, I hope you are fine and the same for your relatives.
> 
> With this contribution, I enabled using syscalls:sys_exit_execve and
> syscalls:sys_exit_execveat as tracepoints on arm64.
> Indeed, before this contribution, the above tracepoint would not print their
> information as syscall number was set to -1 by calling forget_syscall().
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Do not forget syscall when starting a new thread.
      https://git.kernel.org/arm64/c/de6921856f99

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
