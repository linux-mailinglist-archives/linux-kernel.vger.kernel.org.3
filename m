Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B055B0A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiFZJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiFZJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810FF12A93;
        Sun, 26 Jun 2022 02:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D7661192;
        Sun, 26 Jun 2022 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34BDC341CC;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=G0P7+zs4VxXNPuNjxyj+vlBVmWbADS8UupACdmN4L70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9kTCcoVINofXnbRADVeHd9AcLQIyg+/AaMR1uQXZtr70+Pv/sSh373cXGgGKENYo
         SA/RSvzuOeJaKgY3r/Qj0WQgoYG8KU/yc8Iagh9RDYWQuyltczeV7YhaTOUYgLaK9m
         xS27ULI01f6OnH29X60HU/E031osnTCBN2HRp2SD25OEUAdie3WfaFmhWIwzmLIQOy
         ZUUPBsiMtfRGUvQy23jTS9zTkjtXY4XIneK2xGFM/K/P0qRE/Y8wunW9IKSv2c6paH
         N6gUWih+E3bzjViI9EDQXhPYnDokzBkAMLkNZQbAb2stz3dZDDIKOu01A+26MIlg8h
         xvLoEHN2TDjUQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coY-WB;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/20] docs: zh_CN/vm/zsmalloc.rst: fix a typo
Date:   Sun, 26 Jun 2022 10:10:54 +0100
Message-Id: <25a9fff20d39a6638b8a7c0fefa0767e77d96dec.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo:
	zs_malloc.rst -> zsmalloc.rst

Fixes: 6dbc3a5bdb46 ("docs/zh_CN: add vm zsmalloc translation")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/vm/zsmalloc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/vm/zsmalloc.rst b/Documentation/translations/zh_CN/vm/zsmalloc.rst
index 29e9c70a8eb6..45a9b7ab2a51 100644
--- a/Documentation/translations/zh_CN/vm/zsmalloc.rst
+++ b/Documentation/translations/zh_CN/vm/zsmalloc.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/zs_malloc.rst
+:Original: Documentation/vm/zsmalloc.rst
 
 :翻译:
 
-- 
2.36.1

