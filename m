Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D9496A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 06:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiAVFv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 00:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiAVFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 00:51:25 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154BC06173B;
        Fri, 21 Jan 2022 21:51:24 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id w7so3242605ljw.11;
        Fri, 21 Jan 2022 21:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E4IaFvH/PCJMVLVC64/0KaKQlWqnlMzYgCVzrsXDxRE=;
        b=hR1w7Er4P5ukaD/8e3QBLs37jiPN6SuotHSjxK4rx8XkFUvqVp6Nmi5wPy/huaECKC
         wdoftPzlb/9ufXYFpIy47SzXqSGqgKKgoI+djeG1uw06nGSWBNQm0Ys9m8pJeveWdzER
         ubrnPqRuSpiRzyn0V5qWBWiLb1IntvXvTlvx6y40+1L9nUsM21EppZC9pEJNPXuDtgUJ
         oGjvss/b1Z31TCTscxzZ4O7+OrHD0wMp8BkKQ+9/MC/1pJTi2GIl+uwQHjJQMyE7SkVi
         jkuZrWAWoMK9CRfGATXXPDy5uaWG3VvSBCot2mf2YMJxOcNpu+NWasz14Jk+UEhp5Zj3
         9OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E4IaFvH/PCJMVLVC64/0KaKQlWqnlMzYgCVzrsXDxRE=;
        b=tB1Ns7yRdJDqd5vnaVnukd15PscoAoy5X0rSkArNlOj+BmJ6ZvAhTKRWt1tgPBIzg/
         4i4tpNjxYOOe2ZIyNrXqLVqVTavTVblMHRFCynp53WNR8WiZW028yY/+ELVCgV/Kv3H1
         XP+Us3mF/cOjYtc3oJ93V+G/s8IyfE/cg8lzqW4cqeZD5IuE+Va679AxcZnxO/GXGrEM
         w3kry4COVddirLf1ZfIxAcT7ds9kb/VyOrDne8OXH9U9HvFG24uGXQWGszF9sRXycYr8
         Jl+XMKVbUhjtqFHBNpmzfTioSzWKnswtcCHKKrv/+I2lD7r2Nra25SoTwEWyq4WfnqfM
         yThA==
X-Gm-Message-State: AOAM533ibJysnV3enCObbLrBJOMODEXYD73SNXpK9DGMRZtfAsNvaqM2
        5TrBVlv6fB0/UzXVpzf6aPDS9tqI6voc5R59cm2tkR/4hwY=
X-Google-Smtp-Source: ABdhPJzkaZldnvuY9pHHhBxRFwd9im93D7sBhfIPySFG4zwN51CaZfXMcdqamQFude/LqtPhknbMf9s/uuKNyzyhrKw=
X-Received: by 2002:a2e:9813:: with SMTP id a19mr5190706ljj.23.1642830682594;
 Fri, 21 Jan 2022 21:51:22 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 21 Jan 2022 23:51:11 -0600
Message-ID: <CAH2r5mvb8d_mo+tEhQ+rXE33zgixiq5YiFyapcMEzEd6bXqf2Q@mail.gmail.com>
Subject: [GIT PULL] smb3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
0c947b893d69231a9add855939da7c66237ab44f:

  Merge tag '5.17-rc-part1-smb3-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2022-01-17 09:53:21 +0200)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc-part2-smb3-fixes

for you to fetch changes up to 51620150ca2df62f8ea472ab8962be590c957288:

  cifs: update internal module number (2022-01-19 23:14:34 -0600)

----------------------------------------------------------------
18 cifs/smb3 fixes including:
- 9 multichannel fixes, addressing additional reconnect and DFS scenarios
- reenabling fscache support (indexing rewrite, metadata caching e.g.)
- send additional version information during NTLMSSP negotiate to
improve debugging
- fix for a mount race
- 2 DFS fixes
- fix for a memory leak for stable
----------------------------------------------------------------
David Howells (1):
      cifs: Support fscache indexing rewrite

Eugene Korenevsky (2):
      cifs: alloc_path_with_tree_prefix: do not append sep. if the path is empty
      cifs: quirk for STATUS_OBJECT_NAME_INVALID returned for non-ASCII dfs refs

Muhammad Usama Anjum (1):
      cifs: remove unused variable ses_selected

Ronnie Sahlberg (1):
      cifs: serialize all mount attempts

Shyam Prasad N (9):
      cifs: free ntlmsspblob allocated in negotiate
      cifs: check reconnects for channels of active tcons too
      cifs: fix the connection state transitions with multichannel
      cifs: protect all accesses to chan_* with chan_lock
      cifs: fix the cifs_reconnect path for DFS
      cifs: remove repeated state change in dfs tree connect
      cifs: make status checks in version independent callers
      cifs: update tcpStatus during negotiate and sess setup
      cifs: cifs_ses_mark_for_reconnect should also update reconnect bits

Steve French (3):
      smb3: add new defines from protocol specification
      smb3: send NTLMSSP version information
      cifs: update internal module number

Yang Li (1):
      cifs: clean up an inconsistent indenting

 fs/cifs/Kconfig            |   2 +-
 fs/cifs/Makefile           |   2 +-
 fs/cifs/cache.c            | 105 ---------------------
 fs/cifs/cifs_swn.c         |   9 +-
 fs/cifs/cifsfs.c           |  19 ++--
 fs/cifs/cifsfs.h           |   3 +-
 fs/cifs/cifsglob.h         |   7 +-
 fs/cifs/cifsproto.h        |   8 ++
 fs/cifs/connect.c          | 142 ++++++++++++++++++----------
 fs/cifs/dfs_cache.c        |   2 +-
 fs/cifs/dir.c              |   5 +
 fs/cifs/file.c             |  66 ++++++++-----
 fs/cifs/fs_context.c       |   8 +-
 fs/cifs/fscache.c          | 333
++++++++++++++++--------------------------------------------------
 fs/cifs/fscache.h          | 128 +++++++++----------------
 fs/cifs/inode.c            |  25 +++--
 fs/cifs/misc.c             |  49 ++++++++++
 fs/cifs/netmisc.c          |   5 +-
 fs/cifs/ntlmssp.h          |  30 +++++-
 fs/cifs/sess.c             | 112 ++++++++++++++++------
 fs/cifs/smb2pdu.c          | 112 +++++++++++++++-------
 fs/cifs/smb2transport.c    |   6 ++
 fs/cifs/transport.c        |  17 +---
 fs/smbfs_common/smb2pdu.h  |   2 +-
 fs/smbfs_common/smbfsctl.h |   2 +
 25 files changed, 573 insertions(+), 626 deletions(-)
 delete mode 100644 fs/cifs/cache.c


-- 
Thanks,

Steve
