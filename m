Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3204C6441
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiB1IA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiB1IAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:00:54 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5DD69289
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:00:11 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220228080008epoutp03386cbf34894942080ec58ce9affd1cfe~X5E0LibAn2398123981epoutp034
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:00:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220228080008epoutp03386cbf34894942080ec58ce9affd1cfe~X5E0LibAn2398123981epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646035208;
        bh=5lb/XZEA6d4myjK7HT1vCVf2lq/nLV7+u97my67yA4k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=otXQUoGcKUCXOuX1p9JtNA/sHvA+3GIBw8Tdp+6++Pw9IP/GNnmQkySkUji74WxWD
         kbjD2pyTKYT4ile8JeomQM3Nj7w66yAZYGHmMVnHDFxHY2evZLSPOkjh7ndphN7nNf
         dT+GkrkURskWE6XhcMhhhGVC59b8kohucYOeXAuY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220228080007epcas5p298df853932d6c7ad51d203ee1a730dc2~X5EzudzCO2427724277epcas5p2F;
        Mon, 28 Feb 2022 08:00:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.E6.05590.7018C126; Mon, 28 Feb 2022 17:00:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b~X4w13oz9J1138311383epcas5p1I;
        Mon, 28 Feb 2022 07:37:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220228073715epsmtrp1bea15c5a3109c1ed5f344252bc521afc~X4w120QQd2358623586epsmtrp1b;
        Mon, 28 Feb 2022 07:37:15 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-11-621c81077fdc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.77.29871.BAB7C126; Mon, 28 Feb 2022 16:37:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220228073714epsmtip165f1325c35d89b7f52219a05a50bd505~X4w0P45FU0350703507epsmtip1c;
        Mon, 28 Feb 2022 07:37:13 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v4] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Date:   Mon, 28 Feb 2022 13:07:08 +0530
Message-Id: <20220228073708.1610603-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7bCmhi57o0ySwYp7xhZz1q9hs/iwVsNi
        /cJlzBaz7z9msbi8aw6bRcvRdhaLw/PbWCwOnZzL6MDhMauhl81j56y77B4nZvxm8fiy6hqz
        R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGUs6l/MUrCAu+Lbwx6mBsb5nF2MnBwSAiYSO58f
        Yepi5OIQEtjNKLFjxkso5xOjxIHXfYwQzjdGiVVbDzLBtDSumwaV2MsoMWHvbyjnC6PEn0M3
        GUGq2AT0JFbt2sMCYosIlEr8PPiUDcRmFiiS+HKtE6xGWCBOYtONv2BTWQRUJT6sOQNm8wrY
        SZzv/8kIsU1eYual7+wQcUGJkzOfsEDMkZdo3jqbGWSxhMAtdonGny1AzRxAjovEhCXeEL3C
        Eq+Ob2GHsKUkXva3sUPUdzNKbOg+xgLhzGCU+HzwKtQ2e4knFxeyggxiFtCUWL9LHyIsKzH1
        1DomiMV8Er2/n0CDgldixzwYW1Wi5eYGVghbWuLzx48sELaHRPvFPrAjhARiJS5Me8c0gVF+
        FpJ/ZiH5ZxbC5gWMzKsYJVMLinPTU4tNC4zzUsv1ihNzi0vz0vWS83M3MYLTjZb3DsZHDz7o
        HWJk4mA8xCjBwawkwsvOKpkkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdU+oZEIYH0xJLU7NTU
        gtQimCwTB6dUA9OkNTUCnGZ/1iYVv2RL0bu1SH/rWat9WjMmbykL6rmqwLdxpq6q8PaJ/kX/
        Dn7k8ij+zj5Z1aspsXPvXimOb9sYLm08mXZuisqpU8sexPV33smtMlGXNn9Rdt7gZcSntWE8
        B64z/ZRo2Gjpt7uJv/5wsUn333kd8dueB9gkMOUemevEzH713/zTLFPmsn0t2Pru1uk1VcHh
        nR8faXVnvbn9pSrm4BqT/LdGy/zKTmrPFs2wrtaO3xPS8GTrL+5mdo+bApunx35X62t9E9OW
        I/1Vy1b4kWT7ed2U+weTK85MuVB6h+nTt1BdU41K8YaAo/8S+htX2u+p5dX6JB0Vue20E/sF
        1oMhWisO3Ume+F+JpTgj0VCLuag4EQABKqM+pgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO7qapkkgwmPNS3mrF/DZvFhrYbF
        +oXLmC1m33/MYnF51xw2i5aj7SwWh+e3sVgcOjmX0YHDY1ZDL5vHzll32T1OzPjN4vFl1TVm
        j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MpY1L+YpWABd8W3hz1MDYzzObsYOTkkBEwkGtdN
        Y+xi5OIQEtjNKHH8x2pmiIS0xM9/71kgbGGJlf+es0MUfWKU6H13GyzBJqAnsWrXHjBbRKBa
        Ytbnj0BFHBzMAiUSP/d4g4SFBWIkbk37wwpiswioSnxYc4YJxOYVsJM43/+TEWK+vMTMS9/Z
        IeKCEidnPgEbyQwUb946m3kCI98sJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIEh62W5g7G7as+6B1iZOJgPMQowcGsJMLLziqZJMSbklhZlVqUH19UmpNafIhRmoNF
        SZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTyTyO47rdS3rzzkSumhp+RrBsdWq15bop1ksu
        rOBJ66+I277obLj+mu98XzknLXFtOzfX/JFWyCN5+e11Dv1qLLFb0ttXS/X18/nVbtHpWtD7
        JHDeRCH329/E1K9Nf6jZluj19ndb2OqvViURa02vrOGbUZrS73yX/f/CmWv/ey1J1d324OHt
        r+Lnb1x+WXFx5rENFSLqV88uy1DataT99ZWyeyrekwXWW3B8PK8vJ5nFOb/G7veuXl0Pu/bO
        7RYud3pr0yZEqX2NTvI0O5W/mvvCIcZ5x9hrpBQN7s/La1NJe1VrWLSw+USELGNWo0hd58Uo
        rWW3p+bX8L01XiHG2u60urS+bKLcN5/tP7crsRRnJBpqMRcVJwIAvLmGxcoCAAA=
X-CMS-MailID: 20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b
References: <CGME20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with commit 98e35f5894cf ("printk: git rid of [sched_delayed] message for
printk_deferred") printk_deferred and printk_deferred_once requires
LOGLEVEL in argument, but checkpatch.pl was not fixed and still reports
it as warning:

WARNING: Possible unnecessary KERN_ALERT
printk_deferred(KERN_ALERT "checking deferred\n");

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v3 -> v4: v3 was dropped, because it starts reporting *_printk as
          unnecessary KERNEL_* levels as report by Joe Perches.
          dev_printk(KERN_DEBUG "foo", ...). thus fixing it with simple
          addition of deferred in same line of _ratelimited as original
          https://lkml.org/lkml/2021/8/24/91

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2653177f52d9..78053545a0d5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6312,7 +6312,7 @@ sub process {
 		}
 
 # check for logging functions with KERN_<LEVEL>
-		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
+		if ($line !~ /printk(?:_ratelimited|_once|_deferred|_deferred_once)?\s*\(/ &&
 		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
 			my $level = $1;
 			if (WARN("UNNECESSARY_KERN_LEVEL",
-- 
2.17.1

