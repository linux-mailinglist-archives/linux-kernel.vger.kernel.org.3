Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5F587CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiHBM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiHBM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:59:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624E3F301;
        Tue,  2 Aug 2022 05:59:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 72FE4320092C;
        Tue,  2 Aug 2022 08:58:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 02 Aug 2022 08:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1659445138; x=
        1659531538; bh=EyqLRR/gJxmcr7g1pwtG2naHdJfOFyDPyU7jUEASeuQ=; b=W
        04xSL1Z8GAx7u0UysHvjtg3bPRYWF0iTmM6pWu532Hl7jZvh3p4XbVxhzC/LM/Z+
        XQRlNka5tX8k4t14dM8MZnP8BNGEbY8nd06PNLVUjvffWbMF21rWRJgEFtdrxsk3
        KYIaI6BOHKl4fYXmW6nVWpdK7wDS5vNlv+VDnLVmrExqsJovMJP7W64vLFuYlyLk
        Mk6MItEcR5tgIyIUrqVS35ndUCYNLhso1SQd3b6GsEhpqmJniUqln8Nc/EJf/+I3
        bjdxrxLDzev83V84dy94TahXRT/0YT/8BGbU2thp68z9VN4bXU+/WsyO3GhRP+tM
        ZK8YkTABCVw1qFRrWQyWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659445138; x=1659531538; bh=EyqLRR/gJxmcr
        7g1pwtG2naHdJfOFyDPyU7jUEASeuQ=; b=Ox5gYGsg9yH9JuYBz4O/BbHsQbiPf
        3qiuVUaHm93XPWk0ZM967lE+4DKhGzpsN3ENokEaURUrjVo+llmtVZ22rwsEizXz
        9XyibpQi+95/nizC3WcvZl73goFie8+2LAPn5vqbA3whLf0C+kCnBqMnolfENJKf
        2pDymmhXQKH5FP7viPvA1q/c19cde5pwat6CTzf3/4aXCLeuAhruAFSP9FC6frc+
        StA36efvAiDZ1P1ytKYq+X1XwO4RvizuKAD+nOA0IJCLczST9pViCQa9uXO/J5rR
        OtlK6n4qMOAwJwO3E/E/DV8k1+j48cxhIU/C4as6V1vFFiwpW8OJFdNxQ==
X-ME-Sender: <xms:kh_pYifu5uiwX03hWVVVlXG13IqBlodlD7k1m-tw2bfic7bX6Ac62Q>
    <xme:kh_pYsOMNErr6PVp9wj_Z8WJMVwp4X_g8IZzDwDBO8urwE3N0d_CHjINwEnFdO9Xk
    KhhcICaLFCalZWHauc>
X-ME-Received: <xmr:kh_pYjh5-6MbJR8o6LzDIhNsDZ3kf7S3EpPplBkPtfYW00F1Z-Rn5-aQz0VmGhHS5tUIOHVgk8t9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeujeffuefguedvteekveej
    jeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:kh_pYv9YflVVG0r05FPP1OCJzTOpQvVGqBFOuGC_17SfroaXc1Ia5Q>
    <xmx:kh_pYuvCGFQBbF4WYKVfRWFFWEJnR-PnkjhUaf6qVeGlfF8JWVvgGA>
    <xmx:kh_pYmG8NAmE6RP5rzwuTSj4Vwo6_T7v3egGN-sAVKLjxEkWBK2SiQ>
    <xmx:kh_pYvHHGcaGXb3g4szenDzrwof3P799jGhXU1jNjKcyKNPRicPnJQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 08:58:53 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     shawnguo@kernel.org, alistair23@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        andreas@kemnade.info, krzysztof.kozlowski+dt@linaro.org,
        rydberg@bitmath.org, dmitry.torokhov@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Tue,  2 Aug 2022 22:58:26 +1000
Message-Id: <20220802125827.34509-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802125827.34509-1-alistair@alistair23.me>
References: <20220802125827.34509-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 88a3602c4e58..4f2d4e91bd9a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_AD7879=y
 CONFIG_TOUCHSCREEN_AD7879_I2C=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_CYTTSP5=y
 CONFIG_TOUCHSCREEN_DA9052=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_GOODIX=y
-- 
2.37.1

