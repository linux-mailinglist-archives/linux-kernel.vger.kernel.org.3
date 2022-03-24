Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D604E67BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352246AbiCXR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiCXR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:26:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B04D63D;
        Thu, 24 Mar 2022 10:25:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a17so6421220edm.9;
        Thu, 24 Mar 2022 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4IHohZfNhxIELfk0O0C8Svu0kWT5bRkI2fJh/C2zgs=;
        b=MYlhUF/HBx16m5ik87ELtjf2YuF6geOeLvoTwuekMaJRyvamJaCLfQs0ItVL2YYuBY
         iBLtUGGrfk4brxV813B/L2sVOM0aKCQ2YvkNW+2guKzfP9ovRBNov1hhcniCr32B7eTq
         SpgKkB3TyxPrXnUksSudinXKQQEOmBlrruAM9rq0dsH3qPUfIS4Lj3aE41TuRI9/FaXP
         zowLc31B9ZVqtmZYPMG74z9tEvqCLiyVZoI7yIoM9PyiGafrUXFDg4PYkInbFJApVuz2
         sQ5cDLx9NmHIkhTGZqiAjYUAqQCwqMJSKNA93t42TAN9E5TgqY1BcUtiTc8UR/vjaCZz
         Z4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4IHohZfNhxIELfk0O0C8Svu0kWT5bRkI2fJh/C2zgs=;
        b=Yhoena4Ws5oXwj4VHvEHBR7hCbBaE9KV6sjHqK2CrvQvAGxEvaQFlsEumdMdwKEcI+
         MH9nltDOE4wNtpbtKidZsQpG0CTU2oohuLjUGyEn/kkRIwmQC4lN5SJ2IXkc5QT/7rYK
         hBcCEgKtQoeO2nlXutiA+WdMkka2Dj8r6okZhgvLLrkGEXmgSiCiEpnhysxbCVFgV3OX
         R418uP36kD/Cxq3mRnEz6rs2KkSfPNUpmfFHakb/ER4TaRPUSYAD6BB2QgviFYJ38WSv
         3lMgAuspaQY0bEhz/E1XB57wqX/jNgDP7IZ3jcPf2ICBRTIwemy8Ro87x2TlXJL4BXje
         +sDg==
X-Gm-Message-State: AOAM532MBdIEVAMEDNFI7qdnJY3lCXR1f1pI/+/xMU0VEp4hYClh9Csn
        Zs3KGG1N/PuvwknoIJoqa/2nnQgIuco=
X-Google-Smtp-Source: ABdhPJw5viWiKisWEADO+O57N7NcAn41nsAwUZRQ602vKp3eXEk79Lux/afbNYwkxdb1jExcfI3K2A==
X-Received: by 2002:a05:6402:11d2:b0:419:7cd7:b25 with SMTP id j18-20020a05640211d200b004197cd70b25mr7768503edw.19.1648142716646;
        Thu, 24 Mar 2022 10:25:16 -0700 (PDT)
Received: from kwango.redhat.com (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id y17-20020a056402359100b0041926ea1e12sm1708517edc.53.2022.03.24.10.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:25:16 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [GIT PULL] Ceph updates for 5.18-rc1
Date:   Thu, 24 Mar 2022 18:25:54 +0100
Message-Id: <20220324172554.12797-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc1

for you to fetch changes up to f639d9867eea647005dc824e0e24f39ffc50d4e4:

  ceph: fix memory leak in ceph_readdir when note_last_dentry returns error (2022-03-21 13:35:16 +0100)

----------------------------------------------------------------
The highlights are:

- several changes to how snap context and snap realms are tracked
  (Xiubo Li).  In particular, this should resolve a long-standing
  issue of high kworker CPU usage and various stalls caused by
  needless iteration over all inodes in the snap realm.

- async create fixes to address hangs in some edge cases (Jeff Layton)

- support for getvxattr MDS op for querying server-side xattrs, such
  as file/directory layouts and ephemeral pins (Milind Changire)

- average latency is now maintained for all metrics (Venky Shankar)

- some tweaks around handling inline data to make it fit better with
  netfs helper library (David Howells)

Also a couple of memory leaks got plugged along with a few assorted
fixups.  Last but not least, Xiubo has stepped up to serve as a CephFS
co-maintainer.

----------------------------------------------------------------
Dan Carpenter (1):
      ceph: uninitialized variable in debug output

David Howells (2):
      ceph: make ceph_netfs_issue_op() handle inlined data
      ceph: uninline the data on a file opened for writing

Jeff Layton (6):
      ceph: switch netfs read ops to use rreq->inode instead of rreq->mapping->host
      ceph: eliminate req->r_wait_for_completion from ceph_mds_request
      ceph: wait for async create reply before sending any cap messages
      ceph: wake waiters after failed async create
      libceph: drop else branches in prepare_read_data{,_cont}
      MAINTAINERS: add Xiubo Li as cephfs co-maintainer

Milind Changire (1):
      ceph: add getvxattr op

Venky Shankar (4):
      ceph: use ktime_to_timespec64() rather than jiffies_to_timespec64()
      ceph: track average r/w/m latency
      ceph: include average/stdev r/w/m latency in mds metrics
      ceph: use tracked average r/w/m latencies to display metrics in debugfs

Xiubo Li (12):
      ceph: fail the request directly if handle_reply gets an ESTALE
      ceph: move to a dedicated slabcache for ceph_cap_snap
      ceph: zero the dir_entries memory when allocating it
      ceph: do not update snapshot context when there is no new snapshot
      ceph: eliminate the recursion when rebuilding the snap context
      ceph: remove incorrect and unused CEPH_INO_DOTDOT macro
      ceph: do not release the global snaprealm until unmounting
      ceph: allocate capsnap memory outside of ceph_queue_cap_snap()
      ceph: misc fix for code style and logs
      ceph: fix inode reference leakage in ceph_get_snapdir()
      ceph: assign the ci only when the inode isn't NULL
      ceph: fix memory leak in ceph_readdir when note_last_dentry returns error

hongnanli (1):
      ceph: fix comments mentioning i_mutex

 MAINTAINERS                  |   2 +
 fs/ceph/addr.c               | 240 ++++++++++++++++++---------------------
 fs/ceph/caps.c               |  16 ++-
 fs/ceph/debugfs.c            |   5 +-
 fs/ceph/dir.c                |  17 ++-
 fs/ceph/file.c               |  83 ++++++++------
 fs/ceph/inode.c              |  65 ++++++++++-
 fs/ceph/locks.c              |   8 +-
 fs/ceph/mds_client.c         |  69 ++++++------
 fs/ceph/mds_client.h         |  15 ++-
 fs/ceph/metric.c             |  63 ++++++-----
 fs/ceph/metric.h             |  63 +++++++----
 fs/ceph/snap.c               | 263 +++++++++++++++++++++++++++----------------
 fs/ceph/strings.c            |   1 +
 fs/ceph/super.c              |   7 ++
 fs/ceph/super.h              |   9 +-
 fs/ceph/xattr.c              |  13 ++-
 include/linux/ceph/ceph_fs.h |   5 +-
 include/linux/ceph/libceph.h |   1 +
 net/ceph/messenger_v2.c      |   8 +-
 20 files changed, 577 insertions(+), 376 deletions(-)
