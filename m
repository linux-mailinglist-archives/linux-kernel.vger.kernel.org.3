Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE29493CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355513AbiASPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:07:56 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53135 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355521AbiASPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:07:53 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220119150752epoutp01b87b6a4d524792b78997c083d613eecd~LtG3QAor02375323753epoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:07:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220119150752epoutp01b87b6a4d524792b78997c083d613eecd~LtG3QAor02375323753epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642604872;
        bh=TQ+FsQwiai2Dj/+nOjirxy4VgVsV7oTd5gfKNQLpgo4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QF1zZo75EVGq4Tzzmcg04zQkCfM/ufnP7N27PkSGyM1yEoz+EbE1FQ+sFWbhjUN1F
         Guay7z9fEDE3s7BesryweEWqKM17g/UUCXWiC2HdQQs90DObGu5qtspyvYrE5Nvha6
         2QI3lyjJ1YT6WhqYDkig8pcYy7oxApRZkCrhqW8Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220119150751epcas5p305e2bddab256f496fc71febbf68eaf0b~LtG2YB0co1458814588epcas5p3o;
        Wed, 19 Jan 2022 15:07:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jf8C64dPLz4x9Pr; Wed, 19 Jan
        2022 15:07:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.49.05590.14928E16; Thu, 20 Jan 2022 00:07:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220119150746epcas5p135480c5f901d25cd1a85d5bfa3ed907d~LtGxFBzs91665516655epcas5p1M;
        Wed, 19 Jan 2022 15:07:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220119150746epsmtrp25a2b096be50fb73c785f5c4b555ab7d5~LtGxCg_bw0098200982epsmtrp2L;
        Wed, 19 Jan 2022 15:07:46 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-87-61e829418f5e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.BD.29871.14928E16; Thu, 20 Jan 2022 00:07:45 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220119150742epsmtip22e012473e131fdc301c5bdcda968d414~LtGtlb63C0776207762epsmtip2M;
        Wed, 19 Jan 2022 15:07:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Arjun K V'" <arjun.kv@samsung.com>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Chandrasekar R'" <rcsekar@samsung.com>,
        "'Shashank Prashar'" <s.prashar@samsung.com>
In-Reply-To: <43e72d34-0e11-9ff6-6924-0cab62b51891@canonical.com>
Subject: RE: [PATCH v2 14/16] arm64: dts: fsd: Add initial device tree
 support
Date:   Wed, 19 Jan 2022 20:37:40 +0530
Message-ID: <000301d80d46$502ae590$f080b0b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJMmkM0C21BpYmk5XGVS3CIVixL0wHpXZBSAtdH440B6AfsdatMCgwg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATZxSdb7PZBKbRNYB8jdM2ZkYsVCCREBcLLVaGbgtOqf6g5UdxB7aE
        SUgy2aS1lI6pqbxphTJTDEIVECqg5WmTKKAh4mM6UAsiQ60PQC3yEOUhFISSrG35d86958y9
        537z8TnCeUzET9UYaL2GUkswT/Rsp79/4C7/vyip7Y6cuPD4IkrUnLKjxPOiLh7haG7lEY+r
        8wHxo7ObSzROzCNE8VINQjQN93OJJ/m3ucS9R/FEr/0YRpT0tCPEtZvTGFHROsMjLL9ZucTh
        NieP6BzP4hLl1jJADN9cwog/xs9wI33I+vJ6QC7+XQRIi6kAI5tqczDyVv95jGyuOkj2XTnE
        Jb9tqQXk8qEyHjnd9GqcZ4IqXElTybReTGuStMmpmpQIScy+xN2JoQqpLFAWRuyQiDVUGh0h
        iYqNC4xOVa9mlIg/o9TG1VIcxTCS4LfC9VqjgRYrtYwhQkLrktU6uS6IodIYoyYlSEMbdsqk
        0u2hq8L9KmXljUuornvjgUHLcdQEsrxyAZ8PcTk8ORiVCzz5QvwcgC1XCgFLngLYU9LIYckc
        gP3FZdxc4OF2jF1tR9lGG4DfmIe4LBkFMNvaAlwqDA+E1spMzNXwxnMArHu2gLgIB3ei0F4/
        4lZ54Ltg108PeC7shcdBx7lGN0bxLfByVinqwgI8DHbc+4HH4g3w6tERd52DvwGrT4xx2J3E
        cOF+tXs/bzwaVk/NAVbjC0cvOXmuwRAv9YDNJifGGqLg6ZUqwGIv+OhyC4/FIjg92Yaxp1HB
        fHsIW86AJ8u7UBa/DS/0HUNdEg7uD3+2B7Oj1sGCxRGEdQpgdqaQVW+B5skbL5ybYGFe3osr
        ktDx5BfkCNhsWRPMsiaYZU0Ay//DjgO0FrxM65i0FJoJ1YVo6M//e/AkbVoTcH+BgBgrGLo7
        FeQACB84AORzJN4C0cEHlFCQTH2RTuu1iXqjmmYcIHT12oUckU+SdvUPaQyJMnmYVK5QKORh
        IQqZxFdwLaWBEuIplIFW0bSO1v/rQ/geIhNixuCXFXu37Rl8p27fazu3ZhRYiz89O2ObLaia
        aNw6fH1iz1J0f1Fwk78x4noM8r0pwi41mFfkc69vTyv0GHj41fyssJJuzjJkFg7ZPjhdhzzc
        mJNQpOpJmP9wONtvfXvMx52iwXhH1Zle29eCve+H54aY483WxQbLsyBb7LogW0nfeqv0bmZ4
        rHNpsk3duuwz9mvMd9rqi/wA1YK32DBllaaHx9Welx9pU1YNfTLgeMVXYSwd7NhwdLNvpN/o
        juWEjtnbeX8+T7eTyyNMze4RS/DAYYvfxO/mU7fuI08PqNsr3tN9NL6ucUV5wpZs2vTutjd7
        ozXld2Yahl6aiuzO2M/4SlBGSckCOHqG+gfoPn/eiwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCSvK6j5otEg2s3rS0OvD/IYrF85S4W
        i7+TjrFbHNq8ld3i/bIeRov5R86xWmx8+4PJYsqf5UwWmx5fY7X42HOP1eLhq3CLy7vmsFnM
        OL+PyeLU9c9sFou2fmG3mHVhB6tF694j7BaH37SzWszbMZfR4vH1P2wWt9+sY3UQ9Vgzbw2j
        x+9fkxg9ZjX0snlsWtXJ5nHn2h42j81L6j2unGhi9ejbsorR41/TXHaPz5vkAriiuGxSUnMy
        y1KL9O0SuDIWN+QW/BatmLBKroFxk1AXIyeHhICJxOuT+1i6GLk4hAR2M0qcXf6OBSIhLXF9
        4wR2CFtYYuW/5+wQRc8ZJRq2rGcCSbAJ6ErsWNzGBpIQEehmlLjSM5MRJMEscI1FYvKPAoiO
        r4wSSzaeAOvgFHCUOLbiGdhYYQE/iQdHDrGB2CwCqhLH22eDreYVsJTY/3A6O4QtKHFy5hMW
        iKHaEk9vPoWzly18zQxxnoLEz6fLWEFsEQE3iWUfvkEdIS7x8ugR9gmMwrOQjJqFZNQsJKNm
        IWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOBFoae5g3L7qg94hRiYOxkOM
        EhzMSiK8UvXPEoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLg
        lGpg4k9UF1Nx5Aryv2b7+lBCXYhL97Tm00VyYRqT567L2uXf5ae9YPaOlc9MLPPWBpxZUZ++
        86dDc9Kq0kevwpflhTfVSC9/5BzQvuksa99ez1OLelm9m09PU7j3YKmEyefgC7WHeXa9P8N2
        bXerRN+MW6xXGtr8K9qlw/YymxTX7i+cKzT7XbmB5IJk2bxA74A3H5uiFXYuWXswhVs5TMFF
        ZcfpB+71XZe/ZfdO6Who3Go27eDM7sh68+vXl88X+VXMtHNGqOhS6deiT9U7av88jyqaE7HI
        OkrtW0/Zmgqm0vPF2YG/YsNPXvuuLnJIIE1m99qvWSeXfbtxhX+54+vzczTlmX+w3bu2IF8m
        VOWsEktxRqKhFnNRcSIAmFGTq3MDAAA=
X-CMS-MailID: 20220119150746epcas5p135480c5f901d25cd1a85d5bfa3ed907d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150108epcas5p2d9cd4db7cb368c2bfbd7d058eba4107c
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150108epcas5p2d9cd4db7cb368c2bfbd7d058eba4107c@epcas5p2.samsung.com>
        <20220118144851.69537-15-alim.akhtar@samsung.com>
        <43e72d34-0e11-9ff6-6924-0cab62b51891@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Wednesday, January 19, 2022 12:15 AM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; arnd=40arndb.de; linus.walleij=40linaro.org;
>catalin.marinas=40arm.com; robh+dt=40kernel.org; s.nawrocki=40samsung.com;
>linux-samsung-soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-
>fsd=40tesla.com; Arjun K V <arjun.kv=40samsung.com>; Aswani Reddy
><aswani.reddy=40samsung.com>; Ajay Kumar <ajaykumar.rs=40samsung.com>;
>Sriranjani P <sriranjani.p=40samsung.com>; Chandrasekar R
><rcsekar=40samsung.com>; Shashank Prashar <s.prashar=40samsung.com>
>Subject: Re: =5BPATCH v2 14/16=5D arm64: dts: fsd: Add initial device tree=
 support
>
>On 18/01/2022 15:48, Alim Akhtar wrote:
>> Add initial device tree support for =22Full Self-Driving=22 (FSD) SoC Th=
is
>> SoC contain three clusters of four cortex-a72 CPUs and various
>> peripheral IPs.
>>
>> Cc: linux-fsd=40tesla.com
>> Signed-off-by: Arjun K V <arjun.kv=40samsung.com>
>> Signed-off-by: Aswani Reddy <aswani.reddy=40samsung.com>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs=40samsung.com>
>> Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
>> Signed-off-by: Chandrasekar R <rcsekar=40samsung.com>
>> Signed-off-by: Shashank Prashar <s.prashar=40samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  MAINTAINERS                           =7C   8 +
>>  arch/arm64/Kconfig.platforms          =7C   7 +
>>  arch/arm64/boot/dts/Makefile          =7C   1 +
>>  arch/arm64/boot/dts/tesla/Makefile    =7C   3 +
>>  arch/arm64/boot/dts/tesla/fsd-evb.dts =7C  39 ++
>>  arch/arm64/boot/dts/tesla/fsd.dtsi    =7C 651
>++++++++++++++++++++++++++
>>  6 files changed, 709 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/tesla/Makefile
>>  create mode 100644 arch/arm64/boot/dts/tesla/fsd-evb.dts
>>  create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
>>
>
>I saw you dropped the MCT timer from DTSI. I wonder why?
>
I dropped it intentionally, as you had a comment on MCT driver changes, so =
will send later along with MCT driver fix.

>Not very happy with FSD naming (as discussed before), but board compatible
>looks reasonable. Code looks good to me:
>Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski=40canonical.com>
>
Thanks Krzysztof for all the reviews.

>Similarly to previous vendor-prefix patch, please let me know if it's expe=
cted
>me to take it. I assume no. :)
>
I am expecting this will go via your tree, but I am ok either ways. May be =
you and arm-soc maintainers (Arnd/Olof) can take the call here.

>Best regards,
>Krzysztof

