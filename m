Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7A54BEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiFOAwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiFOAwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:52:05 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC624C424
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:52:02 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220615005157epoutp0410895e08ae6adb56cdf1408623ecb3d7~4pQgqmw4e0215302153epoutp04V
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:51:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220615005157epoutp0410895e08ae6adb56cdf1408623ecb3d7~4pQgqmw4e0215302153epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655254317;
        bh=u77g1GwGZYoWxR6fg/coCgMy7PXyvYHKk69Uj7aqJm8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TotdMkDK8CmU8KEhc8zfA3HUip9Bkif6VkEwlHrDCL+EWAECALGFDKYQcjbqM31vq
         Em8rnYrqSpbWZ0oMfT53GxrL3tSwUKpSELhrsID5/CJmcvIrPNssNv8tQoTSn32eO+
         1tS93XoKLlkQIvC+jfJGa0EDnr1Dv1jlyYZsWk7w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615005157epcas1p27069642b6bf9825e9785df3ae2115c00~4pQgLB18r0466904669epcas1p2j;
        Wed, 15 Jun 2022 00:51:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LN6Fm4jH0z4x9QG; Wed, 15 Jun
        2022 00:51:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.16.10063.C2D29A26; Wed, 15 Jun 2022 09:51:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220615005156epcas1p1c124873ba59260e6f94f3793ef8d3f3c~4pQfRvhA00664806648epcas1p18;
        Wed, 15 Jun 2022 00:51:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615005156epsmtrp2eddaa7ee70159dc923d741f3ba969013~4pQfQwAMp0298802988epsmtrp2S;
        Wed, 15 Jun 2022 00:51:56 +0000 (GMT)
X-AuditID: b6c32a35-1f1ff7000000274f-f5-62a92d2ce564
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.DE.11276.B2D29A26; Wed, 15 Jun 2022 09:51:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220615005155epsmtip2e8e37abe0294d2876d4fbe0ca107731a~4pQfCe6DW0333403334epsmtip25;
        Wed, 15 Jun 2022 00:51:55 +0000 (GMT)
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     snitzer@kernel.org
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [PATCH] dm verity: fixed ERROR: else should follow close brace '}'
Date:   Wed, 15 Jun 2022 09:51:51 +0900
Message-Id: <20220615005151.4907-1-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmga6O7sokg0V/lS3WnzrGbLH33WxW
        i0v377BaXN41h83ixC1pB1aPTas62Tze77vK5tG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGZcXdbEVnGWvuL/uD3sD
        Yx9bFyMnh4SAicSqBZ9Yuxi5OIQEdjBKTFvWzAqSEBL4xCgxfZUuROIbo8T8SbNYYDrurm1n
        hEjsZZR4cf4cO4TzhVGi+8cLRpAqNgFtidstm9hBbBEBMYmG6xfBbGaBPInFL9qZQWxhAW+J
        VQuvgdksAqoSl47/A1vNK2AhsffEUaht8hL7D55lhogLSpyc+YQFYo68RPPW2cwQNfvYJQ5/
        VIGwXSSe9H1jhLCFJV4d38IOYUtJfH63F+rnbInrGw5BzS+R+L6uEWgOB5BtL/H+kgWIySyg
        KbF+lz5EhaLEzt9zGSG28km8+9rDClHNK9HRJgRRoiSx4t81qIESEhsOd0Mt8pDYuekOG0i5
        kECsxNczKRMY5WcheWUWkldmIexdwMi8ilEstaA4Nz212LDAEB6jyfm5mxjByU7LdAfjxLcf
        9A4xMnEwHmKU4GBWEuGdfHFZkhBvSmJlVWpRfnxRaU5q8SFGU2DgTmSWEk3OB6bbvJJ4QxNL
        AxMzIxMLY0tjMyVx3lXTTicKCaQnlqRmp6YWpBbB9DFxcEo1MN1TEIvr+7Jw05XyfqYS1dQp
        NTn6ztPuSN7N45lvYSL4w6N1Qytnxhz5Rv7toTs4On04FzX8bL5QscNiUZLmzIa9GQbSkhtK
        4tMSFXqzulheuPodt/nbv2+x1+9Hz/wKTO/d3mBy85h+MXPrQYst3Y0n3wbFqE06YaV8Yd60
        2XuMNuh3/xET+rPQ/LpEksG92PJ5C8wPLtfa6vAszuWVWKHa1PicKgXl0xtrVRJfrODrm3bG
        +rZNVK2T095p3AoOteYZ+heui0nyTljHmDWNe8KtF7uu3uCet/PUsrcHbZO78iLznxr1M6n8
        PfTQqmbFJoHT9/esnLowM/3So5h41tYlF4K0XvVeelZ3MyuiVYmlOCPRUIu5qDgRAF/uskH/
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvK627sokg0PvLCzWnzrGbLH33WxW
        i0v377BaXN41h83ixC1pB1aPTas62Tze77vK5tG3ZRWjx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        lxd1sRWcZa+4v+4PewNjH1sXIyeHhICJxN217YwgtpDAbkaJaz+sIOISEhs2rWXvYuQAsoUl
        Dh8u7mLkAir5xCjx+9dqFpAaNgFtidstm9hBbBEBMYmG6xfBbGaBIonn+xaAzRcW8JZYtfAa
        M4jNIqAqcen4P1YQm1fAQmLviaMsELvkJfYfPMsMEReUODnzCQvEHHmJ5q2zmScw8s1CkpqF
        JLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwCGpp7mDcvuqD3iFGJg7GQ4wS
        HMxKIryTLy5LEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNT
        qoGJVdn88dZrjy6eT0g5m9Lz6CvrxPOenEt/u1j2BS3+ezfibcYqRrvn/gXiHsFfOOuv3qvd
        ccTo5sIF558fevFg9xPJ8mdl3nG7uM7GXgv8LeJ1/PS58LNu7xeFqUzuLThxZM/vuYVR3BdT
        5892Vzux4abWxfm1Uj0/+P7J/vrLcXWx5Np1Ip+n9XFdf/zg78WkXz/CL1/9onkqPfZuxxWF
        BQ8P62sbqK/nuNLcsqWKI3+7yJbD5nVffzbcf+P/95ja74unDkt71KtLih6PfuOU48lnXTQv
        r/sYy87vbRoflx7fevr5m+nW82uimWacX2Gvs3VbsvTtA/6nJWPETzz+f+NudPk+mbN7Njc0
        f+Bpfv1biaU4I9FQi7moOBEA5s5TWbACAAA=
X-CMS-MailID: 20220615005156epcas1p1c124873ba59260e6f94f3793ef8d3f3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220615005156epcas1p1c124873ba59260e6f94f3793ef8d3f3c
References: <CGME20220615005156epcas1p1c124873ba59260e6f94f3793ef8d3f3c@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch error,
ERROR: else should follow close brace '}'

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 drivers/md/dm-verity-target.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index d6dbd47492a8..75b66dd67633 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -527,11 +527,10 @@ static int verity_verify_io(struct dm_verity_io *io)
 			if (v->validated_blocks)
 				set_bit(cur_block, v->validated_blocks);
 			continue;
-		}
-		else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
-					   cur_block, NULL, &start) == 0)
+		} else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
+					   cur_block, NULL, &start) == 0) {
 			continue;
-		else {
+		} else {
 			if (bio->bi_status) {
 				/*
 				 * Error correction failed; Just return error
-- 
2.34.1

