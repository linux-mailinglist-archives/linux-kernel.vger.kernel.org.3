Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC39446D2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhLHLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:45:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47424 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhLHLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:45:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1867BCE2139;
        Wed,  8 Dec 2021 11:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057B8C00446;
        Wed,  8 Dec 2021 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638963705;
        bh=/jdeSe9ndEJbszVWTcKbxiwVrB+QIibzwAIexLRfjMg=;
        h=From:To:Cc:Subject:Date:From;
        b=fzJ9m/rI9L1vNkJiwx7K0kTLveimwivydNf821oXXuNxQEvD7P6PMNp3qUxKqfSjT
         9Re5XAxrHA/5LiQgeCtYRT6ylXOvBvId1UCwYAFgAIRzprUHCyFsD8oDIDQH/F4Nm2
         GWdZeNqsjfia4kvShSrmnYeW6yDUZJvflpEObwdrFq+1Tg/jQ6VeNSodofLiGQtrZw
         YK7YaDKJId1vi/KU44Q1Ov1RapS0Mg9yXPhl0mWr3r2hi6ZQ/mHN8ak16hNq60zJS5
         zKvoH+9ji/G5mIlXfikmd1e2AsSu/XEKqDMgiDU02mRTYgmE14YrZe3VHMXLG1miGT
         In39NYpeXcvvw==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng01@gmail.com>,
        Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc/zh_CN: add Chinese document coding style reminder
Date:   Wed,  8 Dec 2021 19:41:25 +0800
Message-Id: <20211208114125.58472-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The coding style requirement for Chinese document is easy to be overlooked.
Add the request as a remdiner.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng01@gmail.com>
Cc: Tang Yizhou <tangyizhou@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/translations/zh_CN/index.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index a34e58733ac8..8c2786ed0279 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -23,6 +23,10 @@
 另外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
 上的linux-doc邮件列表。
 
+顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
+的字符标点占用两个英文字符宽度， 所以，当英文要求不要超过每行100个字符时，
+中文就不要超过50个字符。另外，也要注意'-'，'=' 等符号与相关标题的对齐。
+
 许可证文档
 ----------
 
-- 
2.27.0

