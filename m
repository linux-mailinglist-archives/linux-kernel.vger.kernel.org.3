Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C816B531021
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiEWNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiEWNGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE511C29
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D338361349
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C3EC385AA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311159;
        bh=KNZd246A+U2gSpUP4pHbyKW6lW1Ntblp4/fdISMCRws=;
        h=From:Date:Subject:To:Cc:From;
        b=L6PNywv5NE4Nj4zo0B9SvMcPQxUKoBGdfedN8KFbjMvQjoV4tqib1c/65JguY0vTK
         cqPouktSdsrPDKm2LZqXs7k3HpBEt5Ky3jEgkDAYepEF15SbfUHZi8X1CCLkEe2fm9
         8WUhaRmXLa0C0r8yPlp3CzGSjZloyb3mX8u9519GPk6vyNZAWDIXq9/LAbYGcJG2sM
         j16fbDGRLG2S+r+rtP2qQov45KLVcfZp3Pu2h9cBaL2uOkB7guRgAZJ4nonElO1Yyv
         8VEUO1mdlop8JsRpRFbUFuNWNZEasYXKZB/6FilgYpBrf+tOKr2+xv9Hn0VYPN+cSD
         IRa6ALX8QQMRQ==
Received: by mail-wm1-f42.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so5318492wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:05:59 -0700 (PDT)
X-Gm-Message-State: AOAM531mqXZ0P09EtT3/Si4KBb08rgmf6PsW0+yubzZ43q7WhcLpVwPr
        tsutedi877bfPVEM79tIqB0SRnKbxaCLwRDqCMc=
X-Google-Smtp-Source: ABdhPJyQW0Y4GbMJ69RiNsvCCk0x3R9H3VaMcMUcy7aJ/YDDWCShq3gITIH8Jq72/2EoAStyv28qvLdBiZPpxWqa/X4=
X-Received: by 2002:a05:600c:19cd:b0:397:4897:8bfd with SMTP id
 u13-20020a05600c19cd00b0039748978bfdmr6260321wmq.9.1653311157461; Mon, 23 May
 2022 06:05:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f344:0:0:0:0:0 with HTTP; Mon, 23 May 2022 06:05:56
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 23 May 2022 22:05:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_tOxGD7syqV17YEbpNkcmi3-cNoLz5mKneXyLGbQyjhA@mail.gmail.com>
Message-ID: <CAKYAXd_tOxGD7syqV17YEbpNkcmi3-cNoLz5mKneXyLGbQyjhA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.19-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-5.19-rc1

for you to fetch changes up to 64ba4b15e5c045f8b746c6da5fc9be9a6b00b61d:

  exfat: check if cluster num is valid (2022-05-23 11:17:30 +0900)

----------------------------------------------------------------
Description for this pull request:
 - fix referencing wrong parent directory information during rename.
 - introduce a sys_tz mount option to use system timezone.
 - improve performance while zeroing a cluster with dirsync mount option.
 - fix slab-out-bounds in exat_clear_bitmap() reported from syzbot.

----------------------------------------------------------------
Chung-Chiang Cheng (1):
      exfat: introduce mount option 'sys_tz'

Tadeusz Struk (1):
      exfat: check if cluster num is valid

Yuezhang Mo (3):
      exfat: fix referencing wrong parent directory information after renaming
      block: add sync_blockdev_range()
      exfat: reduce block requests when zeroing a cluster

 block/bdev.c           |  7 +++++++
 fs/exfat/balloc.c      |  8 ++++++--
 fs/exfat/exfat_fs.h    |  7 +++++++
 fs/exfat/fatent.c      | 47 +++++++++++++++++------------------------------
 fs/exfat/misc.c        | 10 ++++++++--
 fs/exfat/namei.c       | 27 +--------------------------
 fs/exfat/super.c       |  9 ++++++++-
 include/linux/blkdev.h |  1 +
 8 files changed, 55 insertions(+), 61 deletions(-)
