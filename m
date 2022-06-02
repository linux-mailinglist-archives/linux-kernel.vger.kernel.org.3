Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C953C06B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiFBVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFBVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:37:15 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81704BCA5;
        Thu,  2 Jun 2022 14:37:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 806D4723;
        Thu,  2 Jun 2022 21:37:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 806D4723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654205829; bh=emu3MD0vFpbuAKqg2DnTP00ci/l1caFfIP/xff9yOAU=;
        h=From:To:Cc:Subject:Date:From;
        b=ohMMGb8O+3eEEk0jbxt5GAVbAp3Ih3SJAzrXuPoKzuIaAzRFM71G/hullP1DzeBYf
         LIOn+tSe+Dm/7btPfemCgAsKRNdXAZLPfu1r1ECy+XIXFHwx2jzxxzgx33TBdTCCzA
         wLN3Ko6i88T5Zh6KQsLKdG54Lrgdq0rOEl9CU71ksL35nesFkzXvwpYderJXfWWnRT
         7HbmunzOeoqaW830VaCBlameiM9BHVUtw5cvs+YJmjPztHh6bmV4HkNO50v4SH6cIQ
         mdCbyTel7slwCv1Fqk4HtFbuVW6+nnPA0eDZiiBXojZ9gvFe3+VxRwlAbcsLAchunO
         EcX1XoHPu5eAw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.19
Date:   Thu, 02 Jun 2022 15:37:21 -0600
Message-ID: <875yliycfi.fsf@meer.lwn.net>
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

The following changes since commit b86f46d5ce3e7497930be931a9a9e57480f0baff:

  docs: pdfdocs: Add space for chapter counts >= 100 in TOC (2022-05-17 13:41:26 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.19-2

for you to fetch changes up to a27e51b45e1bc57f15cffd6b9bfc38efef8cc419:

  documentation: Format button_dev as a pointer. (2022-06-01 09:34:28 -0600)

----------------------------------------------------------------
A handful of late-arriving documentation fixes and the addition of an SVG
tux logo which, I'm assured, we're going to want.

----------------------------------------------------------------
Akira Yokosawa (1):
      docs/conf.py: Cope with removal of language=None in Sphinx 5.0.0

Joel Colledge (1):
      docs: blockdev: change title to match section content

Miguel Ojeda (2):
      docs: move Linux logo into a new `images` folder
      docs: add SVG version of the Linux logo

Nelson Penn (1):
      documentation: Format button_dev as a pointer.

 Documentation/admin-guide/blockdev/index.rst |    6 +-
 Documentation/conf.py                        |    2 +-
 Documentation/{ => images}/COPYING-logo      |    8 +
 Documentation/{ => images}/logo.gif          |  Bin
 Documentation/images/logo.svg                | 2040 ++++++++++++++++++++++++++
 Documentation/input/input-programming.rst    |    6 +-
 scripts/spdxcheck-test.sh                    |    2 +-
 7 files changed, 2056 insertions(+), 8 deletions(-)
 rename Documentation/{ => images}/COPYING-logo (64%)
 rename Documentation/{ => images}/logo.gif (100%)
 create mode 100644 Documentation/images/logo.svg
