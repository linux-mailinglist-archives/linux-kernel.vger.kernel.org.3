Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A64A93D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiBDGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiBDGIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:08:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B534CC06173D;
        Thu,  3 Feb 2022 22:08:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i34so10715309lfv.2;
        Thu, 03 Feb 2022 22:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v4uaoO0oZZSWkasJgS763obvd7uTNueKYnUar/MRn1U=;
        b=KDCAEUXeuVQlYMZaKJlZfQaTddng4CXFu02Mdfu40AtCngGHRAKmUbMZPQIitk09mZ
         e8G857nomvD3nXFHDLZJjVvqTymd9BEAfniFEi4eKEjc/GNmdb05/mH7We17uuFx9DaG
         aVPFhLcKzcL2icYiY6UAib3BgruwJqBT9YCm8pzfQ1JFqTYZDWA7Yi5O4nsOvQ9jgREd
         FWoPsljIiev+ZmPLa3/lmbh3QOT4l5WhWSq0bkwehOiY8PW/mbsjzqYbtX0k9uDLCyxe
         600JIfyMnAp2Ii6xB0b/GiFbjEyWgXzH19bAl4E4miF+LaU2LcVUKEKwMnc4BeOlkVQg
         Zv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v4uaoO0oZZSWkasJgS763obvd7uTNueKYnUar/MRn1U=;
        b=4D/nMjp/CvXmWpzx7Nln8HNnfRQIDD4koUMOQ0cChmrts4p0rC5q5MsGteYi7cE/92
         DPe6xTxusldN3+Hu1xaJ3/OCVG6ITG1NHPareiFtCN1gMgeIt3x/fyxndVmeAGSqRMpK
         bmrUHULfsr/hzpFBDTmSY8Rj0hrQ8KAkGFHcKFG5LX0Wa8+OzfeHMYoVpi5IO0unOFu9
         zQc3euWUUFK2Chmi+fUeIVPtGE0z0NqtDmV2lWcD5IfLRiUuvvSqllvYtiEdaQC1/41F
         y6grpzTsLdPAWxQsPKHXKnr39+eDNu78BbGx76eg6z0mBVAY4Ntf7ymdE4dZsO142iX8
         QCTQ==
X-Gm-Message-State: AOAM531m1aJybeLIsc7BECSYuqAtyRdm520Xt1BPAHfYguw2G+27PPGD
        EvA5ShBdTKx/7zb7n85SRTeUFK7NwMKwm9fxYnZhKfqdSbs=
X-Google-Smtp-Source: ABdhPJyArqdEsc1GfQqaCC018GXybzMFe1My7xMWi66Ouk4pSgg3UJdWB1o1J2wsYFMzWvM/y6wnQfQRQJaC0/WSX2I=
X-Received: by 2002:a05:6512:2248:: with SMTP id i8mr1227340lfu.595.1643954902927;
 Thu, 03 Feb 2022 22:08:22 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 4 Feb 2022 00:08:12 -0600
Message-ID: <CAH2r5muqducHGxPtueahyFbqZZkUr1=04JrTuLEzejj_pKjEJQ@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc3-smb3-client-fixes

for you to fetch changes up to d3b331fb51f326d5b5326010bf2b5841bb86cdc6:

  cifs: fix workstation_name for multiuser mounts (2022-02-03 00:16:37 -0600)

----------------------------------------------------------------
SMB3 client fixes including:
- multiple fscache related fixes, reenabling ability to read/write to
cached files for cifs.ko
  (that was temporarily disabled for cifs.ko a few weeks ago due to
the recent fscache changes)
    - also includes a new fscache helper function ("query_occupancy")
used by above
- fix for multiuser mounts and NTLMSSP auth (workstation name) for stable
- fix locking ordering problem in multichannel code
- trivial malformed comment fix

Unit test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/882

There is an additional DFS reconnection fix, unrelated to this, still
being worked on, that is not included in this P/R
----------------------------------------------------------------
David Howells (5):
      Fix a warning about a malformed kernel doc comment in cifs
      cifs: Transition from ->readpages() to ->readahead()
      netfs, cachefiles: Add a method to query presence of data in the cache
      cifs: Implement cache I/O by accessing the cache directly
      cifs: Fix the readahead conversion to manage the batch when
reading from cache

Rohith Surabattula (1):
      Invalidate fscache cookie only when inode attributes are changed.

Ryan Bair (1):
      cifs: fix workstation_name for multiuser mounts

Shyam Prasad N (1):
      cifs: unlock chan_lock before calling cifs_put_tcp_session

 Documentation/filesystems/netfs_library.rst |  16 ++
 fs/cachefiles/io.c                          |  59 +++++++
 fs/cifs/connect.c                           |  23 ++-
 fs/cifs/file.c                              | 221 ++++++++++-----------------
 fs/cifs/fscache.c                           | 126 ++++++++++++---
 fs/cifs/fscache.h                           |  79 ++++++----
 fs/cifs/inode.c                             |   8 +-
 fs/cifs/sess.c                              |   6 +-
 include/linux/netfs.h                       |   7 +
 9 files changed, 346 insertions(+), 199 deletions(-)


-- 
Thanks,

Steve
