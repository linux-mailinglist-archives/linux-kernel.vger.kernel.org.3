Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF7598451
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiHRNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiHRNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEAD578A9;
        Thu, 18 Aug 2022 06:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E8ED61698;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B790C433B5;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=VQmGTfSrvFIP3MfRDNx6mjCCstDhvHzDAUp/pstKmuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTEQAhEE4+OT+Bk7IzBjnKGkTmEeh6Mr4bZx6hm1nfTe6oOnSrSmhcAMUnQi8dHQR
         YEkTGl9yK+R7VBvG2Zh/+hNwJgjpYRiDEIaPGpg6XAeCb3aDARQg/iwVvGCcOiut7p
         GnCb5aGxzARs/8AeS5U/PWX1T3T8meU2WAqgfDZxD1UtxxCq7+hDHN6qZZct2oHkl/
         BjgFoyZ3Jr8bwLl7KW/8CIom2/bmVMlu+Zkf5YSnHYD5AdjZoAwDe6jYYdjGy5YAX0
         pDZHAXa2a5HriYnXlLHE2IkFlvth/S1OHYcqn2ZElPxd4R26q+27iQpac/tWgKYaUR
         OBnM/g4TU+jxw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7R-AJ;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] docs: zh_CN: remove references to rust documentation
Date:   Thu, 18 Aug 2022 15:38:50 +0200
Message-Id: <d0b2ead8c86cb1820695f400156b0be435aa7b74.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a note on this file that, using a robot to translate,
says:

	"The kernel-doc cannot contain Rust code: please refer
	 to Documentation/rust/general-information.rst."

Such note doesn't exist at the original file anymore, so, just remove
it from the translation, in order to solve this warning:

	Warning: Documentation/translations/zh_CN/doc-guide/kernel-doc.rst references a file that doesn't exist: Documentation/rust/general-information.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/doc-guide/kernel-doc.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
index ccfb9b8329c2..9fd170faf951 100644
--- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
@@ -14,8 +14,6 @@ Linux内核源文件可以包含kernel-doc格式的结构化文档注释，用
           实际有着明显的不同。内核源包含成千上万个kernel-doc注释。请坚持遵循
           此处描述的风格。
 
-.. note:: kernel-doc无法包含Rust代码：请参考 Documentation/rust/general-information.rst 。
-
 从注释中提取kernel-doc结构，并从中生成适当的 `Sphinx C 域`_ 函数和带有锚点的
 类型描述。这些注释将被过滤以生成特殊kernel-doc高亮和交叉引用。详见下文。
 
-- 
2.37.1

