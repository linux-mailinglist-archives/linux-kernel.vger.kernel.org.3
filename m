Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91458C83C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbiHHMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiHHMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:16:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397115822
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ED49B80E23
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1ACC433D7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659960987;
        bh=nd9qSzVuz6+8Om6rNCJyCaTz3wF+dMc9yF5/1mXlboo=;
        h=From:Date:Subject:To:Cc:From;
        b=MDBMbxE73Ud9GQe3F9J+1DUKawN+Deq/OlauI1KOXUJHgWyB60JcFlh8zINcDOq8m
         NKBuelO7OZ2Tv84TWDM2Vv6BnM5iTBlRTgI4FgD7HhBiJLsuDteHnsHMATn6Ck3l8P
         rXXMZ1oXwNixLeyUahysH6qcX70CjjoDqv0j2XC/vAH/rr395oDf8dcYihINku6p3B
         N95nEHVmAcrVb+2LEEFvMkHwL3bDbZreiURCUPeRiale31fZFM7MsT3LG0BMHtdLr2
         xh+eI+qbIMIgNuqeWEOpZDgfu6Ny4UYh5lcNG3FwEwfUPb4P8D/bFJWZKJEmwdibLg
         NZHC/ZFyzQPhw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-10e6bdbe218so10268768fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:16:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo11lhwV8ZIr4Dwf84a+Y/yBQeAsTUlWCDLf4OTqRKakxiFy6GgI
        fpKHrc8E14ueChNxO8++e+1M1Zxk8cYI1LX951o=
X-Google-Smtp-Source: AA6agR6XJr+AWT5vgttNe+wYU0RGO7Q1sWYE/xdjvLtuIJzrTKbX+vWW7JlDTEPjog0LDGjj2dnZrrsOy2/CZW5eeyU=
X-Received: by 2002:a05:6870:b00b:b0:113:5b32:3d4d with SMTP id
 y11-20020a056870b00b00b001135b323d4dmr6452310oae.8.1659960986177; Mon, 08 Aug
 2022 05:16:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Mon, 8 Aug 2022 05:16:25
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 8 Aug 2022 21:16:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_tBecDJSiJF0LLRzkC5UfwzXVU+mvcBn-7+e1mzbgagQ@mail.gmail.com>
Message-ID: <CAKYAXd_tBecDJSiJF0LLRzkC5UfwzXVU+mvcBn-7+e1mzbgagQ@mail.gmail.com>
Subject: [GIT PULL] exfat update for 5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.20-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-5.20-rc1

for you to fetch changes up to df13a3477635414f243d53344bb4b510385e994d:

  MAINTAINERS: Add Namjae's exfat git tree (2022-08-01 10:14:07 +0900)

----------------------------------------------------------------
Description for this pull request:
 - fix the error code of rename syscall.
 - cleanup and suppress the superfluous error messages.
 - remove duplicate directory entry update.
 - add exfat git tree in MAINTAINERS.

----------------------------------------------------------------
Petr Vorel (1):
      MAINTAINERS: Add Namjae's exfat git tree

Takashi Iwai (5):
      exfat: Return ENAMETOOLONG consistently for oversized paths
      exfat: Define NLS_NAME_* as bit flags explicitly
      exfat: Expand exfat_err() and co directly to pr_*() macro
      exfat: Downgrade ENAMETOOLONG error message to debug messages
      exfat: Drop superfluous new line for error messages

Yuezhang Mo (3):
      exfat: reuse __exfat_write_inode() to update directory entry
      exfat: remove duplicate write inode for truncating file
      exfat: remove duplicate write inode for extending dir/file

 MAINTAINERS         |  1 +
 fs/exfat/exfat_fs.h | 19 +++++++------
 fs/exfat/fatent.c   |  2 +-
 fs/exfat/file.c     | 82 +++++++++++++++++------------------------------------
 fs/exfat/inode.c    | 41 +++++++--------------------
 fs/exfat/misc.c     | 17 -----------
 fs/exfat/namei.c    | 22 +-------------
 fs/exfat/nls.c      |  4 +--
 fs/exfat/super.c    |  4 +--
 9 files changed, 54 insertions(+), 138 deletions(-)
