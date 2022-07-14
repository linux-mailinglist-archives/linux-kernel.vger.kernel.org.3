Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D25575530
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiGNSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiGNSmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:42:06 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E758E59250;
        Thu, 14 Jul 2022 11:42:05 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id q194so1202318vkb.6;
        Thu, 14 Jul 2022 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5pM5OZFXT7eT1MtTENfYQDWXBwkREE44lbPNJ/oT6+o=;
        b=E7sQa10BwPnGCB04/oDM8crFqI4vnHr46XcNYRqYxPRB5wPV3MLJHqxVpn+Dj3ljLw
         2zaUbjeD89aUtJI3MuKq+UNnxB1G2w+C9wdOYdHQGRzqIsKyH8blgmyGLp2faTzhzf/M
         NSQ7UMb4prgqIxfTlgDv5S6oHHSAVIGycGS9C9d6jE/h5PdRylXyl6J0/RYyV3p0M18E
         yYQzzhJ+P9iAOWbYMS/99cb15TMdfaVRLBPTb5AnnYEQdiS8FAOskq9OKt+hSzzuiJWF
         42g0clRcQ5PWi02lsPVqU5lETKtOkZB9oNoXTZBNdHukhF/FJZnnQOU+/thfk63sdZhN
         UM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5pM5OZFXT7eT1MtTENfYQDWXBwkREE44lbPNJ/oT6+o=;
        b=BxDcJBok5fGLAsilPF1dwk+djDoBMbxPTVp486uURnqQ9OyretZIU4fFNz1yIcMBzt
         +kzg7nJoGkNc2li7ZVJre5zM3/BwUMuofJpz/9PXKI/GL+DE8W4J74ICajkXH1DxhTSd
         10xYo1wKAIww72BxV2HKBFOhv+zk9Zk8+89GZqn76hJEgywpV+AeYv5w96uhjnkc231Z
         1KT0+JzRT1mwlpphCAxHId5tVpfi/CslnI1f391GMWic8bmKskQjRDROgXMWpq8ADu5h
         egY+MDHNJHyWWF7VBSWQ5WzfAlPnkziSU3tVlGunFRlLPhrpzzaOjtPaYR6Z0po8HxG6
         v88g==
X-Gm-Message-State: AJIora+ehROFWbcJtsn6WLFa7XSsDPrAYvpTrjbOfiVR2QcqcxfnqNxs
        9h0VJER3V7CDHs/AGTvHKgRAY1+eiJimerFCXIBfXMKbotB7UQ==
X-Google-Smtp-Source: AGRyM1vdsie2DfOySX22WISVuGQt1xoE2iHu1Uv1TBIsysTY5Kobk6zuYMoLDtO+nuY13g4AoO5RfKC294PUP4AaUe8=
X-Received: by 2002:a1f:2997:0:b0:374:4bca:e8da with SMTP id
 p145-20020a1f2997000000b003744bcae8damr4523986vkp.4.1657824124883; Thu, 14
 Jul 2022 11:42:04 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 14 Jul 2022 13:41:54 -0500
Message-ID: <CAH2r5mtdGBeQK+nVg_9QS5CXWoKM=f=9vbau8Cv6+vcN6DMikA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
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
32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc6-smb3-client-fixes

for you to fetch changes up to 32f319183c439b239294cb2d70ada3564c4c7c39:

  smb3: workaround negprot bug in some Samba servers (2022-07-13 19:59:47 -0500)
----------------------------------------------------------------
[resending due to cut-n-paste error in earlier P/R]

Three smb3 client fixes:
- 2 related to multichannel, one fixes a potential deadlock freeing a channel,
  and the other fixing race condition on failed creation of new channel
- one fixes a mount failure, working around a server bug in some
  common older Samba servers by avoiding padding at the end of the
  negotiate protocol request

----------------------------------------------------------------
Shyam Prasad N (2):
      cifs: fix race condition with delayed threads
      cifs: remove unnecessary locking of chan_lock while freeing session

Steve French (1):
      smb3: workaround negprot bug in some Samba servers

 fs/cifs/connect.c |  2 --
 fs/cifs/sess.c    | 11 +++++++++--
 fs/cifs/smb2pdu.c | 13 +++++++------
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
Thanks,

Steve
