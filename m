Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08D4A4EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356878AbiAaSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:41:05 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:30917 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356741AbiAaSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:41:03 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220131184102epoutp031161ef40c8902d172dfbdfb37d5a4574~PbwZas0Gw1735617356epoutp03S
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:41:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220131184102epoutp031161ef40c8902d172dfbdfb37d5a4574~PbwZas0Gw1735617356epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643654462;
        bh=+Eb/ge6U8qUjxg2a+FfLkVgW+b7TqJ+I4nHa/jChYAQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hyecUWzEii5i7bzuDkk7K21gMlfP5kq+qGx5YYAd7ylXfjIuKZX7g4fn5emsHF6sU
         0UKnSteGucVpZoRSMCV6BypyONhRluhdSWSUkeJpmTpacPbnBUOwm/F8j8lgHj2WWM
         cAL59gk10PG+EJyfH8wMBrdxIBHLFz8LP8KuDnJ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220131184101epcas5p28175108bbc81852fac172c5dc1c22f83~PbwY8-1gN1134311343epcas5p2F;
        Mon, 31 Jan 2022 18:41:01 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JncMV74B0z4x9Pt; Mon, 31 Jan
        2022 18:40:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.AF.05590.63D28F16; Tue,  1 Feb 2022 03:40:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220131184054epcas5p35bb3491004ca6c7ceaea16d71cf6ac72~PbwSRnELA0527205272epcas5p3U;
        Mon, 31 Jan 2022 18:40:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220131184054epsmtrp1f144e4eea65586c8a5a7aa7d88865fa4~PbwSQgks80798507985epsmtrp1f;
        Mon, 31 Jan 2022 18:40:54 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-e8-61f82d36d765
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.33.08738.33D28F16; Tue,  1 Feb 2022 03:40:51 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220131184053epsmtip25d2058f1bc952c10a4e195cfbe87c92d~PbwRQqUuh1034310343epsmtip20;
        Mon, 31 Jan 2022 18:40:53 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
In-Reply-To: <164361952065.14120.582076973615108824.b4-ty@canonical.com>
Subject: RE: [PATCH 1/3] ARM: dts: exynos: update dma nodename for
 exynos3250
Date:   Tue, 1 Feb 2022 00:10:51 +0530
Message-ID: <02cb01d816d2$13f75870$3be60950$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJST+FB4v64CXjUV2A/uk/xJfagJgFYGszNAVup0+erc2XuYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ9dc90eiwYelTBbzj5xjtdj49geT
        xabH11gtLu+aw2Yx4/w+JovWvUfYHdg8ZjX0snlsWtXJ5rF5Sb3H501yASxR2TYZqYkpqUUK
        qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
        +nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZV9dtYynYy1Xx
        bFkHUwPjG44uRk4OCQETiUkHrzN2MXJxCAnsZpR4uuEJlPOJUeL16y1sEM5nRokX3xeww7Q8
        7L3MBJHYxSix/NgWVgjnJaPE95trwKrYBHQldixuA2sXEehklFj9/ScTSIJZIFbi7v7PzF2M
        HBycAh4SnbNiQcLCAv4Sz9ZtB+tlEVCR+HdoOZjNK2ApMeP7flYIW1Di5MwnLBBj5CW2v53D
        DHGRgsTPp8vAakQEnCTuvD8DVSMu8fLoEXaQGyQEOjkkOu6/Z4JocJF4ML2XFcIWlnh1fAvU
        a1ISL/vb2EFukxDIlujZZQwRrpFYOu8YC4RtL3HgyhwWkBJmAU2J9bv0IVbxSfT+fsIE0ckr
        0dEmBFGtKtH87ipUp7TExO5uqKUeEp/P/mWfwKg4C8ljs5A8NgvJA7MQli1gZFnFKJlaUJyb
        nlpsWmCcl1oOj+/k/NxNjOCUqeW9g/HRgw96hxiZOBgPMUpwMCuJ8O5d+D1RiDclsbIqtSg/
        vqg0J7X4EKMpMLQnMkuJJucDk3ZeSbyhiaWBiZmZmYmlsZmhkjjvqfQNiUIC6YklqdmpqQWp
        RTB9TBycUg1MRnsibpqJuxbaK7jv7T2kVrvc1nx3UNnv2N25jvZ9HXwvH5rOZYxUdp55rMib
        1af7pe5NF7GlBfNUn/ydY7rkpNxGsQ8+GXYSBo5Oe02v55ee5Vr0cM2Lb0/Pv//eYqcWwHN9
        u+3VKy5fp/249H/GUrs9m2I2XfyyZbnY6ziFeq4Nc4M/nuad90V0l9rThlfVTY9YY9tfJ38J
        YXvUcvFWKPOTi0rP0ngup/39a143/W42u0z5rbgrE5m19nBcOdZ96n5ZskSGeMOGgEOyl/q8
        ROQlqsJ9xRV+lrIaNP7IlVh0u7h2+v12d0FDHQ7TbdN+/d7n1v3LemrhErODYqbcjwVaVuz8
        KXpdN2XRLx8OJZbijERDLeai4kQAIZRIDSIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvK6x7o9Eg1MLRC3mHznHarHx7Q8m
        i02Pr7FaXN41h81ixvl9TBate4+wO7B5zGroZfPYtKqTzWPzknqPz5vkAliiuGxSUnMyy1KL
        9O0SuDKurtvGUrCXq+LZsg6mBsY3HF2MnBwSAiYSD3svM3UxcnEICexglFjZNIsNIiEtcX3j
        BHYIW1hi5b/nYLaQwHNGiRPPykFsNgFdiR2L29hAmkUEuhklrvTMZARJMAvES8y71MEMMfUU
        o8SBzc0sXYwcHJwCHhKds2JBaoQFfCVOL53KCmKzCKhI/Du0HGwBr4ClxIzv+1khbEGJkzOf
        sEDM1JZ4evMplC0vsf3tHGaI4xQkfj5dBlYvIuAkcef9GagacYmXR4+wT2AUnoVk1Cwko2Yh
        GTULScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBkaOltYNxz6oPeocYmTgY
        DzFKcDArifDuXfg9UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQamMycWzT0baLY87OrnnitzP+hamTcxl178wbfunp6EmcuzgztUps37e8wv16+8ejaH
        veafm+ETRfacm7Pqy8+rrJsmuHk8lMh3kX5+WuHNiaR1vEniN88mSXM12F+o8vmm+jjr2uET
        T7d1HSgU4IlrXcST0vJOxLdjlWpuybQ1uleX2/33vsA+x+hz6EkF664VuSuXuC+4d0C1bBuf
        mHHNt82HjGZMffbFi/HmIqa1Wy7M9Sxs7n0bUrnll842u4vTlvzXuKnAFurgw+smv23v0ysf
        J3LKHti45PSK0BVdB9I2nVBOYyhrEpte7ifPXK2zXysiuerEvqZu8Wc1lW/qfd+86UkufuP+
        6GPpj1v8FUosxRmJhlrMRcWJAMgQ3gULAwAA
X-CMS-MailID: 20220131184054epcas5p35bb3491004ca6c7ceaea16d71cf6ac72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220130080810epcas5p425f29e7a017b4b1690509e60651d4245
References: <CGME20220130080810epcas5p425f29e7a017b4b1690509e60651d4245@epcas5p4.samsung.com>
        <20220130075520.49193-1-alim.akhtar@samsung.com>
        <164361952065.14120.582076973615108824.b4-ty@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Monday, January 31, 2022 2:29 PM
>To: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Alim
>Akhtar <alim.akhtar@samsung.com>
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; linux-samsung-
>soc@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org
>Subject: Re: [PATCH 1/3] ARM: dts: exynos: update dma nodename for
>exynos3250
>
>On Sun, 30 Jan 2022 13:25:18 +0530, Alim Akhtar wrote:
>> Currently dma node name does not matches the pl330 dt schema and make
>> dtbs_check report below warning
>>
>> 'pdma@12680000' does not match '^dma-controller(@.*)?$'
>>
>> Update the dma node name to match pl330 dt schema
>>
>> [...]
>
>Squashed into one commit, that's a tiny change in each file.
>
Ok, Thanks Krzysztof.


>Applied, thanks!
>
>[1/3] ARM: dts: exynos: update dma nodename for exynos3250
>      commit: a5a881a33f8d6d5427a4150ee1a24a8790ada270
>[2/3] ARM: dts: exynos: update dma nodename for exynos4
>      commit: 0e1434e19717309c2c3a0770bd4ef5c3a937fe03
>[3/3] ARM: dts: exynos: update dma nodename for exynos5
>      commit: 51d6d2cb2523c3d979e94efc065a7c88a9c8dd61
>
>Best regards,
>--
>Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

