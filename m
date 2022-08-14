Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBB5925CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiHNRhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:37:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED8183BB;
        Sun, 14 Aug 2022 10:37:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BFB5D32004F8;
        Sun, 14 Aug 2022 13:37:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 14 Aug 2022 13:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660498621; x=1660585021; bh=dg
        K2r3NnWA/fMz96186veALUGDdZnI4ai/sBIyyzgBw=; b=Ox5iXGAZAvvTwugoov
        Lx9ZlDx2n/7ZPiAs/SrqqRlxw08NikoDhMHPHRr77nRjDvpMLYZxoGWuqNa8AB7w
        Rt8xmvyvjVCsO+ArGTVqn9dHUOiDLbyLKA7f7HU78VZ6GcVHKDzHBlRDx0MiVywv
        617r9jKXROg5VqhZ48gHzEFqTkLvxg+v5oDtGqL1sDwpVI8LupdPOjkpL/i7KsWt
        B/JplbOtKQfb27Yj9QjnF3ru4VTwcXnTnFIv9INpe3yjH+mNrYkKfHroyKug28fE
        iMydQpRbDIyarAg9r5dpsvSqkegLeNe9OGpAxLPOG4cDaslB0cSUBETah2MwkBCQ
        D4Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660498621; x=1660585021; bh=dgK2r3NnWA/fM
        z96186veALUGDdZnI4ai/sBIyyzgBw=; b=DtOqG70pJkPGoDaHvyP4tN+xEOJS/
        wZ5vi1IF3AYieercncN5qi0KmqkP6RroCrk5itoeLFXNTV6yWVvQ8NIo8c7pbju5
        6lxAV1QwEqMGNLYYeBSrXVguZv5+cWRdb+5s1qtjxCyeGmUYp0mTkCvWyrbP+lda
        H2v6aL9JS664/3si2fNeG7A4/81y/bEoUjar5wD/ZY6P14v1GZ9zGQ35o4jVCOM/
        gQTR3yEPYzvjgXJSxBHwN1mkiPGbS7+jIlCEgy/2NFA/3o70BQThzzR+61mPL8Ar
        nLt7ofIspdZCPQ9eiFC5neTnfiXMOeg0w/9EITdiLGcvd4sCqY6Vf/3gA==
X-ME-Sender: <xms:vTL5YpQCynENEbEO3U2C_9edn-L-SigplgjD1ONkgc26fZuLsy6DkQ>
    <xme:vTL5YiwtuvECzN_7LUtln598dOSTAc_IoYG070hLcpuLM6xo6HuDNVzAhmvN-Sfkw
    qX1n11at3hRSUdj6g>
X-ME-Received: <xmr:vTL5Yu0by_Tu3fKY9SDBt5ulv1919LgHVwXvyzmNWKpVPXtNdahG2M03KqPCjtMtV1IDbbmGm8tqpbLcaYsPYXyo9iBfGbDN8T3GJNRmrqCPlea2cZ6N8k9MJD-etVhGnfHFKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:vTL5YhA-8T5ApfYuYHvyMD748sdldOzXV0KVccvb6rolfPYjIESSsw>
    <xmx:vTL5YiiRfd0qx5_YFUQEek8dW6J3D55Q9_PmxqzNJGXyD1lfu4nW0w>
    <xmx:vTL5YlpapyCNT3umRIdAvID1WHHmP9FWiRlB3TPDQsIO52THwdzqAw>
    <xmx:vTL5YtMCEhpksO_fYiy87bgEiVT_X6coE2lvzoc73ILqqpl1zBwD6Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 13:37:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 1/4] nvmem: sunxi_sid: Always use 32-bit MMIO reads
Date:   Sun, 14 Aug 2022 12:36:52 -0500
Message-Id: <20220814173656.11856-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814173656.11856-1-samuel@sholland.org>
References: <20220814173656.11856-1-samuel@sholland.org>
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

The SID SRAM on at least some SoCs (A64 and D1) returns different values
when read with bus cycles narrower than 32 bits. This is not immediately
obvious, because memcpy_fromio() uses word-size accesses as long as
enough data is being copied.

The vendor driver always uses 32-bit MMIO reads, so do the same here.
This is faster than the register-based method, which is currently used
as a workaround on A64. And it fixes the values returned on D1, where
the SRAM method was being used.

The special case for the last word is needed to maintain .word_size == 1
for sysfs ABI compatibility, as noted previously in commit de2a3eaea552
("nvmem: sunxi_sid: Optimize register read-out method").

Fixes: 07ae4fde9efa ("nvmem: sunxi_sid: Add support for D1 variant")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/nvmem/sunxi_sid.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 5750e1f4bcdb..92dfe4cb10e3 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -41,8 +41,21 @@ static int sunxi_sid_read(void *context, unsigned int offset,
 			  void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
+	u32 word;
+
+	/* .stride = 4 so offset is guaranteed to be aligned */
+	__ioread32_copy(val, sid->base + sid->value_offset + offset, bytes / 4);
 
-	memcpy_fromio(val, sid->base + sid->value_offset + offset, bytes);
+	val += round_down(bytes, 4);
+	offset += round_down(bytes, 4);
+	bytes = bytes % 4;
+
+	if (!bytes)
+		return 0;
+
+	/* Handle any trailing bytes */
+	word = readl_relaxed(sid->base + sid->value_offset + offset);
+	memcpy(val, &word, bytes);
 
 	return 0;
 }
-- 
2.35.1

