Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30679497A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiAXIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:15:21 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:16684 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiAXIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643012121; x=1674548121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VtZz5pmqt4tS7pR0I4pHhznYpm34nVTG0TzfeIWikKY=;
  b=fDlI6mWEfsObdBT00zbpO0MUS3ow+k9gNbb1NX5gSV3WWL0XhGGuiJeB
   /hf6qkIxthnlO0m3FJlhGxnkCxzxC9tH3QLBfufO4N79b32NF/3IDsEX5
   brWW6DCr6r2Cjpwxy1FcyUvmcrpjZmM1SfsKte1yAzL0eBX+90AiZV9WL
   8=;
X-IronPort-AV: E=Sophos;i="5.88,311,1635206400"; 
   d="scan'208";a="57503450"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 24 Jan 2022 08:15:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id 99DCAA2832;
        Mon, 24 Jan 2022 08:15:03 +0000 (UTC)
Received: from EX13D02ANC003.ant.amazon.com (10.43.157.69) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 08:15:02 +0000
Received: from 147ddabc1818.ant.amazon.com.com (10.43.160.209) by
 EX13D02ANC003.ant.amazon.com (10.43.157.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 08:14:59 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <trivial@kernel.org>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Takahiro Itazuri <itazur@amazon.com>
Subject: [PATCH] docs: fix typo in Documentation/kernel-hacking/locking.rst
Date:   Mon, 24 Jan 2022 17:14:47 +0900
Message-ID: <20220124081447.34066-1-itazur@amazon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.209]
X-ClientProxiedBy: EX13D23UWC003.ant.amazon.com (10.43.162.81) To
 EX13D02ANC003.ant.amazon.com (10.43.157.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change copy_from_user*( to copy_from_user() .

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 Documentation/kernel-hacking/locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index e6cd40663ea5..4cbd50edf277 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -295,7 +295,7 @@ Pete Zaitcev gives the following summary:
 
 -  If you are in a process context (any syscall) and want to lock other
    process out, use a mutex. You can take a mutex and sleep
-   (``copy_from_user*(`` or ``kmalloc(x,GFP_KERNEL)``).
+   (``copy_from_user()`` or ``kmalloc(x,GFP_KERNEL)``).
 
 -  Otherwise (== data can be touched in an interrupt), use
    spin_lock_irqsave() and
-- 
2.31.1

