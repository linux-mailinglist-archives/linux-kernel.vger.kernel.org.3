Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19429479EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 02:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhLSBg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 20:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhLSBg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 20:36:56 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4288C061574;
        Sat, 18 Dec 2021 17:36:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b22so13132299lfb.9;
        Sat, 18 Dec 2021 17:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3Ry7SmKoKguXUT7bfZoG81QGnb2TSFmPGW+FtRu9lR8=;
        b=HcMT+QLgPD3c2c3ukmrnzBf25KH4KNzX1qWoi/HMD9K0kX91ZC56fubVw3+VflS1NR
         Tb4XY140RJyjbFxoI6Ovv0BLYJ1PBUBLvouEvZbVRTCut7LMNoPkdAuizjXfcaNGd5fx
         eAALKX0mzObtmEqmWtQYY9zx4KVWXs6Sy/FUFSuqTDW2q0/FePPCT09TGkSZyXAGqtwU
         zirKA3KeQmrjuJXt2jH8IdXHBYPEGIU2FQitgcxAqKXfGKyXH7TEMNVZMMfWlhWInSTm
         qs0oppJgTCMnn3gxEVvUZjJhU7+ZcAeYWcAVvH5gR5AU6KwzB4CD6U8wIbfX36FdmH8o
         VGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3Ry7SmKoKguXUT7bfZoG81QGnb2TSFmPGW+FtRu9lR8=;
        b=db0oIvAzbaPlry9gOC1WhYkCaEvJyoCgRxwZR/AL9E/FYRxU+lKyH/LLX4jI/ZKqiw
         QZ83yNjLKCS2Tair3HHozrvhcZXMKEUQ0GyP3Ruzbd1W1spnD2J8Zsunp+dIAv6iLf/K
         CjostMU6XfOI99rvYg8Tx65u6HaAwsDkYHntBiF8U2BReIFKy+Fs5Cnm7hqM2Aon2ZYa
         Rp3/FHfq3tFUrE5DhwB03vKyFsd4/jbrtYCiGDQt7rnBoKFX/rllz+/rjBdC5/j79YiP
         kDgbo6ok5Jlk9+4R1sZztb1y/kwR9sWGNignfyHxosEeUOUiCxx1AM9tU5NC5XaYLp0/
         Zp+w==
X-Gm-Message-State: AOAM5300TkonDb4uFtdOc83yKyrRa6lPWoCe9HdbmZzu9s6BQm8gjWBS
        1J5nayg8xS7OoGxfW4//myLbSqkyv6qMuS8fDG3x+eHCFi4=
X-Google-Smtp-Source: ABdhPJz8W5QgyUjwjp6CbmmtDTHu60euntNCJoBE0l6Tk7S/1XlRgrH2MlQnLejesQzpdhkh3RMKgwbH1Wj76lujZjE=
X-Received: by 2002:a05:6512:11e5:: with SMTP id p5mr9389707lfs.537.1639877813927;
 Sat, 18 Dec 2021 17:36:53 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 18 Dec 2021 19:36:43 -0600
Message-ID: <CAH2r5mtRV8WbGZZcgNRJ4MEnaLWP08JRWJQRftFkkvjieW6Q+A@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc5-smb3-client-fixes

for you to fetch changes up to a31080899d5fdafcccf7f39dd214a814a2c82626:

  cifs: sanitize multiple delimiters in prepath (2021-12-17 19:16:49 -0600)

----------------------------------------------------------------
Two cifs/smb3 fixes, one fscache related, and one mount path parsing
related (for stable)

(Does not include the recent kernel DNS caching fix, which is still
being tested and reviewed)

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/856
----------------------------------------------------------------
Shyam Prasad N (1):
      cifs: ignore resource_id while getting fscache super cookie

Thiago Rafael Becker (1):
      cifs: sanitize multiple delimiters in prepath

 fs/cifs/connect.c    |  7 +++++++
 fs/cifs/fs_context.c | 38 +++++++++++++++++++++++++++++++++++++-
 fs/cifs/inode.c      | 13 -------------
 3 files changed, 44 insertions(+), 14 deletions(-)


--
Thanks,

Steve
