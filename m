Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD6538D36
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiEaIuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244908AbiEaIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:50:30 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB88BD27
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:50:26 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220531085021epoutp0147e4329d79faad87a147dc133761e9fb~0JG65ozt60843308433epoutp01A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:50:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220531085021epoutp0147e4329d79faad87a147dc133761e9fb~0JG65ozt60843308433epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653987021;
        bh=pipem+2mIb0W3Q/lWThM+lcOngvhQ0rBFMsAtxsUOZI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cD79ejkstpu3SXnc/nHbo3kgflWy4uamxBk33jmou0ozoT/ZvZmicyw8P1QVrPEzB
         ErFSjCRxMreuqPqFudzu5rUSBa92Dd1RKO7VvoVnPjnhuHU3q21LVqghOFBw7E+zeg
         TMy65V0wewQwoU6AcaE0ywjTpPqQHJyni5eM0tVI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220531085019epcas5p49d8271e62861164d52b6c88cbfeca9c5~0JG5oLu1U1319513195epcas5p4o;
        Tue, 31 May 2022 08:50:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LC5ZZ6LZLz4x9Q2; Tue, 31 May
        2022 08:50:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.FE.10063.3C6D5926; Tue, 31 May 2022 17:50:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220531082948epcas5p2000ccae08ac275a18bcaef74e190345b~0I0-Wh7581624816248epcas5p2w;
        Tue, 31 May 2022 08:29:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220531082948epsmtrp17281978a14b332c21f73637aeda23a90~0I0-VqBbK0673006730epsmtrp12;
        Tue, 31 May 2022 08:29:48 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-3b-6295d6c3332d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.38.08924.CF1D5926; Tue, 31 May 2022 17:29:48 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220531082946epsmtip2545cf79bf6f90a93748c6af86c3c34e8~0I09Bemwq0749507495epsmtip2g;
        Tue, 31 May 2022 08:29:46 +0000 (GMT)
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
In-Reply-To: <b5994aac-f471-52bd-e6a1-6f8cbba62d60@linaro.org>
Subject: RE: [PATCH v2 2/3] iio: adc: exynos-adc: Add support for ADC FSD-HW
 controller
Date:   Tue, 31 May 2022 13:59:43 +0530
Message-ID: <015901d874c8$97454490$c5cfcdb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIGNN21wa2G9ryxTCo9HfAX0Xxs4AIEb8M6AoyC4FAB9O8sRayo+Awg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmpu7ha1OTDBZ0mVk8mLeNzWL+kXOs
        Fs9u7WWyeNC0isni5ax7bBZ7X29lt1gyeT6rxabH11gtHr4Kt5h35B2LxeVdc9gsZpzfx2TR
        v/gSi0Xr3iPsDnweqy+1s3lsWtXJ5nHn2h42j0OHOxg9Ni+p91jy5hCrR9+WVYwe/5rmsnt8
        3iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDI
        FKgwITvj4sr17AXLWSqOnz3K2sB4iLmLkZNDQsBE4sC9aUA2F4eQwG5GiQvdlxghnE+MEpMf
        LWKFcD4zSuxe8g3I4QBrOXmFAyK+i1Fiy/7TUB3PGCUmvjnHDFLEJqAqseOmCEhcRGAyo8TO
        b9dZQBxmgUlMEuuPbWAHWc4pYCex8P0dJhBbWCBS4tv2SawgNgtQ8/rNZ5hABvEKWEqcaVQF
        CfMKCEqcnPmEBcRmFpCX2P52DtQPChI/ny5jhYiLSxz92QN2g4iAm8SNJfogayUE3nBINB5u
        YoGod5E4/HQOE4QtLPHq+BZ2CFtK4mV/G5SdLjH3YS9UTYHEsl3foeL2EgeuzGEBmc8soCmx
        fpc+RFhWYuqpdUwQJ/BJ9P5+AtXKK7FjHoytKPF/dz/UGHGJdyumsE5gVJqF5LNZSD6bheSb
        WQjbFjCyrGKUTC0ozk1PLTYtMMxLLYfHd3J+7iZGcMrW8tzBePfBB71DjEwcjIcYJTiYlUR4
        S3ZNTRLiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cCskVcSb2hiaWBiZmZmYmlsZqgkzivw
        vzFJSCA9sSQ1OzW1ILUIpo+Jg1OqgWnJndkFFY9y/UNsLz3bsUvxwNwHR+4ef6jxnKF/dTbH
        hj8rcydlGD5LUBf77lbcY39gXsAfr0UNhgt8G9y0M/QmbF+19JKqNw/TtW5ZdUVD3vRLm20T
        9N04Jy4OLtpwt3fbaxZJieoQfeP0fJ+NWkmnLyWYcl8sYGE/ohn+8VhVaW/PvTlLW6S67Pbc
        c120re7w8emlLb83d8ycUnq1WXvSQ9Ozv7KfPvvJ/UlQKsH/8ouTl5Y2zI3zcghcYcoi35LJ
        OFfbj9Vd5PrMEq0PvmZPX3x0PsmcprfiZ7BppFqke53LOw+WNac3vumKLfcyteDL+fe0+G/T
        nYyVnv+viqatnzpP+tb/eXpBZj9UipRYijMSDbWYi4oTAZAyp7ViBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSvO6fi1OTDCZ/NbR4MG8bm8X8I+dY
        LZ7d2stk8aBpFZPFy1n32Cz2vt7KbrFk8nxWi02Pr7FaPHwVbjHvyDsWi8u75rBZzDi/j8mi
        f/ElFovWvUfYHfg8Vl9qZ/PYtKqTzePOtT1sHocOdzB6bF5S77HkzSFWj74tqxg9/jXNZff4
        vEkugDOKyyYlNSezLLVI3y6BK+PiyvXsBctZKo6fPcrawHiIuYuRg0NCwETi5BWOLkYuDiGB
        HYwS074sY+xi5ASKi0tM+7UfyhaWWPnvOTuILSTwhFHixIwYkF42AVWJHTdFQHpFBKYzSvza
        fogFxGEWmMMkcfrmI2aIqS8ZJS49+s0E0s0pYCex8P0dMFtYIFzi14dlYDYL0KT1m88wgUzl
        FbCUONOoChLmFRCUODnzCQuIzSygLdH7sJURwpaX2P52DjPEcQoSP58uY4WIi0sc/dkD9piI
        gJvEjSX6ExiFZyGZNAvJpFlIJs1C0r2AkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7u
        JkZw1Gpp7WDcs+qD3iFGJg7GQ4wSHMxKIrwlu6YmCfGmJFZWpRblxxeV5qQWH2KU5mBREue9
        0HUyXkggPbEkNTs1tSC1CCbLxMEp1cBkHZh86tOhBS5rddm1b1twxNczrT3pf/FTcsqpz5k+
        bIzq9wr6/zLH1yTZHiv7/OW1Z4TlVUm/K/sWOq1Ze3FalkqEWglLbXHstJPczUo/Fn38sGd3
        bs+7XRyVK3wv+UxQn964gGe73KqHf7M1Syt5L1nn9z7Ins21auqGi5W1dkkSvgvyXl++f9gu
        dflNM+t2+Tnhc536i6T/nBMUs3Die1q+O0nX7ZW8ztzEHKv7O2M2mb6UjDNSWDf/5o/0S3cc
        1R2qP4TlrWr8d3XyFw7bEL1lC80Na1yub6kL+BfvWWA44WP+ogS9vzbNyT9Tb87rX8b+5uPD
        hKDVUzouHOcXyDvyb4rWS4fTi1QUwvqUWIozEg21mIuKEwEdbCzzSQMAAA==
X-CMS-MailID: 20220531082948epcas5p2000ccae08ac275a18bcaef74e190345b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb@epcas5p2.samsung.com>
        <20220520145820.67667-3-m.shams@samsung.com>
        <b5994aac-f471-52bd-e6a1-6f8cbba62d60@linaro.org>
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
>> Exynos's ADC-FSD-HW has some difference in registers set, number of 
>> programmable channels (16 channel) etc. This patch adds support for 
>> ADC-FSD-HW controller version.
>> 
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Signed-off-by: Tamseel Shams <m.shams@samsung.com>

>The compatible needs changing (as commented in bindings).

Sure, will change in next version 


Thanks & Regards,
Tamseel Shams

