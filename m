Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E425925D2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbiHNRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiHNRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:37:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7218E32;
        Sun, 14 Aug 2022 10:37:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B2BFF32005CA;
        Sun, 14 Aug 2022 13:37:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 Aug 2022 13:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660498629; x=1660585029; bh=49
        dhIZfr5q8v+hGU8cuF1niSFm1wGL2iaQ0mMKaC1Us=; b=KMrjwpl8IyD45VewM0
        dnahvq08KfsO25Cnb/NS7UvZIdllLvu08CkJfT1IJRn+RauKE5ROgPXzcLoAiPbz
        GG8x351g5x40BbTEE4fd1BN0E/bac9JP1l5OqMBTwLGNfmhczFib9iGTh3GLmy3V
        XmV69ZIXLPW74p1KKcwojNrkasQok2SPbX77ECRBQqtftiO/XGl4OmmMXzP24rlF
        yL9wxa8ipCWVvid7XN6jHf0uPnGWw9YYKeD61p1/nQTDW3TPodE7Rs7nHn/5ixTD
        U+IxN+38eMNvnJFEe6KGosSZWIrtOO2q79E05Fdf6kTIFHWVMvChvKmNFQfJ8X0X
        1NDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660498629; x=1660585029; bh=49dhIZfr5q8v+
        hGU8cuF1niSFm1wGL2iaQ0mMKaC1Us=; b=RuQ9kyJ9nsUTo/A8HY226w+V00dU+
        QdHGVJOLVr2M9qocaY5Z4cMX5XD9AMI1Fj08k47MlL0PjmsS7Ssu81c+vK7M3IaW
        1RaxCyJBMvjjay4GWXNp0AOfg86Go3xI9DfuyJCPJ8KAeMwRxxxoYsPMDyCjH1Jo
        1b/bUWAs6vSbgjAa0ib/ILDeujgYWhjpXw6d1FyXo07teXesVwvxA3y6X4xYjmoS
        ix6ASTAZXNv5ONtUw4V7GA2Zk7BeHKfnU3z0FhXHeYsOhJANAy6/J9TbEXOgB2j+
        Dhavxe9oT/eil+udKtY7y8DRiCwp7pvobX0m0xf+0MgVOVr0Ej1vcUn7g==
X-ME-Sender: <xms:xTL5YkxODX12D1Aq4EyfkqSJ1C6d3iVT2IIeVTIO8-3WC5O37FAOdg>
    <xme:xTL5YoS6CJEARSd6d0zqgeKm9CrN9EYaXpHUF_jKUQzs-3BSjv4XhfPGG_I1Kz9Ok
    T64-Nog92hkYHp5dg>
X-ME-Received: <xmr:xTL5YmVaWvkZOf31BDT9kuUCP9PgjQRIGdpaoeh2IvWwcH3WBKfVCzu0RXX6KFSWsqQSrmbqSeWO9VkZYLIbihspEU3v32V24hmU7mlYmixZixGlukNeEgFwQ0XzV_8NVq0EeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:xTL5YiinrohnMCAtfOeDbJQzUrS3hkEBoac7wJVm5vLjellUHXYlXQ>
    <xmx:xTL5YmDgriE-MUY-RnNbLeC1ctcdkVHXVqnsGi4_pfly8Ahf8VoYMg>
    <xmx:xTL5YjJlcg75im5-1bXtZHqFZRjvUYjh_IfOxFikbAgA2YxPh9rimg>
    <xmx:xTL5Yuvh2-za21XwMcj3mjnmNf5knNWjpxT53cp5A-tc_Nzvo_WTfg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 13:37:08 -0400 (EDT)
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
Subject: [PATCH 4/4] nvmem: core: Support reading cells with >= 8 bit offsets
Date:   Sun, 14 Aug 2022 12:36:55 -0500
Message-Id: <20220814173656.11856-5-samuel@sholland.org>
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

For NVMEM devices with .stride > 1, some cell values may not be aligned
to the device's stride. In this case, it is necessary to use bit_offset
to access the cell. For example, to access the third byte of an NVMEM
device with .stride == 4, we need "bits = <16 8>;" in the devicetree.

Implement this on the read side. The write side implementation would be
more complicated, and it is not necessary for read-only NVMEM devices.
For now, reject writes for these cells to avoid any incorrect behavior.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/nvmem/core.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1e3c754efd0d..309beba8c9f0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1373,63 +1373,67 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
+static int nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
+	int bit_offset = cell->bit_offset, bytes, i;
 	u8 *p, *b;
-	int i, extra, bit_offset = cell->bit_offset;
 
 	p = b = buf;
 	if (bit_offset) {
+		int byte_offset = bit_offset / BITS_PER_BYTE;
+
+		b += byte_offset;
+		bit_offset %= BITS_PER_BYTE;
+		bytes = cell->bytes - byte_offset;
+
 		/* First shift */
-		*b++ >>= bit_offset;
+		*p = *b++ >> bit_offset;
 
 		/* setup rest of the bytes if any */
-		for (i = 1; i < cell->bytes; i++) {
+		for (i = 1; i < bytes; i++) {
 			/* Get bits from next byte and shift them towards msb */
-			*p |= *b << (BITS_PER_BYTE - bit_offset);
-
-			p = b;
-			*b++ >>= bit_offset;
+			*p++ |= *b << (BITS_PER_BYTE - bit_offset);
+			*p = *b++ >> bit_offset;
 		}
-	} else {
-		/* point to the msb */
-		p += cell->bytes - 1;
 	}
 
 	/* result fits in less bytes */
-	extra = cell->bytes - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
-	while (--extra >= 0)
-		*p-- = 0;
+	bytes = DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
+	p = buf + bytes;
+	memset(p, 0, cell->bytes - bytes);
 
 	/* clear msb bits if any leftover in the last byte */
 	if (cell->nbits % BITS_PER_BYTE)
-		*p &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
+		p[-1] &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
+
+	return bytes;
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		      struct nvmem_cell_entry *cell,
 		      void *buf, size_t *len, const char *id)
 {
+	int bytes = cell->bytes;
 	int rc;
 
-	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_read(nvmem, cell->offset, buf, bytes);
 
 	if (rc)
 		return rc;
 
 	/* shift bits in-place */
 	if (cell->bit_offset || cell->nbits)
-		nvmem_shift_read_buffer_in_place(cell, buf);
+		bytes = nvmem_shift_read_buffer_in_place(cell, buf);
 
 	if (nvmem->cell_post_process) {
 		rc = nvmem->cell_post_process(nvmem->priv, id,
-					      cell->offset, buf, cell->bytes);
+					      cell->offset, buf, bytes);
 		if (rc)
 			return rc;
 	}
 
 	if (len)
-		*len = cell->bytes;
+		*len = bytes;
 
 	return 0;
 }
@@ -1526,6 +1530,7 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 	int rc;
 
 	if (!nvmem || nvmem->read_only ||
+	    cell->bit_offset >= BITS_PER_BYTE ||
 	    (cell->bit_offset == 0 && len != cell->bytes))
 		return -EINVAL;
 
-- 
2.35.1

