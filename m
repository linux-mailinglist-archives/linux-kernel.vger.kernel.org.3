Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6D50CE11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiDXANh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiDXANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 20:13:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260603FDBE;
        Sat, 23 Apr 2022 17:10:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q14so13739103ljc.12;
        Sat, 23 Apr 2022 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KGwY3w/LUk+p3Q5uLCT6SYX2S/12e2zbleAJeZwrDYg=;
        b=G3fienA+ez19EBrR2L/csO/MP0X8ecN5glUBPwTMLXUKzqG9OUvMbiBfNHQQ7AFb3D
         wtw15LVMt5GFE+R3iabH0Xe4j8nAfWnKTjA3t33OOY66P22lI90+R9nw3pStZb6821eI
         uzWY/Wd8rJpQaycR1Rr5t28Kwmx+j0mjPXptXLWYJECBVWd3hG+SyOf/trj27uqFKCfZ
         A6VsKNPnrpLwSSy6DVMKqNXBKSo2KlX4VAMupObiKBT/SvX1pB8s/lVhCZid0snDP+V4
         mxice+nMrHabfvjHywciadTQ/cbgwy5w4x4TxnqJ+Jc++4pl0INOsEd6Lr2DrDN4/0WW
         U0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KGwY3w/LUk+p3Q5uLCT6SYX2S/12e2zbleAJeZwrDYg=;
        b=uIEZx3pRP8M9do2jKDbZQcdTTHk9pfMH0YdXAYCZoy5a6aPqJuYbZxEBEzYkxhh2e9
         /K6vSqDXoapwAlR69Es0KB2w395CD/aWOFH4TkxnbtQDEEHFKG9gH3G9bs+V3vnPEFNr
         19ZBcTM08Nb1ZDZmwm5PlZQ4JtRr9s62HIBkdOYbFmrzS2uBI3RW7kF77DUEABoFzcZ9
         43g3321zn9GngiAUIPPX9qRE/kt+2vFwCIsZ5H0WlmfPcD9V3IJVfmwjhrdy2pkMAkOG
         5rCwZElKr4QwBf3c8hKZVFsGikbtHKUGLRFds4SHVXHpnpuu+r9zDCaIKJnZAL+Qndjb
         9Hhg==
X-Gm-Message-State: AOAM530seIKOK/9Yxv5MVk40KsRb91dj2T4Fapf1+5Au6sOTKW3uJwVD
        rK3DJiYOWXdaCsb8eoZBOgW3uzXGs5xtRTm24hTEZhdU0Nw=
X-Google-Smtp-Source: ABdhPJznNOSlpjE1X3V5T70Dkcg9tAL96reP0179VZxiy6c2HoiT4NCTh2KLQ5GMQlEVB9yZVKoUz5le3e6rvCEIWCo=
X-Received: by 2002:a2e:bf08:0:b0:247:f79c:5794 with SMTP id
 c8-20020a2ebf08000000b00247f79c5794mr6633811ljr.398.1650759034242; Sat, 23
 Apr 2022 17:10:34 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 23 Apr 2022 19:10:23 -0500
Message-ID: <CAH2r5muyG8HZJvOYi+wPa_Qj6Yce8Q4MR-Oh28DrT1j8iH8FuQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.18-rc3-ksmbd-fixes

for you to fetch changes up to 02655a70b7cc0f534531ee65fa72692f4d31a944:

  ksmbd: set fixed sector size to FS_SECTOR_SIZE_INFORMATION
(2022-04-14 20:56:13 -0500)

----------------------------------------------------------------
3 fixes to ksmbd server
- cap maximum sector size reported to avoid mount problems
- reference count fix
- fix filename rename race

----------------------------------------------------------------
Namjae Jeon (3):
      ksmbd: remove filename in ksmbd_file
      ksmbd: increment reference count of parent fp
      ksmbd: set fixed sector size to FS_SECTOR_SIZE_INFORMATION

 fs/ksmbd/misc.c      | 40 +++++++++++++++++++++++++++++++---------
 fs/ksmbd/misc.h      |  3 ++-
 fs/ksmbd/oplock.c    | 30 ------------------------------
 fs/ksmbd/oplock.h    |  2 --
 fs/ksmbd/smb2pdu.c   | 34 ++++++++++++++++------------------
 fs/ksmbd/vfs.c       |  6 ++----
 fs/ksmbd/vfs_cache.c |  2 +-
 fs/ksmbd/vfs_cache.h |  1 -
 8 files changed, 52 insertions(+), 66 deletions(-)

-- 
Thanks,

Steve
