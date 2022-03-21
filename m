Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234464E3218
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiCUU71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiCUU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:59:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40E73BF;
        Mon, 21 Mar 2022 13:57:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g24so20340284lja.7;
        Mon, 21 Mar 2022 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=59Gat+qN8WYpOTE7jvqTIV+CFqNDHfOUiPDOr7kqbpI=;
        b=qRlll4fPK7PvNN9xxSThqBTIVaDT1lTOnflWhLswPW4fzuPFbpLkQMitkW1FSXhFn9
         ouKvR49cXE4PbLn10tQw73qAUN72rM/3ewqdetuZASVRnLPjiXnxaqOsqmg+HlbEI7m8
         EH6JLA3w3QvN/uG6OdkvCiEWvoW8twdD9WWVTJgW9zd07ZO5NuTaRnMVbMQnH79d+Y+R
         17qkBclkjQ1nhDzRHAllOe7Z3Dwb3JROFgRRwPQkv9Q7coVpnjDxNJR3piO+2cAkYDPE
         y/EIYIVMRO2XfuX/5BTaHPMBfp+HdRDbn3OimzueAUne39YK03EKKPD3/yf9K8QYSfkm
         RgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=59Gat+qN8WYpOTE7jvqTIV+CFqNDHfOUiPDOr7kqbpI=;
        b=mJPmo1uyECTV7lwksk70WJRWr/jCyBwku8n81CtqckSL3STgj1GD7HLymhj52pM+XA
         xrZ+JU+SuB6DlDu7v/EoOhnvzNVNROr/8TCTU7HYm6J8evYJBQKORueRo6d9htKbsBAW
         /dKLZw1bmJMoiYHX6DWAh6LrT9UxfLgGq/NcBElk+wFeOKxxjpLdP9Nzx+VTevMMj3tK
         p2UtqemHjS6jiKsPAnvvJQ93ndKEpKGxFlBvrb2Nbxkx2Eb7bluGDAZLvAxhBGI6WcZS
         mcAqXyIUcgZjuwPgPprS0O/X/AhpcVsE4ocA84CT6r1hAZeFmPYYwz0/5VMkivukqA6n
         sR+A==
X-Gm-Message-State: AOAM53352zb5HTC4QIhOrDA+FLxW082igRCN03YjksTvITmLaLrua5Bu
        CpP1Jd7VSvlbPJ0a1LoMpGH7OinmLCdx4IkoXDW+h0R4VKo=
X-Google-Smtp-Source: ABdhPJwvMRtGusSZ+hNspFYr/Dii0ZVYYUEk7bK9rqI2rA1ikb6lsCypXRqVfnRcaAO2ylQsZHJCoH2cy1r7A2jNnq0=
X-Received: by 2002:a2e:9dcf:0:b0:247:f8eb:90d5 with SMTP id
 x15-20020a2e9dcf000000b00247f8eb90d5mr16503519ljj.23.1647896276871; Mon, 21
 Mar 2022 13:57:56 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 21 Mar 2022 15:57:45 -0500
Message-ID: <CAH2r5mt+Zkrv8A2cw=xSXp=J=sebtF0qxRdP-+WWZqo9USXRsg@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
6e4069881a7f9dceb6dfb97e436d55e3c7f43e81:

  Merge tag '5.17-rc8-smb3-fix' of
git://git.samba.org/sfrench/cifs-2.6 (2022-03-18 12:22:15 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-smb3-fixes-part1

for you to fetch changes up to dca65818c80cf06e0f08ba2cf94060a5236e73c2:

  cifs: use a different reconnect helper for non-cifsd threads
(2022-03-18 23:12:03 -0500)

----------------------------------------------------------------
5 cifs/smb3 fixes, 3 for stable

handlecache,  unmount, fiemap and two reconnect fixes

Am working on (testing, reviewing) a larger set of fixes for
later in the merge window, but these are good to get in
early.
----------------------------------------------------------------
Rohith Surabattula (1):
      Adjust cifssb maximum read size

Ronnie Sahlberg (3):
      cifs: fix handlecache and multiuser
      cifs: truncate the inode and mapping when we simulate fcollapse
      cifs: we do not need a spinlock around the tree access during umount

Shyam Prasad N (1):
      cifs: use a different reconnect helper for non-cifsd threads

 fs/cifs/cifs_swn.c  |  6 +++---
 fs/cifs/cifsfs.c    | 14 +++++++++++---
 fs/cifs/cifsproto.h |  3 +++
 fs/cifs/connect.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/cifs/dfs_cache.c |  2 +-
 fs/cifs/file.c      | 10 ++++++++++
 fs/cifs/smb1ops.c   |  2 +-
 fs/cifs/smb2ops.c   | 18 ++++++++++++++----
 fs/cifs/transport.c |  2 +-
 9 files changed, 85 insertions(+), 14 deletions(-)

-- 
Thanks,

Steve
