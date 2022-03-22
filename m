Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E84E3737
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiCVDIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiCVDID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32A1EC62;
        Mon, 21 Mar 2022 20:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2CB1B81B2C;
        Tue, 22 Mar 2022 03:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DED6C340F0;
        Tue, 22 Mar 2022 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918393;
        bh=M6wFsr2l/9FSCeDSMFkG2LmCR3J9wLp8uejymEp99G8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R8mG8+YiGTabSx5vm+QNuOJfaWSnrhMYmJng5CR9yVF0HqbV/H3uuBBNrj4lwbXaG
         kYWDM3Nvq2aI9K1bB7bpk/PNQyisuA1Hpfb0a+ZXVgEhsRl2aKG5RgDEfRcXuD4OPD
         LQBLsgq8LTkf0PDrM0ZTrju8EdSNZIMsQNFKwVKtUgj72T8kYaC7v75v6QNTOL3Aaq
         efy8UnLt8cJpKbzYlfwnTqra6q42jOcU0nDFxmuO5Yx8SgKw0CrJM4YEvcSDqiM8EY
         0/wsoNCkcHudlIfHWrRl3jlt3rO1W0cm00+im4p8KLJd6UBkgi+TUr/2CXnW9pa4+v
         B3qDGQIuC87Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 798C6E7BB0B;
        Tue, 22 Mar 2022 03:06:33 +0000 (UTC)
Subject: Re: [GIT PULL] overflow updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203210821.9E5FDCA863@keescook>
References: <202203210821.9E5FDCA863@keescook>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203210821.9E5FDCA863@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.18-rc1
X-PR-Tracked-Commit-Id: 02788ebcf521fe78c24eb221fd1ed7f86792c330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0858cbdef50d973ca6b38c0ed0cce54cb2b6182
Message-Id: <164791839348.13286.3334273006964765383.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:06:33 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Richard Weinberger <richard@nod.at>,
        Vitor Massaru Iha <vitor@massaru.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 08:26:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0858cbdef50d973ca6b38c0ed0cce54cb2b6182

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
