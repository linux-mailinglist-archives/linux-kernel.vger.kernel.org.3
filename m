Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67958510C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiG2Np0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiG2NpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FAE12D1D;
        Fri, 29 Jul 2022 06:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D71461F4C;
        Fri, 29 Jul 2022 13:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1D3C433D6;
        Fri, 29 Jul 2022 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102320;
        bh=TmeZGjT5oPLat788dn3l4aAkr6TNIEya2wIPcGK6CSM=;
        h=From:To:Cc:Subject:Date:From;
        b=M78f0iyebCswI6LtTZ10WSfi+z8d3MhKKyWuwKaYKlh9FR8e+AxwvIVhdEzTs1E/r
         2bvGMo7qPW7475DdggrT9ROup9NhA9duBQHkkDTP86U3/KXaSk1sSaltr7LZMYi9oc
         WIIs1Nxpv/uchjFRPo4Qlt/nR/oxqDkCB/TpB3Fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] docs: embargoed-hardware-issues: fix invalid AMD contact email
Date:   Fri, 29 Jul 2022 15:45:17 +0200
Message-Id: <20220729134517.2284700-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735; i=gregkh@linuxfoundation.org; h=from:subject; bh=TmeZGjT5oPLat788dn3l4aAkr6TNIEya2wIPcGK6CSM=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPn2TVOTRpyN883KmsZ+gzbXn9zE0HLm9rUrl5s5dnUknu vdWdHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAR7lyGucIavWv3CIg/nngpb8EVud jHbpP6fzDMD04uKvwWpnDr7L9O1t3fLj/fHflmGQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current AMD contact info email address is incorrect, so fix it up to
use the correct one.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Hu Haowen <src.res@email.cn>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/embargoed-hardware-issues.rst             | 2 +-
 .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
 .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 95999302d279..420bf4a4b006 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
-  AMD		Tom Lendacky <tom.lendacky@amd.com>
+  AMD		Tom Lendacky <thomas.lendacky@amd.com>
   Ampere	Darren Hart <darren@os.amperecomputing.com>
   ARM		Catalin Marinas <catalin.marinas@arm.com>
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
index 88273ebe7823..cf5f1fca3d92 100644
--- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
@@ -174,7 +174,7 @@ CVE分配
 
   ============= ========================================================
   ARM
-  AMD		Tom Lendacky <tom.lendacky@amd.com>
+  AMD		Tom Lendacky <thomas.lendacky@amd.com>
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index 6c76fc96131a..fbde3e26eda5 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -177,7 +177,7 @@ CVE分配
 
   ============= ========================================================
   ARM
-  AMD		Tom Lendacky <tom.lendacky@amd.com>
+  AMD		Tom Lendacky <thomas.lendacky@amd.com>
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
-- 
2.37.1

