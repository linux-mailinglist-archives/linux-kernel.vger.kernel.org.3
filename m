Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9083C490075
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiAQDEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiAQDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:04:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140AC061574;
        Sun, 16 Jan 2022 19:04:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p27so40680679lfa.1;
        Sun, 16 Jan 2022 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BcLWSCFxcIxXuHQd2ZX9wwZMoc7+0eTGm4EM3OR4jpU=;
        b=ZaYjBcoytcgYu0YN53yR2+fkLtowk5L8XQrd3YiWdvpWRMdSuV+UiGQWRqZglFwrxL
         nywXxwAMzJynw9HACRFMOllznNjNePAsByIFVs+g78yNBgqaRe2A9dV32wAspZvqXISi
         KmyVLzXj9mlQM5ZZupLPyx+3ynUKXuws0mCzgyM4ZrqghLrCbkP/DWJzEMFwmefjT9+t
         g+wlmuZJgiE3HQrBlFZGhhR7aD9Yk2HwmfeoRUs1eGUVNRDb7FAQlqxs2DWFQzb60iaJ
         6XLCYkEdxisU4Zc8UpzIeNbWtn6k3FdHtQ3JHKRwkn1KXA3cWHmH8hYEOGFzLV20fLpd
         IIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BcLWSCFxcIxXuHQd2ZX9wwZMoc7+0eTGm4EM3OR4jpU=;
        b=fvU7etFEfMzX4yIWd8ktYiTDq0agB3CVyHrivYcT9tt3e7jga9XTPPqaU0Ft+NM2fT
         58y9U6MLe5kDzJdCGR4Ua5aLN64J02+rx74jvILfKpd+xmGXvY8JXu3c/R/acUq2AE59
         md1V+VAoM6o3/AYLm02xDFKZCSC8GRJ36PpHEGM0ux/7emD+q5h6Lp04EgMZZrqvaFrk
         sRgrKT2UIHcbBg1mQLkgcs1RF69KR7uf3+XnZGqtWKwLYeXrquFdpXL3TB/WNHiTl/HT
         2aW3to2F3eZ8AjbJjIx1LyllAVP+uz/GyfYSYTvlA1F/iAmLPhvV4npflr6SSpwa3AnJ
         kibg==
X-Gm-Message-State: AOAM5331ms7CpIwcgHb3+UyixmmwMPC/1XosvCKFHnrA0okhmco25B6t
        z1S9toSWr7A+bEoOYszy2DnKwrXiYAQmT7LqZg2txqpID8c=
X-Google-Smtp-Source: ABdhPJz4uUl+FXb01sRnnkK7Rxg2VDSdVajRNqiRCXRw5oGeSNRQP49xOMe53sf7wPJJQPyYgOM+qr8r1nbY3pkSCgE=
X-Received: by 2002:a19:8c4a:: with SMTP id i10mr14679181lfj.537.1642388668824;
 Sun, 16 Jan 2022 19:04:28 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 16 Jan 2022 21:04:17 -0600
Message-ID: <CAH2r5mu=D=hnvdUTnZg8fYYRUbnGkOLzzo667XxmbYw8ZOBTxA@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc-part1-smb3-fixes

for you to fetch changes up to 9bbf8662a27b56358366027d1a77c0676f85b222:

  cifs: fix FILE_BOTH_DIRECTORY_INFO definition (2022-01-15 10:08:47 -0600)

----------------------------------------------------------------
13 cifs/smb3 fixes

- 9 multichannel patches mostly related to improving reconnect behavior
- 4 minor cleanup patches

There are a similar number of additional patches that I will send later
in the week that are still being tested and reviewed, and hopefully that
will also include the integration with the new fscache that Dave Howell's
is working with me on.
----------------------------------------------------------------
Colin Ian King (1):
      cifs: remove redundant assignment to pointer p

Enzo Matsumiya (1):
      cifs: fix hang on cifs_get_next_mid()

Eugene Korenevsky (1):
      cifs: fix FILE_BOTH_DIRECTORY_INFO definition

Jeff Layton (1):
      cifs: move superblock magic defitions to magic.h

Shyam Prasad N (8):
      cifs: track individual channel status using chans_need_reconnect
      cifs: use the chans_need_reconnect bitmap for reconnect status
      cifs: adjust DebugData to use chans_need_reconnect for conn status
      cifs: add WARN_ON for when chan_count goes below minimum
      cifs: reconnect only the connection and not smb session where possible
      cifs: take cifs_tcp_ses_lock for status checks
      cifs: maintain a state machine for tcp/smb/tcon sessions
      cifs: avoid race during socket reconnect between send and recv

Yang Li (1):
      cifs: Fix smb311_update_preauth_hash() kernel-doc comment

 fs/cifs/cifs_debug.c       |   8 ++-
 fs/cifs/cifs_spnego.c      |   4 +-
 fs/cifs/cifs_spnego.h      |   3 +-
 fs/cifs/cifs_swn.c         |   4 +-
 fs/cifs/cifsencrypt.c      |   6 +-
 fs/cifs/cifsfs.c           |   5 +-
 fs/cifs/cifsglob.h         |  79 +++++++++++--------------
 fs/cifs/cifspdu.h          |   2 +-
 fs/cifs/cifsproto.h        |  31 ++++++++--
 fs/cifs/cifssmb.c          |  94 +++++++++++++++++++++++------
 fs/cifs/connect.c          | 230
++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 fs/cifs/netmisc.c          |   4 +-
 fs/cifs/ntlmssp.h          |   2 +
 fs/cifs/sess.c             | 183
++++++++++++++++++++++++++++++++++++++------------------
 fs/cifs/smb1ops.c          |  24 +++++---
 fs/cifs/smb2glob.h         |   2 -
 fs/cifs/smb2misc.c         |   5 +-
 fs/cifs/smb2ops.c          |  34 +++++++----
 fs/cifs/smb2pdu.c          | 179
+++++++++++++++++++++++++++++++++++++------------------
 fs/cifs/smb2proto.h        |   6 +-
 fs/cifs/smb2transport.c    |  61 ++++++++++++++-----
 fs/cifs/transport.c        |  78 ++++++++++++++++--------
 include/uapi/linux/magic.h |   4 ++
 23 files changed, 723 insertions(+), 325 deletions(-)


-- 
Thanks,

Steve
