Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24053666C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbiE0RMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiE0RMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:12:34 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A7D14041C;
        Fri, 27 May 2022 10:12:33 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id i25so2291140vkr.8;
        Fri, 27 May 2022 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8/qQqU5chRkK7Mkhz91frLWXZcmhm18ziBMwC1vCWao=;
        b=iTfrRXHKLmUP2IbHC38KJSP1mCT8/WLMGXUv/ikYHFXa8wCy6dKrFblC5oYVjSaS0c
         VFyolpCgoEK75jBl2sDkwtfizbzYvHb923aeONsv4U6qtb9jhmQzBbaJQhBLasWG7p10
         Zx5ESQbx9nXpJl99OUS1gCGUpAwDZP9cqd4aIJ6RADem3Unt+fwQUXc2XfAxJSud+5eL
         oHoO7U8Kvb/7DBbMUy+iw2OpoGUGY+TNylyUzsNVbzLGuAk2x2atEGaW9yrde352wcEU
         7dcf4xxXZlsGGXOwQxIjUIE3/GG59xk6+7c7Rr31dT6+XUdirLqRoq29s7sxt9YTOOkP
         UA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8/qQqU5chRkK7Mkhz91frLWXZcmhm18ziBMwC1vCWao=;
        b=XNXun2127rC0WFkG+2h8mlAffv+vgM1k2gaTHBlvptGSVU4HMakQiMTF5Opbxn17z1
         taa4ktN8LmJII4ZSoLbwBiuu02v81A44O/KfIUGQm4mpnq1CDw2TIF7W1NGH+RQ3Qkb5
         y9bYlPVZTFiwUAgtzVEr3Oxo/LYbp9cWNKY+S9HyayZYk5UKk9lNg3/4+HNcPO+30KsL
         6wBNBiUlUgD7uEL89kQj/sUfWJ2z2BnYin7mPFtPDKqnkOBTRnlpjJO3fogYWlCduBaI
         879wnipWa1fF+/EyacBIRTMa1Gq6wRaDTP5lowA/EJDIeyub1ewnw2GJZri5pTxBv5Wj
         K4kg==
X-Gm-Message-State: AOAM533LzjlDDJ5X3O+etclKwHT90pbnRqwzSh8xqyjP47QvxExwIrSh
        LFgb9A7/8jOHoPGPS1C7GO72NbCoib5dCCeLm1w=
X-Google-Smtp-Source: ABdhPJz69jIPRxF8Pmtx1to7GDByZ3Pv+MZ4z8QY9tNbyYzLzMpNvQnbN8dVqTPM53Z1DBbnSAECWhpZnX4UxE/PgqM=
X-Received: by 2002:a1f:20c3:0:b0:357:51cc:3309 with SMTP id
 g186-20020a1f20c3000000b0035751cc3309mr14423778vkg.24.1653671551068; Fri, 27
 May 2022 10:12:31 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 27 May 2022 12:12:20 -0500
Message-ID: <CAH2r5mv11JkF3ShrMLQ_PQHGSTysqF=gR9MSZsZHgR-mb-JH4g@mail.gmail.com>
Subject: [GIT PULL] SMB3 Client fixes (updated)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git
tags/5.19-rc-smb3-client-fixes-updated

for you to fetch changes up to 44a48081fc03187d3c047077f3ad3eb3a3eaf8fb:

  smb3: remove unneeded null check in cifs_readdir (2022-05-27 12:05:47 -0500)

----------------------------------------------------------------
Twenty four cifs/smb3 client fixes, including:

- a series of fixes for multichannel fixes to improve reconnect after
network failure
- improved caching of root directory contents (extending benefit of
directory leases)
- 2 DFS fixes
- 3 fixes for improved debugging
- an NTLMSSP fix for mounts t0 older servers
- new mount parm to allow disabling creating sparse files
- various cleanup fixes and minor fixes pointed out by coverity

Does not include Dave Howell's iov_iter series (converting i/o paths
in cifs.ko to use iterators) pending addressing a few things Al
just pointed out.  Also not included yet are some RDMA (smbdirect)
fixes and a patch to dynamically requery and adjust the network
interfaces on the fly which are still being tested.

----------------------------------------------------------------
ChenXiaoSong (1):
      cifs: return the more nuanced writeback error on close()

Enzo Matsumiya (3):
      cifs: don't call cifs_dfs_query_info_nonascii_quirk() if nodfs was set
      cifs: return ENOENT for DFS lookup_cache_entry()
      cifs: print TIDs as hex

Julia Lawall (1):
      cifs: smbd: fix typo in comment

Paulo Alcantara (2):
      cifs: fix signed integer overflow when fl_end is OFFSET_MAX
      cifs: fix ntlmssp on old servers

Ronnie Sahlberg (4):
      cifs: move definition of cifs_fattr earlier in cifsglob.h
      cifs: check for smb1 in open_cached_dir()
      cifs: set the CREATE_NOT_FILE when opening the directory in
use_cached_dir()
      cifs: cache the dirents for entries in a cached directory

Shyam Prasad N (3):
      cifs: do not use tcpStatus after negotiate completes
      cifs: use new enum for ses_status
      cifs: avoid parallel session setups on same channel

Steve French (10):
      SMB3: EBADF/EIO errors in rename/open caused by race condition
in smb2_compound_op
      smb3: add trace point for lease not found issue
      smb3: add trace point for oplock not found
      Add defines for various newer FSCTLs
      Add various fsctl structs
      cifs: fix minor compile warning
      smb3: check for null tcon
      smb3: don't set rc when used and unneeded in query_info_compound
      smb3: add mount parm nosparse
      smb3: remove unneeded null check in cifs_readdir

 fs/cifs/cifs_debug.c       |  11 +++-
 fs/cifs/cifsfs.c           |   2 +
 fs/cifs/cifsglob.h         | 124 +++++++++++++++++++++++++++------------
 fs/cifs/cifsproto.h        |   9 +++
 fs/cifs/cifssmb.c          |   5 +-
 fs/cifs/connect.c          | 107 ++++++++++++++++++----------------
 fs/cifs/dfs_cache.c        |   6 +-
 fs/cifs/file.c             |  13 +++--
 fs/cifs/fs_context.c       |  33 +++--------
 fs/cifs/fs_context.h       |   4 +-
 fs/cifs/misc.c             |  11 ++--
 fs/cifs/readdir.c          | 179
++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/cifs/sess.c             |  33 ++++++++++-
 fs/cifs/smb2inode.c        |   7 ++-
 fs/cifs/smb2misc.c         |  12 +++-
 fs/cifs/smb2ops.c          |  32 +++++++++--
 fs/cifs/smb2pdu.c          |   5 +-
 fs/cifs/smb2pdu.h          |  22 -------
 fs/cifs/smb2transport.c    |   7 ++-
 fs/cifs/smbdirect.c        |   2 +-
 fs/cifs/trace.h            |   2 +
 fs/cifs/transport.c        |   8 +--
 fs/smbfs_common/smb2pdu.h  | 108 +++++++++++++++++++++++++++++++---
 fs/smbfs_common/smbfsctl.h |   6 ++
 24 files changed, 559 insertions(+), 189 deletions(-)


-- 
Thanks,

Steve
