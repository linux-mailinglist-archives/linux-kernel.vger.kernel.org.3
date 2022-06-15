Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3578454C141
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbiFOFnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242607AbiFOFnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:43:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB527CD4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:42:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5B6353200954;
        Wed, 15 Jun 2022 01:42:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Jun 2022 01:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655271775; x=1655358175; bh=5Ktr4vYlyz0VnFc26zfV4hN2K
        qo9QoraAHP2bMY/PDg=; b=KMMKtA1s02sqAPbxvx2FdTwb9+2bAj1C9yJoal2s0
        7d5FkAXdtRCBYl9tnhl6fWKHbrUmidXVAGFIAVMQoyHO5erHF4UIZGer/W9cBzP6
        7n4V8oUOXpH6z34JJ18LeSNrnStvSyu2nprIx37o5MRqMrHerPE6F/Eu8cVSnVuh
        AA+zQSg9uiK2egLpDx0H1YuQIWdG+6KBA1QI9kkrhxJjvFm7tI2J2pSb6WNQrH1a
        8K525Wo27Izo5Y/ig9EqhHf0vT7TLbqjtWNEfnj0nWhUUc+GyfxHssu9WKmazvDv
        GikcgGqcso/cBywFQcK7V/YWsjYFCXSdA7LUSgYILjC0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655271775; x=1655358175; bh=5Ktr4vYlyz0VnFc26zfV4hN2Kqo9QoraAHP
        2bMY/PDg=; b=ZndezcDyHErKLOX5G6RxC/ecHQJasGa+gubBIJoi55KxX+zaw2V
        shvidQ+ga7J45jYelXWNLcNsakPJK8DA/zWDteV4kSw7DOw5QDDU8PwabIjdRKfH
        3DRWiTEikErIma6DZbs3vzkGmQR48czsQ+3+Nx+BZcCy52bpJ+irlmPlNF3/EzUA
        FaYIUem8zmoNyHL0FK852pHOllNGPpEoRuRFKrT0ZnAjjX8QPJbVwM55qvb472nj
        v81Jh6wfiJK3wv8u70nhbO0tivPcNOfRTPJeO9YQ42leZvpyizU84YFQd+WKcZ0u
        wtFdUZ7v3fIngvTgMe7QDWinWPUFrcXjwhw==
X-ME-Sender: <xms:X3GpYlg5uzhgxfBmFM9iNkimF1K_PYuEZjrFD9-EQodottwWxYIpCw>
    <xme:X3GpYqCWUtLDZBIFuJPraHltqW4UDd_FJcjjyNJJdMwHtdY4NzsUsD5lVYUlsj2h_
    WWKqFq_t3vIJKvG6A>
X-ME-Received: <xmr:X3GpYlE6XlM1IADqUvb86YXVX6rw7V4zJN8vqNj4VljMYqwOuZJ9UHearuuXsQpqM2xEvZ8rVdy5WzxYNijEvwT3p8c1rhuYMt5u5xfcXIpp__1Ak6cpa4CE__b9VH_2fRSYWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvtddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:X3GpYqQGE235Da4u_CqxAhYmNPTlXjLmHN_ZOFojI7eRCmz3xIousA>
    <xmx:X3GpYizwhBwL1AHT8MlNXqT_WB8ckxYohfAAPqRC6-ZJ5WpUz2lftQ>
    <xmx:X3GpYg5n2KXNsDyZ_kNp_R-hLfHlPLfMwZMTHBSvQQ_oxjZNpY6KZA>
    <xmx:X3GpYmcYR3ebHiNAgnlRJSFNQOWQ4-CXGM8NGDzadPfMg8mY_rIMtA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jun 2022 01:42:55 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] drm/sun4i: Fix crash during suspend after component bind failure
Date:   Wed, 15 Jun 2022 00:42:53 -0500
Message-Id: <20220615054254.16352-1-samuel@sholland.org>
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

If the component driver fails to bind, or is unbound, the driver data
for the top-level platform device points to a freed drm_device. If the
system is then suspended, the driver passes this dangling pointer to
drm_mode_config_helper_suspend(), which crashes.

Fix this by only setting the driver data while the platform driver holds
a reference to the drm_device.

Fixes: 624b4b48d9d8 ("drm: sun4i: Add support for suspending the display driver")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 275f7e4a03ae..8841dba989ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -73,7 +73,6 @@ static int sun4i_drv_bind(struct device *dev)
 		goto free_drm;
 	}
 
-	dev_set_drvdata(dev, drm);
 	drm->dev_private = drv;
 	INIT_LIST_HEAD(&drv->frontend_list);
 	INIT_LIST_HEAD(&drv->engine_list);
@@ -114,6 +113,8 @@ static int sun4i_drv_bind(struct device *dev)
 
 	drm_fbdev_generic_setup(drm, 32);
 
+	dev_set_drvdata(dev, drm);
+
 	return 0;
 
 finish_poll:
@@ -130,6 +131,7 @@ static void sun4i_drv_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
+	dev_set_drvdata(dev, NULL);
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_atomic_helper_shutdown(drm);
-- 
2.35.1

