Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4844EA251
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiC1VVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiC1VVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:21:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7BBDE0AA;
        Mon, 28 Mar 2022 14:20:03 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 12so17040074oix.12;
        Mon, 28 Mar 2022 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9qRB0II6Ytegh9oDXsqAEWbvdBJG2QMLk1XoynhcSdc=;
        b=dxqQd6nql5QXzoESlASrLi1QNkobaBAfzSkh02IyFE7xIQp9LayDWrLjad2/e4NV3e
         xhjRuCUBFwECfaR20P33Z4CpX1MdPjRdQRUuTFiOJFcKXeBjA5r+bizltdaNZWuiSWD6
         hn1f33L5SfUYyaf5iJIsYYAl/bx+r9sHzE1xKxI4L2A6dDqoobwqfBGMLODhu52x7k5D
         QHqWvOHY9zBJ3N9mSrpxkEqkw5dBK70UBub3nxP9Zqnztjjy+jv21M5JKOtmDNr9/cF5
         B5PQm8obEdKDAtVCwldxSMJh4cU1a5C9t2Aw6KmO9bB0SAvfuTQvRrz4YjkoE0rpSa29
         dRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9qRB0II6Ytegh9oDXsqAEWbvdBJG2QMLk1XoynhcSdc=;
        b=s8CYnYUe04PlkSPi7KP7Uft8PjbZkDdrZVhH4ewb0XBE/6JTiOPtpZNN+ZPDwzVo4K
         45fkufdR3Nf3hGd1siHqdE+fp5TF+TUHHNVDtPNM4fEHmhPnRB5k75qfDIU5i6O7Y3QI
         LRMA91LBPgL9oITDZLE0R3iMjM08s7FYyAp7Ea9waUGqf3uG8/O52DVBCJJN1YLot6eM
         EY8cUUdSKi9OviR2EKqv+y+b1AZoD4MX7cwO2RaaG4jLJMp2ml6Mjf1eoFAAQKN/Nxp1
         7gKrHZ8AjMpDCMgk8XbGfknBNogQjr1BrnnNukWS4phbhj+ZV/uaq4ZUkJzF1TlwzxLo
         jh+Q==
X-Gm-Message-State: AOAM530i+eWTPG2cad6racpyf2hhMyJ2vqhVpDKe+Pm+1bqhK4pGed5J
        epWyM+4ekCkFXAhLQJITujxjZ1yOdEB/qw==
X-Google-Smtp-Source: ABdhPJyfDVaw45zbC+ieRzXi6qjNPLAoCc7QpjVc07EsaBBdS2dXFzBmXSZZyWt4sD5iyArPPUtkew==
X-Received: by 2002:aca:705:0:b0:2d9:6bb6:5b0 with SMTP id 5-20020aca0705000000b002d96bb605b0mr621876oih.11.1648502402818;
        Mon, 28 Mar 2022 14:20:02 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id q9-20020a4ae649000000b00320d35fc91dsm7408930oot.24.2022.03.28.14.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:20:02 -0700 (PDT)
Date:   Mon, 28 Mar 2022 18:19:56 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] Documentation: dev-tools: Add a section for static analysis
 tools
Message-ID: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement the Kernel Testing Guide documentation page by adding a
section about static analysis tools.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Hey everyone,

I think this patch can be a good addition to the documentation as
discussed in the thread for the testing guide documentation page:
Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/

If you think it would be worth it, I can try making something more
elaborated. Maybe provide some guidance on when to use each tool.
I've been studying how Linux device drivers are tested.
Here's a post I wrote talking about some testing tools.
Link: https://marcelosc.gitlab.io/how-is-linux-tested/

Best regards,
Marcelo

 Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 65feb81edb14..b00511109a9d 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
 Some of these tools integrate with KUnit or kselftest and will
 automatically fail tests if an issue is detected.
 
+Static Analysis Tools
+======================
+
+In addition to testing a running kernel, one may also scout for bugs by
+analyzing the source code semantics. Three tools are well known for serving this
+purpose.
+
+Sparse can help test the kernel by performing type-checking, lock checking,
+value range checking, in addition to reporting various errors and warnings while
+examining the code. See the Documentation/dev-tools/sparse.rst documentation
+page for details on how to use it.
+
+Smatch extends Sparse and provides additional checks for programming logic
+mistakes such as missing breaks in switch statements, unused return values on
+error checking, forgetting to set an error code in the return of an error path,
+etc. Smatch also has tests against more serious issues such as integer
+overflows, null pointer dereferences, and memory leaks. See the project page at
+http://smatch.sourceforge.net/.
+
+We also have Coccinelle as an option within static analyzers. Coccinelle is
+often used to aid collateral evolution of source code, but it can also help to
+avoid certain bugs that have been expressed semantically. The types of tests
+available include API tests, tests for correct usage of kernel iterators, checks
+for the soundness of free operations, analysis of locking behavior, and further
+tests known to help keep consistent kernel usage. See the
+Documentation/dev-tools/coccinelle.rst documentation page for details.
+
+These static analysis tools support running tests on the whole source tree or
+over a specific file or directory.
-- 
2.35.1

