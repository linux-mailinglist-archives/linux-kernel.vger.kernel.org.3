Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF96449006C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiAQC7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:59:38 -0500
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252]:32779 "EHLO
        out162-62-57-252.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbiAQC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642388374;
        bh=JGr2weHXTxFi2FBYoPnWBMe7jsciVyJNcATS4sCqvi0=;
        h=From:To:Cc:Subject:Date;
        b=s/AzW0QIkeNzMmCNN+9WJiBOfNLPgwmRq7NXbBoUzGUBGgVh3JjrHpU82lrZyi38j
         AMGjNbhwQ2tkzq3/5iiY01BUSnoJMJx1K0hWwm82NY3uItjiOCUUJjlb3Zl8HoLwYS
         XGglgb7eqr+AFv3AP0OEq/kcu2JX+vQrSH5MTeLE=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id E900C0C4; Mon, 17 Jan 2022 10:58:16 +0800
X-QQ-mid: xmsmtpt1642388296ti8y3o2r2
Message-ID: <tencent_0589E3FF08A4905922F78BC38602361C5505@qq.com>
X-QQ-XMAILINFO: NqPEjZpmuGEFRaoDyprIgkXuk3dUIQyMkzK+WHIbhIFdQ0G4Nugt3kB5ayloZS
         HM9mp0jweU7D+t19VetxxU7sGTlTUq6boUV/LO3W0dVqQMq9VzMdE5G8vvV/AeffhvFvM+Lb3Tvf
         P+gXe9NgqiKnMn7SF7qQ7kEpiwx0WgcgJAThc4HeWc1teZq5cnvPL/RCdX67sLlNpu4qYMDWv4rL
         4d4B7T7oop0MqNqL6erS1tIiBHEVxbLuREWwAq7+U6x9BmFUDqRuXHeP9aErKk/mYnnOiV/mvO43
         aRPUMuK6aQIV+IfsR5N0WgBVuJmvLluSBeY0sYF1IbbpAO30v+MMmprvhK9ydFvS/cGODo8JdGs9
         /bsepshyp7Yx8K2T8d9SgX3UBCsmKUAg94I8Z32LyjhsBDtsrjSS/neihzSQFkF+vtI/VSCYdIGe
         7Lhwvp14UB+sXc1G64ZJJb0HJ9tge/Y6jnxYkUqkXw3f95wEQT977NxhsIOS0mdQJtkgeaBnUFml
         akd1G+lTJ539j0Hdqw8eZgPAq/lJmEOZ7P74ir6iNOMmEAYTvU83Iq9cy0L1oCc7dGichWjNHPmb
         LTlLXKXEbve6e3648uQMmoVO+7pBx0opJrDWxRECugK6i9IevCKVn7OWTqhhwiJB+jCgfbCb0bmZ
         MCUdccXjVCOxyqLYNauINVKqalxKSo+FfjLLz3juOJXism7sio+/brBZCcraIM+3XFAeVlmlL+TT
         a+hOYIeonl9B4z2y8ZRV2g+odtvuco1S8F7UQPedUcy3DihMiINoDkhgnH+XfEV4cprHk0e4Vhjo
         y3Xt1BXlsxisRk68JScRfHmfZu8TyqE2aq2WgaFAcZ1Lzi7jlwbJIv4JBZ4S7HXJLvHRIuqUCfL6
         w2aUeVwy0B
From:   xkernel.wang@foxmail.com
To:     martin.blumenstingl@googlemail.com, srinivas.kandagatla@linaro.org,
        narmstrong@baylibre.com, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] nvmem: meson-mx-efuse: replace unnecessary devm_kstrdup()
Date:   Mon, 17 Jan 2022 10:56:21 +0800
X-OQ-MSGID: <20220117025621.3214-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

Replace unnecessary devm_kstrdup() so to avoid redundant memory allocation.

Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelogs:
Simplify the patch to replace unnecessary devm_kstrdup().
 drivers/nvmem/meson-mx-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 07c9f38..13eb143 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -209,8 +209,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-	efuse->config.name = devm_kstrdup(&pdev->dev, drvdata->name,
-					  GFP_KERNEL);
+	efuse->config.name = drvdata->name;
 	efuse->config.owner = THIS_MODULE;
 	efuse->config.dev = &pdev->dev;
 	efuse->config.priv = efuse;
-- 
