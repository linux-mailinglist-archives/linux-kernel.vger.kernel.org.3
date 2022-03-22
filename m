Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271BE4E3DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiCVLic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCVLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:38:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCFC82D26;
        Tue, 22 Mar 2022 04:37:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso2374600pjb.0;
        Tue, 22 Mar 2022 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbrbPkE2aUXo5cVNXsCi9vK1u5Mq1NJg+C23A/DyNPc=;
        b=pHb5hEW7Z3tmfsv7dPHkJQM9szY/WTm/rRuNpc7eJTyxU3hzEommKLH4EpEG61Qhex
         0Vqj+Wb/xPrRm+2NJzM7xEKJat+VxojW+k6PXBUV0052507sMvQqbvXeS7mdjVrdppXR
         LLHODDTTMJFFb5G7v1NKUDFtrmSdSAtmSN9QZaY5y70o0F/RT/SJ3prCOccjoYTQi03i
         3UFWlcfXpizkWKRZLqmiHbNklQFOBqCLfcVN34RRfQ4OZtANdjxRODYjJqCny8BEONvc
         kFOhdZVs57jC5vI5GEFDTbvf+aZBr4KjLeFO7Ne4OrOLgWG9HHSbAqeFYPMXoGMWX6zi
         xLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbrbPkE2aUXo5cVNXsCi9vK1u5Mq1NJg+C23A/DyNPc=;
        b=d0PZ/urwuLocVwCfPUb63HQWHj39b2gRwFzbTP2E9lN74n8esygbXRa6Fk6bGyhNhP
         x3ZKTV2DH5JjK1JFED/jUQQ+bRujMF/xfGqwJyN9+Y2G/+A3wjpw6OoHrexX/AqulVf6
         +aYuGZ/N5y/ib24UC1X11dS6RI0dyww3ijvC7zbCDD84jNa8gQ4bFT8b7/lVqd1lTJcz
         VuMHhz1x4ibOQGMjtHkiq8D0bj73PkBN5Nc/RXCXpUDodkXO8xlO6w4W3boU2KHBGBwp
         BRNnKSWX339bnZ+h0yBaaZ7gJBRij+l+RefYBckmJiLjowFitjr/2PxvepRMwb8r/Ubh
         0Cuw==
X-Gm-Message-State: AOAM533WET+nf23xRoSZqRO1+A4BKIrt1rv4iVWGypZJFCAEMrlcpJh1
        lj8/vMGuI7Wf377Q5ytL3A05Zejh4DlE0A==
X-Google-Smtp-Source: ABdhPJzAOGtqAFTEcO/NSk0wpTMeSUwSUgTJzFfOVo+zu0Enc1+wLCokCGXxxlOLwbRkTFVDO5E13A==
X-Received: by 2002:a17:90b:390c:b0:1c6:259e:759 with SMTP id ob12-20020a17090b390c00b001c6259e0759mr4421493pjb.120.1647949021231;
        Tue, 22 Mar 2022 04:37:01 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id b7-20020a056a00114700b004f7be3231d6sm22483286pfm.7.2022.03.22.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:37:00 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Documentation: add missing page title for kernel-doc.rst and sphinx.rst
Date:   Tue, 22 Mar 2022 18:36:44 +0700
Message-Id: <20220322113645.502544-1-bagasdotme@gmail.com>
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
index 79aaa55d6bcf2b..de47b20c806acf 100644
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
index bb36f18ae9ac3e..140507de5a85e0 100644
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

