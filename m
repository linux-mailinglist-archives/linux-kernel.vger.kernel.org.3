Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C284D1459
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbiCHKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbiCHKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05D41F93
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso1784816pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGdSDDQNkWhUKe33kF4Pj3YfO7xrQa9jh28/YPNZHXQ=;
        b=Xc64V2C3B+kdpVRo+6vOPVtr+wdh+pkujfSHyLdve/PVnzSDyR8OAFEMyRnpsHi6jN
         eaFxWFfybXPd+S69UPSIo50ij3LSwFkygbdRkOTMcRDO8J6qh0fwexcLjDaxZJh9Yw70
         LmXcfY33hytZUxq99hTKvsp3EiXSuWR/bIGeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGdSDDQNkWhUKe33kF4Pj3YfO7xrQa9jh28/YPNZHXQ=;
        b=kJn461DeWO4Yk4lA/haaLBmCQ2sdaeyeEYbRfUor4Jj7of2lezpud2hPg394a/abaL
         7KO2esnEX+TTWRURRSPg0LGxTqGFMNVpDeGBfCEajWl4dWla1r57/aU02zyz7SDfQkbD
         OdyaCPd1O4W/toeYMQyHT9WXzKBPjcs1gKyBiFX91IMWZdfUR2hUOaMhIkCeVWd9hkX6
         +5F2uL8czKR/Ty3N+H9va6QzS/0mgH1XjQrLydszNnMXEsO20Jzfzpayf8X7U74UcOqc
         /E9E5x0NEzkFEzJZiSFzuwgemCrJFPq4N03Zv/t8lNw0aiFQDUATiSMoFj0cmKGeOfim
         Unfw==
X-Gm-Message-State: AOAM532S1C84s3lgi/oSLGJ0k/hu3tNwZngtUszUUMt2AXqtTegGSrwC
        UrBmj565LYdY9dAq3tneixTN1g==
X-Google-Smtp-Source: ABdhPJxTWoED9DBGHXC3bbL4qawyt3m8I6aWwzNtsOMjlw76oLy6YYPISct3R0U33YSX/T9UDF9BFw==
X-Received: by 2002:a17:902:d2d1:b0:151:ef69:c27d with SMTP id n17-20020a170902d2d100b00151ef69c27dmr7994753plc.34.1646734214813;
        Tue, 08 Mar 2022 02:10:14 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:14 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 05/11] pinctrl: mediatek: paris: Drop extra newline in mtk_pctrl_show_one_pin()
Date:   Tue,  8 Mar 2022 18:09:50 +0800
Message-Id: <20220308100956.2750295-6-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of mtk_pctrl_show_one_pin() is responsible for printing the
full line. mtk_pctrl_show_one_pin(), called through mtk_pctrl_dbg_show(),
should only produce a string containing the extra information the driver
wants included.

Drop the extra newlines. Also unbreak the line that is only slightly
over 80 characters to make it easier on the eye, and get rid of the
braces now that each block in the conditionals is just one line.

Fixes: 184d8e13f9b1 ("pinctrl: mediatek: Add support for pin configuration dump via debugfs.")
Fixes: fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 3bda1aac650b..38a00a906daf 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -634,14 +634,10 @@ ssize_t mtk_pctrl_show_one_pin(struct mtk_pinctrl *hw,
 			pullen,
 			pullup);
 
-	if (r1 != -1) {
-		len += scnprintf(buf + len, buf_len - len, " (%1d %1d)\n",
-			r1, r0);
-	} else if (rsel != -1) {
-		len += scnprintf(buf + len, buf_len - len, " (%1d)\n", rsel);
-	} else {
-		len += scnprintf(buf + len, buf_len - len, "\n");
-	}
+	if (r1 != -1)
+		len += scnprintf(buf + len, buf_len - len, " (%1d %1d)", r1, r0);
+	else if (rsel != -1)
+		len += scnprintf(buf + len, buf_len - len, " (%1d)", rsel);
 
 	return len;
 }
-- 
2.35.1.616.g0bdcbb4464-goog

