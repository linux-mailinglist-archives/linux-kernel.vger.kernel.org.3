Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24C4D95B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbiCOH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiCOH4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:56:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B5D4BB95;
        Tue, 15 Mar 2022 00:55:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s11so18306649pfu.13;
        Tue, 15 Mar 2022 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHSZIG+RYTCoSU7g3G2vhk0zPZz5xdBXJmdaVeF2FQc=;
        b=WpRExcQZ2oJRGbTE4iawonQ/UFuxcyfdbxG7vnwZuYboTrVodWofNu9ITXPkK9ykzR
         ove6te24iAGQljWqWFRhG3xe8zk5jIpOrqeQqIWsb5EUfRkCIQSl/ZqJMH37IzlDwM27
         T1Pe/VGEXEKAvR8zFUx1MUQW9Ew6lSg1nTfRyjqEHXXWscEMDRBDHhb234BD7hum7Bzx
         OC8WGLzWujuzIPTQiViAfhohcYNOAQVPJqTWDe0xacHlWmJH7CvPpbMheoD/xsdE+e+u
         9ptwybUFlE6UpFS1spqJbf1Yt8Zs+JN+afXEjecMCEv6kuKVt1jHDuvl/p8FreJAw7vm
         Vg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHSZIG+RYTCoSU7g3G2vhk0zPZz5xdBXJmdaVeF2FQc=;
        b=pSKw9bCabIuAW0txrrDiVahU0LWrRy7pWE+tfXaDaNQmnH3NRgrMiYEsyDeBV/Bvpg
         d7q1sV4IqUNSsGn0JlrtEPSQ5kl6N1YIzSYVYsAgkD1gZrde8VxS1pIl2JHrw1IS5Inn
         aVyU3BfRDDc/d/KDOmkDVPJGY7UhPgxny5F0SmW9WGLT1JZakSjDj2AhEBjP5ow3cjAw
         RwDjpb2W1RcIrtAPCZ/9gBVTlUVVvqOlnTddKyEM1iG5jNI43o141d5u+63rj/+03o5s
         /Rp448EHQC+b0tfnlG9SZEK3biIvfwD4UpNj1nD/0x+8vad9z3I/qNKG5NsjTljl2YO4
         px7g==
X-Gm-Message-State: AOAM53241WKMcO5ODvLA0g4pLS+j7W9z9PA9HB/54BpxGsLbPcbgv/6+
        zFWOe0tfwmba9gQj0uEsaVz9yQ9h0eFQcQ==
X-Google-Smtp-Source: ABdhPJwNq3saFA+VPFYdL6A+EbrsrcQQk4WMnlZ0KPZJHnBq1V7Yr1n5wVJTpG0afaKHlLCbPFltVQ==
X-Received: by 2002:a63:c50:0:b0:381:5118:62d6 with SMTP id 16-20020a630c50000000b00381511862d6mr3962933pgm.420.1647330941329;
        Tue, 15 Mar 2022 00:55:41 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-94.three.co.id. [180.214.233.94])
        by smtp.gmail.com with ESMTPSA id me5-20020a17090b17c500b001c63699ff60sm1754906pjb.57.2022.03.15.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 00:55:40 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: add missing page title for kernel-doc.rst and sphinx.rst
Date:   Tue, 15 Mar 2022 14:55:27 +0700
Message-Id: <20220315075527.229918-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sphinx.rst and kernel-doc.rst are missing page title, thus top-level
headings in the respective documentation is displayed in the table of
contents for doc-guide.

Add the title.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 4 ++++
 Documentation/doc-guide/sphinx.rst     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 79aaa55d6bc..de47b20c806 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -1,3 +1,7 @@
+==========================
+kernel-doc Comments Format
+==========================
+
 Writing kernel-doc comments
 ===========================
 
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index bb36f18ae9a..140507de5a8 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -1,5 +1,9 @@
 .. _sphinxdoc:
 
+=============
+Sphinx Primer
+=============
+
 Introduction
 ============
 

base-commit: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
-- 
An old man doll... just what I always wanted! - Clara

