Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B55538D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiEaIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiEaIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:50:43 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23608CB3C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:50:40 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220531085038epoutp02b599f343ca7968473ed797273d32de3e~0JHLRiIj72449824498epoutp02d
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:50:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220531085038epoutp02b599f343ca7968473ed797273d32de3e~0JHLRiIj72449824498epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653987038;
        bh=IpFxR21ycRBwZRy0NNV1Ev8sWHWxLpZ9m/zI8Ok5k78=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sq0zHCQD0hRVep5tLQ4Hv46dD1HpoODAgE8GS1dGA6O+gbdjQRQ+56yQ0h77XWOHb
         um5CAxfJYO9CtCMzrdEoWjVVTqnizviQwrFsda/C92apDfii6QVkGXYkKjMN8hbCRI
         rfeS8OkfcR3Sv1YJj8GNAN/SEccouuyA3ljA7RMg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220531085037epcas5p3f2c28435cbe804a2db53baf7d42dea94~0JHKfXJn00381703817epcas5p3R;
        Tue, 31 May 2022 08:50:37 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LC5Zv74jMz4x9QP; Tue, 31 May
        2022 08:50:31 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.3B.09762.7D6D5926; Tue, 31 May 2022 17:50:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220531084251epcas5p3101ab1f7043863212544b6fdeeb480bd~0JAYHlO5k2662826628epcas5p37;
        Tue, 31 May 2022 08:42:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531084251epsmtrp2f050a837365c4169e2e72d7b83d767a4~0JAYDQdfV2385123851epsmtrp2I;
        Tue, 31 May 2022 08:42:51 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-9a-6295d6d7d52a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.59.08924.B05D5926; Tue, 31 May 2022 17:42:51 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220531084249epsmtip1dec96aa9b1d1384b569338e8653bcf58~0JAWL0ZjF2129221292epsmtip1-;
        Tue, 31 May 2022 08:42:49 +0000 (GMT)
From:   "m.shams" <m.shams@samsung.com>
To:     "'Jonathan Cameron'" <jic23@kernel.org>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <geert@linux-m68k.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <paul@crapouillou.net>,
        <linux-fsd@tesla.com>
In-Reply-To: <20220522122555.6c65d2b6@jic23-huawei>
Subject: RE: [PATCH v2 2/3] iio: adc: exynos-adc: Add support for ADC FSD-HW
 controller
Date:   Tue, 31 May 2022 14:12:46 +0530
Message-ID: <015b01d874ca$69aa8bb0$3cffa310$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIGNN21wa2G9ryxTCo9HfAX0Xxs4AIEb8M6AoyC4FABXCk8mKytwBtw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmlu71a1OTDDYfN7F4MG8bm8X8I+dY
        LZ7d2stk8aBpFZPFy1n32CyWTJ7ParHp8TVWi4evwi3mHXnHYnF51xw2ixnn9zFZ9C++xGLR
        uvcIuwOvx+pL7Wwem1Z1snkcOtzB6LF5Sb3HkjeHWD36tqxi9PjXNJfd4/MmuQCOqGybjNTE
        lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCLlRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGV83vGIu
        OMhbMXfafvYGxk9cXYycHBICJhIbOt6xdTFycQgJ7GaUePm0iRHC+cQoMb3vBzOE85lR4u+s
        mYwwLd0X90AldjFKbDi0lxXCecYo8fvxeSCHg4NNQFVix00RkAYRAW2JvW8Ogo1lFrjMJHFn
        6nU2kASngLFEY+NUVhBbWCBS4tv2SWA2C1Dvus0nmEDm8ApYSnR3SYOEeQUEJU7OfMICYjML
        yEtsfzuHGeIgBYmfT5exQsTFJY7+7GGG2Osmsbb/MzvIXgmBGxwSMyd0s0E0uEjcnPkVqllY
        4tXxLewQtpTE53d7oWrSJeY+7GWCsAsklu36DlVjL3HgyhwWkNuYBTQl1u/ShwjLSkw9tY4J
        4gY+id7fT6BaeSV2zIOxFSX+7+6HGiMu8W7FFNYJjEqzkLw2C8lrs5C8Mwth2wJGllWMkqkF
        xbnpqcWmBcZ5qeXwCE/Oz93ECE7QWt47GB89+KB3iJGJg/EQowQHs5IIb8muqUlCvCmJlVWp
        RfnxRaU5qcWHGE2BwT2RWUo0OR+YI/JK4g1NLA1MzMzMTCyNzQyVxHkF/jcmCQmkJ5akZqem
        FqQWwfQxcXBKNTAt93G+z73hReHejWWmt+P8vkl7l+sV9ZytUq4/a2idcHDr3wNbFr76aHXO
        jLHYRMHP4Vfxr/mWz1bpMk5Z4fj66NKvV3llZ2x8m9T+L9tqWX4V84r7zBtnd72Yzx41S2rq
        C6YnV3dXRO3aMMHTsDJ3B9/lhZHTHl7Xb8hc0xz2sOGXoLNL0XFh9XOHv8Vtaw+Neapzq3/X
        I/urV/Xfb7pXPf9zs6ZJveBupiwJZ7v72pFVqhcnzVT8vnlCxu9N1pNizrRflX48OUDk/7ca
        3/m+EwuMJuZyXXp3amrzrOT63rr0N5X/ZO+/UPt26lHJgWLDfk+2VjmvkGvLdx5KCdpxf4H9
        p4kr1j9VY+n2NZP/ocRSnJFoqMVcVJwIAGA213ZZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSnC731alJBp03hSwezNvGZjH/yDlW
        i2e39jJZPGhaxWTxctY9Noslk+ezWmx6fI3V4uGrcIt5R96xWFzeNYfNYsb5fUwW/YsvsVi0
        7j3C7sDrsfpSO5vHplWdbB6HDncwemxeUu+x5M0hVo++LasYPf41zWX3+LxJLoAjissmJTUn
        syy1SN8ugSvj64ZXzAUHeSvmTtvP3sD4iauLkZNDQsBEovviHmYQW0hgB6PE21eMEHFxiWm/
        9kPZwhIr/z1n72LkAqp5wijRtr8LyOHgYBNQldhxUwSkRkRAW2Lvm4OMIDXMAg+ZJC6e/M4C
        0XCPUWLKi+NgGzgFjCUaG6eygtjCAuESvz4sYwKxWYAGrdt8gglkKK+ApUR3lzRImFdAUOLk
        zCcsIGFmAT2Jto1g9zALyEtsfzuHGeI2BYmfT5exQsTFJY7+7GGGuMdNYm3/Z/YJjMKzkEya
        hTBpFpJJs5B0L2BkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyfWlo7GPes+qB3
        iJGJg/EQowQHs5IIb8muqUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MHFszj8kU3AlxfvZ1rs2pg0X8hVnPkl8Nndi3W8B1z4Ndr7HJ2ZnRaa5+lls
        Wp09+aq/POv/Ztvd88TunX0Uxxvan62r8H8yz8P4+fx7bzzXMVD58WVjm8kmpZU7GHWmerz7
        17pC6chhg/kdIt/67Fb8CMu0bc15Kj2P822Q0lKZFYLfc6elv9MsSm8OyFoTqS3jJeDUnblh
        Vlj6j3NnuTOuObN0ROzW7pKJUVPh/+J9jOV5n+fGvMdiDhV/2rlK31RUsqU5NV4RZ2b5uKlo
        NYND89x7GjXu33xOL19/jO3fXQOjtxMv/+iRcLlf4zlvf778svPeMzOyJwi3HHNxqop+uD3m
        g1vTy4eTlnWoK7EUZyQaajEXFScCAKTqlwU+AwAA
X-CMS-MailID: 20220531084251epcas5p3101ab1f7043863212544b6fdeeb480bd
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
        <20220522122555.6c65d2b6@jic23-huawei>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jonathan,

On Fri, 20 May 2022 20:28:19 +0530
Tamseel Shams <m.shams@samsung.com> wrote:

>> From: Alim Akhtar <alim.akhtar@samsung.com>
>> 
>> Exynos's ADC-FSD-HW has some difference in registers set, number of 
>> programmable channels (16 channel) etc. This patch adds support for 
>> ADC-FSD-HW controller version.
>> 
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
>
> Hi,
>
> One suggestion inline, otherwise LGTM. Plenty of time to tidy this up as
this won't make the upcoming merge window - I'll be queuing it up for 5.20
>
> Thanks,
>
> Jonathan
>

Okay, Thanks for reviewing.

>> ---
>> - Changes since v1
>> * Addressed Jonathan's comment by using already provided isr handle
>> 
>>  drivers/iio/adc/exynos_adc.c | 55 
>> ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>> 
>> diff --git a/drivers/iio/adc/exynos_adc.c 
>> b/drivers/iio/adc/exynos_adc.c index cff1ba57fb16..183ae591327a 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -55,6 +55,11 @@
>>  #define ADC_V2_INT_ST(x)	((x) + 0x14)
>>  #define ADC_V2_VER(x)		((x) + 0x20)
>>  
>> +/* ADC_FSD_HW register definitions */
>> +#define ADC_FSD_DAT(x)			((x) + 0x08)
>
> I mention this below, but these different register sets should be in the
struct exynos_adc_data to avoid the need for an if "compatible" == check on
each use of > them.
>

Can you clarify on how exactly you want me to add these register sets to
struct exynos_adc_data?
Do you mean just for these registers or other registers too which are
defined in this way only?


Thanks & Regards,
Tamseel Shams

