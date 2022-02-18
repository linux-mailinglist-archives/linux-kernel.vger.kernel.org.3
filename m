Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B234BAE5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiBRA0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:26:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBRA0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:26:33 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E92B64;
        Thu, 17 Feb 2022 16:26:17 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v22so17017ljh.7;
        Thu, 17 Feb 2022 16:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eUXifU57wr8m7+vb0ZA07WLIAZ3Qd08pHdmasfzwIqI=;
        b=nBoUY4swZ+A3dxeiKuJp18/Emru0aZHp0tyjQTAx036tVs1sDB7Y6FtxIvCFiEi+Wl
         gwyCpOIwWSEbWU2gzsyIC2FsvHuaolr/XCCGspAsLSHtgE2EY+1InOZCZZI6dsSOMedQ
         yxeFxCCiijbZnby8POR8gaxHjFch6e85dgIIl4wUxh4knNlQwUfOFoH3yzI1RLjqx/Cq
         g5A0Cw5y5ez1hg4dlFlF40J7oEWWy+U5s5zdVDwMZ2PRynDCHO/kT/L9yNnp3tvX8K8U
         p6MobnPXs2iEv/gFIzftEzMRA8oUIf+qVmSl+rLVojOUQ0+D0xN43U9vk//am2seyXI/
         3b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eUXifU57wr8m7+vb0ZA07WLIAZ3Qd08pHdmasfzwIqI=;
        b=RqMUcDkTrNLADGDBu3Qz0z+jakmiZp4DCKMzOthnMjk85WwoADMyUGUCVPguVGV2Bp
         L9QskS7Fs+KME8k2qZvD/UuwEHp2vc6CIpgp5jty0baASVa/eiPaCetrSQ2CquDYFZzT
         GMbq90bfky1ZhVQFVi7sVh85b+ddzi2AjtnA3uPVCTvsdR4jqB18soYwzex9M8GN833u
         rshk7XE1RwnGTcYKOHQ/WmOqo6Nvp2xMW0EDU7PzRnUVrLU2DU5kpe0QBdpUNlYU/URe
         4S7T5SrC0DMmEC2bL7XJoRFZ5P0wO7E1M1CkpXe3wziuX0eNba4MH+1iIIlbTbLZqLSK
         UKsA==
X-Gm-Message-State: AOAM530ZVQVGo41lltRv+0YJInewFsVQGulTSS56aXiMi0BgVw3rZCKk
        UvSpYnfEqNZ0kk2RgSFJeL1oaTpNIXBGl/tQgVqto6iUOgh4OQ==
X-Google-Smtp-Source: ABdhPJxLNDvHJgu3mKO93fNwjadv88jy7UAMG7iS/OkM7bZMx0lSjqEfK3TgSd69SephuwQm+LayaIAZva7VYQsdXGA=
X-Received: by 2002:a2e:b16a:0:b0:244:e31c:ea96 with SMTP id
 a10-20020a2eb16a000000b00244e31cea96mr4110177ljm.500.1645143975846; Thu, 17
 Feb 2022 16:26:15 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 17 Feb 2022 18:26:04 -0600
Message-ID: <CAH2r5mukF1Af7TyrQPbvqQ1bpV67+btHiFstJLUh0RpJHeTmSg@mail.gmail.com>
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
754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc5-smb3-fixes

for you to fetch changes up to 53923e0fe2098f90f339510aeaa0e1413ae99a16:

  cifs: fix confusing unneeded warning message on smb2.1 and earlier
(2022-02-16 17:16:49 -0600)

----------------------------------------------------------------
6 small smb3 client fixes, 3 for stable:
-fix for snapshot mount option
- 2 ACL related fixes
- use after free race fix
- fix for confusing warning message logged with older dialects

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/904
----------------------------------------------------------------
Amir Goldstein (1):
      cifs: fix set of group SID via NTSD xattrs

Ronnie Sahlberg (3):
      cifs: do not use uninitialized data in the owner/group sid
      cifs: fix double free race when mount fails in cifs_get_root()
      cifs: modefromsids must add an ACE for authenticated users

Steve French (2):
      smb3: fix snapshot mount option
      cifs: fix confusing unneeded warning message on smb2.1 and earlier

 fs/cifs/cifsacl.c    |  9 ++++++---
 fs/cifs/cifsfs.c     |  1 +
 fs/cifs/fs_context.c |  4 ++--
 fs/cifs/sess.c       | 11 ++++++-----
 fs/cifs/xattr.c      |  2 ++
 5 files changed, 17 insertions(+), 10 deletions(-)

--
Thanks,

Steve
