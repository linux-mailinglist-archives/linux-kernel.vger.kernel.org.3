Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E500359844F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiHRNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbiHRNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7657E35;
        Thu, 18 Aug 2022 06:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39361616A0;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B27C43140;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=/u+oKcPW6ChqPyJvj84EmuaOgNhqaFaZAyoGnBvxnqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwvQJkMP7sKAup+IMRAOJNCY/nR4UeVdNyY2tX4e7ZQsZanBK+lHhogPva3aYdsDG
         gy4izYE4OrQgFZNdfjd2LTIV6emUljpX9KX4Tk3bc3PlsFIahl0GnFkr/UBtauykhM
         /Npqeb0StGezUcBbZobOdkRiHVrag8XH80kgaLEee/yPQHO2ldQHgFMsuUUEpDCRuX
         P0OV8x9XNvESfil84IBv6N3Iu+Su0eCttqi52LYDgwofn7qQIAwGpswtyuTeLnX/dJ
         /iGU/k8CvnbTOMskvWketZ4l/IRVBca6b0gz60lc9sSo79Rbvhkq4zDWVo8MiCRHZk
         3y/fm7ozACUeg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7V-CG;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] dt-bindings: arm: update arm,coresight-cpu-debug.yaml reference
Date:   Thu, 18 Aug 2022 15:38:51 +0200
Message-Id: <20815dbff3d27f5d3e6876363f052d2a08ad2e72.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 66d052047ca8 ("dt-bindings: arm: Convert CoreSight CPU debug to DT schema")
renamed: Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
to: Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml.

Update its cross-reference accordingly.

Fixes: 66d052047ca8 ("dt-bindings: arm: Convert CoreSight CPU debug to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 Documentation/trace/coresight/coresight-cpu-debug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight/coresight-cpu-debug.rst b/Documentation/trace/coresight/coresight-cpu-debug.rst
index 993dd294b81b..79bbe587e5e8 100644
--- a/Documentation/trace/coresight/coresight-cpu-debug.rst
+++ b/Documentation/trace/coresight/coresight-cpu-debug.rst
@@ -117,7 +117,7 @@ divide into below cases:
 Device Tree Bindings
 --------------------
 
-See Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt for details.
+See Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml for details.
 
 
 How to use the module
-- 
2.37.1

