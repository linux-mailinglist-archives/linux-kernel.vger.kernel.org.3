Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7D4CDBEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiCDSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiCDSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:15:11 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A111C60CD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:14:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j13so478556plx.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh5vftoRUG9tfWgBVUTs1k9OlrXPgXdVBmBZqLBdt+w=;
        b=HAxfOfNK8fPE6K65RuTPytFLirRUSAVwwC2JDfJRPuSkPrXNoRiAaAdrIrTR86ceJ3
         Y4Va49BKXHMkDyeikBczrSuuHCh5GsXb3LAAYK5FKtcaBaYi95ZPXf+SqeQemlg+ELkP
         WqDapHPkJRipPGggWxQ5b8uzYCfXFjQp9Mh28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh5vftoRUG9tfWgBVUTs1k9OlrXPgXdVBmBZqLBdt+w=;
        b=I8+iKZRG/2d1G2l5QJc1+LMJTJj1kK2NqcUMtErIEwO2zQHkG7kSU7G0UK8n4+He7p
         MPfNfu1v8N4vw78/ndWVMD20XDS6A0+srqLzZCV/bTQ22tXRxOQAmDtVxsnEn2x8wBUy
         S0fKw0p+Pm2ectGSQVhp3Sy8mPfyAN4KqHmb5jYKggX2LAU6QfYJ7f6Zmd5G+kTFLr4y
         siatFBvKPH5TJ+iRLvso1h/TABrFsFjSJIySY72s5xzhmc8hVeFTQT4bMBAsvxwhSYPJ
         eZWAACy6ypbesO/b+jF+XnzMv+IOWxoqZEPzVQOM5Fmtfss92ntpp7lLX+eK9cF7GJWC
         Ly1Q==
X-Gm-Message-State: AOAM531wghI7zCaF7cpnYX00Dgux6KzQD1TqzkuPtDYfPqCn0e5/Bvrm
        qv3ITwohSsoOfY8C5ZslVs3Y+bbReiCqDg==
X-Google-Smtp-Source: ABdhPJxr8ZmSXgfKKXpIZjtR4ExIq/Oeywv9jznmqbkfVe79uwXkfwYtvEQUqlwuh0gyWzJ9cfA+RA==
X-Received: by 2002:a17:902:7e4b:b0:151:57d6:670f with SMTP id a11-20020a1709027e4b00b0015157d6670fmr31248297pln.144.1646417660733;
        Fri, 04 Mar 2022 10:14:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a0008c800b004f664655937sm6931436pfu.157.2022.03.04.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:14:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] Documentation/process: Add Researcher Guidelines
Date:   Fri,  4 Mar 2022 10:14:18 -0800
Message-Id: <20220304181418.1692016-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9606; h=from:subject; bh=FHNm+uQKf9xPLm8qMtVXtRFAvmc97RmA7Plr28ba3vk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiIlb6QnVq67zwRqfqUG0qPrwtZVFZ+Kq2tRCuJza5 oIT2I8aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYiJW+gAKCRCJcvTf3G3AJpr2EA CyMAfxmvcnGei0BvduLgBxmxonTgyP/mCnp1OMWRwtHilKoYRjX67Zz3gAhbWKsp7unBP7EExDRigO K0K1VANrK6yJSWbUhIbGbb3T4WGdYTya/7QsYZpsP9eB++hg4x2M3w2VB9Vg4AK0lOLafax4GkHBXv 6TtejOg3Djqf+61a11BZm0AoZ1A1gL5c7MIaWgRuOeAK2i84KH5qxTlE8zpATRVwa5QYPbEPckYWJ1 NkWUKQ/vtGOIja8JSLzm+8LJMWmLcGQ1LUi4ls4fmWzDhuZ9UCT1Jm0FM1yrfjWGoA/CZZWAMBxdny XVAzVNzWhznBL+67BLuHu9+o3VNi+j9RjFuYsJ5zjbPHDRWjX6Jryg3ZjdnuDXOvRjk1qx9QEFD7p5 mpxEd5r/TtcJRq9HX+Ws0l4s6Im4IbjcKF3+fesRlxqA4wr+M6+qxh/mvTWOP/S8MRBTmNADmy2bkD Rai9g+d0SsC6pMAtBraoFljbsKbXcLkqLIlb01jpr9njScIuCREyzld4uSe6kqhZXkeqoa9tkkPZ6d wDHhfS+ikyajwLzfoGkRAFVj/RkY46nqpGnpU/++CjQjG8HKxe9L3wr5lbb7FzWwMxNOZDRK6WhPmB cE+fvPVybltbkhs7gC1GGQLrm5lj8yBpuxJ9kXzZMlzdasNQNiKR9Cxe08iw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow-up to the UMN incident[1], the TAB took the responsibility
to document Researcher Guidelines so there would be a common place to
point for describing our expectations as a developer community.

Document best practices researchers should follow to participate
successfully with the Linux developer community.

[1] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/

Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Co-developed-by: Stefano Zacchiroli <zack@upsilon.cc>
Signed-off-by: Stefano Zacchiroli <zack@upsilon.cc>
Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Steve Rostedt <rostedt@goodmis.org>
Acked-by: Laura Abbott <labbott@kernel.org>
Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220224001403.1307377-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220225201424.3430857-1-keescook@chromium.org
v3:
 - move to /process
---
 Documentation/process/index.rst               |   1 +
 .../process/researcher-guidelines.rst         | 143 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 Documentation/process/researcher-guidelines.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 9f1b88492bb3..f7664a1db8b8 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -48,6 +48,7 @@ Other guides to the community that are of interest to most developers are:
    deprecated
    embargoed-hardware-issues
    maintainers
+   researcher-guidelines
 
 These are some overall technical guides that have been put here for now for
 lack of a better place.
diff --git a/Documentation/process/researcher-guidelines.rst b/Documentation/process/researcher-guidelines.rst
new file mode 100644
index 000000000000..afc944e0e898
--- /dev/null
+++ b/Documentation/process/researcher-guidelines.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _researcher_guidelines:
+
+Researcher Guidelines
++++++++++++++++++++++
+
+The Linux kernel community welcomes transparent research on the Linux
+kernel, the activities involved in producing it, and any other byproducts
+of its development. Linux benefits greatly from this kind of research, and
+most aspects of Linux are driven by research in one form or another.
+
+The community greatly appreciates if researchers can share preliminary
+findings before making their results public, especially if such research
+involves security. Getting involved early helps both improve the quality
+of research and ability for Linux to improve from it. In any case,
+sharing open access copies of the published research with the community
+is recommended.
+
+This document seeks to clarify what the Linux kernel community considers
+acceptable and non-acceptable practices when conducting such research. At
+the very least, such research and related activities should follow
+standard research ethics rules. For more background on research ethics
+generally, ethics in technology, and research of developer communities
+in particular, see:
+
+* `History of Research Ethics <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
+* `IEEE Ethics <https://www.ieee.org/about/ethics/index.html>`_
+* `Developer and Researcher Views on the Ethics of Experiments on Open-Source Projects <https://arxiv.org/pdf/2112.13217.pdf>`_
+
+The Linux kernel community expects that everyone interacting with the
+project is participating in good faith to make Linux better. Research on
+any publicly-available artifact (including, but not limited to source
+code) produced by the Linux kernel community is welcome, though research
+on developers must be distinctly opt-in.
+
+Passive research that is based entirely on publicly available sources,
+including posts to public mailing lists and commits to public
+repositories, is clearly permissible. Though, as with any research,
+standard ethics must still be followed.
+
+Active research on developer behavior, however, must be done with the
+explicit agreement of, and full disclosure to, the individual developers
+involved. Developers cannot be interacted with/experimented on without
+consent; this, too, is standard research ethics.
+
+To help clarify: sending patches to developers *is* interacting
+with them, but they have already consented to receiving *good faith
+contributions*. Sending intentionally flawed/vulnerable patches or
+contributing misleading information to discussions is not consented
+to. Such communication can be damaging to the developer (e.g. draining
+time, effort, and morale) and damaging to the project by eroding
+the entire developer community's trust in the contributor (and the
+contributor's organization as a whole), undermining efforts to provide
+constructive feedback to contributors, and putting end users at risk of
+software flaws.
+
+Participation in the development of Linux itself by researchers, as
+with anyone, is welcomed and encouraged. Research into Linux code is
+a common practice, especially when it comes to developing or running
+analysis tools that produce actionable results.
+
+When engaging with the developer community, sending a patch has
+traditionally been the best way to make an impact. Linux already has
+plenty of known bugs -- what's much more helpful is having vetted fixes.
+Before contributing, carefully read the appropriate documentation:
+
+* Documentation/process/development-process.rst
+* Documentation/process/submitting-patches.rst
+* Documentation/admin-guide/reporting-issues.rst
+* Documentation/admin-guide/security-bugs.rst
+
+Then send a patch (including a commit log with all the details listed
+below) and follow up on any feedback from other developers.
+
+When sending patches produced from research, the commit logs should
+contain at least the following details, so that developers have
+appropriate context for understanding the contribution. Answer:
+
+* What is the specific problem that has been found?
+* How could the problem be reached on a running system?
+* What effect would encountering the problem have on the system?
+* How was the problem found? Specifically include details about any
+  testing, static or dynamic analysis programs, and any other tools or
+  methods used to perform the work.
+* Which version of Linux was the problem found on? Using the most recent
+  release or a recent linux-next branch is strongly preferred (see
+  Documentation/process/howto.rst).
+* What was changed to fix the problem, and why it is believed to be correct?
+* How was the change build tested and run-time tested?
+* What prior commit does this change fix? This should go in a "Fixes:"
+  tag as the documentation describes.
+* Who else has reviewed this patch? This should go in appropriate
+  "Reviewed-by:" tags; see below.
+
+For example::
+
+  From: Author <author@email>
+  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
+
+  The error path in foo_bar driver does not correctly free the allocated
+  struct foo_bar_info. This can happen if the attached foo_bar device
+  rejects the initialization packets sent during foo_bar_probe(). This
+  would result in a 64 byte slab memory leak once per device attach,
+  wasting memory resources over time.
+
+  This flaw was found using an experimental static analysis tool we are
+  developing, LeakMagic[1], which reported the following warning when
+  analyzing the v5.15 kernel release:
+
+   path/to/foo_bar.c:187: missing kfree() call?
+
+  Add the missing kfree() to the error path. No other references to
+  this memory exist outside the probe function, so this is the only
+  place it can be freed.
+
+  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
+  11.2 show no new warnings, and LeakMagic no longer warns about this
+  code path. As we don't have a FooBar device to test with, no runtime
+  testing was able to be performed.
+
+  [1] https://url/to/leakmagic/details
+
+  Reported-by: Researcher <researcher@email>
+  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
+  Signed-off-by: Author <author@email>
+  Reviewed-by: Reviewer <reviewer@email>
+
+If you are a first time contributor it is recommended that the patch
+itself be vetted by others privately before being posted to public lists.
+(This is required if you have been explicitly told your patches need
+more careful internal review.) These people are expected to have their
+"Reviewed-by" tag included in the resulting patch. Finding another
+developer familiar with Linux contribution, especially within your own
+organization, and having them help with reviews before sending them to
+the public mailing lists tends to significantly improve the quality of the
+resulting patches, and there by reduces the burden on other developers.
+
+If no one can be found to internally review patches and you need
+help finding such a person, or if you have any other questions
+related to this document and the developer community's expectations,
+please reach out to the private Technical Advisory Board mailing list:
+<tech-board@lists.linux-foundation.org>.
-- 
2.32.0

