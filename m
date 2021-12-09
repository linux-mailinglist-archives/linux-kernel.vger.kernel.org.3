Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB446E606
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhLIJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhLIJ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:59:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E12C061746;
        Thu,  9 Dec 2021 01:56:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F7ECCE2502;
        Thu,  9 Dec 2021 09:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D0C004DD;
        Thu,  9 Dec 2021 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639043770;
        bh=W7pXooK1kVAIY+RLt1VIpEkQiuX45GNgfUBx3j8LOw4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZLz5ZkkMpNLhQ5Nr7/y0eDTi6Bs4+DBDbjwdu0XuvJO/DoVXOp5ufLxdOm29d60c5
         2enmS6Q8VhkTAZQLiGjSeyv1pKIbk8FaQD/OuRC8RhoZqPCxRyag9Put3d6tr0jkN8
         vbk1iUo+wvxgnRlHkIrz/TKK4W6yzidJp2bQDpdTGo1B3wt7xOTBY84576vO7svxd3
         JC4l1laNWXmJPyd7O77VCz3OJ8fDK2STrxS6RKEcRPHmFDP+BDGk+v7mUmLmcg0Zjy
         7ZRb9m3wAzo03AkWckBLGBHOMO2llrFE+JmJ2oSK9njj/M0HHddJtnXlvBxRQ8HB7S
         Vak5JCer3Vs+A==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng01@gmail.com>,
        Tang Yizhou <tangyizhou@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc/zh_CN: add Chinese document coding style reminder
Date:   Thu,  9 Dec 2021 17:56:04 +0800
Message-Id: <20211209095604.68954-1-alexs@kernel.org>
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
 Documentation/translations/zh_CN/index.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index a34e58733ac8..b01c04227d8a 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -23,6 +23,11 @@
 另外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
 上的linux-doc邮件列表。
 
+顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
+的字符标点占用两个英文字符宽度， 所以，当英文要求不要超过每行100个字符时，
+中文就不要超过50个字符。另外，也要注意'-'，'=' 等符号与相关标题的对齐。在将
+补丁提交到社区之前，一定要进行必要的checkpatch.pl检查和编译测试。
+
 许可证文档
 ----------
 
-- 
2.25.1

