Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C355529E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbiFUDmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345090AbiFUDmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:42:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EF1EC79;
        Mon, 20 Jun 2022 20:42:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B42073200413;
        Mon, 20 Jun 2022 23:42:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 Jun 2022 23:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655782951; x=1655869351; bh=Lx
        uWI7fwqUJxo8RalFUvW8brkX0rNqDAgLS/C3jwWOM=; b=e7K2mVJZDmTrc470vv
        XbdFJ71hbK8iS+o1Atn7nY+g3n9tpEkn+YiY1D2nJIjUjQOnSgxY+8pANso3ZPfb
        GwboWO3Opn2k3RfMFd+HHjDDZTobjBFxkMD/h0bM2OW80WqeCmIviZZS3F05z6vb
        r5zifmydTiNupFLXg5NC4KwvaJrGfLijxvG37iS6Sj3Tzb62EFiEh535vqbkEkPJ
        8hcOW7JonDOwaSBm4537LxJRKU8jol1JjrTbv7fAFJpenM2jCzKMJ7oJGlH79mcs
        sYjlnnDaPEr1JNvvIyokeU+LO2X03EJzH8aRGYH/TB6vcgqk2N4u28KPJNW1gikF
        HwnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655782951; x=1655869351; bh=LxuWI7fwqUJxo
        8RalFUvW8brkX0rNqDAgLS/C3jwWOM=; b=eLjLryZYKEw1lLLccdtjDoM1LjY9M
        o4Mt2Uy5PDhT1evtiv07d1eHcUhjctMItqsHJaku5ZuhG0FU9Q/7zvZgYXuPopUI
        CkC0jZE0vdgE29QuKxaSO8y9GnU+4ObGdmAKnqvkQY9psgBkDmbujAmt59LixDEG
        nDOlZbtsDXAsrkygLTqmPC0FP6buTupjwWxdQAYJWzL/zGJB+V2i5oec1nWEtde9
        u1v4oNqlFFAA/Cjb2jdeQMdskhg7U0vue5HGty34o+z4lKvYSW9hXt5JVb/nf8WD
        j4UOMm+9Wic1oLsvhykz+x5/dn5p9PfCyUnRQZFnVuwXYN3LsrWqrWCkQ==
X-ME-Sender: <xms:Jz6xYs_dLOCE8Us1VVMneKKAXP52ZNcVHks0FI61S5FqO5VKJdh9vg>
    <xme:Jz6xYkuHLAeE_WsJZLdLvL07DT0teqWPllEqhdIlqjX1RzSpcDf-3RITR9e9ER4i9
    bmWlqIWjL71G1lxqQ>
X-ME-Received: <xmr:Jz6xYiBVB8psHnGeFMSCSkmVbFexmCyLG7MGOJRKT9_AKgz3olo6BKxfWLQmW9rLgnX9JCCim6rwTzFJiAZdbG_u1qf9duaikiUA5k14FsuSceM6sKLEIvNm2ktZpN-ZHGUlRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Jz6xYsdq_RlUhntcY14HtbzPKn0mk61Zft73de-aZpv2pABsyU1fQA>
    <xmx:Jz6xYhMFjfzNw8N066mQFThyypxL3Ep88wlQ_Pa7s7r7JnCSi4YF-g>
    <xmx:Jz6xYmnXBONjifZzlF22JyYMVYxa0xyhGXm8mYyBJ15wqDsde2vkgw>
    <xmx:Jz6xYqjFtSQGm2KBjIG_1bRSrm4ETMRMIM5WusI8ZY48kepYF94fhA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:42:30 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
Date:   Mon, 20 Jun 2022 22:42:22 -0500
Message-Id: <20220621034224.38995-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621034224.38995-1-samuel@sholland.org>
References: <20220621034224.38995-1-samuel@sholland.org>
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

These PMICs all contain a compatible GPIO controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/mfd/axp20x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8161a5dc68e8..88a212a8168c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -619,6 +619,9 @@ static const struct mfd_cell axp20x_cells[] = {
 
 static const struct mfd_cell axp221_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp221-gpio",
+	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
 		.resources	= axp22x_pek_resources,
@@ -645,6 +648,9 @@ static const struct mfd_cell axp221_cells[] = {
 
 static const struct mfd_cell axp223_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp221-gpio",
+	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
 		.resources	= axp22x_pek_resources,
@@ -785,6 +791,9 @@ static const struct mfd_cell axp806_cells[] = {
 
 static const struct mfd_cell axp809_cells[] = {
 	{
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp221-gpio",
+	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp809_pek_resources),
 		.resources	= axp809_pek_resources,
-- 
2.35.1

