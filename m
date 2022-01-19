Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4B493BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355136AbiASOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:20:53 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:61274 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355120AbiASOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:20:44 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220119142042epoutp036710a9589730886c87e2609f21554fb4~LsdrSKRmh1606616066epoutp03B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:20:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220119142042epoutp036710a9589730886c87e2609f21554fb4~LsdrSKRmh1606616066epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642602042;
        bh=4qL0yRrULLmNIEl412+YEXG4c2EwToRqCrIChVLN3+Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Yzx/VxJmIRdpM9cYAVChukcMv1DaGlc4WEo4dbe+S2W8xsC0MWgsuomIEfps9Kcv4
         G9CUn3c8VGFFF+N75mp6dzfy5InXRYSHmZp3bxhCA0qnBjkB2HaVAzaMXVl7s5indS
         ObTvGPmNhuA8FxQvPKa60m2oAhv6FteFugBndI1Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220119142041epcas5p4632352421438a660e135e8f436aac254~LsdqmW1Z32350623506epcas5p4-;
        Wed, 19 Jan 2022 14:20:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jf78g36vJz4x9Pp; Wed, 19 Jan
        2022 14:20:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.09.46822.EAD18E16; Wed, 19 Jan 2022 23:18:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220119142034epcas5p4ad309b4bd15e1e543e6e48a10094a484~LsdkInGHq2350623506epcas5p41;
        Wed, 19 Jan 2022 14:20:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220119142034epsmtrp2328325c777abd047582360f072323f33~LsdkDCYMM0560305603epsmtrp2h;
        Wed, 19 Jan 2022 14:20:34 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-9f-61e81dae8d21
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.8C.08738.23E18E16; Wed, 19 Jan 2022 23:20:34 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220119142032epsmtip11d253309fcdfb6e944dde5737090c025~LsdhvPbSq0858208582epsmtip1k;
        Wed, 19 Jan 2022 14:20:32 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Jayati Sahu'" <jayati.sahu@samsung.com>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>
In-Reply-To: <b35fa0ff-18a0-2a9d-5a1b-378ef2fef66f@canonical.com>
Subject: RE: [PATCH v2 04/16] clk: samsung: fsd: Add initial clock support
Date:   Wed, 19 Jan 2022 19:50:30 +0530
Message-ID: <000001d80d3f$b8f9a9a0$2aecfce0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJMmkM0C21BpYmk5XGVS3CIVixL0wHiE8L7AdsaVJICW3JNAatQhUfA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMJsWRmVeSWpSXmKPExsWy7bCmpu462ReJBpO+G1kceH+QxeLvpGPs
        Fu+X9TBazD9yjtXiyKklTBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMDV8/sRR8FanYd/8eUwPjY8EuRk4OCQETiXMv
        21m6GLk4hAR2M0qsO3CBCcL5xCjR8PQFM4TzmVHi4/3drF2MHGAtT29bQcR3MUrsO36RDcJ5
        ySjxbMFyRpC5bAK6EjsWt4ElRAQ6GSVWf/8JNpdZYCKzxO/VB1hBqjgFHCVuXL0IZgsLeEm0
        HtrABGKzCKhKvO56yQJi8wpYSjQu2M4KYQtKnJz5BCzOLKAtsWzha2aILxQkfj5dBlYjIuAm
        MaNxOVSNuMTLo0fYIWraOSV+PEuFsF0kplxYyAphC0u8Or4FqkZK4vO7vWwQb2ZL9OwyhgjX
        SCydd4wFwraXOHBlDgtICbOApsT6XfoQm/gken8/YYLo5JXoaBOCqFaVaH53FapTWmJidzfU
        Ug+JVcefs09gVJyF5K9ZSP6aheT+WQjLFjCyrGKUTC0ozk1PLTYtMMpLLYfHd3J+7iZGcGrX
        8trB+PDBB71DjEwcjIcYJTiYlUR4peqfJQrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGB2
        ySuJNzSxNDAxMzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1Oqgcm6UEEw+v78jZbW
        ubcmPmBmTc///nmydCADw8KVqzq3dk268y+eR6V0bejeVzN+N61+qPagIrG/S+Yxw6/vSQoV
        KevyJsxibJu8XF7prPKzg+dXsW54tdLkWNjPFYq19fMtNf4KCp6PNf7381rV/PYqvSMytnpy
        D+KLl9geXHxTLUPq2If07UtSMti23f77slxj/6Srvj6e5Yv1Yq0jv/ht2Xz12WHxx986vs/e
        G/ZzmgJr0JOYdUXGxU8CvrpomTnqMQZWOe448fN4rPOlGwLcvheCH8+4sc5l7ZOgNbxy84I8
        Rc/P/SN19ILl5Ss656WSsg0eTtmWxFs8JYVvZ5D+0aLGrbduLa2o25947MEqJZbijERDLeai
        4kQAqmyb4XYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnK6R3ItEg11X1C0OvD/IYvF30jF2
        i/fLehgt5h85x2px5NQSJouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCuKyyYlNSezLLVI3y6BK2P9qm1MBetEKrb0HmVr
        YJwm2MXIwSEhYCLx9LZVFyMXh5DADkaJx9daWbsYOYHi0hLXN05gh7CFJVb+e84OUfScUeLP
        z59gCTYBXYkdi9vYQBIiAt2MEld6ZjKCOMwCC5kl5iz9zAbR8oVR4sTJf2AtnAKOEjeuXgTb
        ISzgJdF6aAMTiM0ioCrxuuslC4jNK2Ap0bhgOyuELShxcuYTsDizgLbE05tP4exlC18zQ9yn
        IPHz6TKwehEBN4kZjcuhasQlXh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsW
        GOWllusVJ+YWl+al6yXn525iBEe5ltYOxj2rPugdYmTiYDzEKMHBrCTCK1X/LFGINyWxsiq1
        KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGppQ6kaID13SOfHi9hsPD
        K6N2A8vl3OTVM8sn/N/+Iawh6cqND12LeBjsu64n1YuVXZfYvyrD/LBLdMrboqeqd/uMjHs2
        nF5U/XDa9q3vtCcd2LiVn5VZ72SUofzU4ssBHp71YZnzn+nZhXyad2LZ6r+L501hVy1r69Lf
        yjCb5WFKLFNfxLelPFub3ky6ERKqmbE2cYlntPfZVb2z+FVyWL5K/Hh6JH1u/qO5q6dsvTnp
        9NP8BeUKF9IumId02zzidqw4sCNnz7qzyxVmXGA9812u/eKjzza3VCrEp65bLySwvHfay4g7
        /SwK8i1qwRFH5/iotB1/Frjp7dmAnwIiHXrxuy1MZpzoktmx4XtSX68SS3FGoqEWc1FxIgAV
        ty7YYQMAAA==
X-CMS-MailID: 20220119142034epcas5p4ad309b4bd15e1e543e6e48a10094a484
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150028epcas5p282c05b78f28a9b11d46da94e78330f0c
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150028epcas5p282c05b78f28a9b11d46da94e78330f0c@epcas5p2.samsung.com>
        <20220118144851.69537-5-alim.akhtar@samsung.com>
        <b35fa0ff-18a0-2a9d-5a1b-378ef2fef66f@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Wednesday, January 19, 2022 12:01 AM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; arnd=40arndb.de; linus.walleij=40linaro.org;
>catalin.marinas=40arm.com; robh+dt=40kernel.org; s.nawrocki=40samsung.com;
>linux-samsung-soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-
>fsd=40tesla.com; Jayati Sahu <jayati.sahu=40samsung.com>; Ajay Kumar
><ajaykumar.rs=40samsung.com>
>Subject: Re: =5BPATCH v2 04/16=5D clk: samsung: fsd: Add initial clock sup=
port
>
>On 18/01/2022 15:48, Alim Akhtar wrote:
>> Add initial clock support for FSD (Full Self-Driving) SoC which is
>> required to bring-up platforms based on this SoC.
>>
>> Cc: linux-fsd=40tesla.com
>> Signed-off-by: Jayati Sahu <jayati.sahu=40samsung.com>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs=40samsung.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  drivers/clk/samsung/Kconfig   =7C   7 +
>>  drivers/clk/samsung/Makefile  =7C   1 +
>>  drivers/clk/samsung/clk-fsd.c =7C 308
>++++++++++++++++++++++++++++++++++
>>  drivers/clk/samsung/clk-pll.c =7C   1 +
>>  drivers/clk/samsung/clk-pll.h =7C   1 +
>>  5 files changed, 318 insertions(+)
>>  create mode 100644 drivers/clk/samsung/clk-fsd.c
>>
>> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
>> index 0e18d6ff2916..11587eb87fc4 100644
>> --- a/drivers/clk/samsung/Kconfig
>> +++ b/drivers/clk/samsung/Kconfig
>> =40=40 -124,3 +124,10 =40=40 config S3C2443_COMMON_CLK
>>  	help
>>  	  Support for the clock controller present on the Samsung
>>  	  S3C2416/S3C2443 SoCs. Choose Y here only if you build for this SoC.
>> +
>> +config TESLA_FSD_COMMON_CLK
>> +	bool =22Tesla FSD clock controller support=22 if COMPILE_TEST
>> +	depends on COMMON_CLK_SAMSUNG
>> +	help
>> +	  Support for the clock controller present on the Tesla FSD SoC.
>> +	  Choose Y here only if you build for this SoC.
>
>The clock drivers Kconfig is organized in a way, that platform should sele=
ct only
>COMMON_CLK_SAMSUNG (first comment in a file), so let's keep it consistent
>also for FSD. =22select TESLA_FSD_COMMON_CLK if ARM64 &&
>ARCH_TESLA_FSD=22 and skip the select in Kconfig.platform in following pat=
ch.
>
Thanks Krzysztof for a quick review.
Will incorporate above in the next set.

>
>Best regards,
>Krzysztof

