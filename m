Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234B53E9CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbiFFPZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiFFPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06801C592F;
        Mon,  6 Jun 2022 08:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815B66150F;
        Mon,  6 Jun 2022 15:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDB1C3411D;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529148;
        bh=VtYAMmCXheoYZzfzGc9xWH6VwlROf5UK8WlhLc0Lrlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFu9KUgF8RyeLz+rN31PQfZJZlmCtXdCWt+SBiUufO9ADzOrBFVnzu4rHbBDilr2C
         FE4prd3YQ8XW3lQomchUOQTfcWel0XUdT3isEJRzs8B3ewnRdf1NTEFO7Qnt95Bjs3
         71oWz6RrQzlmZ0zaLBwM4ufQoklardEYr2HpLmoZYHydy0CWJUVZhvCuCCDcpvNY8B
         rBQzmn2gTjpu+Xw+IzSlTzd3t50RywUkHRYwVlS6DAVfBOJ0IMXdyJ5iUCfc/4iIAO
         gce6y64+XRq2Cf/y2nZhzsE1KP6g9g+C8csn5qwSksMGlnx4Yf5YERdsU3JW4HBsLD
         kFQ9rEBYZSOOA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Pw-E7;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 20/23] MAINTAINERS: update snps,axs10x-reset.yaml reference
Date:   Mon,  6 Jun 2022 16:25:42 +0100
Message-Id: <56560a2bcc06af94d36a28ed2cfdb25de481eee5.1654529011.git.mchehab@kernel.org>
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

Changeset 820f722c05dd ("dt-bindings: reset: snps,axs10x-reset: Convert to yaml")
renamed: Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
to: Documentation/devicetree/bindings/reset/snps,axs10x-reset.yaml.

Update its cross-reference accordingly.

Fixes: 820f722c05dd ("dt-bindings: reset: snps,axs10x-reset: Convert to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc64a23d0bdc..47cbe1fef266 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19220,7 +19220,7 @@ F:	arch/arc/plat-axs10x
 SYNOPSYS AXS10x RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
+F:	Documentation/devicetree/bindings/reset/snps,axs10x-reset.yaml
 F:	drivers/reset/reset-axs10x.c
 
 SYNOPSYS CREG GPIO DRIVER
-- 
2.36.1

