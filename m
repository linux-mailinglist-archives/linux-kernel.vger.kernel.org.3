Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD35898DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiHDH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiHDH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:56:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B8A65578
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:56:02 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220804075600epoutp037fffc6311c7c357dc8253685fbe15a39~IFTCEEYx_1747317473epoutp031
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:56:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220804075600epoutp037fffc6311c7c357dc8253685fbe15a39~IFTCEEYx_1747317473epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659599760;
        bh=YaUFXrkk/2TN02SnQTghhwfTl7I5ajrem/rsP/HXG7c=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=uPZ/1XMxGOCIBW8nSzcBZe98Rw/G6bHPqxaoqcs6THHCHOO3A7Otu94DplQ9TMTGr
         Tuf1XU32dXp07nnnAXY8vAn7KTvUDlLCnT3jHYfEmuZnkXQ/vMdly2wp44hDe7v9ob
         FG81vlrcmmisoBzazlicZwqzMYhgepc05hahQksw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220804075600epcas2p4b4ffb9a6c1e387c762aded9bd4b4f857~IFTBt3pkd2939529395epcas2p45;
        Thu,  4 Aug 2022 07:56:00 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lz1Hz5kyDz4x9QK; Thu,  4 Aug
        2022 07:55:59 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-0a-62eb7b8f3123
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.85.09642.F8B7BE26; Thu,  4 Aug 2022 16:55:59 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 6/6] scsi: ufs: wb: Move the comment to the right
 position
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804075559epcms2p8018c0a90eb2200713ad521942715a33f@epcms2p8>
Date:   Thu, 04 Aug 2022 16:55:59 +0900
X-CMS-MailID: 20220804075559epcms2p8018c0a90eb2200713ad521942715a33f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmhW5/9eskg3ePNS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8dksXTrTUYHbo/LV7w9
        Fu95yeQxYdEBRo+Wk/tZPL6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbH94GLWgl72io2f
        ZzE1MH5n7WLk5JAQMJG4s+MwSxcjF4eQwA5Gif8bzgE5HBy8AoISf3cIg9QIC/hLzJ5zignE
        FhJQkji3ZhYjSImwgIHErV5zkDCbgJ7EzyUz2EBsEYE2Fon1p9khxvNKzGh/ygJhS0tsX74V
        rJVTwE/i/uEsiLCGxI9lvcwQtqjEzdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouKXHo0Fc2
        kJESAvkSGw4EQoRrJN4uPwBVoi9xrWMj2AW8Ar4Sk79sARvPIqAqcf1lP9RIF4lt65vAHmQW
        kJfY/nYOM8hIZgFNifW79CGmK0scucUC81PDxt/s6GxmAT6JjsN/4eI75j1hgmhVk1jUZAQR
        lpH4eng++wRGpVmIMJ6FZO0shLULGJlXMYqlFhTnpqcWGxUYw6M1OT93EyM4xWq572Cc8faD
        3iFGJg7GQ4wSHMxKIrwrLF8nCfGmJFZWpRblxxeV5qQWH2I0BXp4IrOUaHI+MMnnlcQbmlga
        mJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgMrZsXx0YtODG6/9HNjSvSY9i
        3PBC9tniuX8MprTkV/DIVS/8cYLn6TmjSh+hve82bfjY6sVSwJ3xdsa1JNuHK3medb2Z9rE0
        9Pa2kk8XHVcX/gu9V31TqLFtc7bApA1MoqI+hq/zdjp8Svt0Jqz93Mbt7hL3RUrncj3+MyG/
        quqkcZfNkSurmM5NWHT1cfokJQkbIeb2H2pXeG6xZd3YmP7ZKMDA5LB0qkDswaMsnf9XtLLJ
        Xbyb/e37L1+dgypP7BJ17k5S8gm9/bNscskffSfff/lSYju0dieV7bn2nin5Z/iUuvWq5mYx
        epWsMpfevEwuuCXau2/lxmjpjj0u/PbiCw7xB+QwfY98732qQImlOCPRUIu5qDgRALBjsZQ6
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of the comment is wrong. so fix it.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6460e3c643fa..8217a05f6f3a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1298,9 +1298,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 		}
 	}
 
-	/* Enable Write Booster if we have scaled up else disable it */
 	downgrade_write(&hba->clk_scaling_lock);
 	is_writelock = false;
+
+	/* Enable Write Booster if we have scaled up else disable it */
 	ufshcd_wb_toggle(hba, scale_up);
 
 out_unprepare:
-- 
2.25.1
