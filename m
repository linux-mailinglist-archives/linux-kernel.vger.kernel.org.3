Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5749C5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiAZJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:15:12 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35928 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiAZJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:15:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091500euoutp01a60c5b7d786e34d7d3af6361622fde03~Nxzw_uwsE2826428264euoutp01P
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:15:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126091500euoutp01a60c5b7d786e34d7d3af6361622fde03~Nxzw_uwsE2826428264euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188500;
        bh=2kxgqbUOSiR/HAQwrNWg/JhY0i5DL9Kj/WNddeqRUWU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=vbyqmrDXjK6XaXoSvvGwx03VDY8U9OGD9oIFp790xD+1EDkzyxO+669Fqv7DU5FDj
         5QaLnsJsjRvRO29ichr+Xl/3yhyAsASdTFZ+xDKGuZkpz+nhcOwU8Jjfl4AeWt1RBD
         EEPSY7eYM01xGKTSIJWo4EC5kQBPLZOxLc4xGNsY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091500eucas1p12eb9da9afb0fa34960e3a087615b5fa4~NxzwjkJ250450004500eucas1p1E;
        Wed, 26 Jan 2022 09:15:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.AE.10009.31111F16; Wed, 26
        Jan 2022 09:14:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091459eucas1p1881b40812beda47dbf94ada05a1f51b9~NxzwH2qkg0450004500eucas1p1D;
        Wed, 26 Jan 2022 09:14:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126091459eusmtrp19386a2364ee656566c8fe8c8aeedf0dd~NxzwG6UYZ1373813738eusmtrp1a;
        Wed, 26 Jan 2022 09:14:59 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-cb-61f11113f71a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E0.D2.09522.31111F16; Wed, 26
        Jan 2022 09:14:59 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091458eusmtip1dcde91b01251d358331599f1db9a4bca~Nxzu7C3c31968719687eusmtip1v;
        Wed, 26 Jan 2022 09:14:58 +0000 (GMT)
Message-ID: <6457f0c3-4f2a-a784-aadf-b3cbe563db74@samsung.com>
Date:   Wed, 26 Jan 2022 10:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 04/16] clk: samsung: fsd: Add initial clock support
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org, linux-fsd@tesla.com,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-5-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djPc7rCgh8TDX4ftbA48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLf9c2slg8vv6HzUHIY828NYwev39NYvSY1dDL5rFpVSeb
        x51re9g8Ni+p97hyoonVo2/LKkaPf01z2T0+b5IL4IrisklJzcksSy3St0vgyni9/ixzwS2W
        itu3njM3MP5m7mLk5JAQMJH4tPYOkM3FISSwglHiX/ccdgjnC6PEl8srWCGcz4wSLVNOM8K0
        HLq/B6pqOaNEW9MrKOcjo8TvzqdMIFW8AnYSs//PBFvCIqAqsfHuazaIuKDEyZlPWLoYOThE
        BZIkelqcQcLCAl4S+3ftA1vALCAucevJfLAxIgL5Ej//7WQBmc8s0McssXt/K1gRm4ChRO/R
        PkaQOZwCthL3jgdD9MpLbH87B+wfCYFbnBLPDmxigrjaRaL1dysrhC0s8er4FnYIW0bi9OQe
        FoiGZkaJnt232SGcCYwS948vgPrZWuLOuV9sINuYBTQl1u/Shwg7SnxfvJ4VJCwhwCdx460g
        xBF8EpO2TWeGCPNKdLQJQVSrSPxeNR3qHCmJ7if/WSYwKs1CCpVZSN6fheSdWQh7FzCyrGIU
        Ty0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMkKf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8P73
        fp8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6YklqdmpqQWoRTJaJg1Oqgcls/yRm
        f5+FbDEOj18tXpy1pjl+/7GF9qIfHsnUnOk6tnZaqO151TLxXdNCo3g+PBLtdu1jeP5Nd/6D
        yd8aHk7aw3Nw7u87roek8r4fnH6t7UMop7p+yoLgpTM3zaw/HpSaKunkljjD4t3mG3a7VD38
        Y78Hhx2v7lDbvfqeUNW66jaNtdOfTjm30Ulr+qWCQx/qCvnT5p/IFH4qPWPORtFFM5y3K1Y+
        Ez7W8W/+xK0ptzvsdx+7c+Pd9JPlx3NCKxurriaUOSw8MPnj8mvZXGf3rao8US3MUuG4wi/4
        Tnj/f5HPgStEl+woz9P+7/J3v1NToozzv093unUPOvP4r01qmHyHZdX3y24HUu5+DE0WUWIp
        zkg01GIuKk4EAF7nZQn/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7rCgh8TDU7slrE48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLf9c2slg8vv6HzUHIY828NYwev39NYvSY1dDL5rFpVSeb
        x51re9g8Ni+p97hyoonVo2/LKkaPf01z2T0+b5IL4IrSsynKLy1JVcjILy6xVYo2tDDSM7S0
        0DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3i9/ixzwS2Witu3njM3MP5m7mLk5JAQMJE4
        dH8PexcjF4eQwFJGiRd397N0MXIAJaQk5rcoQdQIS/y51sUGUfOeUWLClG0sIAleATuJ2f9n
        gg1iEVCV2Hj3NRtEXFDi5MwnYDWiAkkSDce6weLCAl4S+3ftYwSxmQXEJW49mc8EYosI5Ev8
        6f/ICrKAWaCPWeL4pG9QFx1mlNhyey0rSBWbgKFE79E+RpDrOAVsJe4dDwYxmQXUJdbPE4KY
        KS+x/e0c5gmMQrOQnDELybpZCB2zkHQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZgM
        th37uXkH47xXH/UOMTJxMB5ilOBgVhLh/e/9PlGINyWxsiq1KD++qDQntfgQoykwKCYyS4km
        5wPTUV5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1Oa0UvOwBpV
        b67pentf/LV7o6i+tk/tV9BBx63Btx2vTWQ49+yMivKa3/wLAtW4Ds+eMMk/O6wz4n/smjcy
        9rFvwrctSQre9m2q5QO/Y72HTxw6KX6VIX6G4IwrZ+4+shMzO93BfeyjSzl76skfx7jqLxvo
        LTmw+9vpJxO/mZrcflwX9tezjO1db1Mgu07NRM8DWf868pTfsWtcOOy9T/7FV40kL147jhiL
        P74KCz+nBTKvunx4yuG0BwZzrZJ0jMUE7181sBH+2pgcqSte7rScZfN1xbaFr3bufCWz8ABX
        uu51m+7Nh86XKIiel2J64F43oYdn/9kie93C9pyLmhqdVem2ZQJNSroec7c+DlRiKc5INNRi
        LipOBABV5GmfjwMAAA==
X-CMS-MailID: 20220126091459eucas1p1881b40812beda47dbf94ada05a1f51b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f@epcas5p2.samsung.com>
        <20220124141644.71052-5-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Add initial clock support for FSD (Full Self-Driving) SoC
> which is required to bring-up platforms based on this SoC.
> 
> Also, fix the build error reported by the kernel test robot [1]. 
 
> Cc: linux-fsd@tesla.com
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

