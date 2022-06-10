Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88299545F69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbiFJIjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348073AbiFJIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:38:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865D73C738
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:36:25 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220610083623epoutp0119f060b6f6e8a538ab29e993142bcc60~3NXla0qWv0360803608epoutp01T
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220610083623epoutp0119f060b6f6e8a538ab29e993142bcc60~3NXla0qWv0360803608epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654850183;
        bh=9fygd4cJnkjRwonGKvCEIJ1MU9sletJhu01G0Yhjlos=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LOqAv/NH8Phhuf4hbAefQsjEVRTCQMEMFLTsJB4768DvfYAwOj+LI/NhxbuMedijF
         +X8fDZ/IApib5HxS+JfNC8H0erTmpx1XVBG9M6JpvD4bvInGro+XkJ7i6vuPvFr/8Q
         v2vUfJdaKiutD+1elg+TwoQPHMO1XOJr3+517iVM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220610083622epcas2p4be056a1b3bffaf8ed360d8c6183e2527~3NXk7s_rr0386403864epcas2p4S;
        Fri, 10 Jun 2022 08:36:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LKDny29mkz4x9Pq; Fri, 10 Jun
        2022 08:36:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.E8.09764.68203A26; Fri, 10 Jun 2022 17:36:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220610083621epcas2p2c447d2d66bcc8f2ca002f51c09ac93b4~3NXjmn4ir1138811388epcas2p2h;
        Fri, 10 Jun 2022 08:36:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610083621epsmtrp265ece1e7683e14aa4aca8e6c20877a54~3NXjlx1qe2000320003epsmtrp2c;
        Fri, 10 Jun 2022 08:36:21 +0000 (GMT)
X-AuditID: b6c32a46-f75ff70000002624-1b-62a3028627dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.C7.11276.58203A26; Fri, 10 Jun 2022 17:36:21 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220610083621epsmtip1c506a285cf1a99dd820d07272bbf7460~3NXjZ232P0901809018epsmtip1I;
        Fri, 10 Jun 2022 08:36:21 +0000 (GMT)
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
In-Reply-To: <20220610072924.12362-7-alim.akhtar@samsung.com>
Subject: RE: [PATCH v3 6/6] ufs: host: ufs-exynos: add support for fsd ufs
 hci
Date:   Fri, 10 Jun 2022 17:36:21 +0900
Message-ID: <004301d87ca5$296850e0$7c38f2a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFtFf96RVHhaZQrIgSilU6FuDAtQI8yMISAWhEIA6r0LZF4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmhW4b0+Ikg0l3eSwezNvGZvHy51U2
        i2svL7BbTPvwk9li/pFzrBZ9Lx4yW2x6fI3V4vKuOWwWE1Z9Y7Hovr6DzWL58X9MFou2fmG3
        aN17hN1i550TzA58HpeveHtsWtXJ5nHn2h42j81L6j0+Pr3F4tG3ZRWjx+dNch7tB7qZAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        vDgsU7CAo2Ltk80sDYwN7F2MnBwSAiYSy7fPZOli5OIQEtjBKHHp/T92COcTo8SGR4ugMt8Y
        Jbre7WeEafnavY0NIrGXUeLmqwNQVS8YJX7dXQM2mE1AX+JlxzZWkIQIyODPKz6BVTELdDJJ
        dB+5wARSxSlgK3H2zG1WEFtYIEDi/FeQDg4OFgFVidb/3CAmr4ClxK3HKiAVvAKCEidnPmEB
        sZkF5CW2v53DDHGRgsTPp8vApogIOEm07z/ECFEjIjG7s40ZZK2EwAMOiY4Jl6G+dpHY3bYU
        yhaWeHV8C5QtJfH53V42CLtYYumsT0wQzQ2MEpe3/YJKGEvMetbOCHIcs4CmxPpd+iCmhICy
        xJFbULfxSXQc/ssOEeaV6GgTgmhUlziwfToLhC0r0T3nM+sERqVZSD6bheSzWUg+mIWwawEj
        yypGsdSC4tz01GKjAiN4ZCfn525iBKdoLbcdjFPeftA7xMjEwXiIUYKDWUmEN+D2oiQh3pTE
        yqrUovz4otKc1OJDjKbAkJ7ILCWanA/MEnkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tS
        s1NTC1KLYPqYODilGpiY3np6/U1/4MlvP9+aqXjDW8u/N5d0lD/x/VtTVjP3tN+6yHlh3SlT
        rpm0mD5Tefr/xwMNjmbB5zZPXE0OcYr7tATMUV/8R3SmnFxX6uf9uVb6PBq52h2Bj+fe6d8Z
        zZoyeYLd3zK5u5WFNmV7ugQm3Oa/6LTTen7mEZFs+6cTFjes73Tm7n5n96Nqp2Gr++4Jl5Nu
        p+/22irtKRv8nDG9Sr4gxPlAqc7Um3zuiXqBrDt9NC4mfF3+fveJ2/dP1O6aLhhgt+BkO3OS
        /UIzp89T5W/Oc9i/tfJ90OfofuEKl/UtboeFQ9eKL+BT927+alehe+Hd0xfX1wtLX4uNXMd5
        eOvWnFTe2U8PLfmvMU2JpTgj0VCLuag4EQC7G8WDWgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSnG4r0+IkgxcLJSwezNvGZvHy51U2
        i2svL7BbTPvwk9li/pFzrBZ9Lx4yW2x6fI3V4vKuOWwWE1Z9Y7Hovr6DzWL58X9MFou2fmG3
        aN17hN1i550TzA58HpeveHtsWtXJ5nHn2h42j81L6j0+Pr3F4tG3ZRWjx+dNch7tB7qZAjii
        uGxSUnMyy1KL9O0SuDJeHJYpWMBRsfbJZpYGxgb2LkZODgkBE4mv3dvYuhi5OIQEdjNK9D7/
        zQyRkJV49m4HVJGwxP2WI6wQRc8YJWa+f8YIkmAT0Jd42bENLCEisIdRom3eKXYQh1lgMpPE
        pIavLBAt+xkljtw4BjaLU8BW4uyZ26wgtrCAn8Sp+S1Aozg4WARUJVr/c4OYvAKWErceq4BU
        8AoISpyc+YQFxGYW0JZ4evMplC0vsf3tHKhLFSR+Pl0GNlFEwEmiff8hRogaEYnZnW3MExiF
        ZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwvGpp7mDc
        vuqD3iFGJg7GQ4wSHMxKIrwBtxclCfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEk
        NTs1tSC1CCbLxMEp1cC0qMTdfnV7yt/+q1Jy4Q90900SOXOh/dT7QOn1M6MX30s/IBkdrhPN
        7vZrW9OPWY8FhJVOhjeoPp9eW/N9+tSkstNLpN/OjtO5+Vw063cYj6r0xuynpUezPXrZwybw
        V1qGNv3tV4vl3ZDremUBa/qDwvQpJa8Wbluy0nzhx7rli8PSdxlc3KbC7Kj5eL7/hbWz5Kaf
        2/KA/52SUvTGI/tFF7Gqndb93N/jeiJpQltP3vZJIZkWBncenmpoiSj777/2w53ANteMFT98
        juycz/D6mo/73vWLLKPfNllot6266DEj1oavx33vgrQaBU3GuH9PTlp12u6w9gqbeLSOpUHr
        xJuXrjuqK6U6fV+kx8opsRRnJBpqMRcVJwIAwab3HUYDAAA=
X-CMS-MailID: 20220610083621epcas2p2c447d2d66bcc8f2ca002f51c09ac93b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950@epcas5p2.samsung.com>
        <20220610072924.12362-7-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v3 6/6] ufs: host: ufs-exynos: add support for fsd ufs hci
> 
> Adds support of UFS HCI which is found in Tesla Full Self-Driving (FSD)
> SoC.
> 
> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/ufs/host/ufs-exynos.c | 140 ++++++++++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-exynos.h |   1 +
>  2 files changed, 141 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index cc128aff8871..19068605d9fe 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -146,6 +146,10 @@ enum {
>  #define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER1	0x0A8
>  #define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER2	0x0AC
> 
> +#define DME_POWERMODE_REQ_REMOTEL2TIMER0	0x78B8
> +#define DME_POWERMODE_REQ_REMOTEL2TIMER1	0x78BC
> +#define DME_POWERMODE_REQ_REMOTEL2TIMER2	0x78C0

They look mismatch naming with previous definitions.
UNIPRO_DME_POWERMODE_*

Best Regards,
Chanho Park

