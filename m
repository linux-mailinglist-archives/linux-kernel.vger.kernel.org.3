Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD17531422
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiEWONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiEWONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:13:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBAD275E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:13:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so8862293wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wMd3MAVGTEWvLDECRQj4k5EQPlSx82n3nZY69Crfbkk=;
        b=p2KwDuenh3ZqtcMrAp2PcV50hZl16VaDpOUHQfDrGTKFZo+sBapEL/vCFhO0fUJI00
         2Gl33276R5kI/N/lATZXOvvaFKLG5EtAPp1YqX0WIkTYmo8A2HpkBQNULEQeoCLHjyEi
         CyGVdO+Spun3Fqzf3KcuqElqI5Phplf0f+nX2gRVrak35ZFX9pVhrhy+nvALMxN/0YcF
         Qi9hzvZgeoBLkXtP4DBCJehmuMgNVbXVAG4ZF7fKuCg7fnllo/mb/WU9CQ7PMB9qxcUw
         yVHLHPY8cuagGCiNtk+wjbDfpJN+zW6m0ykAPjS4no+aK+Ni8qQh8ZuHe4QNKBoAvSAr
         xBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wMd3MAVGTEWvLDECRQj4k5EQPlSx82n3nZY69Crfbkk=;
        b=di+Zrseu5yakAUvAhxX6B3BJmrNdHL6MJQED16AR1wLH3Im7e4Ki2X3Bj9Zv9y6/8v
         w1XCT6Ugm2PlqZmYSrLbDkqC/5kxu08dplH4BEEbjPImPX4NJAJoX6A16mgF++NcJZSA
         ZEUr2NHRO/FWiDtCRWllBwEWINaTDs5TjgVyS8u3Mt715GzviaAOKBFXdP7/0ugmkRkX
         lVNUayIEuqb16OcyJB07JjYifvZpIH9nmO2VwWQoFPqxkuSNiJU6eykdeCADpje1G1vr
         0Ec/O1bbxEPbXe7jgumI/LTijRKpyRevOOf7ibG5L7IAHU0XpJa17FMH+kuHnOl045QG
         jCfg==
X-Gm-Message-State: AOAM533d1/uOBDqCKXvToIZsprgtnMoQ2RxWYI/2roYC5WVsPReBt/fu
        bBHQgpg5Xw4hbehh/joKsv94PXTqf8fYxBPfwB9N
X-Google-Smtp-Source: ABdhPJwWjOXbK0Xh4wF+Je/K9mbXv1GGVKfDI7BUiK8RXyiuAS+iMDEoxi0ZDPvFouhLymQvkgFVCtXkHM0ao9xLxGw=
X-Received: by 2002:a7b:ce8a:0:b0:397:37c9:254a with SMTP id
 q10-20020a7bce8a000000b0039737c9254amr15349128wmj.96.1653315194616; Mon, 23
 May 2022 07:13:14 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 May 2022 10:13:04 -0400
Message-ID: <CAHC9VhTFMrc3yRiQ=fnw0-qWCTuUcH3iD1txSvLUh71WFsLrFw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

We've got twelve patches queued for v5.19, with most being fairly
minor.  The highlights are below:

- The checkreqprot and runtime disable knobs have been deprecated for
some time with no active users that we can find.  In an effort to move
things along we are adding a pause when the knobs are used to help
make the deprecation more noticeable in case anyone is still using
these hacks in the shadows.

- We've added the anonymous inode class name to the AVC audit records
when anonymous inodes are involved.  This should make writing policy
easier when anonymous inodes are involved.

- More constification work.  This is fairly straightforward and the
source of most of the diffstat.

- The usual minor cleanups: remove unnecessary assignments, assorted
style/checkpatch fixes, kdoc fixes, macro while-loop encapsulations,
#include tweaks, etc.

Please merge for v5.19.
-Paul

--
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17=
:

 Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220523

for you to fetch changes up to 1af0e4a0233fea7e8226cb977d379dc20f9bbe11:

 security: declare member holding string literal const
   (2022-05-13 14:51:06 -0400)

----------------------------------------------------------------
selinux/stable-5.19 PR 20220523

----------------------------------------------------------------
Christian G=C3=B6ttsche (8):
     selinux: resolve checkpatch errors
     selinux: update parameter documentation
     selinux: avoid extra semicolon
     selinux: include necessary headers in headers
     selinux: fix indentation level of mls_ops block
     selinux: declare data arrays const
     selinux: log anon inode class name
     security: declare member holding string literal const

Michal Orzel (1):
     selinux: Remove redundant assignments

Paul Moore (3):
     selinux: runtime disable is deprecated, add some ssleep() discomfort
     selinux: checkreqprot is deprecated, add some ssleep() discomfort
     selinux: don't sleep when
              CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is true

include/linux/lsm_audit.h                        |  2 +
include/linux/lsm_hooks.h                        |  4 +-
scripts/selinux/genheaders/genheaders.c          | 75 ++++++++++++--------
scripts/selinux/mdp/mdp.c                        |  4 +-
security/lsm_audit.c                             |  3 +
security/security.c                              |  2 +-
security/selinux/avc.c                           |  6 +-
security/selinux/hooks.c                         |  9 +--
security/selinux/include/audit.h                 |  5 +-
security/selinux/include/avc.h                   |  1 +
security/selinux/include/avc_ss.h                |  4 +-
security/selinux/include/classmap.h              |  2 +-
security/selinux/include/ibpkey.h                |  2 +
security/selinux/include/initial_sid_to_string.h |  3 +-
security/selinux/include/netnode.h               |  2 +
security/selinux/include/netport.h               |  2 +
security/selinux/include/policycap.h             |  2 +-
security/selinux/include/policycap_names.h       |  2 +-
security/selinux/include/security.h              |  4 ++
security/selinux/include/xfrm.h                  |  2 +
security/selinux/nlmsgtab.c                      | 12 ++--
security/selinux/selinuxfs.c                     |  8 ++-
security/selinux/ss/avtab.c                      | 20 +++----
security/selinux/ss/policydb.c                   | 36 +++++-------
security/selinux/ss/services.c                   | 47 ++++++++-------
25 files changed, 144 insertions(+), 115 deletions(-)

--=20
paul-moore.com
