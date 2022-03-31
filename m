Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEE4EDDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiCaPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiCaPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:52:00 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDB5BE4B;
        Thu, 31 Mar 2022 08:50:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0954C491;
        Thu, 31 Mar 2022 15:50:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0954C491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648741810; bh=7QB0b0ssGKQvmjLjiPTHQVpkKPWURloFMy9AGd8X2iw=;
        h=From:To:Cc:Subject:Date:From;
        b=A3Wz45X55uKzA2H5oZcNnT70v/WxC4ufpWMV0civt0VlgpYYql3lTtJkNHp9/QCrL
         AD5TVKdh9bm4BMX8+uLJEX4tMypbRiES4EJFTihZ8EFPO7W/6yJHEQMJH677WFwMkM
         X7YnqDeB+jjdiE9uZPFy5HkHJn9tnjH7GLlFvZEXifoO+Fp8DuvrM0qKfW9qjRlfg1
         RqhQHRm8oWMbvrY5Ve3bS5K+q5HgNpJKuNIK4gstnAgXI0N4Lb4GF5hI0NIQJ6QVqI
         aJYdzU+inuc72K2DzPl10R7irRblkmYoe+Dd1LbmpOMb97kvaA9mFig3ZxD+uu2Y0J
         FhX569nIcr26Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] More docs for 5.18
Date:   Thu, 31 Mar 2022 09:50:09 -0600
Message-ID: <87fsmy15qm.fsf@meer.lwn.net>
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

The following changes since commit 75c05fabb873367d9e64f063dda8a310c4c58826:

  docs/kernel-parameters: update description of mem= (2022-03-16 15:57:56 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.18-2

for you to fetch changes up to 022bb490c79799229ef467d9ccc3e5966001b0ae:

  docs: Add a document on how to fix a messy diffstat (2022-03-30 13:45:15 -0600)

----------------------------------------------------------------
Some late-arriving documentation improvements.  This is mostly build-system
fixes from Mauro and Akira; I also took the liberty of dropping in my
"messy diffstat" document.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs: kfigure.py: Don't warn of missing PDF converter in 'make htmldocs'
      docs: sphinx/requirements: Limit jinja2<3.1

David Gow (1):
      Documentation: kunit: Fix cross-referencing warnings

Guilherme G. Piccoli (1):
      Documentation: Fix duplicate statement about raw_spinlock_t type

Jonathan Corbet (1):
      docs: Add a document on how to fix a messy diffstat

Mauro Carvalho Chehab (6):
      scripts/get_feat.pl: allow output the parsed file names
      docs: kernel_feat.py: add build dependencies
      docs: kernel_abi.py: add sphinx build dependencies
      docs: kernel_include.py: add sphinx build dependencies
      scripts/get_abi: change the file/line number meta info
      scripts/kernel-doc: change the line number meta info

 Documentation/dev-tools/kunit/architecture.rst | 13 +---
 Documentation/locking/locktypes.rst            |  3 -
 Documentation/maintainer/index.rst             |  1 +
 Documentation/maintainer/messy-diffstat.rst    | 96 ++++++++++++++++++++++++++
 Documentation/sphinx/kernel_abi.py             |  6 +-
 Documentation/sphinx/kernel_feat.py            | 20 +++++-
 Documentation/sphinx/kernel_include.py         |  3 +
 Documentation/sphinx/kerneldoc.py              |  2 +-
 Documentation/sphinx/kfigure.py                |  8 ++-
 Documentation/sphinx/requirements.txt          |  2 +
 scripts/get_abi.pl                             |  4 +-
 scripts/get_feat.pl                            | 11 +++
 scripts/kernel-doc                             |  4 +-
 13 files changed, 148 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/maintainer/messy-diffstat.rst
