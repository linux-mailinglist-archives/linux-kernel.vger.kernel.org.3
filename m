Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60535871A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiHATq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiHATqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:46:12 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025102F652
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:46:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u9so14189067oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=ID6xmj0jlQ+oDOkE/7Q+FgRKVEA9FMrNbK3ElhVYCyA=;
        b=WA3I28VBvO79DMJm4m2+mr3Opk1D6B6L5OOH178VBhJ6JhiF+KQaV8/JHywUOFkjSg
         mkSTIiUt8Wwp5xjuOIT36Y9wSS0qC0cZA5XMUgK9onfDswF1u1taSm1zzQlYydDsn6x2
         DLEAZDDwVSGEpCis0ATBMv5rSGFMycluutowFHPIGDRQrSeNVBZ8pCmwaRtsZN63wFpg
         uURcrumXrv863wspRQIRTsCrwOI18ed1bjGnBDFuwONQSOUQh8ChsM3RcINn2ydJ18BE
         AEK3V0MPw4a2Svwt4G5HzJfIlXJ1mOzCEOzDAJ/HwrNnhWl6ZaytSJKHETnKmlpSxs38
         4wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ID6xmj0jlQ+oDOkE/7Q+FgRKVEA9FMrNbK3ElhVYCyA=;
        b=PhL0TKtdX9UASZSj1ki6hzcWHqzqW66prSyaoTn61o0eywP2Fow9m0yemMYYVxWHSQ
         Q7q8XJI6PjGNlcWCdKDmFm/isGkynYVdEbqZnVL3P6JQxTZ/7ijLifgc4qYrOqQvSj4O
         2qFNebWZH7mZC9plDDIrOkkjI1iTHaynSzPW635GiRN7VMJ1raVEmzJ0aBoRkjnVs52W
         +iJDf52VeFBUgFMUPfyBxC2HPThYzmhsxnmq/nhADnKNsrSQX340ieHYgzmtf+bAjRc0
         tEtW/IDJndO3vbN3cQpBWv2TZGcKPNMVoY4OLWeorgcI3tJ+Ra+pXfzTGLectY6xATYE
         OwjA==
X-Gm-Message-State: AJIora+H4BFEQibH1aXucR23/uN02xw0EU8/Abm0vJFTfDLsUo2wQdaN
        Wrh8fopwJN5uwih43uxjnspS4ym6wRXMJ8+QSnJf
X-Google-Smtp-Source: AGRyM1sCm+BGsavzuU8R7OvhrIHNa9EHD+2j1SMH6Vhp8e1AMfpfusSn/nZoPJDZj6e8JwRGFrYGuEDZYg6hOUspwe8=
X-Received: by 2002:a05:6808:3087:b0:33a:a6ae:7bf7 with SMTP id
 bl7-20020a056808308700b0033aa6ae7bf7mr7521566oib.41.1659383170306; Mon, 01
 Aug 2022 12:46:10 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 15:45:59 -0400
Message-ID: <CAHC9VhQtBZg1_V7yuzSZzzAB5A3gZB1KTHjx0ZBrc9yCA98f-Q@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A relatively small set of patches for SELinux this time, eight patches
in total with really only one significant change.  The highlights are
below:

- Add support for proper labeling of memfd_secret anonymous inodes.
This will allow LSMs that implement the anonymous inode hooks to apply
security policy to memfd_secret() fds.

- Various small improvements to memory management: fixed leaks, freed
memory when needed, boundary checks.

- Hardened the selinux_audit_data struct with __randomize_layout.

- A minor documentation tweak to fix a formatting/style issue.

Everything applies cleanly to your tree as of a few minutes ago,
please merge for v6.0.
-Paul

--
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56=
:

 Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220801

for you to fetch changes up to ef54ccb61616d8293bc68220d88a8e74271141b5:

 selinux: selinux_add_opt() callers free memory
   (2022-06-20 21:05:40 -0400)

----------------------------------------------------------------
selinux/stable-6.0 PR 20220801

----------------------------------------------------------------
Christian G=C3=B6ttsche (2):
     selinux: drop unnecessary NULL check
     mm: create security context for memfd_secret inodes

GONG, Ruiqi (1):
     selinux: add __randomize_layout to selinux_audit_data

Jonas Lindner (1):
     selinux: fix typos in comments

Randy Dunlap (1):
     docs: selinux: add '=3D' signs to kernel boot options

Xiu Jianfeng (3):
     selinux: fix memleak in security_read_state_kernel()
     selinux: Add boundary check in put_entry()
     selinux: selinux_add_opt() callers free memory

Documentation/admin-guide/kernel-parameters.txt |  4 ++--
mm/secretmem.c                                  |  9 +++++++++
security/selinux/hooks.c                        | 17 +++++++----------
security/selinux/include/audit.h                |  2 +-
security/selinux/include/avc.h                  |  2 +-
security/selinux/ss/policydb.h                  |  2 ++
security/selinux/ss/services.c                  |  9 ++++++++-
7 files changed, 30 insertions(+), 15 deletions(-)

--=20
paul-moore.com
