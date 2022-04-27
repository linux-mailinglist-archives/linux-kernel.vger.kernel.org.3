Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320C6511290
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358871AbiD0Hfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358872AbiD0Hfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:35:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B9888C6;
        Wed, 27 Apr 2022 00:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60B861AE1;
        Wed, 27 Apr 2022 07:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09083C385AA;
        Wed, 27 Apr 2022 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651044738;
        bh=Re0RgXJGnca1jXG71eZZH/Isy2xvfbR7ESV6L/VsEoo=;
        h=From:To:Cc:Subject:Date:From;
        b=konfTTjIek83M/SNfWhqBvJPMcgWRw0Ikpd/4gNseDywbPJ7aFFI3nmppWXQNoD+Y
         Sj8jckpuyhXkAH/DBDUyvjSecumjX/zA4Uf2f9bl1RFm0r3PvSAWyJV4f9/1vIPXHe
         kn0hLlZsLS0TuoJVaxEcyvu0b0hOJxEPsEZQCSsDt4cXYKG2r47BRaSRvJ/vYj3gRw
         +5Mrjhji/KshE8GF6v2ABexREhoZUmjrE7pQZrnmNY0OW4c++r1orBZz4e0g2hfq/O
         9ceyc0LGxDWJyefXN+E8WhPDgqCFlo7A9NRi2NwIn2qvwCyeoVnEFcxQeIOrlwMFut
         1uB5fzSY4qkdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1njc9r-0004Li-M2; Wed, 27 Apr 2022 09:32:19 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] Documentation: devres: fix typo in interface list
Date:   Wed, 27 Apr 2022 09:31:42 +0200
Message-Id: <20220427073142.16700-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the misspelled devm_get_clk_from_child() helper name in the devres
interface list.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/driver-api/driver-model/devres.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5018403fe82f..2d39967bafcc 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -249,7 +249,7 @@ CLOCK
   devm_clk_bulk_get()
   devm_clk_bulk_get_all()
   devm_clk_bulk_get_optional()
-  devm_get_clk_from_childl()
+  devm_get_clk_from_child()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
   devm_clk_hw_register_clkdev()
-- 
2.35.1

