Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2585246878B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352357AbhLDUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351034AbhLDUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:45:14 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F9C061751;
        Sat,  4 Dec 2021 12:41:48 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 207so13055574ljf.10;
        Sat, 04 Dec 2021 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BwyEUIOnJUD80uAEwJlMTSHXVRvqwA6nJjgGBs8ClYw=;
        b=YiJ4H8z/mnNfGQtG3TL/NGJCoQTstL+Ozg2g3rOD5TCKdpZTh3U+aW6aw519AqiVnz
         jbavApfqHpJ4LGz6CBA9neeRPUqefnVZhdn5HG8U9VupT+hnrFWQeOS27IPx/aCNXAL6
         knU0314zsIW5sR7BvxxVaa1VHncMGsusgV2ZpojzI/TeyR4rhFeufQo6rVuJvt9Pz6PA
         pveoz1K1rMZ6upGoaBIsV8vkrkvurxQ6K1+DyRF8swt7PUBiu0OFYM/JrorBJXZFp6aI
         89gVID3dYoucMmSjL3nttLVEXVc1V0GBFMBwKPAPNyYVcAAet/eNLjdWEl/p6NuNqPQn
         eLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BwyEUIOnJUD80uAEwJlMTSHXVRvqwA6nJjgGBs8ClYw=;
        b=LPnvaygG/7W1mICy+4B5U6VsNc1Ai/F3jq0bgKONBv7sxKuFd89tnhh79HH8jcJgMN
         QRaTSts4ppjPwurcA1/s5bgDDsII0ka5vXxOalAynNYrMCbZQTvPlryoQp/6sSAW7FVY
         WskNc+nA8jdLk7pPvewiKMDmMumTNXT4Rp93qr02XB9/pIZ8huKbjj6IyVwY2Bcop9Wf
         fFxa6Kr0+yPnoCJYS8mCz5uMzCAn/AZfWBXlrJSurQfW+/eJfDJwCNWeFqxXyonAx9ax
         PiPSx5yPR2eIIvLU52Gbpqfhg6EAi8qhY85dKk3MISXQdAzG7/OhYLCWRfKiB82bEKbn
         GauA==
X-Gm-Message-State: AOAM532okJciYKrnoTw9ulTQAJFv7uTeMij/gJwqFr3G0nPduOSRE6R7
        nhi+AJBsrB7qmgdKzbRWWfbxilHnjnb2NqAc7aw=
X-Google-Smtp-Source: ABdhPJy7oOdPgcI5T/nVwAhI99+r+9y8mmJ3cdJOFl1xc9Lb7/hlKTtWDgB3cZTWDWO8HMRSpH9kWgYGTNpVcC3cchY=
X-Received: by 2002:a2e:a588:: with SMTP id m8mr26925937ljp.23.1638650506883;
 Sat, 04 Dec 2021 12:41:46 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 4 Dec 2021 14:41:36 -0600
Message-ID: <CAH2r5mt5WfWBs_d+og=eOG08P4z8iQumes05PxEbpi0k4HTNPA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc3-smb3-fixes

for you to fetch changes up to bbb9db5e2a7a1ca0926d26a279000384be21b789:

  cifs: avoid use of dstaddr as key for fscache client cookie
(2021-12-03 12:38:25 -0600)

----------------------------------------------------------------
3 SMB3 multichannel/fscache fixes and a DFS fix. In testing
multichannel reconnect scenarios recently various problems with the
cifs.ko implementation of fscache were found (e.g. incorrect
initialization of fscache cookies in some cases).

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/846
----------------------------------------------------------------
Paulo Alcantara (1):
      cifs: fix missed refcounting of ipc tcon

Shyam Prasad N (3):
      cifs: wait for tcon resource_id before getting fscache super
      cifs: add server conn_id to fscache client cookie
      cifs: avoid use of dstaddr as key for fscache client cookie

 fs/cifs/connect.c | 11 +++++------
 fs/cifs/fscache.c | 46 ++++++++++------------------------------------
 fs/cifs/inode.c   |  7 +++++++
 3 files changed, 22 insertions(+), 42 deletions(-)

-- 
Thanks,

Steve
