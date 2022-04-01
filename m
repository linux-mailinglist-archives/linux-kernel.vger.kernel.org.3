Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9654EF813
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbiDAQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiDAQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:38:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561551017E0;
        Fri,  1 Apr 2022 09:15:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so5764096lfj.11;
        Fri, 01 Apr 2022 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XbXCNFwHHw/7AcxBigwapuOKfyDexeoHFsZgqSWyus4=;
        b=A7Qi+5s7OShNNKc36z53P4uDvpSQu+/hqp7p5j1TVC27Ytu91DmHq7N7yvw/woHrbm
         +XzmvxLEHwkNXGhttQI3+hE3X6mKE5l783VNROkI30aZGhsmAD9wnqu2YnvOqFvEsTBK
         fuM+1wVvd49XNC5ogu2AOOMp6PPaxUqnrPUjB5yMqyySWTAlVxHlFVmkblyFLjwS4IxE
         F9BSSvnNw5mpNNvv8ivgtlcEdmU5h/KtZxnrQGwXgMD462mfr2oBz/qiFQ13kXxBSwUB
         ENo654fYGP2/6zYAzv4XyAx+5sCSAZdSHoyP524DobpjEdNuhRz753X3X9piFroCpOSD
         hPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XbXCNFwHHw/7AcxBigwapuOKfyDexeoHFsZgqSWyus4=;
        b=kgJASmoLD4qm/HcKyitbBVFG+ZamBnYByFc5oNOTHw76I0OFYMERqI80MADhLQTHH1
         i7wixJjTF7NVpRUT0/VAtn7g2N6cTm5KF9M0lRvtZPNf+Nn1tAUhdvW4uDoF8FSBlBc4
         q7WX/VDYVYKVXoDMOltOZUwcwcMei+wjQeDhcr/y0YLWvywcPThCRKEHIZMSDoZXmbq2
         QV7nj6F40ZWn9ChWeV5SeO+6Foaom5SoRapyNwGnvIwcjSc+QOvlYTR9S4kpgotM3glb
         yrz7jMCAVS+6Q9HTjrSHMJYuOOIYktQR688AUYz9ypon7VlbFlzk/QdhbnM+sJPYt/z5
         EPYw==
X-Gm-Message-State: AOAM530P40cxZ7zFoop41nyJ5pe2k2dYAbGHJlSYsYEfutF82OObdNuQ
        RwLOTvQ6zR6RocUTrj1UoDb+onHWAWNUVfVacfMa/bRYGyY=
X-Google-Smtp-Source: ABdhPJxm+mIZJM8q8k+iyEWVAPrlsYs1TcKqFg3TgDkek/wGBqQxDD6Y4+OE75h+uDgdr/IB/UpjG0/R3I9YNvZg8EU=
X-Received: by 2002:a05:6512:33c3:b0:44a:8067:7ec4 with SMTP id
 d3-20020a05651233c300b0044a80677ec4mr14736397lfg.601.1648829741242; Fri, 01
 Apr 2022 09:15:41 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 1 Apr 2022 11:15:30 -0500
Message-ID: <CAH2r5msKJPqE9sMpB2=_w9ZJQ8PAPhfD3CqpR5SKJkEFtTyaFg@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
dca65818c80cf06e0f08ba2cf94060a5236e73c2:

  cifs: use a different reconnect helper for non-cifsd threads
(2022-03-18 23:12:03 -0500)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-smb3-fixes-part2

for you to fetch changes up to d6f5e358452479fa8a773b5c6ccc9e4ec5a20880:

  cifs: fix NULL ptr dereference in smb2_ioctl_query_info()
(2022-03-31 09:39:58 -0500)

----------------------------------------------------------------
14 fixes to cifs client and to smbfs_common code
(used by both cifs.ko client and ksmbd server), 4 for stable
- three fixes for big endian issues in how Persistent and Volatile
file ids were stored
- Various misc. fixes: including some for oops, 2 for ioctls, 1 for writeback
- cleanup of how tcon (tree connection) status is tracked
- Four changesets to move various duplicated protocol definitions
(defined both in cifs.ko and ksmbd) into smbfs_common/smb2pdu.h
- important performance improvement to use cached handles in some key
compounding code paths (reduces numbers of opens/closes sent in some
workloads)
- fix to allow alternate DFS target to be used to retry on a failed i/o

There is a trivial merge conflict (fixed in linux-next) with recent
upstream commit:
" 5224f7909617 ("treewide: Replace zero-length arrays with
flexible-array members")" .

Here is a link to a rebased version that resolves the conflict if you
prefer using this:
  git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc-rebased-cifs-merge
----------------------------------------------------------------
David Howells (1):
      cifs: writeback fix

Paulo Alcantara (5):
      cifs: do not skip link targets when an I/O fails
      cifs: fix bad fids sent over wire
      ksmbd: store fids as opaque u64 integers
      cifs: prevent bad output lengths in smb2_ioctl_query_info()
      cifs: fix NULL ptr dereference in smb2_ioctl_query_info()

Ronnie Sahlberg (2):
      cifs: convert the path to utf16 in smb2_query_info_compound
      cifs: change smb2_query_info_compound to use a cached fid, if available

Steve French (5):
      [smb3] move more common protocol header definitions to smbfs_common
      smb3: move defines for ioctl protocol header and SMB2 sizes to
smbfs_common
      smb3: move defines for query info and query fsinfo to smbfs_common
      smb3: cleanup and clarify status of tree connections
      smb3: fix ksmbd bigendian bug in oplock break, and move its
struct to smbfs_common

Xiaomeng Tong (1):
      cifs: fix incorrect use of list iterator after the loop

 fs/cifs/cifs_debug.c      |   2 +-
 fs/cifs/cifsfs.c          |   4 +-
 fs/cifs/cifsglob.h        |  24 +--
 fs/cifs/cifspdu.h         |  14 +-
 fs/cifs/cifssmb.c         |  11 +-
 fs/cifs/connect.c         |  46 +++--
 fs/cifs/file.c            |   8 +-
 fs/cifs/misc.c            |   2 +-
 fs/cifs/smb2glob.h        |  11 --
 fs/cifs/smb2misc.c        |  14 +-
 fs/cifs/smb2ops.c         | 246 +++++++++++++----------
 fs/cifs/smb2pdu.c         |  73 ++++---
 fs/cifs/smb2pdu.h         | 560
+---------------------------------------------------
 fs/cifs/smb2proto.h       |   2 +-
 fs/ksmbd/oplock.c         |   4 +-
 fs/ksmbd/smb2pdu.c        | 108 +++++-----
 fs/ksmbd/smb2pdu.h        | 533
+-------------------------------------------------
 fs/smbfs_common/smb2pdu.h | 639
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 18 files changed, 924 insertions(+), 1377 deletions(-)


-- 
Thanks,

Steve
