Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79A65AC0DD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiICSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiICSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:40:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C929839;
        Sat,  3 Sep 2022 11:40:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 631555C00FE;
        Sat,  3 Sep 2022 14:40:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 03 Sep 2022 14:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662230434; x=
        1662316834; bh=Tx3DFdgigyfpS0RGXNOmDW5kr5FUnVG7KC79bAVMMLo=; b=T
        b2mptC1d2k7blc6CQXb8fB9SsHbY4U8HviqJsA+Iy1QU7eOZElNHjEtOmUMXj5Rg
        ZqCst2AWcrYm3t4Cxm2z3txof5Mbuz2sihMwtYglMwMN5UDFBvE2sxVjtl2HzYu4
        IIloOuhkdKQAK4jUnl2poJvbuULdC/qcFZhePxTjNGv872tm8O9len3EexODi7Yq
        wemJ4XEzfMUfNpHE2PLr7GmKt7GiKycKwyLQEXw/C/CZFUnZZfWyoOxJlMG+PJZL
        zfDpHiFbmSrghJ22jZEyDxUJEQo1n6GWraDAlRI14ErRYN7gSlZqNG62vFZwbyoM
        757QdxwICyS4khF6+0hnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1662230434; x=1662316834; bh=Tx3DFdgigyfpS
        0RGXNOmDW5kr5FUnVG7KC79bAVMMLo=; b=NnQTErZDs8y0O47HjG2lI9s/qtqTR
        TjedFU0rxaiHOfL82oqwaLvRreaJrjFhzsT0wm7k5NsSrmMp53f45djmr1QIN9nd
        C2wwQ8ny5GUOw8z/njLWfRhkJhCGhaC1cou2QzvzIp7CoUyd8GOwCQb2+/xxlAV1
        +6W4CRzZOH33wNP5fqIHLJqmqfEAIpe5cA0HoLVJRCXhYlCVLF2awEe4eS8C2byx
        KFuqBNt1cNqIJgFnabU6Ba9omTBVFVkyzUZ87ZPDcus1qwLgnWPnpjr4rsVp+evx
        bgE2R58NKcdl+/FDcbl1iKIxSj6cyfw674byOSvUUR2rU35KAxPO0FhqA==
X-ME-Sender: <xms:op8TY0uW6x7B3vPPLnjgCZGfoF7G2uipvrC_9K-OCKjK5XH7BK43Mg>
    <xme:op8TYxd8cLLnRfgZR_OQuYGksO3TsEFuOFANLGCLwvt4v9OFmaOTQhU52HtVXa8jM
    cLwAbIdbFYkPHCs6lk>
X-ME-Received: <xmr:op8TY_zX9VcHgWkuQe3sKN9b8LgEbN8n5XA5TViVKXzweWqZxJdVvNBL3zFfJOqgFN0VfFm5k_aCgBOhNir3rW66mhY7PSn71tl17UVoZS5eN6oSXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelvddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepofgrgicuhfhivghrkhgvuceomhgrgiesmhgrgihfihgv
    rhhkvgdrtghomheqnecuggftrfgrthhtvghrnhepudelvedvtdffhfeugfelieevvedvhe
    fgvedtteefkeevvdfhieekudeuteefgeeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepmhgrgiesmhgrgihfihgvrhhkvgdrtghomh
X-ME-Proxy: <xmx:op8TY3PK7Dz_cgmWmp8dBkqf2e-EyrDjiJbO38aNZiLvdv7fkrTSrA>
    <xmx:op8TY09J_Ubh7eWwkU9vini7e2qdoYbKyOSnIW8zwg2-fQxtAFuyIw>
    <xmx:op8TY_XMb2GKl5aSNkauyBZS839U3p1oTuQUGocdDNzkR2wPz2dW0Q>
    <xmx:op8TY_WXNEtMuBvQhmyawHWKqMcm5QKSZ7DDrYGcoBzqTvxov05tDg>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 14:40:33 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>
Subject: [PATCH v2 4/4] drm/panel: clockworkpi-cwd686: Implement .get_orientation callback
Date:   Sat,  3 Sep 2022 13:37:53 -0500
Message-Id: <20220903183753.25736-5-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903183753.25736-1-max@maxfierke.com>
References: <20220903183753.25736-1-max@maxfierke.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returns the panel's configured orientation

Signed-off-by: Max Fierke <max@maxfierke.com>
---
Changes in v2:
 - this was added as .get_orientation is now available in drm-misc-next since v1

 drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c b/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c
index 87d20d784596..2c433a458c8b 100644
--- a/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c
+++ b/drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c
@@ -340,7 +340,10 @@ static int cwd686_get_modes(struct drm_panel *panel, struct drm_connector *conne
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-	/* Set up connector's "panel orientation" property */
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
 	drm_mode_probed_add(connector, mode);
@@ -348,10 +351,18 @@ static int cwd686_get_modes(struct drm_panel *panel, struct drm_connector *conne
 	return 1; /* Number of modes */
 }
 
+static enum drm_panel_orientation cwd686_get_orientation(struct drm_panel *panel)
+{
+	struct cwd686 *ctx = panel_to_cwd686(panel);
+
+	return ctx->orientation;
+}
+
 static const struct drm_panel_funcs cwd686_drm_funcs = {
 	.unprepare = cwd686_unprepare,
 	.prepare = cwd686_prepare,
 	.get_modes = cwd686_get_modes,
+	.get_orientation = cwd686_get_orientation,
 };
 
 static int cwd686_probe(struct mipi_dsi_device *dsi)
-- 
2.37.1
