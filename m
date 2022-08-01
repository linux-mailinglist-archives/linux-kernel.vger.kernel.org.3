Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3696A5871C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiHATw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiHATwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:52:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A064F4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:52:24 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so9709723fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=wnWScf7LqaAZDkgZLzfimbdgLl88BBcMGXBxkFVnUxw=;
        b=R6pwpH/oM2GIYRFw8ggxOe+jAaEgpxEAYVIalSyt7g0V84z3CA3NBm3Js8HpWp2IdO
         8IfPN2CEQfwy9AzXfrtD8wS5qwo9wDyKCwDy2/D2oVjjqhzBTtxIpxwNakj4YF3QuAND
         ZWj1/1jGDo3rUIX+r7OV6quKddh8vidqqnq+dHKdc3gOvQxemfqdqH9ZCGTbeos1Pvgy
         QuwIFXXabOxeudMYtcKgHy98/X2TroHOG3g/kQMsla1rT56ji+v4aMd1v41T1i5lMncp
         R4XjfoGVJPKDIyPeRbHdX55tm0jeT/Qu5B6IX5/Wm0hwaBcxq7d5eAF0hkAfpBZu0Ncj
         yMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=wnWScf7LqaAZDkgZLzfimbdgLl88BBcMGXBxkFVnUxw=;
        b=LnncCLH/nlq1mtOxUMvhNf1uxC5SjvkAMpPeMLPgxHkyaffiUwvJ4J+muKljKSKFE1
         0tgs9NBcjYBUqtB1yhsYzvGWvFd6dNnrwFnT1kRrGRbPCAxr1hakOoxN4sGWgiGtTCfD
         w4B6aeqnO9b+t81JwF5BFrSRYmhblqFteFApXgUrK+KeI93C0LjFA59W1CeHLqUVxsRp
         mXyG1TXqHxFtdF71nIJYxKeAT2aVLURIzbw7L8aF7A8vnT5lspx2th953hPDqMgNChjx
         3Y0/IVYir1zUAgFEHGrc7t1qLsZiOUcDighZPsGR2xar1zR0ShBk4Eixl14p7EQBkCKs
         V6ew==
X-Gm-Message-State: AJIora8RCtA8r/qcdjeKZxSVuSO3hmx2EuU/9b7krEQbyD0OnfJWZ34o
        k2QaB+CNHGf7UiYDHte6+tVOKixIwPNEW4L3E/QQzZM54paC
X-Google-Smtp-Source: AGRyM1sV3MTmg1UTxb+NlyH4mYnyvqIa3VrKRt+JM1Fp0fB5GFjb/XZCHX1rgY0ucm8rsIXInjWUyHeomQF9CL3bL4A=
X-Received: by 2002:a05:6870:b40d:b0:10b:8586:9d91 with SMTP id
 x13-20020a056870b40d00b0010b85869d91mr8361515oap.136.1659383543416; Mon, 01
 Aug 2022 12:52:23 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 15:52:12 -0400
Message-ID: <CAHC9VhTzrgsDuSgQSAJyJ=E9q5VsLqvms8n83WS3oMnFJtxf7w@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Two minor audit patches: on marks a function as static, the other
removes a redundant length check.  Everything merges cleanly against
your tree of a few minutes ago, please merge for v6.0.

-Paul

--
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

 Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220801

for you to fetch changes up to 546093206ba16623c18e344630dbfdd71a4327e0:

 audit: make is_audit_feature_set() static (2022-06-13 14:08:57 -0400)

----------------------------------------------------------------
audit/stable-6.0 PR 20220801

----------------------------------------------------------------
Shreenidhi Shedi (1):
     audit: remove redundant data_len check

Xiu Jianfeng (1):
     audit: make is_audit_feature_set() static

include/linux/audit.h | 2 --
kernel/audit.c        | 4 ++--
2 files changed, 2 insertions(+), 4 deletions(-)

-- 
paul-moore.com
