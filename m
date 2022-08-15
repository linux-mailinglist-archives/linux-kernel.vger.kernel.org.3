Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA99759287E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbiHOENg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbiHOENW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:22 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A2A140BD;
        Sun, 14 Aug 2022 21:13:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4BC1032004E7;
        Mon, 15 Aug 2022 00:13:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536794; x=1660623194; bh=0n
        lG6ZDiBzbAdn9rMY9Wvc4mEHKC/xeUwBEc8zJn16s=; b=yEWx64jF6G5/dLN6NA
        jPioeG+W1SSLewCp15W4PUN/F//rEfm+tw6KVILyGaORUNuSKZ4FYwEfNzNnIS0J
        GCC0KOKS6QwW66vYejfeVsqoN5F2tyigXSC/H1xKISLNFi03dyvEBtN1D0NEORdv
        W9DbGaQxP7zEXO7oAFaOeN8Q8JDDB5ikxviXVgb2pAzIeUrbeGUyY4P9eOT6CJyW
        JTGQJqUdLwNQLBJJwXKP49vjVQa8YmOHspl0Nyv3+PF8aNekX4lait9oln+zaeDi
        1kUqfMlVmLh6VYnGaLTHv5cqJRjf1P1UuIkoxDYHTZnKslZupinpDa60heXqmWva
        zewQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536794; x=1660623194; bh=0nlG6ZDiBzbAd
        n9rMY9Wvc4mEHKC/xeUwBEc8zJn16s=; b=wjC8+hS7bps6cUT22i2PtCsj49FeS
        uuKzq+2l1LjAMQ6X4RQXpV4wdTAS/gSl9kJJ/nDzavn14cHkvLpXvc1myg/SXnyn
        nk3Z3zZBwEtXk+8IsEOdlUOuZakExUomWo1V0x0H0b0SAuASsFq5tIU6pRtuPFVS
        X2euSKBqvWLMnSo+CAt6a/Iv9X5nZCvNtSlgPnJQyQ7N0XZSeSrZyCmQajaz6d2x
        CUBo4bo/7AgirS0rwOjnhVBPgUnMx7ITJ5RSYgu3ydTua98htC+Ae1jd2cJlxfbD
        BqZk7rR+4ARdNXZKWEjl7kF7WNsHrgZNX1+UtBeAQzm4h0cxKbpT/0LMA==
X-ME-Sender: <xms:2sf5Yk3tDjR-wxW4LsZDe41g8b97kbWwm_LarZNH0oTrXmCw8NAAeQ>
    <xme:2sf5YvFTgGQR1o2o6b_ZxfITOw3DgH4qsHh-m_IQbipjnKeTgS45L3ZLvKPY_-j4H
    bQqJ34oTCPYoNtFig>
X-ME-Received: <xmr:2sf5Ys6bmm13qyOq2_sxVg_JVyhYlYSztfGjN1IkBm97fjE2fdP96O5SPr94E8LHIosSgdm6NucLTbmkFEKiYgsN8S9aejMJX1W4uyum8cuaBo52e0aiUyeFRb-whiUdD9XIqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:2sf5Yt3Wmh1my8avFRv5CpsuNmXJDgKqtBRICG58GoZqx_JUVFk_Pw>
    <xmx:2sf5YnHO961yvq7Bo-9HR4_qFrinpzSXMN-k0JoYzch1XR6Ok_bNTg>
    <xmx:2sf5Ym8ID4X4tDap1rM-jNcX2Kk4_p5bdxxmTofAsZmkWP6W0RuNFQ>
    <xmx:2sf5Yu8UxJc9sj-ZJZSWsVQtiyLt34R5UTmXfWQ5Pqgpyp5dzjWulw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:14 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 07/10] soc: sunxi: sram: Return void from the release function
Date:   Sun, 14 Aug 2022 23:12:44 -0500
Message-Id: <20220815041248.53268-8-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in returning an error here, as the caller can do
nothing about it. In fact, all callers already ignore the return value.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/soc/sunxi/sunxi_sram.c       | 8 +++-----
 include/linux/soc/sunxi/sunxi_sram.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 09754cd1d57d..9622fd45f5e5 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -261,25 +261,23 @@ int sunxi_sram_claim(struct device *dev)
 }
 EXPORT_SYMBOL(sunxi_sram_claim);
 
-int sunxi_sram_release(struct device *dev)
+void sunxi_sram_release(struct device *dev)
 {
 	const struct sunxi_sram_data *sram_data;
 	struct sunxi_sram_desc *sram_desc;
 
 	if (!dev || !dev->of_node)
-		return -EINVAL;
+		return;
 
 	sram_data = sunxi_sram_of_parse(dev->of_node, NULL);
 	if (IS_ERR(sram_data))
-		return -EINVAL;
+		return;
 
 	sram_desc = to_sram_desc(sram_data);
 
 	spin_lock(&sram_lock);
 	sram_desc->claimed = false;
 	spin_unlock(&sram_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL(sunxi_sram_release);
 
diff --git a/include/linux/soc/sunxi/sunxi_sram.h b/include/linux/soc/sunxi/sunxi_sram.h
index c5f663bba9c2..60e274d1b821 100644
--- a/include/linux/soc/sunxi/sunxi_sram.h
+++ b/include/linux/soc/sunxi/sunxi_sram.h
@@ -14,6 +14,6 @@
 #define _SUNXI_SRAM_H_
 
 int sunxi_sram_claim(struct device *dev);
-int sunxi_sram_release(struct device *dev);
+void sunxi_sram_release(struct device *dev);
 
 #endif /* _SUNXI_SRAM_H_ */
-- 
2.35.1

