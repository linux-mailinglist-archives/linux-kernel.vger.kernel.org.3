Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7A4BCE72
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiBTMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:23:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbiBTMXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:23:55 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F77753B77
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:23:32 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220220122323epoutp0381182055536e67137d45755225d97d48~VfgYpSP-I2992329923epoutp03y
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220220122323epoutp0381182055536e67137d45755225d97d48~VfgYpSP-I2992329923epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645359803;
        bh=xsUVQh3weFbhZe5BBUOwKpwtKfhT0PfFLVuSXIs/6OA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HCoIjOwbTuNLQ7AhKjzVG/H24NIauOOSMQVOk2tMgGozXA/u4yUk0KUOVipDy7+EP
         s0SPdTng6qhCk3Z42+Br3TMyrh6T2IKIb/jBqjM5CzaG0WSXrEXije37ZtOOo7oz+T
         FjeYCK36loA1UwnNrUo0Ki961IXkzIGaT4B2KdA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220220122322epcas5p34a431fce6a717223949300ea6ebb33e1~VfgXaocZw1315013150epcas5p3p;
        Sun, 20 Feb 2022 12:23:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K1l2Z2d1Lz4x9Pq; Sun, 20 Feb
        2022 12:23:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.FB.05590.6B232126; Sun, 20 Feb 2022 21:23:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220220122317epcas5p3ff8910d18d8f6aa924f3b6130f869c77~VfgSi_HNa1315013150epcas5p3o;
        Sun, 20 Feb 2022 12:23:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220220122317epsmtrp128e0cdd103bcc6c0f6d5b5c993e06548~VfgSiJ_nl0066700667epsmtrp1s;
        Sun, 20 Feb 2022 12:23:17 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-0c-621232b67697
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.10.08738.5B232126; Sun, 20 Feb 2022 21:23:17 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220220122315epsmtip139d1b9cd8e6fce2f64244607542ded0c~VfgRUVtuB1849018490epsmtip1W;
        Sun, 20 Feb 2022 12:23:15 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <linux-samsung-soc@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <pankaj.dubey@samsung.com>,
        <m.szyprowski@samsung.com>
In-Reply-To: <72848f6c-adc7-2d36-edcd-9a5fac655bbc@canonical.com>
Subject: RE: [PATCH] clocksource/drivers/exynos_mct: Remove mct interrupt
 index enum
Date:   Sun, 20 Feb 2022 17:53:20 +0530
Message-ID: <0a0201d82654$a6eae570$f4c0b050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEXBP1woSFOUEXaM7x+Nv8ayDIoJwJcL7PpAlCY7tit+TN4gA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhu42I6EkgydNvBbzPstabHz7g8li
        0+NrrBaXd81hs5hxfh+Txdojd9ktFm39wm6xedNUZgcOj1kNvWwed67tYfN4d+4cu8fmJfUe
        fVtWMXp83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvjwLLzjAX90hU7H/1gamCcI9bFyMkhIWAise/hNKYuRi4OIYHdjBKnfq9i
        gXA+MUrM2feWHcL5zChx8e0+ZpiWjTMOs0EkdjFKrNs+gxXCeckosbi/jQmkik1AV2LH4jaw
        KhGBTkaJ1d9/gm1hFpjCKHF2wjOwKk4BR4mJxw+AzRUWCJPYMH0rkM3BwSKgKnHzvAtImFfA
        UmLz+y1sELagxMmZT1hAbGYBbYllC19DnaQg8fPpMlaQVhEBJ4k5Ey0gSsQlXh49AvaChMBS
        DokTR3ug6l0kbkxqZ4OwhSVeHd/CDmFLSbzsb2MHmSMhkC3Rs8sYIlwjsXTeMRYI217iwJU5
        LCAlzAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3awQtofE3Q032CYwKs5C
        8tcsJH/NQvLALIRlCxhZVjFKphYU56anFpsWGOellsPjOzk/dxMjOLFqee9gfPTgg94hRiYO
        xkOMEhzMSiK8Hw7yJgnxpiRWVqUW5ccXleakFh9iNAWG9URmKdHkfGBqzyuJNzSxNDAxMzMz
        sTQ2M1QS5z2VviFRSCA9sSQ1OzW1ILUIpo+Jg1OqgWmS8x+9Nzx3EoMWrzN12jMnYNcrD+cp
        y6z/+lm3vpjdu+L3Y3m5b0X3xDR69kW4CLulp+6ZZ7PipouXyWNhnkr+B4HmqekLhIOZJL4X
        H8o2ueUtYmfvEerm+3SWLW/AnIYJy8yuvn7lvuhiQ8yLnMKW4nmfuiz6sr5lZnjETdy76rLO
        cbX8vMMXtd+12Wpe/3Nl4VTV8u5TF8uiblsUmh3IP2z/cckGySZG+UMrzXPsKwI0p3Gc71sQ
        8Djk77HX7Ne6HJp5ruxmXB712VAihudGS0j+dfazb4wXcLpaXEmOzPugbvX98hvGXQxLTNfc
        8uZ675r8crKW6SL1QztDDtqY7o66nsT8JW6WpKvfAyWW4oxEQy3mouJEAHccbbg1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTnerkVCSwaIeIYt5n2UtNr79wWSx
        6fE1VovLu+awWcw4v4/JYu2Ru+wWi7Z+YbfYvGkqswOHx6yGXjaPO9f2sHm8O3eO3WPzknqP
        vi2rGD0+b5ILYIvisklJzcksSy3St0vgytj6dQFzwVapigtfXrM3MB4S7WLk5JAQMJHYOOMw
        WxcjF4eQwA5GiU3fVrNDJKQlrm+cAGULS6z895wdoug5o8S6ntdsIAk2AV2JHYvbwLpFBLoZ
        Ja70zGQEcZgFZjFKLG7ZBDX3MKPE09P9TCAtnAKOEhOPH2AGsYUFQiTu9F0Gsjk4WARUJW6e
        dwEJ8wpYSmx+v4UNwhaUODnzCQuIzSygLdH7sJURxl628DUzxHkKEj+fLmMFGSMi4CQxZ6IF
        RIm4xMujR9gnMArPQjJpFpJJs5BMmoWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOAI09Lawbhn1Qe9Q4xMHIyHGCU4mJVEeD8c5E0S4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        znuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgam3pvFMx9abGeHfHR75bf1escjp40vd5rIbN06f
        2riy1PflS/a1bkxTNpYtmPfjSABD6uMzV27Eck6b0bH8zN1nS7ki2H0Yzt37teBn1LnD63oe
        zK4TvfnKKJqn4/CnCMMJnAd5bht/evJKZt6dq1V/qtdPLXXPZ7Vljxc2je9R+VZtWf7rZPQk
        kaQ1DzIW3Mh6vH196ttfP3+cu31QWKjC9XjqO2nuul8ZFt8+LT1dMndGz2zlrsUtGYdehTWk
        BX2sT8mPtt49w61zXUeLY3VinEL4xLyZEuUV7lN09c/kGTXemjfV69wC7QybhUuO5y/mWKx4
        bHeVZ069xOMC/naPP28PM/Uk5an1CZoqXa1QYinOSDTUYi4qTgQASfPumh8DAAA=
X-CMS-MailID: 20220220122317epcas5p3ff8910d18d8f6aa924f3b6130f869c77
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220219175832epcas5p399b652e6da610ada233376651694b42c
References: <CGME20220219175832epcas5p399b652e6da610ada233376651694b42c@epcas5p3.samsung.com>
        <20220219181003.12739-1-alim.akhtar@samsung.com>
        <72848f6c-adc7-2d36-edcd-9a5fac655bbc@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Sunday, February 20, 2022 3:32 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: linux-samsung-soc=40vger.kernel.org; daniel.lezcano=40linaro.org;
>tglx=40linutronix.de; pankaj.dubey=40samsung.com;
>m.szyprowski=40samsung.com
>Subject: Re: =5BPATCH=5D clocksource/drivers/exynos_mct: Remove mct interr=
upt
>index enum
>
>On 19/02/2022 19:10, Alim Akhtar wrote:
>> MCT driver define an enum which list global and local timer's irq
>> index. Most of them are not used but MCT_G0_IRQ and MCT_L0_IRQ and
>> these two are at a fixed offset/index.
>> Get rid of this enum and use a =23define for the used irq index.
>>
>> While at it, bump-up maximum number of MCT IRQ to match the binding
>> documentation. And also change the name variable to be more generic.
>>
>> No functional changes expected.
>
>There is a functional change - you increase MCT_NR_IRQS from 12 to 20 whic=
h
>affects size of mct_irqs. Can you increase it in separate commit?
>
Yes, my thought was it is going to increase the mct_irqs array size and it =
will not affect any=20
of the current SoC's mct functionality.
Anyway, I will separate it out as you suggested.

>>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  drivers/clocksource/exynos_mct.c =7C 25 ++++++++-----------------
>>  1 file changed, 8 insertions(+), 17 deletions(-)
>>
>> - currently tested on exynos7 platform, appreciate testing on
>> exynos-=7B3,4,5=7D platforms
>>
>> diff --git a/drivers/clocksource/exynos_mct.c
>> b/drivers/clocksource/exynos_mct.c
>> index 6db3d5511b0f..4aea9cd3f7ba 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> =40=40 -60,27 +60,18 =40=40
>>  =23define MCT_CLKEVENTS_RATING		350
>>  =23endif
>>
>> +/* There are four Global timers starting with 0 offset */
>> +=23define MCT_G0_IRQ	0
>> +/* Local timers count starts after global timer count */
>> +=23define MCT_L0_IRQ	4
>> +/* Max number of MCT IRQ as per binding document */
>> +=23define MCT_NR_IRQS	20
>> +
>>  enum =7B
>>  	MCT_INT_SPI,
>>  	MCT_INT_PPI
>>  =7D;
>>
>> -enum =7B
>> -	MCT_G0_IRQ,
>> -	MCT_G1_IRQ,
>> -	MCT_G2_IRQ,
>> -	MCT_G3_IRQ,
>> -	MCT_L0_IRQ,
>> -	MCT_L1_IRQ,
>> -	MCT_L2_IRQ,
>> -	MCT_L3_IRQ,
>> -	MCT_L4_IRQ,
>> -	MCT_L5_IRQ,
>> -	MCT_L6_IRQ,
>> -	MCT_L7_IRQ,
>> -	MCT_NR_IRQS,
>> -=7D;
>> -
>>  static void __iomem *reg_base;
>>  static unsigned long clk_rate;
>>  static unsigned int mct_int_type;
>> =40=40 -89,7 +80,7 =40=40 static int mct_irqs=5BMCT_NR_IRQS=5D;  struct
>> mct_clock_event_device =7B
>>  	struct clock_event_device evt;
>>  	unsigned long base;
>> -	char name=5B10=5D;
>> +	char name=5BMCT_NR_IRQS - 1=5D;
>
>This does not look related MCT_NR_IRQS and using here MCT_NR_IRQS
>confuses. This is a =22mct_tick%d=22 with number of local timers, so maybe=
 make
>it just 11?
>
Yes, it is for local timer, let me add separate macro for this, which match=
es the current dt binding.
As per binding max 16 local timers can be supported.=20
And it will make code scalable, which is the positive side effect of this c=
hange.

>>  =7D;
>>
>>  static void exynos4_mct_write(unsigned int value, unsigned long
>> offset)
>
>
>Best regards,
>Krzysztof

