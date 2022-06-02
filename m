Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867AD53B97D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiFBNLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiFBNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:11:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2491261B;
        Thu,  2 Jun 2022 06:11:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q1so9876217ejz.9;
        Thu, 02 Jun 2022 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brdaE36/5F/x/iFbu9swQ3VSiPLNbwgh4yvLlRE8Z1E=;
        b=eOCRyscO4MNtj6wvnml7Zc1hrYWUsNZ/DuBeA/QEPeuekHpa/ErxgiRIQ4TmD4aQPE
         tXVIvAu4Tx8dHZJ8XH24aSNlZAlXTea3aqXDHax+X0XY1f2dgzWUm/J+vkCPHj2YWTZT
         7pMHJqOE+aPX4T1C1r7JNGdZM86eysEjqv+JfQRRrEY+FWKaSc6csyo66mTVbI6GJ7a4
         i56hj+8qR0orJAx7Gk/9Bkk4M4+7YnDEcWYclUjVPPMHmwHQdWIZOtrkOep5Dt/cWCcY
         vnjM8t7Qay5p5CFY3hXvi2cG+upSFedlC8fzAU3NG1xpvrYJgkfzWffbKbIm28cJwNcI
         xW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brdaE36/5F/x/iFbu9swQ3VSiPLNbwgh4yvLlRE8Z1E=;
        b=5OrXuJrmnX9fO/wpp36ogl6EzB7Xw3n+jSvTXaY6V5jOXyA8Nwr4TAKTwf32cl7Liv
         lPaOaPZEuVPhJNyM4aMef51chogC9kFZU/Xk5F9hjTvqddYGlsIVgIv4bLRgV3Yt+MVM
         4sB+wo1MJhCjN2bcGni1Qt97lJEYF4E/gzDoKsUUbc4mtpEW3T44tu7bAUSns18rQI8v
         fKh/uozoGJyIAZxbMnf19bdadAWw4TkmN3+y9woVJ97JZ/JDDn7rPALttn09eAILq+lo
         k2rFE3TapTrBrp4csx1OzdG7LAgYFUDz1GoAALhwwVRMOK0UtyGTfkxXowhUs69Wr9QS
         yHOQ==
X-Gm-Message-State: AOAM530j59O6b5xfZ9jnTYBG1JN4u9ZbXEXtQT/9ii652wADSdaFepad
        Yi5tqXzuov9vtvPh3ETFG7DFV+1exq6VpQ==
X-Google-Smtp-Source: ABdhPJwb1PXK3C05Q+IbSCjlHCNOYKk5ouCm0zAf96gJWoSbkQkjb+jDbt+9XqiaURRGi8j7OouuHw==
X-Received: by 2002:a17:907:3f91:b0:6fe:8af0:4b2c with SMTP id hr17-20020a1709073f9100b006fe8af04b2cmr4390682ejc.220.1654175502888;
        Thu, 02 Jun 2022 06:11:42 -0700 (PDT)
Received: from kwango.redhat.com (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7ca51000000b0042a9fcd7c73sm2390181edt.46.2022.06.02.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:11:42 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 5.19-rc1
Date:   Thu,  2 Jun 2022 15:11:31 +0200
Message-Id: <20220602131131.22117-1-idryomov@gmail.com>
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

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc1

for you to fetch changes up to af7dc8e5124daf017ebc85c8ea97212e1e2e62fe:

  MAINTAINERS: move myself from ceph "Maintainer" to "Reviewer" (2022-05-25 20:45:14 +0200)

----------------------------------------------------------------
A big pile of assorted fixes and improvements for the filesystem with
nothing in particular standing out, except perhaps that the fact that
the MDS never really maintained atime was made official and thus it's
no longer updated on the client either.

We also have a MAINTAINERS update: Jeff is transitioning his filesystem
maintainership duties to Xiubo.

----------------------------------------------------------------
Colin Ian King (1):
      ceph: remove redundant variable ino

Guo Zhengkui (1):
      libceph: use swap() macro instead of taking tmp variable

Jakob Koschel (3):
      rbd: replace usage of found with dedicated list iterator variable
      ceph: use dedicated list iterator variable
      ceph: replace usage of found with dedicated list iterator variable

Jeff Layton (1):
      MAINTAINERS: move myself from ceph "Maintainer" to "Reviewer"

Luis Henriques (2):
      ceph: fix statfs for subdir mounts
      ceph: fix decoding of client session messages flags

Venky Shankar (1):
      ceph: allow ceph.dir.rctime xattr to be updatable

Xiubo Li (14):
      ceph: remove unused CEPH_MDS_LEASE_RELEASE related code
      ceph: stop forwarding the request when exceeding 256 times
      ceph: stop retrying the request when exceeding 256 times
      ceph: update the dlease for the hashed dentry when removing
      ceph: no need to invalidate the fscache twice
      ceph: fix statx AT_STATX_DONT_SYNC vs AT_STATX_FORCE_SYNC check
      ceph: rename unsafe_request_wait()
      ceph: flush the mdlog for filesystem sync
      ceph: disable updating the atime since cephfs won't maintain it
      ceph: try to choose the auth MDS if possible for getattr
      ceph: redirty the page for writepage on failure
      ceph: fix possible deadlock when holding Fwb to get inline_data
      ceph: try to queue a writeback if revoking fails
      ceph: switch TASK_INTERRUPTIBLE to TASK_KILLABLE

 MAINTAINERS             |   4 +-
 drivers/block/rbd.c     |  13 +++---
 fs/ceph/addr.c          |  42 ++++++++++-------
 fs/ceph/caps.c          |  75 +++++++++++++++++++-----------
 fs/ceph/inode.c         |  35 ++++++++++++--
 fs/ceph/mds_client.c    | 121 +++++++++++++++++++++++++++++++++++++-----------
 fs/ceph/mds_client.h    |   2 +-
 fs/ceph/quota.c         |  19 ++++----
 fs/ceph/super.c         |   1 +
 fs/ceph/super.h         |  29 ++++++++++--
 fs/ceph/xattr.c         |  10 +++-
 net/ceph/crush/mapper.c |   5 +-
 12 files changed, 253 insertions(+), 103 deletions(-)
