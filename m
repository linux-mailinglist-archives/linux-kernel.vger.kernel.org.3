Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98156C8CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiGIKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiGIKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436614B48B;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D246360E76;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8346DC36AE5;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=WaEukhzEXe+wdr8DCtDOQwfRiV3PmV1Lux7lE2QT938=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afMdsa9NS6Xfpj4CIxQWM9PsqssB5gR2y64spq5MeZrbNnqBulrVb585SOqYY+vZG
         RJBeZm0cYXoIPFK3OXnjgRpxBdQWNzNVdI7ckbGG78hqYPvCOyurN7O/5g33nzVj8X
         aJ3e34Xs2WF/Y1iUNEGra8VjTvF4Zdh/Xr8kZlqz0zaEXVDvgx2Pyh+ejt0qUBmpg4
         7ZUrXafbuA7Y07yvdQj19zZiHfMBUadTjrLZ6YrKOJg0DGiKybwq2vv5I3REuyuWWX
         Mr6WmFWBRBlJxiYzgpA784hOS+dzpEkCWDPpZ76pkYVCYKhZWyiXE818RWErK5Dcxi
         HsnlRGM+h/YIQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGf-Fh;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/21] dt-bindings: arm: update arm,coresight-cpu-debug.yaml reference
Date:   Sat,  9 Jul 2022 11:07:18 +0100
Message-Id: <0c299504f7cbb44d7231eb0555333f54262d7631.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

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
2.36.1

