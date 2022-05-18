Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E752C242
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbiERSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbiERSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:16:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0195D5F8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:16:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h14so3825006wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kWHj3GGl8z0pQ8ELFmv+NfP4zyxBIorTjHSTLj3pqmE=;
        b=TYfcHLJ3sVF2GMZ/bt1Qslc/cTbhJ89bSU3/3f8cVSFgbWvFp0lw3otLcOG3hv8Fbc
         4RZFlvI8WP5f5bmLTnKRkychHi63T9jZw9UBq8xKjPao5euS2MeARa9zMpg9CucRUCa7
         GxzHqqOKuFQTr6SipwfHLWBgNhiaTvfVKqqG/50WCTkOEhT6+2YcDiVfSrI7Ad4DZcig
         mxYNZQSW/WHE5SmuoTcxDe1FnoldZ8kZtpmoOmYPGeqTREwtIBnGpG2+Aac/d585pUYL
         zRk3pgvcIki599diV1OZv/zLo9MquCPW8Rtbwhk0JDuH5+Qx4I8abUZdLb1efm/mBN1v
         ZcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kWHj3GGl8z0pQ8ELFmv+NfP4zyxBIorTjHSTLj3pqmE=;
        b=jUxncJYWolQtTqq1MO0gfSV84+oIHhIYG9+x0bQ+CdRmvPLn/hkTLHG5A3YQU6lTg0
         6iCkFSdtv0yLdHrMBqE6MX3ZfmM7dhXqinT8XmK1KKrgaNQbDsV56bsHa9Sa7PJYcZda
         eQCd/PcnoSCQyKBem6IG2l2g0byQxSxoVc/R9WIPpksRN6tw/vTlu/jtRXqd5WKtayE7
         6QyudvcH7UguIuT+IJG/X2+hcoF9936DurOLGJuKPhDpRmfkxerrpBQScvwMcHYX9t5u
         WNHKrfeIN216NHSP+3u5jLlCrGn0oyV54C8HcOcnlieqNopzJsTfz+/wRDHvH3sqz53N
         eVxg==
X-Gm-Message-State: AOAM533FBrgn8vm2ZWkXEFpWkbflrn8Ldjp1i/ATrQEHL2LMFJ3oYQee
        BtyyxbCb1wZY/ESOkCYrzxLJmBo01gxaGvNOrS30Pyvbq300
X-Google-Smtp-Source: ABdhPJw6wDTkc19Ln53H3KAjKofnbEQ0/3R2SNkk59SSN0lJv209DtpZRbRuCUXeYxHnwcvgHTLS0DeJD7fITuZLl38=
X-Received: by 2002:adf:f049:0:b0:20d:a8d:b1e3 with SMTP id
 t9-20020adff049000000b0020d0a8db1e3mr751533wro.241.1652897809699; Wed, 18 May
 2022 11:16:49 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 May 2022 14:16:39 -0400
Message-ID: <CAHC9VhRzZwD5X6AVojX8eFyN8i4fHfw1T5ugDd8brb=qRi1Cug@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.18 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A single SELinux patch to fix an error path that was doing the wrong
thing with respect to freeing memory.  Please merge for v5.18.

Thanks,
-Paul

--
The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

 Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220518

for you to fetch changes up to 6254bd3db316c9ccb3b05caa8b438be63245466f:

 selinux: fix bad cleanup on error in hashtab_duplicate()
   (2022-05-17 18:34:35-0400)

----------------------------------------------------------------
selinux/stable-5.18 PR 20220518

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix bad cleanup on error in hashtab_duplicate()

security/selinux/ss/hashtab.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

-- 
paul-moore.com
