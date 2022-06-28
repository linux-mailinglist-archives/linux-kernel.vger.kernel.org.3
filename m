Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65855EB31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiF1RnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiF1Rm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:42:27 -0400
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB033A14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656438124; bh=OnG6BofeKIcOc3qBoOMQcWAYSD8krtB0UZjVBxSp6Og=;
        h=X-EA-Auth:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=T0+6VErB5jbKrEjomgXIeIsknFef3JQPYzhkg1bBU9jJyefocJlhw/Jp5VTngbTUK
         mVKi6mHtLfq5Se+AfNNdV4tNl6t1dAMG2FpDXvcjzV/v7038B38d538cJ1fIgRdTgK
         CabFGneYdgMF4Kxqc4b1PkVoKlltIY8ad1HJw9RQ=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Tue, 28 Jun 2022 19:42:04 +0200 (CEST)
X-EA-Auth: PH4grJEO8TOqTmekSPslVqqoFQlyfaOfmUq1RfpuhDt7gw8sZlxGgcOPZzjX8gWscH5YPWWS+sp1wh7kd9t01dIpPO9PgPxhxkj8VcLarRk=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] leds: is31fl319x: Add missing si-en compatibles
Date:   Tue, 28 Jun 2022 19:41:18 +0200
Message-Id: <20220628174124.2819238-4-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628174124.2819238-1-vincent.knecht@mailoo.org>
References: <20220628174124.2819238-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add si-en compatibles for all chip variants.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 4161b9dd7e48..0db5d4988131 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -102,6 +102,10 @@ static const struct of_device_id of_is31fl319x_match[] = {
 	{ .compatible = "issi,is31fl3193", .data = &is31fl3193_cdef, },
 	{ .compatible = "issi,is31fl3196", .data = &is31fl3196_cdef, },
 	{ .compatible = "issi,is31fl3199", .data = &is31fl3199_cdef, },
+	{ .compatible = "si-en,sn3190",    .data = &is31fl3190_cdef, },
+	{ .compatible = "si-en,sn3191",    .data = &is31fl3190_cdef, },
+	{ .compatible = "si-en,sn3193",    .data = &is31fl3193_cdef, },
+	{ .compatible = "si-en,sn3196",    .data = &is31fl3196_cdef, },
 	{ .compatible = "si-en,sn3199",    .data = &is31fl3199_cdef, },
 	{ }
 };
@@ -432,6 +436,10 @@ static const struct i2c_device_id is31fl319x_id[] = {
 	{ "is31fl3193" },
 	{ "is31fl3196" },
 	{ "is31fl3199" },
+	{ "sn3190" },
+	{ "sn3191" },
+	{ "sn3193" },
+	{ "sn3196" },
 	{ "sn3199" },
 	{},
 };
-- 
2.35.3



