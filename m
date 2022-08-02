Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58731587930
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiHBIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:41:44 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DC815FF2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:41:41 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220802084139epoutp043fee1aa2a59664be90eb8fee82606fe7~HeoUKd76_3186931869epoutp04N
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:41:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220802084139epoutp043fee1aa2a59664be90eb8fee82606fe7~HeoUKd76_3186931869epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659429699;
        bh=U2+1C8PyVM3+hskOZoTZthnT4tSJpiYEGUCuift9Ad8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=C15jSF7Gc41WrPiviSYPX/D1Kjkhh9ggB9Je/XVVVJ/kFdco/mcstAxByDoCTXDU0
         UwWDxLriwBmUsqA1hUSckDetw7QqeHsX5OjGtqTAKLIUQCbY+eKQ+0NIlWAJM63TNS
         53Rek4BgZK9DknmrQt+KY46thnLbybBAEDZ6YOYk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220802084139epcas1p474dbcd625e171018e9aeb919ab261110~HeoTyX_4O0481804818epcas1p4r;
        Tue,  2 Aug 2022 08:41:39 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.242]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LxpPZ5fGWz4x9Q5; Tue,  2 Aug
        2022 08:41:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.13.09633.243E8E26; Tue,  2 Aug 2022 17:41:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220802084138epcas1p22d18382ac9a3ae0990c53e0273645755~HeoTLGGOb1164911649epcas1p2F;
        Tue,  2 Aug 2022 08:41:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220802084138epsmtrp265f2cbe72f1307887fde4c4aff2ee696~HeoTKWPnn2317523175epsmtrp2V;
        Tue,  2 Aug 2022 08:41:38 +0000 (GMT)
X-AuditID: b6c32a36-075ff700000025a1-6c-62e8e3425619
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.B7.08802.243E8E26; Tue,  2 Aug 2022 17:41:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220802084138epsmtip1b99909611d302fe81cbc5b8d7f3a5b29~HeoS9bvb62656426564epsmtip1q;
        Tue,  2 Aug 2022 08:41:38 +0000 (GMT)
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     minchan@kernel.org
Cc:     ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [PATCH] zram: fix typos in comments
Date:   Tue,  2 Aug 2022 17:41:34 +0900
Message-Id: <20220802084134.27202-1-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQNfp8Yskg8uduhar7/azWVy6f4fV
        Yu8tbYvLu+awWSz7+p7dYkPLLHaL3RsXsTmwe8xuuMjicflsqcemVZ1sHn1bVjF67Py0mdXj
        8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wc
        oEuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZG
        pkCFCdkZd/svshYs5ay4Mu0CYwPjbfYuRk4OCQETiY8tR9i6GLk4hAR2MErcWD+ZCcL5xCjR
        0TaNGaRKSOAzkLONE6aja9ETVoiiXYwS/6/NYIFwvjBKnNq0gAmkik1AW+J2yyawHSICYhKP
        v/wAs5kFljFK/JgaD2ILC+hInFp6ASzOIqAqsfDzAjCbV8BS4umnU4wQ2+Ql9h88ywwRF5Q4
        OfMJC8QceYnmrbOZQRZLCFxil9i8YQEzRIOLxK7J16FsYYlXx7dAPSol8fndXjYIO1vi+oZD
        LBB2icT3dY1A9RxAtr3E+0sWICazgKbE+l36EBWKEjt/z2WEWMsn8e5rDytENS8wgIQgSpQk
        Vvy7BjVQQmLD4W6oRR4SDybNABsuJBAr0diVMIFRfhaSX2Yh+WUWwt4FjMyrGMVSC4pz01OL
        DQuM4FGanJ+7iRGcFLXMdjBOevtB7xAjEwfjIUYJDmYlEd47Ls+ThHhTEiurUovy44tKc1KL
        DzGaAkN3IrOUaHI+MC3nlcQbmlgamJgZmVgYWxqbKYnzrpp2OlFIID2xJDU7NbUgtQimj4mD
        U6qBqZU53ySPl+XOgwVl80r2Tnjw4//OOcaNEi/frJ7kKzf384HIOgvefcluczq99yu+/nZq
        KX9/t+PGzKwZSxddOL/+ffbf1zZx75q2nipUUDBn3soiYRsRbrKkbObXOb+W6OduWjvvwNO4
        3XJFZnP/Je9gENdb9cY7QPi8z9uvezUyupTc3GR6pbjm/Jxw/dCiPX27np39rFH0+51SYHrq
        2u9ZYvtVJLsdnl64la5cV3/6aun1LTvWM3EK2O+YwH9dbMJjbjsLO+GZ+17OjKlSK34VEmC4
        RZOT/afko0us/mw5hYy5P2+ZN57+6m1X+yVzT2bdl0Nplxy5rDnuhfLKmP9QSXgaLGfgfz58
        u5rrFSWW4oxEQy3mouJEAFIanMMTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK7T4xdJBh1nxCxW3+1ns7h0/w6r
        xd5b2haXd81hs1j29T27xYaWWewWuzcuYnNg95jdcJHF4/LZUo9NqzrZPPq2rGL02PlpM6vH
        501yAWxRXDYpqTmZZalF+nYJXBl3+y+yFizlrLgy7QJjA+Nt9i5GTg4JAROJrkVPWEFsIYEd
        jBL/9ohAxCUkNmxaC1TDAWQLSxw+XNzFyAVU8olRYsEKiF42AW2J2y2bwGwRATGJx19+sIMU
        MQusYZSYMvcwG0hCWEBH4tTSC2BFLAKqEgs/LwCzeQUsJZ5+OsUIsUxeYv/Bs8wQcUGJkzOf
        sIDYzEDx5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw
        qGpp7WDcs+qD3iFGJg7GQ4wSHMxKIrx3XJ4nCfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUy
        XkggPbEkNTs1tSC1CCbLxMEp1cCkd0ukOD0p5mqS/eplb8qYtpQsOqm5imfHZL1NgSkHD0qd
        nVdi6vIgw+4q/wmfOndVj0Vs+1LSTH4J6yZ5Kf3K+Jv2b/3DsjCuTUcEt7w10r79ctXc5gsT
        O70vqwcIhTtUfXQRE/gkpldT66l5+wX7+RVRp+YLytSmiG83K3RwKrrJKLx77RLTuDCxE8rx
        3nqudT7ufxcJfrii8XhWOLOJ9LvCH1fEMw53PD/88KjJMZW3SSyyTkc2Rb/Q0Xn3cwHjjvVF
        Jxdd2r3nVl4vQ0HIFqVNU/9wZ1aU5ciEO897fyn0bZGav4PGaZ4L2R1uHK8Of69tTFCzVVNT
        /nLQ63B7x93WYFHNXw09dYe/WSqxFGckGmoxFxUnAgDzk7AnxAIAAA==
X-CMS-MailID: 20220802084138epcas1p22d18382ac9a3ae0990c53e0273645755
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802084138epcas1p22d18382ac9a3ae0990c53e0273645755
References: <CGME20220802084138epcas1p22d18382ac9a3ae0990c53e0273645755@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- The double `range` is duplicated in comment, remove one.
- change `syfs` to `sysfs`

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2c..dc91d7587bbb 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -172,7 +172,7 @@ static inline bool valid_io_request(struct zram *zram,
 
 	end = start + (size >> SECTOR_SHIFT);
 	bound = zram->disksize >> SECTOR_SHIFT;
-	/* out of range range */
+	/* out of range */
 	if (unlikely(start >= bound || end > bound || start > end))
 		return false;
 
@@ -1917,7 +1917,7 @@ static int zram_add(void)
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
 
-	/* Actual capacity set using syfs (/sys/block/zram<id>/disksize */
+	/* Actual capacity set using sysfs (/sys/block/zram<id>/disksize */
 	set_capacity(zram->disk, 0);
 	/* zram devices sort of resembles non-rotational disks */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, zram->disk->queue);
-- 
2.34.1

