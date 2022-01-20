Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27643494736
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358704AbiATGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358755AbiATGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:14:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84900C061574;
        Wed, 19 Jan 2022 22:14:50 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o12so17504656lfu.12;
        Wed, 19 Jan 2022 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wgY9n1o9EyMchovL77wDX3vrku6A63uyxJQ/2t6Yg0c=;
        b=BBstiArjsJqkDPaqoi3fGDp5rtNc24jxKhipe7OoBosoipcFnYrOoJZDWKy3bYhlWV
         /PMpUOz4Dt9fyV4d8KqKB1Ovbzm8gnKnjH/uSkvc6ff3uDzB9gGqfLoTvjU7VoXPLqyj
         dw55kKHTRYVXpPu8ieTTMmn5r1FAU8/IrdZC3eVBPRucw0VGL5IGzbo95xUdiqgDZLOj
         bSwn8VpLmb7NAshZ/oGXPl5Xsv5BmYHj16KpDptVXru8qmAOV6XLs1zSY/HhaKTmvkOL
         9gVFhKq4HQnJNUmVf1GM6KWS54Qx+yF4MK0O5rvtobPXq9glkOqqMDOudUJ+gJ98GLKH
         XOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wgY9n1o9EyMchovL77wDX3vrku6A63uyxJQ/2t6Yg0c=;
        b=GNIciGJvIxdDYt6geQ2+EcAMEY4BkEALd8u4Tp0932qA4vYsu8e7oqU98ZOSYcbatM
         QjJIHLTzC3qjZsU4adNaImZrxmB8SvJIOuZAz99SrurobGHxDNv/AmzbmnGNpGiyk8/U
         cGZzQeEb4sqNZnkKxJijnD10DSOXdYr04CJ+RHzNzLKpo/dwnh3BNNU6FRSDE+b4HHcU
         nH3Io3Bh/OWWEcBq7+MVDredFKtIGQh9yTLa7E4zSjrGUEf9STdkjwhVNMb4CZ+SIXGe
         CqxLLJtiuSpoH8tJRFevQnApD5r6G4aoYdV2o2CN8eJcPY3Epj38crPT3NRzSSk203Vc
         s7GA==
X-Gm-Message-State: AOAM532OXr4UVFp+hBi7GKDcH1bFj9krs6qqKQZJCrE8EZpUGqzXAVKJ
        7AMUB1BwMz0kC1QUHoyncz7whDrORoOHyPQ1g5g=
X-Google-Smtp-Source: ABdhPJzLoRuOcV4/elu+oUsKnT0Mkak19wVZN8NSKanF0/XRoQ3JagCm83txHRsk0u8R+c3CybPttRYP/cUYd80aO1U=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr32122660lfs.234.1642659288815;
 Wed, 19 Jan 2022 22:14:48 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 20 Jan 2022 00:14:38 -0600
Message-ID: <CAH2r5mthCbxAM-OOjwK01YGiqU7SMexco1vgTFp6tcC-XHAbVw@mail.gmail.com>
Subject: [GIT PULL] ksmbd fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.17-rc-ksmbd-server-fixes

for you to fetch changes up to ac090d9c90b087d6fb714e54b2a6dd1e6c373ed6:

  ksmbd: fix guest connection failure with nautilus (2022-01-18 16:53:20 -0600)

----------------------------------------------------------------
23 ksmbd server fixes, 2 for stable
- authentication fix
- 7 RDMA (smbdirect) fixes (including fix for a memory corruption, and
some performance improvements)
- multiple improvements for multichannel
- misc fixes including for 3 for crediting (flow control) improvements
- 5 cleanup fixes, including 3 kernel doc fixes

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/98
----------------------------------------------------------------
Dan Carpenter (1):
      ksmbd: uninitialized variable in create_socket()

Hyunchul Lee (6):
      ksmbd: use oid registry functions to decode OIDs
      ksmbd: register ksmbd ib client with ib_register_client()
      ksmbd: smbd: call rdma_accept() under CM handler
      ksmbd: smbd: create MR pool
      ksmbd: smbd: change the default maximum read/write, receive size
      ksmbd: smbd: fix missing client's memory region invalidation

Marios Makassikis (2):
      ksmbd: Remove unused parameter from smb2_get_name()
      ksmbd: Remove unused fields from ksmbd_file struct definition

Namjae Jeon (9):
      ksmbd: set RSS capable in FSCTL_QUERY_NETWORK_INTERFACE_INFO
      ksmbd: set both ipv4 and ipv6 in FSCTL_QUERY_NETWORK_INTERFACE_INFO
      ksmbd: fix multi session connection failure
      ksmbd: set 445 port to smbdirect port by default
      ksmbd: add support for smb2 max credit parameter
      ksmbd: move credit charge deduction under processing request
      ksmbd: limits exceeding the maximum allowable outstanding requests
      ksmbd: add reserved room in ipc request/response
      ksmbd: fix guest connection failure with nautilus

Yang Li (4):
      ksmbd: Fix buffer_check_err() kernel-doc comment
      ksmbd: Fix smb2_set_info_file() kernel-doc comment
      ksmbd: Delete an invalid argument description in
smb2_populate_readdir_entry()
      ksmbd: Fix smb2_get_name() kernel-doc comment

Yufan Chen (1):
      ksmbd: add smb-direct shutdown

 fs/ksmbd/asn1.c              | 142 +++++--------------------------
 fs/ksmbd/auth.c              |  27 +++---
 fs/ksmbd/auth.h              |  10 +--
 fs/ksmbd/connection.c        |  10 ++-
 fs/ksmbd/connection.h        |  12 +--
 fs/ksmbd/ksmbd_netlink.h     |  12 ++-
 fs/ksmbd/mgmt/user_config.c  |  10 +++
 fs/ksmbd/mgmt/user_config.h  |   1 +
 fs/ksmbd/mgmt/user_session.h |   1 -
 fs/ksmbd/smb2misc.c          |  18 ++--
 fs/ksmbd/smb2ops.c           |  16 +++-
 fs/ksmbd/smb2pdu.c           | 222
++++++++++++++++++++++++++----------------------
 fs/ksmbd/smb2pdu.h           |   1 +
 fs/ksmbd/smb_common.h        |   1 +
 fs/ksmbd/transport_ipc.c     |   2 +
 fs/ksmbd/transport_rdma.c    | 261
++++++++++++++++++++++++++++++++++++++++++++-------------
 fs/ksmbd/transport_rdma.h    |   4 +-
 fs/ksmbd/transport_tcp.c     |   3 +-
 fs/ksmbd/vfs_cache.h         |  10 ---
 19 files changed, 429 insertions(+), 334 deletions(-)

-- 
Thanks,

Steve
