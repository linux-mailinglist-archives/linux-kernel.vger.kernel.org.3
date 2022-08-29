Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDAD5A505D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiH2Pln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Plk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:41:40 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9150586703;
        Mon, 29 Aug 2022 08:41:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C75D34B7;
        Mon, 29 Aug 2022 15:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C75D34B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661787696; bh=0+NvBxJ3q6Y6SArSwNFX5UXKy5DkKeZ4bXo8+55AO6E=;
        h=From:To:Cc:Subject:Date:From;
        b=WePNp1+Hf8dRm1Xr0+H+EsEz9wyr7pL12TdbsqN6wQbNla3CrJiPUxXZJMoe9jT5m
         QdnENUHoMhnVIIFA9m2nEydGPKmYWK8wuWbyq82WFRdvqbgYPG2erDXxjFQwWqjiC2
         0XSzj9iZKGI6ce8bbM0NUlx95HBe+549J8AR6xXWm81PRDq+nQU3e5JHvcHwblQr5b
         M7T8/eLFmEaz9GmoIqPe1lKXRuSQt3ZmyAPzFkaePs2V9mooruI0eOYmRlxyLN69WB
         Ydio1e/nkmIryU1iPPcp6PUkemVbs4IyQ+c00HGNs+hBiU/h6WbMVwN3PrMfKY+Bo6
         PW7ftIM6aG7ow==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.0
Date:   Mon, 29 Aug 2022 09:41:35 -0600
Message-ID: <871qszrr9s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.0-fixes

for you to fetch changes up to 5479d6d4bf122d4b137659559a7bd17784b97b7e:

  docs/conf.py: add function attribute '__fix_address' to conf.py (2022-08-26 16:47:13 -0600)

----------------------------------------------------------------
A handful of fixes for documentation and the docs build system.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs: kerneldoc-preamble: Test xeCJK.sty before loading
      docs/ja_JP/SubmittingPatches: Remove reference to submitting-drivers.rst

Kairui Song (1):
      Docs/admin-guide/mm/damon/usage: fix the example code snip

Lukas Bulwahn (1):
      docs: Update version number from 5.x to 6.x in README.rst

Menglong Dong (1):
      docs/conf.py: add function attribute '__fix_address' to conf.py

 Documentation/admin-guide/README.rst               | 30 +++++++++++-----------
 Documentation/admin-guide/mm/damon/usage.rst       | 18 ++++++-------
 Documentation/conf.py                              |  1 +
 Documentation/sphinx/kerneldoc-preamble.sty        | 22 +++++++++++-----
 Documentation/translations/ja_JP/SubmittingPatches |  3 +--
 5 files changed, 42 insertions(+), 32 deletions(-)
