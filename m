Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0594A7DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbiBCCR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:17:56 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:48245 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348962AbiBCCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:17:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 465C12B001A5;
        Wed,  2 Feb 2022 21:17:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 02 Feb 2022 21:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=TGiBQ7VmjM7mVAr+H+Xl3LR9ImpLbL
        k7tYOeYCfQiH4=; b=Yc0/g9AyUyVuRW3P3ICmzCgxGWL2k2t9skVOT+zcHXLPp7
        Pm16SN4hRAs6qbP9/vMdnFluf9mavhfiriqX+ueZ9VrFy51m14SbMS/yefkDcbpD
        kIw+Xzg9fxJHxYaZacmXFyc1qiUteWh4OdbVFl/5v4fs2gGOkEWUcsbeTHvgQtBp
        EguMAogX6FHSg3ezktIxTOacwp0oiuQlXRdHqzjBtSSPmItYbMa+nLDQvFWsH5qA
        s+7yrPeZxxZOQFFeF4PfwmrpWRlifW/di3/Tv73JP2ya+Y86bvkQ6IYMeEKuXNP9
        i+lzfpOLy2f8ytR+ro3q7KLmQRKbjL/7Id798Dgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TGiBQ7
        VmjM7mVAr+H+Xl3LR9ImpLbLk7tYOeYCfQiH4=; b=kFhwLSp/Pjl5lmAa8lxl64
        u8xxaq4wu4pNr4/G6AOlazYIkv00xlBjeW5TnP3Xo37TWN/MqcC/x0OoFIkNLw/W
        nd/oOjVTezajRbtLdr7tgj23l230v8BEaQcygKn+AwVgczZSbuOQmJ/Vg1ge/HFI
        tNJHfnAyEWxxw3Pr/18C6pBtqUutN5H0r78Y5r8OO2nHIKruzCpT72grGPgbyspL
        4KcTxLZ3JcE0y8mff6tHg/98kpF01wv50+11xUIcWIhkaVKKRLeoA2DPw7NnVcXe
        kbpL7he8SJ+35Q4pcwa1jlZLj20xkDra9vKldSo9eA/TDeojnBxKZNvBibUibNsg
        ==
X-ME-Sender: <xms:TTv7YSwdqCUygbdkmSL_23cEO4oTiD1RtvIlHclZubPuYx_vbDk8Ow>
    <xme:TTv7YeQPUGd2rwTnyQlaFfWmBM4FQlX1RmwXkSjf19RkTSbD3MebEm2yz-277eWDA
    PkVcWS5eg5az4zIXQ>
X-ME-Received: <xmr:TTv7YUX07UCnXhwbpjzblVs9XGmi1nB9G-gvKshVERiBtvnitm2g3e4eOIQ8qDRzeh1kJkliJKLmshFbiwOZbaJK9FqfY64WLgva5wSOpzjq66MfQhv802BO2e9cRfoYfTxDUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TTv7YYhrRrnAXW5u001kpoyhVgAjVzmWNWqKnhbN3vKXpsdD04vjfQ>
    <xmx:TTv7YUC9O3WHwYiDhFWsQxlBuQMXoRTPxW_OSOgcPk1ZSEag1OQMIQ>
    <xmx:TTv7YZKwXQ7NLWleFampTEj6PP3FypGmyA3kcNh56MbDGFIfoa-mTg>
    <xmx:TTv7YYzt3Ge5KaPGzfOYhCrh49MYeLWlyX6tPG5oqEaYdE0hzbt4TaN4-S4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:17:48 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/6] rtc: sun6i: Enable the bus clock when provided
Date:   Wed,  2 Feb 2022 20:17:33 -0600
Message-Id: <20220203021736.13434-4-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 and newer variants of the RTC hardware have a bus clock gate in the
PRCM CCU. This was not known at the time H6 support was added, so it was
not included in the H6 RTC binding, nor in the H6 PRCM CCU driver. Now
that this clock gate is documented, it is included in the A100 and D1
PRCM CCU drivers. Therefore, the RTC driver needs to have a consumer for
the clock gate to prevent Linux from disabling it.

Patch-changes: 3
 - New patch for compatibility with new CCU drivers

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/rtc/rtc-sun6i.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 711832c758ae..d5a86cbb2e94 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -668,11 +668,35 @@ static int sun6i_rtc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sun6i_rtc_pm_ops,
 	sun6i_rtc_suspend, sun6i_rtc_resume);
 
+static void sun6i_rtc_bus_clk_cleanup(void *data)
+{
+	struct clk *bus_clk = data;
+
+	clk_disable_unprepare(bus_clk);
+}
+
 static int sun6i_rtc_probe(struct platform_device *pdev)
 {
 	struct sun6i_rtc_dev *chip = sun6i_rtc;
+	struct device *dev = &pdev->dev;
+	struct clk *bus_clk;
 	int ret;
 
+	bus_clk = devm_clk_get_optional(dev, "bus");
+	if (IS_ERR(bus_clk))
+		return PTR_ERR(bus_clk);
+
+	if (bus_clk) {
+		ret = clk_prepare_enable(bus_clk);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, sun6i_rtc_bus_clk_cleanup,
+					       bus_clk);
+		if (ret)
+			return ret;
+	}
+
 	if (!chip) {
 		chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 		if (!chip)
-- 
2.33.1

