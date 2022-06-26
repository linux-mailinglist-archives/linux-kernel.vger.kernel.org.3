Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFE55B09E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiFZJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiFZJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999412A94;
        Sun, 26 Jun 2022 02:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73BBDB80D4F;
        Sun, 26 Jun 2022 09:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C440CC36AFC;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=YriDJptqrGNQjHVyio7gU1wQfAmnU7w3X/2slUg2EDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT5LKGdMVR2GGW5r8NNUZCTK621aVCarSSvmdLk2bieK3IezxGpsSgkxpekXGyheB
         I8bEQJpQryT2Fe9KHdF+ne3W0n6CjO+V8eHqfpVYhqbsBxRdQpew87CrpZHXGcJ9UG
         UjNzd9CMXj6dWvBGBUJzDgUgtw8nqha6oTUj64US4sh701GFcbEIz2taukM03X65iB
         6fcpFEFgBY2rnYqXSyZ1ZXXmqZWXk5DauXECwpVp3DBnt6vWVHUUwwc+Gf8D2Q3vuB
         X7EifaPiYxYBrjvgsmzw22fTqqdq/rq4jgChPKMe3ruQOdur3Vj3mq1Ws2dK9La39m
         y2D3OUjRmv4Iw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coD-RV;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/20] docs: netdev: update maintainer-netdev.rst reference
Date:   Sun, 26 Jun 2022 10:10:47 +0100
Message-Id: <aed0482b3d931bfcfe84f38197526edcbb8fd830.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
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

Changeset 8df0136376dc ("docs: netdev: move the netdev-FAQ to the process pages")
renamed: Documentation/networking/netdev-FAQ.rst
to: Documentation/process/maintainer-netdev.rst.

Update its cross-reference accordingly.

Fixes: 8df0136376dc ("docs: netdev: move the netdev-FAQ to the process pages")
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

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

