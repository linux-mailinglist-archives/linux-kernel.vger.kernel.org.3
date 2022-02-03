Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72554A7D68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiBCBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:25:10 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38279 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348823AbiBCBZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:25:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 69E9B32021CC;
        Wed,  2 Feb 2022 20:25:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 20:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=AevhwIhzctfagAB5U4J4UU0yjjC/vB
        20Pt8LxBdPjqw=; b=SoI1Iap0kg5DH8pjGkOStDAglC0ynFXMGiH2hX112YUxn7
        kWuDK2XniRnuzHKyYaIRfJBuFlnlj9fbyYU39MUkFPN0vgWpSYo/EzUvPL2WTh6e
        tXGSUjCIuMOimjsx329ZtHmZY2yzbgb0qbBvxzHnrINOE0ex/DYXjIbrP8pD45o3
        XTc+DI5aHTLrb8evz60je6i5ouhj01OMceMwPDGgshVwKVFHhtKM2HjN9r7xo1XG
        TU5RuMLVi6/krotkzUUkNK2Z/PQBj7tQC+LWjNT5e1d9qsdetrNZrp57OOM7uDPj
        AJSxTUopzlYjYb9KPrCM69rTHPe83/qpaj6+n6OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AevhwI
        hzctfagAB5U4J4UU0yjjC/vB20Pt8LxBdPjqw=; b=XEvDaKT45a0R+MqooJA8Vj
        4hwdcaTH6cSZnvPD5QE7IFubfsrbCjXLryjC3l/Khgms7lcHZrM/yiKdt5YQwzP5
        +H0LMlX5wgilchrxnSd3cLdGt5YjRyIAUbkmnfYgmhKLrmsPjb3a4zoVrQLAeeuc
        mNIaDxZSc4tNKoLiS1qFKOpwKR+YMTzCkTeGx9d7Bn/FBZ3fejyj6/UO4UkmuK8A
        kE6U1UncVqPORijI7u+aC6SI6uhEllHTUD/RdWYjS1a3smKxcS5PkOcum1qrDUL2
        hnKX7mxrdCc+IA7jv/n13brMsj3sDNr5dJfpnJ9j2NhuDTydCIhF0ZPZTTlTqPBQ
        ==
X-ME-Sender: <xms:8i77YcXMVVSbe4d-7PYjEzxlMB5KNULrbzHPAikDQNlkfy364PB55Q>
    <xme:8i77YQlKE-JTQahHukdO3RXWKyPd8nrYb7z28n47zVsaewiYXUtIBjMCPH5qa88_P
    hjx_-oIM1oROoxkxA>
X-ME-Received: <xmr:8i77YQb0ZpzlysXUpop-1ohTEurAWE4MBz_T1VsuZ5cq1KuVbvLQRDpYhxlGC3dynJU9e-MiuA2faA8_x_I1uui8xGzFtbVQBwjeyWZS67qpadgmGEGrFukhK8-_a086nmZnDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:8i77YbW2foVvPJ-c9b8JV8q_YZ7x7tbwDNGkBh7Ct7Zig9vFN7uyXA>
    <xmx:8i77YWktOlCyncBk5v7Drm68wmFyLMBD4xYChXMML_id2ARQO8leSA>
    <xmx:8i77YQdIRNlSuVh6c2iqJFIFyOj95mYrJLiEKl63WwQMqdEFdr4zpA>
    <xmx:8i77YQ7qco6BW-cLT5b8QXXeFSM4mqCURhBDckHWcjRHl2AqtVPLwQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:25:06 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] nvmem: sunxi_sid: Add support for D1 variant
Date:   Wed,  2 Feb 2022 19:25:01 -0600
Message-Id: <20220203012502.10661-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203012502.10661-1-samuel@sholland.org>
References: <20220203012502.10661-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a smaller eFuse block than some other recent SoCs, and it no
longer requires a workaround to read the eFuse data.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 275b9155e473..5750e1f4bcdb 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -184,6 +184,11 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 	.need_register_readout = true,
 };
 
+static const struct sunxi_sid_cfg sun20i_d1_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
@@ -200,6 +205,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
-- 
2.33.1

