Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3115A55B08B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiFZJLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiFZJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D712AB6;
        Sun, 26 Jun 2022 02:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7070D61196;
        Sun, 26 Jun 2022 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C459EC36AFD;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=GWFfIQwi0KBg8UNa6F/j3qBcQL0kmJb3b/zdkinvsXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmXlK/zn9fbFTPdxMlhuYrYyIFtHvn2M9qW/creKJdVTAolqoIRrqCDoD8y+Sl3QL
         aWR/I6Es7vBmgkypuw7Lt8OSpMClXnXhAbv5G9wO2G9o9UBG7TyaQiPr1kVjlzU2lL
         LQtRvAdaYELyDE66C3EJZxbikExblCCOtNdfVt0Gek9LuaGI2zDg10Mhr7Kf5NjbaW
         raApJUjNGXQRerL+NAcn+nDXKnG0xPxGj1ZcaFS+9X/DEvi67xkDKY/0/VnDdY85jK
         pn6/rE2pIujrQXSnF4ZrDo1Tc5fjconhvkifcSwa8e1QEvL6zvR/CvhTpk58A2hPEC
         xbOkOfOH8saFQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coS-Uy;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alex Shi <alexs@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 06/20] docs: zh_CN: fix a broken reference
Date:   Sun, 26 Jun 2022 10:10:52 +0100
Message-Id: <94fe771609d32583fee41f47fe29433cbce5b04e.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of the rust doc is wrong (probably a typo). Fix it.

Fixes: 3a5915156429 ("docs/zh_CN: Add translation zh_CN/doc-guide/kernel-doc.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
index 82ec84470c0b..ccfb9b8329c2 100644
--- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
@@ -14,7 +14,7 @@ Linux内核源文件可以包含kernel-doc格式的结构化文档注释，用
           实际有着明显的不同。内核源包含成千上万个kernel-doc注释。请坚持遵循
           此处描述的风格。
 
-.. note:: kernel-doc无法包含Rust代码：请参考 Documentation/rust/docs.rst 。
+.. note:: kernel-doc无法包含Rust代码：请参考 Documentation/rust/general-information.rst 。
 
 从注释中提取kernel-doc结构，并从中生成适当的 `Sphinx C 域`_ 函数和带有锚点的
 类型描述。这些注释将被过滤以生成特殊kernel-doc高亮和交叉引用。详见下文。
-- 
2.36.1

