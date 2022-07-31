Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3387B58600A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiGaQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGaQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706BBAE4E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102A560FA2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C9C433D6;
        Sun, 31 Jul 2022 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286676;
        bh=C/F0EfpnyeQpggY2k+3Nc4FV3FsbcipZfmwroGRCehw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=a2SyGynWt8qGUEeIvq7QIXGJBPcNbdg9lPxdj2rlnp/QiAz2g62L8WPb4KbwTPrT7
         TmQRsi/vGE7Lnla6aJdKcrVVSu3sZwxOBiGCCwVBmi/5sxeric/RqkmjlMfC4niDJq
         dOWSostYM2CIO01Ozah4LW4kd9bho4qKbbvcl+Rz1qvWjxro7BwmaXnE5gNGdsp2de
         2WEX6K578w8h1do38E1xLsyrDG3pglxkK+sOnmcUZNQp4aU09wo7aHC+dZZzklpvjZ
         /x7pUQrNpRx/AtEcotv+yAPDpBcDpHIbMNIvu/URabWxZhph2qkxSHc7cv89FHNomN
         faBXxQp1Ab2Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 11ABE5C0514; Sun, 31 Jul 2022 09:57:56 -0700 (PDT)
Date:   Sun, 31 Jul 2022 09:57:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, w@1wt.eu,
        alviro.iskandar@gnuweeb.org, ammarfaizi2@gnuweeb.org
Subject: [GIT PULL] nolibc changes for v5.20 (or whatever)
Message-ID: <20220731165756.GA3034113@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.07.27a
  # HEAD 4f8126f3a665456b68ae923cd7a7e9b9eb98547d: tools/nolibc: add a help target to list supported targets (2022-06-20 09:43:19 -0700)

----------------------------------------------------------------
nolibc pull request for v5.20 (or whatever)

This branch provides nolibc updates, perhaps most notably improved testing
via the "cd tools/include/nolibc; make headers" command.  This should
be considered a smoke test.  More thorough testing is in the works.

----------------------------------------------------------------
Alviro Iskandar Setiawan (1):
      tools/nolibc/stdio: Add format attribute to enable printf warnings

Ammar Faizi (1):
      tools/nolibc/stdlib: Support overflow checking for older compiler versions

Willy Tarreau (3):
      tools/nolibc: fix the makefile to also work as "make -C tools ..."
      tools/nolibc: make the default target build the headers
      tools/nolibc: add a help target to list supported targets

 tools/Makefile                |  3 +++
 tools/include/nolibc/Makefile | 37 +++++++++++++++++++++++++++++++++++--
 tools/include/nolibc/stdio.h  |  4 ++--
 tools/include/nolibc/stdlib.h |  7 +++----
 4 files changed, 43 insertions(+), 8 deletions(-)
