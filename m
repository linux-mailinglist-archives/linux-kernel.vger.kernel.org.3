Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350494E6F70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355013AbiCYIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347696AbiCYIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:30:42 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B16A15A3C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:29:04 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220325082901epoutp031a8ca8a9d529aa5f82dd6da5261c1c78~fkmKxX5F83084930849epoutp039
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:29:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220325082901epoutp031a8ca8a9d529aa5f82dd6da5261c1c78~fkmKxX5F83084930849epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648196941;
        bh=Re/TJcn/hkcuVtvC+CeTUXUbyr+ZF2q96RY2064Azww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3+j4JWyK9nzUSWu3gveL5Wozp0azuTdfyFfy+UJ59foqKzgLNryZ73jTbRdV/WKj
         USvBrTj/tgYE68TqDHMP3SSz/Aldtu8cbxTCfZRIbFXhgUyrC8DU///ighpuH+Kq32
         7i+kVH+iS3v1PGya5fEGKKkXvPjSwnGOfs9ZspgA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220325082900epcas2p174856821de343cce2dba2ce1984f8553~fkmKEasM10990509905epcas2p1N;
        Fri, 25 Mar 2022 08:29:00 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KPwGz1H6yz4x9QN; Fri, 25 Mar
        2022 08:28:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.25.16040.A4D7D326; Fri, 25 Mar 2022 17:28:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220325082858epcas2p41c0918b1cacce09eaa5f7ffe84d9f994~fkmITmKSO2361223612epcas2p4K;
        Fri, 25 Mar 2022 08:28:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220325082858epsmtrp21a3ca25db3d3f744b115732b2a57275f~fkmISm2dH0602206022epsmtrp22;
        Fri, 25 Mar 2022 08:28:58 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-81-623d7d4a139c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.74.29871.A4D7D326; Fri, 25 Mar 2022 17:28:58 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220325082858epsmtip29d36d20e5b35dba8ac07769bbd479a7f~fkmIGF5HD3042030420epsmtip2H;
        Fri, 25 Mar 2022 08:28:58 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v2] scsi: ufs: unipro: add to define HS-Gear5 mode
Date:   Fri, 25 Mar 2022 05:14:10 +0900
Message-Id: <20220324201410.59187-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <sc.suh@samsung.com;>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmua53rW2SwYkTTBYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEZVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+NZ1xHW
        gi72irOvX7A3MF5h7WLk5JAQMJG4fKiDsYuRi0NIYAejxLo5B9ghnE+MEi/bnjJBON8YJU68
        XcYO0zJ90VGolr2MEg8f7oBq+QHUP3UCG0gVm4CGxJpjh8DaRQRWMEn0bPrEBJJgFlCT+Hx3
        GQuILSzgJHHh4AqwS1gEVCX6ty4Ca+YVsJR4/HYTG8Q6eYlFDb/BejkFlCTen3rLDFEjKHFy
        5hMWiJnyEs1bZzODLJMQWMshsaphMtStLhKnV+5ihLCFJV4d3wIVl5L4/G4v1IJiiR9vVjNB
        NDcwSixtP8YMkTCWmPWsHaiZA2iDpsT6XfogpoSAssSRW1B7+SQ6Dv9lhwjzSnS0CUE0Kkmc
        mXsbKiwhcXB2DkTYQ6Kl8SULSFhIoFRi8VHtCYwKs5D8MgvJL7MQti5gZF7FKJZaUJybnlps
        VGAEj+Dk/NxNjOAUrOW2g3HK2w96hxiZOBgPMUpwMCuJ8N6/bJ0kxJuSWFmVWpQfX1Sak1p8
        iNEUGNITmaVEk/OBWSCvJN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwen
        VANT8OzyL0sS4vxOrFE9I/FizoMFs46p/1xWsT7odvbEJ6f+pO97s8CH1eLBr3fuO0vDdpR3
        Bzr7KMpucb9dNoHFvJnzVp/p+6kxUXWrea9oydjdbdz+/uS6D60+WXc2z1te47QsceGF8yLP
        tNaZNv/nmbX0dWywffH33qIdy48V1ibnWit/F2edMuea7+W+qzbH/RWbCs9XNzJq3P4pW2cR
        JObZvvfRxHVaoUp3HsxdN/N2Zxjfp4BzYk1lOjKaf34UHfy9rSfGWVpVdL38kn9Kp9crRGR+
        2Lo25jL3k+70aYufSjGsnVvwfErv7LZ10pWz40z9Cq5phk4Qsziroah0LbHGuiR336XHDx9J
        /+s8psRSnJFoqMVcVJwIAAzb9vRKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK5XrW2SweX7chYP5m1js9jbdoLd
        4uXPq2wWBx92slh8XfqM1WLah5/MFp/WL2O1WL34AYvFohvbmCxubjnKYnF51xw2i+7rO9gs
        lh//x+TA63H5irfH5b5eJo8Jiw4wenxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAEcVlk5Ka
        k1mWWqRvl8CV8azrCGtBF3vF2dcv2BsYr7B2MXJySAiYSExfdJSxi5GLQ0hgN6PE8jvTGCES
        EhL/FzcxQdjCEvdbjrBCFH1jlOiYsI4dJMEmoCGx5tghJpCEiMA2Jom7H06ygSSYBdQkPt9d
        xgJiCws4SVw4uAJsHYuAqkT/1kVgNbwClhKP325ig9ggL7Go4TfYNk4BJYn3p94yg9hCAooS
        39auY4KoF5Q4OfMJC8R8eYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJu
        cWleul5yfu4mRnDEaGnuYNy+6oPeIUYmDsZDjBIczEoivPcvWycJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwMQqFbv6/+3vP6V1JJrfax6b9iNgmZP1
        Qc9Jlo4HVle/Wi1/xkrvWgpzVJhT37V/v5+de/PaLO1Jbs/MqMjA2zFdpgmGZx7trvJlnHTO
        +dkBc+6d5abfYvK8rfbY7mrT4W9Y7La5K7DlHD9LnHwtx7twxo07bwRO4JEU7VleZbhJfpJV
        b/ncQAaFw8rPHX7s2LXB/8Nr1pPSZ1h+LVfdapV6f67hFduyM5NiF/+v6fm+ibX+G+PSE891
        OfU+BBl1RF8SF79ybvONrPM2TH5Zfacf9Hx+yt8rMXndhbQjb3s2b5Rbzr2i7uoeaW0VAcW2
        C6t2bLn3MeTz0Zxw3hPOfNz+X3O3OBXPb//Cd3rV5yIlluKMREMt5qLiRADl6LMWBwMAAA==
X-CMS-MailID: 20220325082858epcas2p41c0918b1cacce09eaa5f7ffe84d9f994
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220325082858epcas2p41c0918b1cacce09eaa5f7ffe84d9f994
References: <sc.suh@samsung.com;>
        <CGME20220325082858epcas2p41c0918b1cacce09eaa5f7ffe84d9f994@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS devices support HS-Gear5 mode with UFS4.0 spec.
However there is no definition of HS-Gear5.
So added it in unipro header

- there is no another mainline need to changed for
support GEAR5 with UFS4.0 spec.
It just need to check if the device supports HS-gear5.
And send to PMC command to changed HS-gear5.
It is a definition to check if the device supports
- delete change-id

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/scsi/ufs/unipro.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h
index 8e9e486a4f7b..0d2131e1f027 100644
--- a/drivers/scsi/ufs/unipro.h
+++ b/drivers/scsi/ufs/unipro.h
@@ -231,6 +231,7 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G2,		/* HS Gear 2 */
 	UFS_HS_G3,		/* HS Gear 3 */
 	UFS_HS_G4,		/* HS Gear 4 */
+	UFS_HS_G5,		/* HS Gear 5 */
 };
 
 enum ufs_unipro_ver {
-- 
2.26.0

