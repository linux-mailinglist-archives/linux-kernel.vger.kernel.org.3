Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BAB5AD5D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiIEPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiIEPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:10:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D72AE0;
        Mon,  5 Sep 2022 08:09:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MLsMD3f3yzKGHV;
        Mon,  5 Sep 2022 23:07:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP2 (Coremail) with SMTP id Syh0CgC3VW8hERZjhLKnAQ--.57944S4;
        Mon, 05 Sep 2022 23:09:22 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Pavel Machek <pavel@ucw.cz>, Oleh Kravchenko <oleg@kaa.org.ua>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] leds: cr0014114: silent no spi_device_id warning
Date:   Mon,  5 Sep 2022 15:26:57 +0000
Message-Id: <20220905152659.4152483-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3VW8hERZjhLKnAQ--.57944S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kCryrtryrGr1fXFW8Zwb_yoWDCFc_CF
        1xWry2vFWkCFy8Ja1j9F15Zr9aka1FgF1kXw4jva45Zr1Svr43ZasruF97A34Uuw17Aa48
        u3Z8XF1UCF43tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Jr0_Jr4l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxUrcTmDUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Add spi_device_id entries to silent following SPI warning:

SPI driver leds_cr0014114 has no spi_device_id for crane,cr0014114

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/leds/leds-cr0014114.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index c87686bd7c18..095455163246 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -281,9 +281,16 @@ static const struct of_device_id cr0014114_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, cr0014114_dt_ids);
 
+static const struct spi_device_id cr0014114_spi_ids[] = {
+	{ "cr0014114" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, cr0014114_spi_ids);
+
 static struct spi_driver cr0014114_driver = {
 	.probe		= cr0014114_probe,
 	.remove		= cr0014114_remove,
+	.id_table	= cr0014114_spi_ids,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= cr0014114_dt_ids,
-- 
2.34.1

