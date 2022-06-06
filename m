Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BF653EBD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbiFFP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiFFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B21CD37F;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5209AB81AAE;
        Mon,  6 Jun 2022 15:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9590C341CC;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=dzovniYXMBskAcBUaM9tKTfOZoD4DhDdAz8f7SxlcU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8PKtPnzjXUG9Pn3kpdfQyNW1r8JQmJ7OKiSEWpuhNAQvJnodpQBUb0KnMmAK+KBB
         dlr1gw8d60NDz7wYgbvTXCujnBzYQkiCWYQgNiOvYEqQdYvSNcuamI3LeG02a5L1Dl
         0SgzQCT7ea8qbRPb329/GDnknM0eO5oAl54SU8RYjptRfbL1WXtl2F6UyIZ32TcoBS
         tRCHcTiYou6xj3REJPygE1FNwt1J5+6gSNqz5zVaoqUfxcDaoU1ar7ijGqbtaaWDlT
         rac3meqNjQ7XfjtVnEhW73mqOFby8h1wwmIXdOEcnymMkYD8zcY8U87suYWr9hBEQ0
         ofTF6Nm/2f5Hw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012P9-5h;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/23] docs: netdev: update maintainer-netdev.rst reference
Date:   Mon,  6 Jun 2022 16:25:29 +0100
Message-Id: <ee0778cb0ae9c26047277610d52e8e3c70b4cf5e.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8df0136376dc ("docs: netdev: move the netdev-FAQ to the process pages")
renamed: Documentation/networking/netdev-FAQ.rst
to: Documentation/process/maintainer-netdev.rst.

Update its cross-reference accordingly.

Fixes: 8df0136376dc ("docs: netdev: move the netdev-FAQ to the process pages")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 Documentation/translations/it_IT/networking/netdev-FAQ.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/networking/netdev-FAQ.rst b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
index 7e2456bb7d92..8a1e049585c0 100644
--- a/Documentation/translations/it_IT/networking/netdev-FAQ.rst
+++ b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
+:Original: :ref:`Documentation/process/maintainer-netdev.rst <netdev-FAQ>`
 
 .. _it_netdev-FAQ:
 
-- 
2.36.1

