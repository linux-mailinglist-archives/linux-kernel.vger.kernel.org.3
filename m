Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82505918D7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 06:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiHMEif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 00:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHMEid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 00:38:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E72871A;
        Fri, 12 Aug 2022 21:38:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0FF403200921;
        Sat, 13 Aug 2022 00:38:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 00:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1660365510; x=1660451910; bh=HEcNfg4CwiBsfqODwObieSZgI
        suTV3ZpAgRuL6VBTtg=; b=NwE54rizUgYGRU5kE4pbEMAx3ul6uR36YOFRkj3sO
        fMW2AM6rnp39EraZBCnBPm42Ymq2xEOnVmM8MaqjxCdN2qbv/WBSGM0GGTIrtT24
        j/V/8AtDtH4H+WN2Bcp994gkAsDKlWpPGAHKuSyZR0MbqLIJQCMAW3LrLg9yNLnt
        u3WK1MBt71/E+tIR9EfHvogHJwg1o0D1XusW9P3peOPkMUkFNH94W6ALBgsI8Ils
        U2mX2vnx47z6FIx8Hb0xn1T0HZNp6+bWo3g/NcA0yPOv3OhBofNaTefWlzxyR/MD
        3TifbectHtm5RweOr4Cv+WNapn1WGpdy5xYBgefH/YQAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660365510; x=1660451910; bh=HEcNfg4CwiBsfqODwObieSZgIsuTV3ZpAgR
        uL6VBTtg=; b=OhHgQzE/QUcnvt8UPLuOF2ZHlwaCVdeFZ7Bx1r+w9L4rFx4Ezqb
        Y34KrqtSVZPcjcc9xDFrxcFEIuxpaGDsR+Wrb42bwGMffG1hNWDRdx1KgTB+CBb7
        b4tjiPkuyPJw3bQ6I5NfBXNJrFbWJvCsA/mSjRCHl1CubUoTTqi+BnrV7WLXyZE0
        J/O7MkR17kdkP2Xab4Ddy3NbP0/qpIpG5leCy6O1FkNo1ivrTvO2x4Ov/6CElxJs
        X+YL5cmclPYfDIUa89Q7xoZq5WcmbJYeJjJBoVsWrIWlFwsDA2ST28JyPWFrjZXL
        r0y/tUuiP8MI3109/lUall7r9ASWP2mvTYA==
X-ME-Sender: <xms:xSr3YnhYk5WE9Q8kZexRKMNCcrRPPs3Ef9qW2IKyPmYsm-lpaPXdtA>
    <xme:xSr3YkCXzvfiqmsP0wgQqdqVO4c-wWc2zk8WGjVUufKHMp7dCzri9ytc5mP5dpMUX
    8qF33AmaZH8Yu09EXo>
X-ME-Received: <xmr:xSr3YnE-OgUuD_SEi1QqjgD7PlQvNlMFIoMWW5HVMOVqZQETx7aALEh4T7uM3dyFCQH4NbmXcg4slgxh6lZ9qwbve4U6mKnbQBsUfEOCKcTBFUeJY-eG5PEQtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkhgvrhhnvghl
    sehunhguvghfrdhtohholhhsnecuggftrfgrthhtvghrnheptddtieehgefgveegkefghe
    ekgeelkeejleelkeejueejkedtkeetfefghfektdeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehunhguvghfrdhtohholh
    hs
X-ME-Proxy: <xmx:xir3YkSI9WA7s-ARKSn7rWSS-n5QDFuDlwht6o5JX_o5aLTiwEaDmg>
    <xmx:xir3Ykzh67NkWRbrHePCTM90GjU5BJbFnMdiJGuv_ru3Unn5bzF4qw>
    <xmx:xir3Yq7Rz6Jrqv1GSQKI5gK0szjJ430kOKiP0sCw25dMm5PAW6_wTg>
    <xmx:xir3YrnL5-JXfp796yqk-SofX5opsl8f-cTrKtOUcIlzBIHV7swKdg>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 00:38:27 -0400 (EDT)
From:   kernel@undef.tools
To:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ondrej Jirman <megi@xff.cz>,
        Jarrah Gosbell <kernel@undef.tools>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org
Subject: [PATCH] Input: goodix: Add compatible string for GT1158
Date:   Sat, 13 Aug 2022 04:38:21 +0000
Message-Id: <20220813043821.9981-1-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
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

From: Jarrah Gosbell <kernel@undef.tools>

Add compatible string for GT1158 missing from the previous patch.

Fixes:	425fe4709c76 ("Input: goodix - add support for GT1158")
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3974cb63708f..995169701f13 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1557,6 +1557,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt1158" },
 	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt5688" },
 	{ .compatible = "goodix,gt911" },
-- 
2.35.1

