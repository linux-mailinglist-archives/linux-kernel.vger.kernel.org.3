Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C555660C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiGEBuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGEBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:50:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CB9BF78;
        Mon,  4 Jul 2022 18:50:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIPTwml_1656985838;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VIPTwml_1656985838)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 09:50:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linus.walleij@linaro.org
Cc:     geert+renesas@glider.be, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] pinctrl: renesas: remove unneeded semicolon
Date:   Tue,  5 Jul 2022 09:50:36 +0800
Message-Id: <20220705015036.106937-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warnings:
./drivers/pinctrl/renesas/pinctrl-rzv2m.c:487:3-4: Unneeded semicolon
./drivers/pinctrl/renesas/pinctrl-rzv2m.c:519:3-4: Unneeded semicolon
./drivers/pinctrl/renesas/pinctrl-rzv2m.c:591:4-5: Unneeded semicolon
./drivers/pinctrl/renesas/pinctrl-rzv2m.c:620:4-5: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 1afc6bb4386a..e8c18198bebd 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -484,7 +484,7 @@ static int rzv2m_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			break;
 		default:
 			bias = PIN_CONFIG_BIAS_DISABLE;
-		};
+		}
 
 		if (bias != param)
 			return -EINVAL;
@@ -516,7 +516,7 @@ static int rzv2m_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			break;
 		default:
 			return -EINVAL;
-		};
+		}
 
 		break;
 
@@ -588,7 +588,7 @@ static int rzv2m_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				break;
 			default:
 				val = 1;
-			};
+			}
 
 			rzv2m_rmw_pin_config(pctrl, PUPD(port), bit, PUPD_MASK, val);
 			break;
@@ -617,7 +617,7 @@ static int rzv2m_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				break;
 			default:
 				return -EINVAL;
-			};
+			}
 
 			for (index = 0; index < 4; index++) {
 				if (arg == drv_strengths[index])
-- 
2.20.1.7.g153144c

