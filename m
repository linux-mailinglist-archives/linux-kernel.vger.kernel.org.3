Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051F55F0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiF1WHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF1WHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:07:22 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE62F01D;
        Tue, 28 Jun 2022 15:07:21 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i186so13360741vsc.9;
        Tue, 28 Jun 2022 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LUjXKFEC3NAgTcs0sbn5hRul2LA26MWo4XxKS40nHYc=;
        b=GnfZLmRXDn6Wv3sxJtGsA5jITqI70oZOVNcua2QTwFr7eTfaXr9mweDOOYqhUhL/FU
         vz0eBs9SZiLwPZoZOToeO4KCb9mzaEz9r+PIq42a4A53OEDn291ghr5WvIabk0zXdGVf
         ynVFYB9zlQxUK/qrBj7KCxZ6nLjLYnDl4Tf87FJKH4RvDTNc9EZ5JkrkiVKUuSivlTjO
         hAUzN/TkILdp+0ktlwT5oxp//083EClM7nQGiprbFIjBGGmOWFHywXNRJ1/DdWk6wvMT
         KsaWA6rkGq7nA6xcigLpuVrXf75pPEPpy4p7GvlJLPBQZ+zzdJxe+ttVC1/u7z3A/LQb
         Ovdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LUjXKFEC3NAgTcs0sbn5hRul2LA26MWo4XxKS40nHYc=;
        b=g/KKeEaPRg/95fJwfqLabxGIGI6hbuKTKNxksiUwcdIkveJpmY6h4RudC3cUuPjVKB
         bxKwRUmMLcBSNvm/fDDtnM76iruhuo0ebUezRZg+Mr5zQYF5avZa4LJc8aJ9lpxrN9kP
         /QvqGKbqwdZf/E+a1J0bDfjc4OqGQd6kj7sW9u/OAZszUiExdPUzedgjV2ZmHFtfvLKB
         juNPV23KAbqfCVRCaQZJwAJ89RN63Azv5Q+p0bqFaRB10jsVXU+xpQMyhOoZVNN2uipM
         Yu9xLjL1nS/gKSuyElRY3oQlsQKsbfNK1ct9u28NYWCvqXWi3qTvQ40swqWiu3dfEMd0
         hELQ==
X-Gm-Message-State: AJIora87BjXWqyEFLrMB75Gr1er3DvrQCCUjqD4cImtU56rOt6Ud8wBM
        MOvVnDK5ombEjvQzdkSrXzUeWzD3toj3fIbCbEicoGyFvarFiA==
X-Google-Smtp-Source: AGRyM1vXzvTFf2YC/lNUMS7WLKOQdHSVucGJhiVwqhxpF0oSRBetS/yrZt4dNOmxsWyZj7igbIM0F9fBwsfRA1fZk5Y=
X-Received: by 2002:a05:6102:2407:b0:356:2318:b743 with SMTP id
 j7-20020a056102240700b003562318b743mr3012735vsi.61.1656454040675; Tue, 28 Jun
 2022 15:07:20 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 28 Jun 2022 17:07:09 -0500
Message-ID: <CAH2r5ms0EHq5zqwjE6PXVC_NCydY7d6+=NSnQcdjtNhbA6bf=A@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
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
f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.19-rc4-ksmbd-server-fixes

for you to fetch changes up to 067baa9a37b32b95fdeabccde4b0cb6a2cf95f96:

  ksmbd: use vfs_llseek instead of dereferencing NULL (2022-06-25
19:52:49 -0500)

----------------------------------------------------------------
Six ksmbd server fixes, including 3 for stable fixing:

- seek null check
- offset validation in FSCTL_SET_ZERO_DATA
- fallocate fix (relates e.g. to xfstests generic/091 and 263)
- two cleanup fixes
- fix socket settings on some arch

----------------------------------------------------------------
Christophe JAILLET (1):
      ksmbd: smbd: Remove useless license text when
SPDX-License-Identifier is already used

Hyunchul Lee (1):
      ksmbd: remove duplicate flag set in smb2_write

Jason A. Donenfeld (1):
      ksmbd: use vfs_llseek instead of dereferencing NULL

Namjae Jeon (3):
      ksmbd: use SOCK_NONBLOCK type for kernel_accept()
      ksmbd: set the range of bytes to zero without extending file
size in FSCTL_ZERO_DATA
      ksmbd: check invalid FileOffset and BeyondFinalZero in FSCTL_ZERO_DATA

 fs/ksmbd/smb2pdu.c        | 32 ++++++++++++++++++--------------
 fs/ksmbd/transport_rdma.c | 10 ----------
 fs/ksmbd/transport_tcp.c  |  2 +-
 fs/ksmbd/vfs.c            |  8 +++++---
 4 files changed, 24 insertions(+), 28 deletions(-)

-- 
Thanks,

Steve
