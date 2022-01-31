Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903894A4FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378107AbiAaUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378070AbiAaUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:11:58 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF6C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:11:58 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 15so12428276ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/CIVa+RRWQNnLGy3V2L9I9H0nPM13t25wkmJKZ8pwI=;
        b=Hnj7i1+qeZ+iODmrXHcHBSwPNybh/5v0O4PxC5spbKJDWOExiCuf939VmbjwOb2Z+X
         k7yLp2RjzqN77q3LYjPU8JgQ0JvMyl5DvsXeyfAbPA5yYaPWbn5r6DFLVghqj4z30a23
         uKyhJJOT1mO/8bmUfW+PeO+nkFU0o9BTzizNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/CIVa+RRWQNnLGy3V2L9I9H0nPM13t25wkmJKZ8pwI=;
        b=0IwOsTr1OmokzXqmckxxgg7dXe+PpbaNn0bPFRQ1ekXodaqHkpAckGbSOwJoLGnJ1j
         xTHHWbL+y0rBvPF8QqEPuszpKwwV4NXfwBdifBw1K9/nZNCZWkKk9hZru9iu3xvCJ58n
         YgF3cUO3WlZZS1MhwQDJcSS+r3oAMWMSg8G6PJas2vZ9jl54B+hTqKDe3cbkFU7m5/VC
         kv9EfYCkB++vlPnUCN2h6iOyhO6WNAiJB4wxnce/QmCcBsOd7dgwrlhbcIpqdJMfagBs
         R4EnaVFIntSqZ0tYYsSgveY27Ofrwt7pAI28/N92ElLnP60BjS4qgdMXTN37FzLDgbpm
         pxsw==
X-Gm-Message-State: AOAM530904DPNCs9WKYJ/NWnjKZIMLd1LPq5hFEC/qCYuZaBgYOidmtE
        k2jv3Wyw+Y9fVbPOsa5TIoI0WA==
X-Google-Smtp-Source: ABdhPJzc1KLhtQ/qzV+HqIN7RIYyaS/0upOopFGFxPE9WLpp9JSVMxKYnelTAztSE/falvX2Qcg1yA==
X-Received: by 2002:a05:6e02:1b04:: with SMTP id i4mr13324482ilv.270.1643659917233;
        Mon, 31 Jan 2022 12:11:57 -0800 (PST)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l7sm18355170ilv.75.2022.01.31.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:11:56 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, rostedt@goodmis.org, bristot@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: add rtla documentation kernel docs index
Date:   Mon, 31 Jan 2022 13:11:49 -0700
Message-Id: <20220131201149.446609-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link rtla documentation to kernel docs. This patch adds index files under
tools and rtla directories linking them to the kernel docs index.

This patch doesn't make any changes to the rtla Makefile and rtla files,
hence no changes to rtla doc build and install.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/index.rst            | 10 ++++++++++
 Documentation/tools/index.rst      | 17 +++++++++++++++++
 Documentation/tools/rtla/index.rst | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 Documentation/tools/index.rst
 create mode 100644 Documentation/tools/rtla/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2b4de3926858..3852b419fd68 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -155,6 +155,16 @@ Architecture-specific documentation
 
    arch
 
+Linux kernel Tools documentation
+--------------------------------
+
+This is a collection user doucmentation for kernel tools that reside under
+the *tools* directory.
+
+.. toctree::
+   :maxdepth: 2
+
+   tools/index
 
 Other documentation
 -------------------
diff --git a/Documentation/tools/index.rst b/Documentation/tools/index.rst
new file mode 100644
index 000000000000..3352ec693596
--- /dev/null
+++ b/Documentation/tools/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+RTLA documentation and man-pages
+================================
+
+.. toctree::
+   :maxdepth: 2
+
+   rtla/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/tools/rtla/index.rst b/Documentation/tools/rtla/index.rst
new file mode 100644
index 000000000000..5aacc2e8113d
--- /dev/null
+++ b/Documentation/tools/rtla/index.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. toctree::
+   :maxdepth: 1
+
+   rtla
+   rtla-osnoise
+   rtla-osnoise-hist
+   rtla-osnoise-top
+   rtla-timerlat
+   rtla-timerlat-hist
+   rtla-timerlat-top
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.32.0

