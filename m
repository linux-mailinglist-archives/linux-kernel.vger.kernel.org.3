Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB195ACC76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiIEHTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiIEHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:18:50 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4880B4DF15;
        Mon,  5 Sep 2022 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lZG7u
        e68WEc89C4m/LVUaUvO0VxOuyeAxv74XOAZBKM=; b=oV7zsC8XUNyJaAtesIJY9
        HHeYhwFrVo5fiY02fSQvlmIx2XBmBzVA5KVIi+rZFqfC7EJ7rZGhiK1wozhJaMy9
        fSgLIekVsAOX6XNoYGDAxHyzz/HV0baW4n5Fgg2wxpXB8A38Fl4WMW/siRVshJva
        Samk/mVvTu6oC6P8rtBuDA=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp5 (Coremail) with SMTP id HdxpCgD3YgOKoRVjtkjJZw--.29861S2;
        Mon, 05 Sep 2022 15:13:15 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     linus.walleij@linaro.org
Cc:     tangmeng@uniontech.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] pinctrl: berlin: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 15:13:00 +0800
Message-Id: <20220905071300.1832105-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgD3YgOKoRVjtkjJZw--.29861S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Jw1xWr18uFg_yoWfZFg_Ca
        48A3s7XrWjkFn3Zr1Yga9YqFWFvan0gr1fJF1qvFs8Ca4UWw4DJ34kXrZI93sak347GF9x
        Zry7Wrnaya9rJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUby8B5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBtgNz+11uQWRUlgAAsp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/pinctrl/berlin/berlin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index a073eedd71aa..1e427ea4d31b 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -209,7 +209,7 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 
 	for (i = 0; i < pctrl->desc->ngroups; i++) {
 		desc_group = pctrl->desc->groups + i;
-		/* compute the maxiumum number of functions a group can have */
+		/* compute the maximum number of functions a group can have */
 		max_functions += 1 << (desc_group->bit_width + 1);
 	}
 
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

