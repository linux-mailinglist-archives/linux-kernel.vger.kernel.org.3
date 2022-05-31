Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233B1538D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbiEaIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiEaIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:50:26 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550C8B0A5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:50:20 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220531085015epoutp03a7496471a0b2de93cc95b95b91711886~0JG18dMIO1621716217epoutp03w
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:50:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220531085015epoutp03a7496471a0b2de93cc95b95b91711886~0JG18dMIO1621716217epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653987015;
        bh=abiBOcs0Psnpx19U+MvDf9ZqzO+1gIXzNq4jEmFC7V8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ZD+QHp4SAB1PZz+ExbrNUQc4lKMNiBa0KfFiNFgvLY+yrat4z4+Kjlm3J4LxbABqA
         a/6L1uMdcw4yEoY4JbSYkk8j7/mFsJx7sGWlcx3SkYzRtwbyP+77kHqzCEgKr20f/d
         gfds1uWsXnNu8f+arfnZkAgRy7rBcD/S9UR07KD0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220531085015epcas5p49f7cea176fc4d33d6e5e9f9efee1a402~0JG1fkjx71142311423epcas5p4q;
        Tue, 31 May 2022 08:50:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LC5ZW33v9z4x9QY; Tue, 31 May
        2022 08:50:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.A2.09827.0C6D5926; Tue, 31 May 2022 17:50:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220531082758epcas5p14b2b4e7c288e8f54e4a2807eb58baf72~0IzYoc4MV0622306223epcas5p1U;
        Tue, 31 May 2022 08:27:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220531082758epsmtrp1ac6424cc510f98d7e7a741e79e168d95~0IzYnhJzh0604506045epsmtrp1J;
        Tue, 31 May 2022 08:27:58 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-37-6295d6c0518a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.EE.11276.E81D5926; Tue, 31 May 2022 17:27:58 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220531082756epsmtip1b9646edf488c456035160fa6d87a6341~0IzWky-Yt1301613016epsmtip1g;
        Tue, 31 May 2022 08:27:56 +0000 (GMT)
From:   "m.shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
Cc:     <geert@linux-m68k.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <paul@crapouillou.net>,
        <linux-fsd@tesla.com>
In-Reply-To: <4cbbd4c2-6d39-da8e-d0fc-c49ba9b8ae7d@linaro.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: iio: adc: Add FSD-HW variant
Date:   Tue, 31 May 2022 13:57:45 +0530
Message-ID: <015801d874c8$558aca70$00a05f50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIGNN21wa2G9ryxTCo9HfAX0Xxs4AGnD3ksAXAI68cCROaF1ayyRcWw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmlu6Ba1OTDCZPYLN4MG8bm8X8I+dY
        LZ7d2stk8aBpFZPFy1n32Cz2vt7KbrFk8nxWi02Pr7FaPHwVbjHvyDsWi8u75rBZzDi/j8mi
        f/ElFovWvUfYHfg8Vl9qZ/PYtKqTzePOtT1sHocOdzB6bF5S77HkzSFWj74tqxg9/jXNZff4
        vEkugDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
        6HYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGR
        KVBhQnbGyv8X2QoWcFX8bPjL3sC4hKOLkZNDQsBE4sqe26xdjFwcQgK7GSVaO9+zQDifGCU2
        r74J5XxjlFj9cB4bTMvCvhtQib2MEo+3PWODcJ4Btdw9AORwcLAJqErsuCkCEhcRmMwosfPb
        dbAOZoFJTBLrj21gBxnFKWAnsXH1IzBbWMBVYtK3P4wgNgtQ88J1bSwgNq+ApcSrn01QtqDE
        yZlPwGxmAXmJ7W/nMEOcpCDx8+kyVoi4uMTRnz1gcREBN4mmD5fAvpMQeMIhMef3GkaIBheJ
        Fx8ms0LYwhKvjm9hh7ClJF72t0HZ6RJzH/YyQdgFEst2fYeK20scuDKHBeRLZgFNifW79CHC
        shJTT61jgriBT6L39xOoVl6JHfNgbEWJ/7v7ocaIS7xbMYV1AqPSLCSvzULy2iwk78xC2LaA
        kWUVo2RqQXFuemqxaYFRXmo5PMqT83M3MYITt5bXDsaHDz7oHWJk4mA8xCjBwawkwluya2qS
        EG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4H5o68knhDE0sDEzMzMxNLYzNDJXFegf+NSUIC
        6YklqdmpqQWpRTB9TBycUg1M/TOWMs/Rdp005fJxlcxn861vHHu301S0Tlugi6s/0uDpfCXP
        JLsrM1jrtF8JKNVLFWr92f3vxJL9u9Y1GEu23rtTZtcQNSti3/+ci6vOXws7fDcq+K+5ltC9
        u1crju/qXD57qvjaXQsuaeg4bnpZzPxctj7kjJSHfEL6TlshBv4zL7boHQkONRM6xiQ0w+Zk
        zCXJGW51ViqvdL5/mKfs1JZiWG9XtDSslfPihcWi2s+PCkxMTT7mJrjSd1bGneQ5xj+nXNzu
        dezdlxcRL0ry38wsV/2io3h9x2+x/Pu7935c0sH28M//YPvefj/r68X/LZud01v3LpKU0WDh
        WjvFUq7P+URT4OHYzf7TnZPYlViKMxINtZiLihMBx6kzuWUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnG7fxalJBt/fKVg8mLeNzWL+kXOs
        Fs9u7WWyeNC0isni5ax7bBZ7X29lt1gyeT6rxabH11gtHr4Kt5h35B2LxeVdc9gsZpzfx2TR
        v/gSi0Xr3iPsDnweqy+1s3lsWtXJ5nHn2h42j0OHOxg9Ni+p91jy5hCrR9+WVYwe/5rmsnt8
        3iQXwBnFZZOSmpNZllqkb5fAlbHy/0W2ggVcFT8b/rI3MC7h6GLk5JAQMJFY2HeDpYuRi0NI
        YDejxLp/B5kgEuIS037tZ4SwhSVW/nvODlH0hFFi9YSjQAkODjYBVYkdN0VA4iIC0xklfm0/
        BDaJWWAOk8Tpm4+YITpeMko0ndoFNopTwE5i4+pH7CC2sICrxKRvf8DiLECTFq5rYwGxeQUs
        JV79bIKyBSVOznwCZjMLaEv0PmxlhLDlJba/ncMMcZ6CxM+ny1gh4uISR3/2gMVFBNwkmj5c
        Yp3AKDwLyahZSEbNQjJqFpL2BYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNX
        S3MH4/ZVH/QOMTJxMB5ilOBgVhLhLdk1NUmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FC
        AumJJanZqakFqUUwWSYOTqkGphVpTUeEqswCXPZbd9fOML3sEfVyoYrCrZMsod4v976Zfehu
        5ONwptTUqlXGeh93/N3nlMJ0Xmiy5mfzdRoKpwL0Did/0zqnWLYldJnyOQEXv+iXf1adWL1S
        T0Tre4Fd5YdpDoa2K3Zxv/mfeIJhh5Fb4hPXpGsx/6on+K37kHlkjfrStRbezWLTlO82qUUH
        Wwur/qlZI/S67vn9e2UWBp2uWut2XJ20Z8nJVa6vCr/YHzs5pfmSZYSOpM+lhgWN/0QMo77k
        thtkPVGs1thV51WsdOr6iXCd48p5Uu5JhR+acqe5LVmtrDWZV/HhvrNni0IUYlsW1K/VtWX5
        vdvDYtL3vctemJnezSoQrtboUGIpzkg01GIuKk4EAJ9xyplNAwAA
X-CMS-MailID: 20220531082758epcas5p14b2b4e7c288e8f54e4a2807eb58baf72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145759epcas5p240de0ce6d1a1bfea6c8a6bfb61c5d27d@epcas5p2.samsung.com>
        <20220520145820.67667-2-m.shams@samsung.com>
        <4cbbd4c2-6d39-da8e-d0fc-c49ba9b8ae7d@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 20/05/2022 16:58, Tamseel Shams wrote:
>> From: Alim Akhtar <alim.akhtar@samsung.com>
>> 
>> This patch adds a new compatible string for FSD-HW's ADC variant
>> 
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
>> ---
>> - Changes since v1
>> * Addressed Krzysztof's comment to use soc-specific compatible
>> 
>>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml 
>> b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
>> index 81c87295912c..ded0e3f85991 100644
>> --- 
>> a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yam
>> +++ l
>> @@ -14,6 +14,7 @@ properties:
>>      enum:
>>        - samsung,exynos-adc-v1                 # Exynos5250
>>        - samsung,exynos-adc-v2
>> +      - samsung,exynos-adc-fsd-hw

> The soc is fsd, so compatible should rather be:
> tesla,fsd-adc

> What does the "HW" mean?

Will change the compatible to "tesla,fsd-adc" in the next version.
By HW, I meant Hardware


Thanks & Regards,
Tamseel Shams

