Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12F4BD005
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiBTRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiBTRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:00:24 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B1527E7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:00:00 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220220165958epoutp03f8e5613d48fb3354355b4ec558097335~VjR36XS2R1913419134epoutp03I
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 16:59:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220220165958epoutp03f8e5613d48fb3354355b4ec558097335~VjR36XS2R1913419134epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645376398;
        bh=TWEeKx50Ilk8tZsO3f9nj8GFWNvR0N3lNeFE1p6EQuE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DaJh52E65alsJHAEIO583WKHgBv/WX3M2rjFgUBQcxg9O+GEcKkIUY5svR8Mz2Fvw
         WRgVEIQXAIgoVflwxgLVubbwL3fXYFuihVG2iPrrZchYir3APqwtmDAKkvjPDJGgpI
         /FqOMzK/bVGFFmEPBo/ewcY2NDIWKSRWn+TNsWCQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220220165957epcas5p495583e322a5cd8dc0ae6b1a8016927d9~VjR2wy7oR1766217662epcas5p4Q;
        Sun, 20 Feb 2022 16:59:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K1s9h2CxBz4x9Pt; Sun, 20 Feb
        2022 16:59:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.38.46822.36372126; Mon, 21 Feb 2022 01:59:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220220165951epcas5p4e13b6c63e38502bd0c6d7ad04a1544de~VjRwtwA5w3080730807epcas5p4M;
        Sun, 20 Feb 2022 16:59:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220220165951epsmtrp15e2e35b99b5e5601ebfc927cf947316e~VjRwtFGO_3257832578epsmtrp1T;
        Sun, 20 Feb 2022 16:59:51 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-66-621273632d9a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.E3.08738.68372126; Mon, 21 Feb 2022 01:59:50 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220220165949epsmtip2c2f8e802a028e3f18595faa84c26aef1~VjRvf4arl3227932279epsmtip2L;
        Sun, 20 Feb 2022 16:59:49 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <linux-samsung-soc@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <pankaj.dubey@samsung.com>,
        <m.szyprowski@samsung.com>
In-Reply-To: <fc8f6c95-e37f-0dc8-c50d-48cadffcaa98@canonical.com>
Subject: RE: [PATCH v2 3/3] clocksource/drivers/exynos_mct: bump up number
 of local timer
Date:   Sun, 20 Feb 2022 22:29:49 +0530
Message-ID: <0a0801d8267b$467e8800$d37b9800$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGsC7VEdhGOZRhGMl9iauL5N6S4CQM1pureAr8wwB8CIzwayqy0FNbg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmum5ysVCSwc+FnBbzPstabHz7g8li
        0+NrrBaXd81hs5hxfh+Txdojd9ktFm39wm6xedNUZgcOj1kNvWwed67tYfN4d+4cu8fmJfUe
        fVtWMXp83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj5RmDgk1CFafWrGBvYFzK38XIySEhYCLxZOsuZhBbSGA3o8TXLocuRi4g
        +xOjxNlpPawQzmdGiR0zFjLCdKxZcIARIrGLUWJ711Io5yWjxIxda1lAqtgEdCV2LG5jA0mI
        CHQySqz+/pMJxGEWmAI0eMIzJpAqTgFHibYFB1hBbGGBaIlNF88CXcLBwSKgKrFgqzlImFfA
        UmLd5WZWCFtQ4uTMJ2ALmAW0JZYtfM0McZKCxM+ny8BqRATcJF6v+MAMUSMu8fLoEXaQvRIC
        CzkkeqZ+gPrBReLp3b+sELawxKvjW9ghbCmJl/1t7CA3SAhkS/TsMoYI10gsnXeMBcK2lzhw
        ZQ4LSAmzgKbE+l36EKv4JHp/P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc31FIPiaVrnjNOYFSc
        heSxWUgem4XkgVkIyxYwsqxilEwtKM5NTy02LTDKSy2HR3dyfu4mRnBa1fLawfjwwQe9Q4xM
        HIyHGCU4mJVEeD8c5E0S4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnAxJ5XEm9oYmlgYmZm
        ZmJpbGaoJM57On1DopBAemJJanZqakFqEUwfEwenVAOTx7qU6dm5t/b7dlWz1WfoWb+/2XN1
        umGgQflO3jr9F/ZzZdZPWZi6ZKXGhuW6WrO5mDj1lD5ofI7SSguykdJ8n5Txc0HA0ykL/3mc
        tE7RCZDfVnt89ZNHkgd9N9uY9bfM99yj6d4Q8cpi9UcxPjeewKYri5bq+lxS3PjkpkjKFqca
        F6Nl/yS3HUjZNc/wh+vXkxW/Sr931Ka5Fq0UeOO192foAvXV1osOfdfI+nIp+Le3+TIJhTuz
        tSdfOF39fcnG+anZB3vfL54o8kbnSlj1yVt8b8XaqzRWt2lsbUi/qXA+THD628VfhGZlnNWr
        Ddg+4+jO/mcm8966BW8WXn24XEJsQvzmSdl7zLYd2LJrqhJLcUaioRZzUXEiAN8KF3I0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXretWCjJ4P4pPYt5n2UtNr79wWSx
        6fE1VovLu+awWcw4v4/JYu2Ru+wWi7Z+YbfYvGkqswOHx6yGXjaPO9f2sHm8O3eO3WPzknqP
        vi2rGD0+b5ILYIvisklJzcksSy3St0vgyljVMY+x4IlgxZKve9gaGK/zdTFyckgImEisWXCA
        sYuRi0NIYAejxOZrz9ggEtIS1zdOYIewhSVW/nvODlH0nFFi8u3nrCAJNgFdiR2L29hAEiIC
        3YwSV3pmgo1iFpjFKLG4ZRMbRMsXRonvu66CtXAKOEq0LTgAZHNwCAtESuz6pg1isgioSizY
        ag5SwStgKbHucjMrhC0ocXLmExYQm1lAW6L3YSsjjL1s4WtmiOsUJH4+XQZWLyLgJvF6xQdm
        iBpxiZdHj7BPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ
        +bmbGMERpqW1g3HPqg96hxiZOBgPMUpwMCuJ8H44yJskxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9OUrn8fim0+vN4stlHU6QBXTILY5S2Fk3c/XiIi
        UxN5h9XQ4+DKd9Jby5pmplx/NMVX5U3CngJLi7li1zbm8z5ZIaX4RO7cg7orgpU3bYOLzZ4d
        5Nuck/Fj7andUzLe+HOWRW35wulbLS5zsbj42LNfDIcN7BmPH+HgC9CSs8rR+ZhXb9NqG/j6
        stlE+Rq2Q81OZcEu3St3X7qlH17KNKPrxu7yjYvELWd67AuIF2fz3DE1gd20+dKtRxm99ivO
        9T/clrFkJntT94yNassP5C85UJPHtz6+jdGhf6f+zgPd+qXi/bszm264uq26kqs4UUqab51c
        TcNtyxUz5nxtupSlmcZcvNvCdOGt7g3GEkosxRmJhlrMRcWJAEECa84fAwAA
X-CMS-MailID: 20220220165951epcas5p4e13b6c63e38502bd0c6d7ad04a1544de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0
References: <20220220133824.33837-1-alim.akhtar@samsung.com>
        <CGME20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0@epcas5p3.samsung.com>
        <20220220133824.33837-3-alim.akhtar@samsung.com>
        <fc8f6c95-e37f-0dc8-c50d-48cadffcaa98@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Sunday, February 20, 2022 9:03 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: linux-samsung-soc=40vger.kernel.org; daniel.lezcano=40linaro.org;
>tglx=40linutronix.de; pankaj.dubey=40samsung.com;
>m.szyprowski=40samsung.com
>Subject: Re: =5BPATCH v2 3/3=5D clocksource/drivers/exynos_mct: bump up
>number of local timer
>
>On 20/02/2022 14:38, Alim Akhtar wrote:
>> As per the dt binding, maximum number of local timer can be up to 16.
>> Increase the array size of the _name_ variable which holds the number
>> of local timer name per CPU to reflect the binding. While at it,
>> change the magic number to a meaningful macro.
>
>This still does not make sense. Let's say you have 16 local timers, so why=
 the
>name of clock event device should be maximum 16? How are these related?
>
As you rightly commented on v1 and it is mainly for =22mct_tick%d=22 with n=
umber of local timers and
local timer is per cpu. With increase in cpu number, name=5B10=5D restrict =
the scalability.
So either we can change to 11, or use some reference (as local timer number=
 in this patch).=20
Let me know your thought on this.

>>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  drivers/clocksource/exynos_mct.c =7C 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c
>> b/drivers/clocksource/exynos_mct.c
>> index 0c7931f7f99a..8d63a9376701 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> =40=40 -66,6 +66,8 =40=40
>>  =23define MCT_L0_IRQ	4
>>  /* Max number of IRQ as per DT binding document */
>>  =23define MCT_NR_IRQS	20
>> +/* Max number of local timers */
>> +=23define MCT_NR_LOCAL_TIMERS	16
>>
>>  enum =7B
>>  	MCT_INT_SPI,
>> =40=40 -80,7 +82,7 =40=40 static int mct_irqs=5BMCT_NR_IRQS=5D;  struct
>> mct_clock_event_device =7B
>>  	struct clock_event_device evt;
>>  	unsigned long base;
>> -	char name=5B10=5D;
>> +	char name=5BMCT_NR_LOCAL_TIMERS=5D;
>>  =7D;
>>
>>  static void exynos4_mct_write(unsigned int value, unsigned long
>> offset)
>
>
>Best regards,
>Krzysztof

