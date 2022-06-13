Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6627A547FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiFMGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiFMGyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:54:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C81140D3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:54:34 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220613065432epoutp022ab9f7df6313929947f66c48583f227f~4G6hTlo3A0639906399epoutp02H
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220613065432epoutp022ab9f7df6313929947f66c48583f227f~4G6hTlo3A0639906399epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655103272;
        bh=2tnnAu4jOqhkj0fxxtPuGPJ2fJuRLGJoMiIlqPlRKnw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DVKFj/cZHBJm1lHat5lPSkYxM19ND43aXD2iqJM7UMo1OfHzxpNSFBaU8XgWE3//w
         TZDvWWZu0od74qKZSTjhusarGoLnzaQVNP38MrKKl1NE5cqWscrLSlhVZHQHlKjiKi
         FqYZJ2NEyQ1oyqxVVIIe/O3w5TyUkgwll0r7+vLA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220613065432epcas2p22b387045c4356e6243296137617fd970~4G6gzJuPS0247802478epcas2p2F;
        Mon, 13 Jun 2022 06:54:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LM2P367RLz4x9QD; Mon, 13 Jun
        2022 06:54:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.17.09694.72FD6A26; Mon, 13 Jun 2022 15:54:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220613065431epcas2p45b77070a453d3d65704a6ba6f8720f50~4G6fpj64a0187501875epcas2p4D;
        Mon, 13 Jun 2022 06:54:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220613065431epsmtrp17d4aa36f32aa58317b7987c2c4d6dc00~4G6focD4W2153621536epsmtrp1H;
        Mon, 13 Jun 2022 06:54:31 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-5d-62a6df2761c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.20.08924.62FD6A26; Mon, 13 Jun 2022 15:54:30 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220613065430epsmtip1a5afeb0db5342870256a41b410415fd7~4G6fZ3coT1340613406epsmtip1d;
        Mon, 13 Jun 2022 06:54:30 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <pankaj.dubey@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <20220610104119.66401-7-alim.akhtar@samsung.com>
Subject: RE: [PATCH v4 6/6] ufs: host: ufs-exynos: add support for fsd ufs
 hci
Date:   Mon, 13 Jun 2022 15:54:30 +0900
Message-ID: <000001d87ef2$6e853a40$4b8faec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEGezFsbNu8B074Ncmz/1JauiaDCQMwSXY4AgzYL5auxwUn0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmma76/WVJBjvWGlo8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF/CPnWC36Xjxkttj0+BqrxeVdc9gsJqz6xmLRfX0Hm8Xy4/+YLBZt/cJu
        0br3CLvFzjsnmB34PC5f8fbYtKqTzePOtT1sHpuX1Ht8fHqLxaNvyypGj8+b5DzaD3QzBXBE
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2tpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO
        +DTvH2vBZ6aKdZ9WsTYwrmfqYuTkkBAwkThw4Q5LFyMXh5DADkaJm09bWSGcT4wS8z5PYYdw
        PjNKXJzwmxGmZdKkDqiWXYwSt1+/h6p6wSgx5/9eVpAqNgF9iZcd28BmiYAM/rziE1gLs0An
        k0T3kQtg6zkFbCVObLnFDGILCwRITFp8B8xmEVCVWHu+D2wfr4ClxOfbk6FsQYmTM5+wgNjM
        AvIS29/OYYa4SUHi59NlQNs4gLY5SXz5Yg9RIiIxu7ONGWSvhMAdDokTm3ewQtS7SCxZ8R6q
        V1ji1fEt7BC2lMTL/jYou1hi6axPTBDNDYwSl7f9YoNIGEvMetbOCLKMWUBTYv0ufRBTQkBZ
        4sgtqNP4JDoO/2WHCPNKdLQJQTSqSxzYPp0FwpaV6J7zmXUCo9IsJI/NQvLYLCQfzELYtYCR
        ZRWjWGpBcW56arFRgQk8upPzczcxgtO0lscOxtlvP+gdYmTiYDzEKMHBrCTCO/nisiQh3pTE
        yqrUovz4otKc1OJDjKbAoJ7ILCWanA/MFHkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tS
        s1NTC1KLYPqYODilGpgOfnh1QmVvGM/mpUvllVdecBA7kpbddu7mvaiOrf2TBc0NH9wWuFVv
        5trNddpxz36vqQK76qoP6LCtFd4zOT7rnu8Mv/C7cQyTXDjMa69Vh1wpLNxquuBje33bmXml
        XUGvdyfHvf5rJerZxr3z8rdZ54p/bd9svOexn7i3zueLG7ySLwQKGme4GIZeTj+QNmnF96k3
        z6S/TTJNfyV2Jy+wQz1EKvVxUVKw7xwhBcXTc8KN/M8WGPkJvty6Xew+v8LDrqVZJ5T/rW0s
        KV/yoWXp0jWKSUt9pXK35YilvRaSzplokiytcr5EyPr6bKa4hF2XjpcbtopfXR5m8WPT/FOf
        Nbi+ctZd0cxSO10mfFyJpTgj0VCLuag4EQCOcl/gXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnK7a/WVJBmfnW1g8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF/CPnWC36Xjxkttj0+BqrxeVdc9gsJqz6xmLRfX0Hm8Xy4/+YLBZt/cJu
        0br3CLvFzjsnmB34PC5f8fbYtKqTzePOtT1sHpuX1Ht8fHqLxaNvyypGj8+b5DzaD3QzBXBE
        cdmkpOZklqUW6dslcGV8mvePteAzU8W6T6tYGxjXM3UxcnJICJhITJrUwdLFyMUhJLCDUeLu
        wQYWiISsxLN3O9ghbGGJ+y1HWCGKnjFKzOvfyAaSYBPQl3jZsQ0sISKwh1Gibd4pdhCHWWAy
        k8Skhq9Qc/czSnQ0nGEEaeEUsJU4seUWM4gtLOAn8X3NRrAdLAKqEmvP94HV8ApYSny+PRnK
        FpQ4OfMJ2E3MAtoST28+hbLlJba/ncMMcZ+CxM+ny4DO4AA6w0niyxd7iBIRidmdbcwTGIVn
        IZk0C8mkWUgmzULSsoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDMamntYNyz
        6oPeIUYmDsZDjBIczEoivJMvLksS4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklq
        dmpqQWoRTJaJg1OqgWnaTJM+k04tWXm7u1+P3NixgkeFs+7TSrO31ruvaR/J2V3z9cj7Xs5W
        /ujZB3g56kNSb87dy7XY3Gcdf2Jm2iqm/Iz5Vp0ZM79eevxETCoyJ+jD7L5KH6cDe1pihdjV
        EuzXKs17lfCK70Jf6pYpp/au+F7KWMErU+a5Zf0trdcr9d75JCrUlFwPX1lrtNnR89qNmeqq
        RvPjOwRSfm63KzBR6b4Xp8Ks9eHFBLcVT71E7igu2KiZdi8jaMoiRjXFj9bvfQvKt9oaTGeu
        mXHvoWTu3V88Ew/9kVZes9dxTXDgDrXd62rOv37Lve+tjRdfdF+5V9fG0DNx/NdPFLRkFc6d
        7sTwf1tFmaEoQ9DVN0osxRmJhlrMRcWJAGcbnpVIAwAA
X-CMS-MailID: 20220613065431epcas2p45b77070a453d3d65704a6ba6f8720f50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104359epcas5p17a61f0254148bc1bdb15d91ff6b3f12c
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104359epcas5p17a61f0254148bc1bdb15d91ff6b3f12c@epcas5p1.samsung.com>
        <20220610104119.66401-7-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v4 6/6] ufs: host: ufs-exynos: add support for fsd ufs hci
> 
> Adds support of UFS HCI which is found in Tesla Full Self-Driving (FSD)
> SoC.
> 
> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

