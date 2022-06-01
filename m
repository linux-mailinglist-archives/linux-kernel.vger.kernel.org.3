Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8E539D24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiFAGUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiFAGUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:20:42 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472A6A066;
        Tue, 31 May 2022 23:20:40 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id j11so412060vka.6;
        Tue, 31 May 2022 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Cvoj+RO+skmK4uotN8SSFJtBNUiO3qHrHDUxMlyGe68=;
        b=ReCnqqVWMgsH8NHsHeRUZMnyYPK+cJT2cJqru+YdqevmRTxovqxSK0UebMccFQOQ0g
         iCiArqo1k58Tv4ZXshEHyJRXekOn7uiA1GepUNHb8844UO3lVOV63XbF4H29lgVce8a+
         ZzF/mLA9/4HjtTFsw6zbGARUsuVs4J3krS4KrIdnVEOtiqxF+QFG2JKBeXyr4rFwOl7x
         2G8dIodHNcWtmoSR47gL99e99qfnswMs85D7U8ocMJfNYcoaEwJlZofUeLPmt0ztQwA6
         C74SSo3UQ92G44WDTfcVNpJiwQ34WdM6sd3bN3o520jHvuGXfhgDjCr4203ZsdI+TTRM
         hNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Cvoj+RO+skmK4uotN8SSFJtBNUiO3qHrHDUxMlyGe68=;
        b=jpKryiXgtTl4fPH3ra4380KaLz6XkLD97sJuzSJPajndXSdv6rPBVdjo0+jR6Jm6IH
         CpsDyM+IJclVz8dgKHSDiDM4vCjEx4Vs8pBRe1o0mCEsRMi+Nto2EqBK5oWdOd/EonH9
         AqKeWcRhQR7tfex3gvHkMstc7W5/HK5PTHkUF2Dta8L8QL01IqobWHtNdLp56ZThCtUl
         kJ0IdZuYh3HGVWvDDkrHA2nfF+bQc/o/Esc6CzSgm53RvXYg3gWvBsYEXbv1a9bodOHL
         CzdMbt9n/HuG9+3YQtS7uQTsV4wcGAJT2X7m2ytUn3eeZJ2kM+MmhvRbUWgBjfoQhvrm
         0ziA==
X-Gm-Message-State: AOAM530wQEpCB+rS9jZTXIzdFL1B18Ny2FvarHT0g6t4lYOBWEf0c24i
        4B4FiuRfFWga5GLwRUYQGGNkLunf5gQShgTd7xI=
X-Google-Smtp-Source: ABdhPJwc2LZwvyEvJkHYDLJIbdgmwanNMcS6f8KRwVS1eR82zJxzIHucJWQhiJkwtRkxaMq3pnqZMmjSc8LEOTtsQ20=
X-Received: by 2002:a05:6122:14e:b0:358:4f5b:f65c with SMTP id
 r14-20020a056122014e00b003584f5bf65cmr12758277vko.3.1654064439940; Tue, 31
 May 2022 23:20:39 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 1 Jun 2022 01:20:28 -0500
Message-ID: <CAH2r5ms4eeQy-2bu_5BxFAW=GUR7T4VWM9khi7F0Hc-RSb8Uew@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
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
c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.19-rc-ksmbd-server-fixes

for you to fetch changes up to 621433b7e25d6d42e5f75bd8c4a62d6c7251511b:

  ksmbd: smbd: relax the count of sges required (2022-05-27 21:31:20 -0500)

----------------------------------------------------------------
fourteen smb3 server fixes:
- 8 RDMA (smbdirect) fixes, cleanup and optimizations
- crediting (flow control) fix for mounts from Windows client
- ACL fix
- 2 cleanup fix
- Windows client query dir fix
- Write validation fix
----------------------------------------------------------------
Hyunchul Lee (8):
      ksmbd: smbd: change prototypes of RDMA read/write related functions
      ksmbd: smbd: introduce read/write credits for RDMA read/write
      ksmbd: smbd: simplify tracking pending packets
      ksmbd: smbd: change the return value of get_sg_list
      ksmbd: smbd: handle multiple Buffer descriptors
      ksmbd: smbd: fix connection dropped issue
      ksmbd: fix outstanding credits related bugs
      ksmbd: smbd: relax the count of sges required

Marios Makassikis (1):
      ksmbd: validate length in smb2_write()

Namjae Jeon (3):
      ksmbd: handle smb2 query dir request for OutputBufferLength that
is too small
      ksmbd: add smbd max io size parameter
      ksmbd: fix wrong smbd max read/write size check

Xin Xiong (1):
      ksmbd: fix reference count leak in smb_check_perm_dacl()

Yang Li (1):
      ksmbd: Fix some kernel-doc comments

 fs/ksmbd/connection.c     |  22 ++--
 fs/ksmbd/connection.h     |  27 ++--
 fs/ksmbd/ksmbd_netlink.h  |   3 +-
 fs/ksmbd/misc.c           |  10 +-
 fs/ksmbd/smb2misc.c       |   2 +-
 fs/ksmbd/smb2pdu.c        | 126 ++++++++++---------
 fs/ksmbd/smb_common.c     |   4 +-
 fs/ksmbd/smbacl.c         |   1 +
 fs/ksmbd/transport_ipc.c  |   3 +
 fs/ksmbd/transport_rdma.c | 363
++++++++++++++++++++++++++++++++----------------------
 fs/ksmbd/transport_rdma.h |   8 ++
 11 files changed, 325 insertions(+), 244 deletions(-)

-- 
Thanks,

Steve
