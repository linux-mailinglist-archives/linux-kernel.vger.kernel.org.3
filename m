Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C438C470BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbhLJUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbhLJUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:45:37 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693FC061746;
        Fri, 10 Dec 2021 12:42:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d10so20147405lfg.6;
        Fri, 10 Dec 2021 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jSOKKCUOR0j7n2R3X2fIZf3rtCqfEobXMp8HS8/8594=;
        b=Qrm3m6wFKwd14InaeW4NAHPt9J7PmEAS+5GSGMc1KjerPswSnV8SxXOgCph/CGt7Kv
         hML7svQky+MEdK8RKxeMRrX2xvBNCkZM7U2rdNmL9dyaqPfEi6JItFwaUzC9Ihxj35WT
         Z6j6HaDK4RyEALpNRpay0XAEyuFLBwqTxXluB3tTR+0akKCJtRApxY2Vub5022SGMGN2
         dsFmedo9HzEIXlqFQcTEV+ULmLXMEI4k9GOzzfcaWLF0rPHNEFltx9qxFP9xM0/DuNlT
         OVbFQxJHsT/kfNgalrGo843SBcm2v2yvkPTuttrANWRkgmhAltN6MsvVwnS5TFcBByS/
         ftUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jSOKKCUOR0j7n2R3X2fIZf3rtCqfEobXMp8HS8/8594=;
        b=rJ1+4p+9od5PCbF9IEYEHgojuBpL4kub4eFeJ+TFCRtDdYSkS0F1Eu3RJLjexO6aZ9
         mKVnQWm0ayM1daVjPf7750uxFyXrjEeyHpB6YyraAFcOsVIKwQC59wYjg/Y5eVEd6MVp
         DnGagYRSwV45OXDjNFmeDxavu8IU1+MrnjBw9oo0fgS1xD6R+HKtVbgpWOsR3/Z9Qi8U
         mn+ce3ZStgILMSkqKhodvZkNtE+DoQ41EP7o7XfC6USfKt5e/ZslFGmo+EcbNB4d3Ym4
         t71Rr0GYygAgKZkHYYRYPgoZ7EJUdYHmPHoB47wiDTrB2QGQK4CGBgkxkR6kmV89QV9M
         fhzw==
X-Gm-Message-State: AOAM5319Kz2NtBxq9MCVgKWKQmwWaLX0vM5L8K/RhcVZJLcv8VpRLsSM
        DMgZM3KLIq/H0xQLNSpAEmklJV/JnJvKDyDzFyZ2fFzUeFo=
X-Google-Smtp-Source: ABdhPJwY+5oP0YCMPHbwoE8IGKglppolADPn4qUnROVZtz/r000vnUurXmaLmESHWTYhNnP9F2Chce9bF3tWfRBjNrI=
X-Received: by 2002:a05:6512:3fa0:: with SMTP id x32mr14966721lfa.320.1639168920082;
 Fri, 10 Dec 2021 12:42:00 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 10 Dec 2021 14:41:49 -0600
Message-ID: <CAH2r5ms8umkdMfYKr6p7C+_SZBzr54X9xdf-oZh4rxjQKEXccg@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc4-smb3-fixes

for you to fetch changes up to 9de0737d5ba0425c3154d5d83da12a8fa8595c0f:

  cifs: fix ntlmssp auth when there is no key exchange (2021-12-08
16:48:43 -0600)

----------------------------------------------------------------
two cifs/smb3 fixes:
- one for stable to fix a problem with module unload of the arc4 module
- the other fixes a recently reported NTLMSSP auth problem

There is an additional fscache fix that is still being tested and
reviewed but not included in this P/R

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/851
----------------------------------------------------------------
Paulo Alcantara (1):
      cifs: fix ntlmssp auth when there is no key exchange

Vincent Whitchurch (1):
      cifs: Fix crash on unload of cifs_arc4.ko

 fs/cifs/sess.c              | 54
++++++++++++++++++++++++++++++++++++------------------
 fs/smbfs_common/cifs_arc4.c | 13 -------------
 2 files changed, 36 insertions(+), 31 deletions(-)


-- 
Thanks,

Steve
