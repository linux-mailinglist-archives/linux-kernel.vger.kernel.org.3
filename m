Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39747682F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhLPCh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:37:29 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38888 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhLPCh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:37:27 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211216023726epoutp0303193ae2c14845b7432a7f2d3f8a781e~BG77rqtH81007010070epoutp03K
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:37:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211216023726epoutp0303193ae2c14845b7432a7f2d3f8a781e~BG77rqtH81007010070epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639622246;
        bh=ov9JBiipu25VcvDU7WfIemIS8TUdNnhQQ4gVix2O/4Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=q8UIuofPl7khBy2O2MJ6HtxfSkWjiUJqFn5X7zggY2sLoNJFTI/X/4GIQGDLpFvDk
         i/ZiB8lfp/5Ol6VHKFNHzFdZjkg72D23hypSDGqTftShy6tQVPy+S6mexr8ngc9jYG
         bdyaT2VkOVXsELN2JZiOOQokRzAJPq5q/UDb/l7s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211216023725epcas1p45e5b4d902bda43a96dfd9700ad71db50~BG77ZL3Z30947209472epcas1p4A;
        Thu, 16 Dec 2021 02:37:25 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.231]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JDx8x4sgFz4x9Q0; Thu, 16 Dec
        2021 02:37:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.41.08277.066AAB16; Thu, 16 Dec 2021 11:37:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216023720epcas1p3327627e581a57dd2cc43324dcedfc10d~BG72uhUDa2339723397epcas1p34;
        Thu, 16 Dec 2021 02:37:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211216023720epsmtrp19b421eb39ab24ccdb11f436f102487b5~BG72t4e450531805318epsmtrp1X;
        Thu, 16 Dec 2021 02:37:20 +0000 (GMT)
X-AuditID: b6c32a36-1edff70000002055-5c-61baa660df12
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.32.29871.066AAB16; Thu, 16 Dec 2021 11:37:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216023720epsmtip2e47069a38630b030fea24fec9cc06b59~BG72hHgA21471014710epsmtip2V;
        Thu, 16 Dec 2021 02:37:20 +0000 (GMT)
Subject: Re: [PATCH] extcon: usb-gpio: fix a non-kernel-doc comment
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d740c09d-e968-806c-364e-ea5e93f304d7@samsung.com>
Date:   Thu, 16 Dec 2021 12:00:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211115030536.2414-1-rdunlap@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTVzdh2a5EgxOzNC0u75rDZvGq+RGb
        xe3GFWwWb+9MZ3Fg8di8Qstj8Z6XTB59W1YxenzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYFqgV5yYW1yal66Xl1piZWhgYGQKVJiQnTF51h6WgnaOip+v1rE3MN5g62Lk
        5JAQMJG43bWapYuRi0NIYAejxOcTtxghnE+MEl/3rWYGqRIS+MYosfobE0zHlL072CDiexkl
        7hySgGh4zyix9ssL1i5GDg5hAWeJ5SfVQUwRATeJjecMQMqZBQIkzu++zwJiswloSex/AXEE
        v4CixNUfjxlBbF4BO4nlLU/BalgEVCW6Wr+xg9iiAmESJ7e1QNUISpyc+QSshlPASuLi1n/s
        EPPFJW49mc8EYctLbH87hxnkNAmBn+wS3/a8Y4a430Xi26YdrBC2sMSr41vYIWwpiZf9bewQ
        DcsYJX5N7mSCcNYzSryc1QnVbSyxf+lkJpDPmAU0Jdbv0ocIK0rs/D2XEWIzn8S7rz3gcJAQ
        4JXoaBOCKFGWuPzgLjQMJSUWt3eyTWBUmoXkn1lIfpiF5IdZCMsWMLKsYhRLLSjOTU8tNiww
        gsd1cn7uJkZwWtQy28E46e0HvUOMTByMhxglOJiVRHifROxKFOJNSaysSi3Kjy8qzUktPsRo
        CgzhicxSosn5wMScVxJvaGJpYGJmZGxiYWhmqCTO+8J/eqKQQHpiSWp2ampBahFMHxMHp1QD
        U+yBnNWu1v839ko13HbfbOA9/8rnSvO8xdOZDRvPR/VM/szye1HL94nr/kSJyJ2dwjRZrMIy
        dO7evdEKdrt0lmyP1f/8cGHMx4cPE3bwzigpk568nc3GMaHhRu+LZ1NfuZ9c9pnn9qOt06e9
        zzvnOqFi8WQXDR0zdVO3FYvKzNYdCBc3PqLcwjv5Wgxvp4/itO8HK1vvPk4KMNkscbe05MmC
        F6LLtIve/D7Aq5ilseOpV94e91P6196vnn9maXDkdE32Jwo1y73mH5Ll3PBEJtHMaNW7+5Om
        r5i+PUnqxcu73sfP5U4I6hdREtnYrCd2ouHOsrln8nXc3m43aLNiU5EQFv5XdodBLNl0f136
        /19KLMUZiYZazEXFiQCLA9iUFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvG7Csl2JBh+vs1hc3jWHzeJV8yM2
        i9uNK9gs3t6ZzuLA4rF5hZbH4j0vmTz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoErY/KsPSwF
        7RwVP1+tY29gvMHWxcjJISFgIjFl7w4gm4tDSGA3o0TTlgOsEAlJiWkXjzJ3MXIA2cIShw8X
        Q9S8ZZR40f+VDSQuLOAssfykOogpIuAmsfGcAUgns4CfRNuZM1AjexklGh5vYwFJsAloSex/
        AbGXX0BR4uqPx4wgNq+AncTylqdgNSwCqhJdrd/YQWxRgTCJnUseM0HUCEqcnPkErIZTwEri
        4tZ/7BDL1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuK
        c9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNES3MH4/ZVH/QOMTJxMB5ilOBgVhLhfRKxK1GI
        NyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJjPpBw/fsGz7
        c2NaedtbFaG+qpAcg7JXczpdUhcr67zMv3Dwkaqk6R3bxT8mHzt9yWIdT/3MH7aMzLZbXq/2
        +Bg2L1zw6J/FV/Jec0ZGbVP+knXLdaLDjYMp27QPBH3P2CW/c1l5YsCDqrV7M8Xv6PRN1tP1
        VZ/DZN30RmYa13ubGedsb9qenPDJ0Jn120zJ4C0q8i6pRfaH/mtc/Wp6OkLyun3FXX7X8Bu7
        jx5M+ShjL7Oy63LVlM2zHzF+zMk4yjf70tUFDTNVHp+x5D6/cMucC1f01yieErPi+2X++r1S
        7sF8xiUzL83ep2myt+DR4Zl235dvu39J9yOLWc+BuaUSU/+uEYn9ZfZYQTv++d1FSizFGYmG
        WsxFxYkArAGAvv8CAAA=
X-CMS-MailID: 20211216023720epcas1p3327627e581a57dd2cc43324dcedfc10d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211115030550epcas1p17967a72736d2221667fdf032e9339eca
References: <CGME20211115030550epcas1p17967a72736d2221667fdf032e9339eca@epcas1p1.samsung.com>
        <20211115030536.2414-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 12:05 PM, Randy Dunlap wrote:
> Do not use "/**" to begin a non-kernel-doc comment.
> Fixes this build warning:
> 
> drivers/extcon/extcon-usb-gpio.c:23: warning: expecting prototype for drivers/extcon/extcon-usb-gpio.c(). Prototype was for USB_GPIO_DEBOUNCE_MS() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-usb-gpio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20211102.orig/drivers/extcon/extcon-usb-gpio.c
> +++ linux-next-20211102/drivers/extcon/extcon-usb-gpio.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * drivers/extcon/extcon-usb-gpio.c - USB GPIO extcon driver
>   *
>   * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
> 
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
