Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1D495EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbiAUL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:58:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53586 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiAUL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:58:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F2661A66;
        Fri, 21 Jan 2022 11:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE5CC340E1;
        Fri, 21 Jan 2022 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642766302;
        bh=+wuMrd0iK40HysyYcCXinOqaUbkRz3u/5O4W5TgHcAo=;
        h=From:To:Cc:Subject:Date:From;
        b=G4b0uHm2X5M8AwKMS/AWzXGqKR0u9eVh6tX6El6CnAfGyaRC0n3WS2+6a/q73LS07
         Q9posEX16+VmGuey1ZYBwGIIjTPp10gGMOGMgu3qf1ny9ieADHIn6U/Y8y7gn75f5S
         fd70Abb4PTZ530BwXZ7LMArILbo25gCbVNHzKyd4l/VZwh44MqjagSk7dzB0fHqZ9S
         X4tIIDtvT83076hJsxVy9SAPBpibHDX140Etw7LlOBcp97Cq+NfWf+IMmXdAYpOukz
         ZYkGylhRRakGjxqR7N8QUzfQqyP0kD70H3h9iMbgHfZ6PV4YJaG6TR7e0+iReu5pc+
         fIVzanNfzkwJg==
Received: by pali.im (Postfix)
        id A66F0857; Fri, 21 Jan 2022 12:58:19 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Extend Avanta list
Date:   Fri, 21 Jan 2022 12:58:04 +0100
Message-Id: <20220121115804.28824-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include another two SoCs from Avanta family.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index 7f5233b3256d..234f4ab0578a 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -265,10 +265,12 @@ Avanta family
 -------------
 
   Flavors:
+       - 88F6500
        - 88F6510
        - 88F6530P
        - 88F6550
        - 88F6560
+       - 88F6601
 
   Homepage:
 	https://web.archive.org/web/20181005145041/http://www.marvell.com/broadband/
-- 
2.20.1

