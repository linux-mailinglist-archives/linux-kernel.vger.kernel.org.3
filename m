Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55E4A3C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357208AbiAaAgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357015AbiAaAgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:36:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF7FC061714;
        Sun, 30 Jan 2022 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RAr/avbZ9dvrmyFHTddz+fhHj1lJqbBwGsig25CiDDI=; b=Q5pgL7x9/+uPI4odK3PwxZmPOO
        Aw4n1NJ8HdAvRhqj2TmO7BmuTY2cyrmdHpl4qm+nU1c12LL2f+MPmVmvTrnVsCjTB2QdltSYaLU+x
        5a7HFjlT1PMJP+CuE3IZeC4V4mlJe9f5dV8hubhOjAteYaYwMHUZh//R5G1fCDwwzNhWjACw0OWR2
        QFB6d5VlykzSOkRtGCxwkrn5KU99IDefWAH1BOLThEzHcWFZgkJwuUCBlUWlWMGzc+jlxzfBpKg3n
        vNkO9sIPJQWN9GI4zqYTMPj6l+Wh16KntfRNtvV2A7xWBdXCZEcG8ZKrbQacDPmnKlWUpC/rhXG5Z
        +HZRb7QA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEKgQ-007mQL-GL; Mon, 31 Jan 2022 00:36:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Rae Moar <rmoar@google.com>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Docs: ktap: add code-block type
Date:   Sun, 30 Jan 2022 16:36:37 -0800
Message-Id: <20220131003637.14274-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple "code-block::" warnings by adding "none" as the type of
code-block. Mends these warnings:

Documentation/dev-tools/ktap.rst:71: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:120: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:126: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:132: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:139: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:145: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:195: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:208: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
Documentation/dev-tools/ktap.rst:238: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.

Fixes: a32fa6b2e8b4 ("Documentation: dev-tools: Add KTAP specification")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/dev-tools/ktap.rst |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20220128.orig/Documentation/dev-tools/ktap.rst
+++ linux-next-20220128/Documentation/dev-tools/ktap.rst
@@ -68,7 +68,7 @@ Test case result lines
 Test case result lines indicate the final status of a test.
 They are required and must have the format:
 
-.. code-block::
+.. code-block:: none
 
 	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
 
@@ -117,32 +117,32 @@ separator.
 
 Example result lines include:
 
-.. code-block::
+.. code-block:: none
 
 	ok 1 test_case_name
 
 The test "test_case_name" passed.
 
-.. code-block::
+.. code-block:: none
 
 	not ok 1 test_case_name
 
 The test "test_case_name" failed.
 
-.. code-block::
+.. code-block:: none
 
 	ok 1 test # SKIP necessary dependency unavailable
 
 The test "test" was SKIPPED with the diagnostic message "necessary dependency
 unavailable".
 
-.. code-block::
+.. code-block:: none
 
 	not ok 1 test # TIMEOUT 30 seconds
 
 The test "test" timed out, with diagnostic data "30 seconds".
 
-.. code-block::
+.. code-block:: none
 
 	ok 5 check return code # rcode=0
 
@@ -192,7 +192,7 @@ line and should end before the parent te
 
 An example of a test with two nested subtests:
 
-.. code-block::
+.. code-block:: none
 
 	KTAP version 1
 	1..1
@@ -205,7 +205,7 @@ An example of a test with two nested sub
 
 An example format with multiple levels of nested testing:
 
-.. code-block::
+.. code-block:: none
 
 	KTAP version 1
 	1..2
@@ -235,7 +235,7 @@ nested version line, uses a line of the
 
 Example KTAP output
 --------------------
-.. code-block::
+.. code-block:: none
 
 	KTAP version 1
 	1..1
