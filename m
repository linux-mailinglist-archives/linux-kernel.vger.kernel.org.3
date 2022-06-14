Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B010154A9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352637AbiFNGtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352520AbiFNGtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:49:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DAC396AE;
        Mon, 13 Jun 2022 23:49:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so3334912wml.2;
        Mon, 13 Jun 2022 23:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rK2JBezORIHT404/AnKcTtSy2/jIHZfS+t0GGJ0+ABY=;
        b=WcIWyHKlRAS26Z8EoLw6XLKzEPXqlPumRldCWWOKPHE60ySBl3cfry6pTEZK8vrxSX
         KEq8iqRSaZUDNgr0sf6uYKhyNaMpdp1d1ALsC2BHLxW+R/p1sLkmlZiG2jTgKWnC6r6M
         wm2CAj+7ewzCvE8yvadPNbiyAYROdGt8+Ccw4jXeewwH2rAdRtbOZ8+l/ryvDupbkgq+
         C0dFBq+ehpIgGJgrf8sAAmy0CLNnoFphd+vN4PKFJsStzMdThDPse7VRf7I036178AIn
         6lby+hWvwbDnQA+hoUlmYub2T329n1TcmdFDFnRJs+V2oSFLDJZxtT/2CK4Dwb+T/8tC
         9tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rK2JBezORIHT404/AnKcTtSy2/jIHZfS+t0GGJ0+ABY=;
        b=FPQLHzF5QK5ZrRuW9FfOG3HVyH8RzlxAcWK5fGf7K60w+AJS3ydokhsmZp0dxBVsgp
         f/v+j9plAiTIwsgZQVpcmfiPo15E63b1cKvAmuPjKv/K/HGcNNAk8oMZwXtZS2JFi8ps
         swsplDbrFpV6Ps7sez0UuUP++54Ske1eslwzWHmWAB1XS1uFpAzQqRfiNt+2SJpvADnA
         /d6Nm48W16osD3z/Oi0+3zHT7B9bH00jZUMjYnTJriTZWlFzXkhwUNpvCc41uJ+/ZuZz
         quBqZr7mF679otjbF7u+eoaGrTLMefhCtXftSady0sNHjzRAAhQilT3DHERthLl/Y8wu
         n1yw==
X-Gm-Message-State: AOAM532dE808gcG3j133q/sJvPWmtSz0Ss0NCWqAntt7d/i2lRaOzSN6
        vFrx0sR3yoaA4/aOL3Ny3B4=
X-Google-Smtp-Source: ABdhPJxKDEf3IT/FOvko39kZHApTNB9iNglrdPDScj/yimRsC18KrDoK3lWb1n7NeK9351mDqeOwVg==
X-Received: by 2002:a05:600c:6020:b0:39c:96ec:5014 with SMTP id az32-20020a05600c602000b0039c96ec5014mr2426943wmb.57.1655189351116;
        Mon, 13 Jun 2022 23:49:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b0039c15861001sm18549655wmb.21.2022.06.13.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 23:49:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/chrome: Fix spelling mistake "unknwon" -> "unknown"
Date:   Tue, 14 Jun 2022 07:49:09 +0100
Message-Id: <20220614064909.47804-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/platform/chrome/cros_ec_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 1bd567244f8e..6923ea4401e5 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -346,7 +346,7 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 		dev_dbg(ec_dev->dev, "found PD chip\n");
 		break;
 	default:
-		dev_dbg(ec_dev->dev, "unknwon passthru index: %d\n", devidx);
+		dev_dbg(ec_dev->dev, "unknown passthru index: %d\n", devidx);
 		break;
 	}
 
-- 
2.35.3

