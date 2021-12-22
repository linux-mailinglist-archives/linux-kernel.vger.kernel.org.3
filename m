Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7862C47CCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbhLVGX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhLVGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:23:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A58C061574;
        Tue, 21 Dec 2021 22:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6uUBRMaQ2F0Tqn3TI/wUZCz0ruog1+fYI6j6sOJEHRY=; b=Pn8kTqcpb7rYIJQGVIC/mCO3l9
        oeio6V2peZ+Ij34Ux4B5PNWn3eqFXtpP8aFIV+Wukvl0GQ3YC1wmxYNPE6Z21NyUNV0FuaPd8WaVt
        PQGdW71JOeAOIoKJ0JAuN/izN6LAXHQfUFC6v6QrCU2Vq4JMpbz+2d6RvR/sK8jPlSW+wTp1ILdlM
        DH4k9suFg/C1kanx/6WViIm7/rcM90Z56of6xnNrnsUZHGAAoeDi9+zVw7gQTgf8pNlJ3Yl383SqQ
        JQMt6fPNzdDLB60l43OpuDBgIK/97YmHSrXpkGRNcAWdt/oblIENXzSxXGlmZSY9XH5JUoUc/w2Ld
        8PjoTtgg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzv2Z-009LE4-GZ; Wed, 22 Dec 2021 06:23:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/sphinx: fix typos of "its"
Date:   Tue, 21 Dec 2021 22:23:54 -0800
Message-Id: <20211222062354.23224-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "its" for possessive form instead of the contraction "it's".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/sphinx/kernel_abi.py  |    2 +-
 Documentation/sphinx/kernel_feat.py |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211221.orig/Documentation/sphinx/kernel_abi.py
+++ linux-next-20211221/Documentation/sphinx/kernel_abi.py
@@ -104,7 +104,7 @@ class KernelCmd(Directive):
         return nodeList
 
     def runCmd(self, cmd, **kwargs):
-        u"""Run command ``cmd`` and return it's stdout as unicode."""
+        u"""Run command ``cmd`` and return its stdout as unicode."""
 
         try:
             proc = subprocess.Popen(
--- linux-next-20211221.orig/Documentation/sphinx/kernel_feat.py
+++ linux-next-20211221/Documentation/sphinx/kernel_feat.py
@@ -106,7 +106,7 @@ class KernelFeat(Directive):
         return nodeList
 
     def runCmd(self, cmd, **kwargs):
-        u"""Run command ``cmd`` and return it's stdout as unicode."""
+        u"""Run command ``cmd`` and return its stdout as unicode."""
 
         try:
             proc = subprocess.Popen(
