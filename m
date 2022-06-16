Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408DA54ECCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378627AbiFPVoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFPVov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:44:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB65C67A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:44:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so3434484wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vJM7RdjKz/WSSaxBuzaq5SgZIUwXr5fvQdIIno3C/Lw=;
        b=o8EaRErmx8+qFSfgfxIM6dwARWAwD+PiJ4fLDS2AOQ4ULPRbJkDX33w2KJqeQ3FegE
         BWtcYvEND6HVWWXe4fvl7Bi1J1PyB3S1OFqoD5ZeHD0y/dXN52uzp58YD5NnCgct6RS5
         4gikIPO65o33LG1qGA81jKRkT/TEF5USZ4N+y6G9VhhZ2Bv8A4QQzsbzFL08ksjkgYI5
         83zDxuYYLF/qL5fc0S+Wq80lMJsqmJSt2zJmvfgbXFL1553ZYhEpq8TMzdoIKC27Q+LZ
         CNl0KY/fLbjDzvmUT1HMNyNPoUtdJ+f0NFREQqT8G/owLBLrW3MeEKI6q2JWsyJBYKGK
         weAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vJM7RdjKz/WSSaxBuzaq5SgZIUwXr5fvQdIIno3C/Lw=;
        b=45ZfdRuOxFxg23b7SXEcBG45889tAsTnGWww9hLTlZbHBLaY2swljMIJaVYANUOTwi
         QthoP/UxN1tz1yWP4ngKwqxuftPXh73d5g1krTWlLNtB/qcTxYqwRzUQoOBkAOU980/l
         WBqPFthBWk09QHAK/DAKuCsZy7NiatvfoK2OyTWq2oIllToZnBd31LLmv1Z/fOvWzR27
         yD51+5OVvVwYVUNJE7mASp8NaNz7P/zWjA4Ku9TVvZiG3hvwWLdNF9qL5kWS6ZQVkWkb
         1lb22vq/R6gfNBUsGZIN2L5oBNF1aKXUyEBmmxtgt/3saDJ5DSvUqnPyt90IBuGx4QDO
         XsDg==
X-Gm-Message-State: AJIora8pjw56O0Uz9kCzdZHqAcnP5u8ZCeCe8V3CQKEM9KsB4yA6r7uW
        pIjm8dyHJu87/pWLhct/OMfRRgGOjZ/wr8L9m39mb4gQA0mj
X-Google-Smtp-Source: AGRyM1vBeV64jRUDVLystW6tHyzywN0o3N1mBbA7cC++KJi1ZRusep3xIZkzfptMKv69n0GAU0SVYiYV8w3yvfY77B4=
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id
 l18-20020a5d5272000000b0021033b8ac4amr6329037wrc.483.1655415886658; Thu, 16
 Jun 2022 14:44:46 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jun 2022 17:44:35 -0400
Message-ID: <CAHC9VhQa-L-_F4UdMekqvyF714xhEerVQzc9rPvuwTQJtmMd8A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.19 (#1)
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

A single SELinux patch to fix memory leaks when mounting filesystems
with SELinux mount options.  Please merge for v5.19.

Thanks,
-Paul

--
The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3=
:

 Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   selinux-pr-20220616

for you to fetch changes up to cad140d00899e7a9cb6fe93b282051df589e671c:

 selinux: free contexts previously transferred in selinux_add_opt()
   (2022-06-15 21:20:45 -0400)

----------------------------------------------------------------
selinux/stable-5.19 PR 20220616

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
     selinux: free contexts previously transferred in selinux_add_opt()

security/selinux/hooks.c | 11 ++++-------
1 file changed, 4 insertions(+), 7 deletions(-)

--=20
paul-moore.com
