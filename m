Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5E58FF43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiHKPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiHKPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:25:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314779411F;
        Thu, 11 Aug 2022 08:25:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso2841576wmq.3;
        Thu, 11 Aug 2022 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sDQypk+nipClY4bl7PZHlfgM+rY7WpeRFb079EdUwYY=;
        b=ePOAt3TKRn0l9ScFAZI0/LDQJ9RE/DmlHuz2H0zHobG422Lzw2EYsGJhEebcVmkLq4
         zFJzniMEA2Zahtklw818NppeVNZ8sDis0xmpt+wtI5b7uDpjTJE28ihruH7pDKnThHy/
         W1ymfd9rROK990b/m//uTy5B5oZFAxaKBOr38YafXQ6D5zEGsQdMmcz71fOtqhDZAdXS
         RLQoV9w3GYco6QFuzl7CMEC3d6pMdSkz/iImzDvrxGKeVDVEhoziDuZUCE9T/vZ9q/5V
         e/s9cRzv8bNJAqObpOz49olViS/tBxVR0PsEWzsWNI9mQLutQ9xSwTpVZCx9RPIBb7pK
         cPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sDQypk+nipClY4bl7PZHlfgM+rY7WpeRFb079EdUwYY=;
        b=0a0VJn/9gZ9IT3rvXJBCeFHpwOenjRi5whCwHCevG/dPU+TEvcuDYAsR7zvZb2jpL8
         tbRbmw+q/+h32Q6qfz69oCPV3scOtYrj62Qd24g4RACRHE6YL11ZacstXWLX12tIRCTS
         Kp4tyk+WmUT3YUkkDlnkDgYTFw93RvMTZuQbcDdibZV6f/AjtjmHc8LLLYcAjQh6qW+f
         ydAZpYI4YSJCv7kkaPTUtvZWC7+H4+0O3Wv1EHy8U7iRf1NT41A1U43+cbfRI+uYveAo
         Y8HV4desojwudT5eYSfszdyQ1VmYJlPMCjkghdnRH4lReUsvjTxaWh5NIuXLd91rQWnG
         DFUw==
X-Gm-Message-State: ACgBeo0lTh+FmSIqT0VQ8WZT8hUF2qG3Y6C1YylI+XviAtY4l7/gFEfS
        rOTqaFivyFZfRHbNulsD43YRIuG2d1bMpg==
X-Google-Smtp-Source: AA6agR7jzSgDT95Ajs9T/kS3HsplVmP9eug5TPIJ9hYsFs27imTgXUufnCngSVn+vZCVCz/ttGWa4A==
X-Received: by 2002:a7b:ce05:0:b0:3a5:c069:25b3 with SMTP id m5-20020a7bce05000000b003a5c06925b3mr2149000wmc.87.1660231499483;
        Thu, 11 Aug 2022 08:24:59 -0700 (PDT)
Received: from zambezi.redhat.com (ip-94-112-17-81.bb.vodafone.cz. [94.112.17.81])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d5908000000b0021f131de6aesm19020112wrd.34.2022.08.11.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:24:58 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 5.20-rc1
Date:   Thu, 11 Aug 2022 17:24:46 +0200
Message-Id: <20220811152446.281723-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.20-rc1

for you to fetch changes up to a8af0d682ae0c9cf62dd0ad6afdb1480951d6a10:

  libceph: clean up ceph_osdc_start_request prototype (2022-08-03 14:05:39 +0200)

----------------------------------------------------------------
We have a good pile of various fixes and cleanups from Xiubo, Jeff,
Luis and others, almost exclusively in the filesystem.  Several patches
touch files outside of our normal purview to set the stage for bringing
in Jeff's long awaited ceph+fscrypt series in the near future.  All of
them have appropriate acks and sat in linux-next for a while.

----------------------------------------------------------------
Daichi Mukai (1):
      libceph: print fsid and epoch with osd id

Hu Weiwen (1):
      ceph: don't truncate file in atomic_open

Jason Wang (1):
      libceph: fix ceph_pagelist_reserve() comment typo

Jeff Layton (8):
      fs: change test in inode_insert5 for adding to the sb list
      fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
      fscrypt: add fscrypt_context_for_new_inode
      ceph: don't leak snap_rwsem in handle_cap_grant
      ceph: convert to generic_file_llseek
      ceph: call netfs_subreq_terminated with was_async == false
      ceph: switch back to testing for NULL folio->private in ceph_dirty_folio
      libceph: clean up ceph_osdc_start_request prototype

Li Qiong (1):
      libceph: check pointer before assigned to "c->rules[]"

Luis Henriques (2):
      ceph: use correct index when encoding client supported features
      ceph: prevent a client from exceeding the MDS maximum xattr size

Xiubo Li (13):
      ceph: remove useless CEPHFS_FEATURES_CLIENT_REQUIRED
      fs/dcache: export d_same_name() helper
      ceph: wait for the first reply of inflight async unlink
      ceph: add session already open notify support
      ceph: choose auth MDS for getxattr with the Xs caps
      ceph: fix the incorrect comment for the ceph_mds_caps struct
      ceph: fix incorrect old_size length in ceph_mds_request_args
      ceph: make change_auth_cap_ses a global symbol
      ceph: update the auth cap when the async create req is forwarded
      ceph: don't get the inline data for new creating files
      ceph: flush the dirty caps immediatelly when quota is approaching
      ceph: make f_bsize always equal to f_frsize
      ceph: remove useless check for the folio

 drivers/block/rbd.c             |   6 +-
 fs/ceph/addr.c                  |  59 ++++++--------
 fs/ceph/caps.c                  |  38 ++++-----
 fs/ceph/dir.c                   |  79 ++++++++++++++++---
 fs/ceph/file.c                  | 123 ++++++++++++------------------
 fs/ceph/inode.c                 |  13 +++-
 fs/ceph/mds_client.c            | 165 ++++++++++++++++++++++++++++++++++++++--
 fs/ceph/mds_client.h            |  13 ++--
 fs/ceph/mdsmap.c                |  22 +++++-
 fs/ceph/super.c                 |  19 +++--
 fs/ceph/super.h                 |  31 ++++++--
 fs/ceph/xattr.c                 |  12 ++-
 fs/crypto/fname.c               |  36 +++++++--
 fs/crypto/fscrypt_private.h     |   9 +--
 fs/crypto/hooks.c               |   6 +-
 fs/crypto/policy.c              |  35 +++++++--
 fs/dcache.c                     |  15 +++-
 fs/inode.c                      |  10 ++-
 include/linux/ceph/ceph_fs.h    |   8 +-
 include/linux/ceph/mdsmap.h     |   1 +
 include/linux/ceph/osd_client.h |   5 +-
 include/linux/dcache.h          |   2 +
 include/linux/fscrypt.h         |   5 ++
 include/linux/mmdebug.h         |  10 +++
 net/ceph/osd_client.c           |  15 ++--
 net/ceph/osdmap.c               |  32 ++++++--
 net/ceph/pagelist.c             |   2 +-
 27 files changed, 538 insertions(+), 233 deletions(-)
