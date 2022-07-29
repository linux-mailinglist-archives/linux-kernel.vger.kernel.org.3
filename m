Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24E0584AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiG2E7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiG2E7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:59:17 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBEF7B7A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:59:15 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220729045914epoutp0115e7f3aef8c368ec26d137f801df0b23~GNA_bNYHs0800208002epoutp01U
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:59:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220729045914epoutp0115e7f3aef8c368ec26d137f801df0b23~GNA_bNYHs0800208002epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659070754;
        bh=YaD5HG56b5yJxD/KEWPhhO1TGGVsj5lqfE49GcpKrwE=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=js8RYgJ2yhX7Ifk5muuaVnw5rR7ahfersrIwj7Ct1WiL2YXTytrjT++GQQEqrR++z
         XJJ5nBT2nbVHzdM8oUnZIiBgeU/wtEOToqm5Ta86Ou+zeVCehH39SKcR8e//mMnsS5
         7mnk5uqAsBEqKbmX4tVU5PAgQDyac2nO4EgKSPXc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220729045913epcas2p1e58c1bbde95037ae2bf7db225f737423~GNA94mBC40569905699epcas2p1w;
        Fri, 29 Jul 2022 04:59:13 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LvFfn3GCQz4x9Py; Fri, 29 Jul
        2022 04:59:13 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-05-62e36921e021
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.42.09650.12963E26; Fri, 29 Jul 2022 13:59:13 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v5 6/6] scsi: ufs: wb: Move the comment to the right
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
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729045913epcms2p598edffb67d42db84526acce0a5a9ce5d@epcms2p5>
Date:   Fri, 29 Jul 2022 13:59:13 +0900
X-CMS-MailID: 20220729045913epcms2p598edffb67d42db84526acce0a5a9ce5d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmha5i5uMkg1+PJSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8fkwOVx+Yq3x+I9L5k8
        Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM81+WshYsZas4uOAHawPjLNYuRk4O
        CQETiQdHfzF3MXJxCAnsYJRY3HkcKMHBwSsgKPF3hzBIjbCAv8TEebsZQWwhASWJc2tmMYKU
        CAsYSNzqNQcJswnoSfxcMoMNZIyIwFlmiYUPpzBBzOeVmNH+lAXClpbYvnwrWC+ngJ/E9X2F
        EGENiR/LepkhbFGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLQoa9sICMlBPIlNhwI
        hAjXSLxdfgCqRF/iWsdGsAt4BXwlOjpPg9ksAqoS9zachKpxkZjz/BRYnFlAXmL72znMICOZ
        BTQl1u/Sh5iuLHHkFgvMTw0bf7Ojs5kF+CQ6Dv+Fi++Y94QJolVNYlGTEURYRuLr4fnsExiV
        ZiECeRaStbMQ1i5gZF7FKJZaUJybnlpsVGAEj9fk/NxNjOCEquW2g3HK2w96hxiZOBgPMUpw
        MCuJ8AoEPE4S4k1JrKxKLcqPLyrNSS0+xGgK9PBEZinR5HxgSs8riTc0sTQwMTMzNDcyNTBX
        Euf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cDEPWWD1vJtR1ZLWVzt4Kx4ZcSxV7XWK2wNi/Zn
        hk9f43siP8acE5z/s2Xby++mRo9ipOfucDh+2H/xpws/b32sODG9bsqcA9kaj+++0uqeY5Xs
        b8R6JVd/CfuT3ReqqkTMHhU1/wnYOme54Ufphi1yCr6/bzsxFUzX5BTp9Ki7vcXyXZtz30nP
        Z7U3s+8lrLjdrt6wVO8QT9aBxuivlxuPGLMz82g1Zmbv2n/5kGbbC3WTytxPvi68aqqpndyS
        mQIfrHqZHq7WPlG/fotMxZ1+T4WszB+/P+Rdr9b9VnPlt9zuowuM/xYm1nXJfbY9dal7tzHr
        DO29AdcKm/n63v9hnhyk+PnUFYUnJ8SuTkpUYinOSDTUYi4qTgQAY56rkjEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
        <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
        <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
        <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p5>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of the comment is wrong. so fix it.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 309f93122078..4120617ff7a6 100644
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
