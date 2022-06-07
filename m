Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8379653F549
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiFGEwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiFGEwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:52:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E910B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 21:52:11 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220607045206epoutp024f95a22a1ecad7cb9f2f07c964a0202a~2PX5ucyVe2411024110epoutp02E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:52:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220607045206epoutp024f95a22a1ecad7cb9f2f07c964a0202a~2PX5ucyVe2411024110epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654577526;
        bh=4JdykfJOyARDoZoGQjgXmjIvIMGnRkH+KxtH2TPENgk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=emAhWONL2XoxgAP08SBmWxjVZT2CyB7/h62TUr6ko5QXfffd72MPws1UdKSQ1mNDX
         wvoAIW3xumyikdKb5MXlwuA3AkQCy/c81thLrLUR17tFQZwDBLZW5ERsRMkZgtuu0L
         hwMC/nE95HlleXiqnD3rDQshHEHAnzayn66ipVo8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220607045205epcas1p3a09558742c06f69410ce9d34bca66c87~2PX5LF7Du0402804028epcas1p3G;
        Tue,  7 Jun 2022 04:52:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.144]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LHHyX2yNHz4x9Pw; Tue,  7 Jun
        2022 04:52:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.0D.10354.479DE926; Tue,  7 Jun 2022 13:52:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220607045203epcas1p3dceb041144e675506aa2130dfbf8d26a~2PX3hpT3z2608726087epcas1p3W;
        Tue,  7 Jun 2022 04:52:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220607045203epsmtrp2d7b2b858051d88566efa153670319176~2PX3gtVXm2579925799epsmtrp2G;
        Tue,  7 Jun 2022 04:52:03 +0000 (GMT)
X-AuditID: b6c32a38-cc605a8000002872-fb-629ed974609e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.75.11276.379DE926; Tue,  7 Jun 2022 13:52:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220607045203epsmtip2b8bb94c087b395c94c70beec80304fe7~2PX3Rk4W-2914229142epsmtip2d;
        Tue,  7 Jun 2022 04:52:03 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>, krzk+dt@kernel.org,
        robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <772c8198-b793-345f-2b78-2733ba304559@samsung.com>
Date:   Tue, 7 Jun 2022 13:52:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <e4d3ab91-9c53-79a0-76f8-098e6b846441@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmnm7JzXlJBkcniFpcWilhMf/IOVaL
        4/uXsFsc+xVs8XTzYyaLl7PusVmcbXrDbrHp8TVWi8u75rBZXG6+yGjxufcIo8WndR0sFq17
        j7A78HrsuLuE0WPTqk42j81L6j1aTu5n8ejbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0
        WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
        Chn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGdP/tjEV3Dar2PX/E1sD4xq9
        LkZODgkBE4kDnbfZuxi5OIQEdjBKbL1+iQ3C+cQo8ev5QqjMN0aJnqlNLDAti07PYIRI7GWU
        mLFyEhOE855R4sO296wgVcIC0RK9N1+wgiREBHYyStxa9g+shVmgm0li75Ob7CBVbAJaEvtf
        3GADsfkFFCWu/ngMVMTBwStgJ9G5KwYkzCKgIrFz5S5GEFtUIEzi5LYWMJtXQFDi5MwnYCdx
        CjhKPL36gQnEZhYQl7j1ZD6ULS/RvHU2M8heCYELHBJtf2ayQ/zgIvFz5hI2CFtY4tXxLVBx
        KYnP7/ayQTQ0M0o0vLjNCOH0MEocfdYHDQFjif1LJzOBXMosoCmxfpc+RFhRYufvuYwQm/kk
        3n3tYQUpkRDglehoE4IoUZa4/OAuE4QtKbG4vZNtAqPSLCT/zELywywkP8xCWLaAkWUVo1hq
        QXFuemqxYYEJPMKT83M3MYJTsZbFDsa5bz/oHWJk4mA8xCjBwawkwus/eW6SEG9KYmVValF+
        fFFpTmrxIUZTYAhPZJYSTc4HZoO8knhDE0sDEzMjYxMLQzNDJXHe3qmnE4UE0hNLUrNTUwtS
        i2D6mDg4pRqYLMp0z4s6Fd/vyuSTY2Yt+HSp/0P9hcVFLHJ2Sze6vji+Ws5q0T/mkAPfpvAK
        Pqn2cZxvJX5YwsvJ/3v1+Q2vDiVbFH6d5BuR+y2Uh/uGfMnaim+RU+0vdZd9V5ey6/a+U8QT
        LX+2MPlJZ2TZ/nl/bx142dYslX0neU1P6g+t5WLx71s3xEySVo3IrYj0OfL8OxOz7+MjNV+C
        j8v0RzF76Dvk3RNxlLBvFWNiNnvjwrnt+0yliQbtE6Lc+tTuLLDz2KT68f3bZaariv3zp3Gf
        FnvNeUxuzhL/0HbD58fi0hkmxluxajPNeq6relFw28L22e88t0wt9kzin87486Rf/5/NUf6v
        vI0bT3lxFCuxFGckGmoxFxUnAgBXOud7TgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvG7xzXlJBm3dphaXVkpYzD9yjtXi
        +P4l7BbHfgVbPN38mMni5ax7bBZnm96wW2x6fI3V4vKuOWwWl5svMlp87j3CaPFpXQeLReve
        I+wOvB477i5h9Ni0qpPNY/OSeo+Wk/tZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj+t82
        poLbZhW7/n9ia2Bco9fFyMkhIWAisej0DMYuRi4OIYHdjBJbjp9nhEhISky7eJS5i5EDyBaW
        OHy4GKLmLaNEx/nTzCA1wgLREr03X7CC2CICOxklNs5TBSliFuhkkrizejsTRMcfRokV106z
        g1SxCWhJ7H9xgw3E5hdQlLj64zEjyAZeATuJzl0xIGEWARWJnSt3gR0hKhAmsXPJYyYQm1dA
        UOLkzCcsIDangKPE06sfwOLMAuoSf+ZdYoawxSVuPZkPFZeXaN46m3kCo/AsJO2zkLTMQtIy
        C0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwfGopbmDcfuqD3qHGJk4GA8x
        SnAwK4nw+k+emyTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMH
        p1QDU6KO+z/hnvAgz7t7I95dPPhWvOxtji1f7ORdBxydtJZU8gk+Xf3AZtq5GxErLl75aXNt
        yrJl9VvSLiowMxlyrp9eNvHCxOcCQSfbwwOUDDdYVa3v/f/cuHFzoFBv7bars1bdMt/iO7F2
        ZdBxL/8/ex86qWQfStzM1BgvNT9XQGL2IrsH2rHzMvqZsrZJddwO0dYO3r4+r89gA//0I/Uy
        DFpG2b4b5XjVQ+a8YZxhxcXi+8HrnoH+9KMhPzyT04IzIg9zbC+W4Nn2M4zpUXuy5LPjHQcN
        rs1aWn/I6Uz4naKzq/6u9fFVmip8v3/rPaOLzCHcMZ8XTpDbaH0vVaP2aZB46Ja8yK5Ttbuu
        LWH6r8RSnJFoqMVcVJwIALsrNhw2AwAA
X-CMS-MailID: 20220607045203epcas1p3dceb041144e675506aa2130dfbf8d26a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220530121644epcas1p482c15aa452315a2e5c343ee2eefc48c1
References: <20220527110036.8810-1-johnson.wang@mediatek.com>
        <20220527110036.8810-3-johnson.wang@mediatek.com>
        <CGME20220530121644epcas1p482c15aa452315a2e5c343ee2eefc48c1@epcas1p4.samsung.com>
        <e4d3ab91-9c53-79a0-76f8-098e6b846441@collabora.com>
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 9:16 PM, AngeloGioacchino Del Regno wrote:
> Il 27/05/22 13:00, Johnson Wang ha scritto:
>> We introduce a devfreq driver for the MediaTek Cache Coherent Interconnect
>> (CCI) used by some MediaTek SoCs.
>>
>> In this driver, we use the passive devfreq driver to get target frequencies
>> and adjust voltages accordingly. In MT8183 and MT8186, the MediaTek CCI
>> is supplied by the same regulators with the little core CPUs.
>>
>> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> This patch depends on "devfreq-testing"[1].
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
>> ---
>>   drivers/devfreq/Kconfig           |  10 +
>>   drivers/devfreq/Makefile          |   1 +
>>   drivers/devfreq/mtk-cci-devfreq.c | 441 ++++++++++++++++++++++++++++++
>>   3 files changed, 452 insertions(+)
>>   create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 87eb2b837e68..9754d8b31621 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
>>         It reads ACTMON counters of memory controllers and adjusts the
>>         operating frequencies and voltages with OPP support.
>>   +config ARM_MEDIATEK_CCI_DEVFREQ
>> +    tristate "MEDIATEK CCI DEVFREQ Driver"
>> +    depends on ARM_MEDIATEK_CPUFREQ || COMPILE_TEST
>> +    select DEVFREQ_GOV_PASSIVE
>> +    help
>> +      This adds a devfreq driver for MediaTek Cache Coherent Interconnect
>> +      which is shared the same regulators with the cpu cluster. It can track
>> +      buck voltages and update a proper CCI frequency. Use the notification
>> +      to get the regulator status.
>> +
>>   config ARM_RK3399_DMC_DEVFREQ
>>       tristate "ARM RK3399 DMC DEVFREQ Driver"
>>       depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 0b6be92a25d9..bf40d04928d0 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)    += governor_passive.o
>>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)    += exynos-bus.o
>>   obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)    += imx-bus.o
>>   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)    += imx8m-ddrc.o
>> +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)    += mtk-cci-devfreq.o
>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)    += rk3399_dmc.o
>>   obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)    += sun8i-a33-mbus.o
>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)        += tegra30-devfreq.o
>> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
>> new file mode 100644
>> index 000000000000..df42da35b312
>> --- /dev/null
>> +++ b/drivers/devfreq/mtk-cci-devfreq.c
>> @@ -0,0 +1,441 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2022 MediaTek Inc.
>> + */
>> +
> 
> ..snip..
> 
>> +};
>> +
>> +static int mtk_ccifreq_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct mtk_ccifreq_drv *drv;
>> +    struct devfreq_passive_data *passive_data;
>> +    struct dev_pm_opp *opp;
>> +    unsigned long rate, opp_volt;
>> +    int ret;
>> +
>> +    drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
>> +    if (!drv)
>> +        return -ENOMEM;
>> +
>> +    drv->dev = dev;
>> +    drv->soc_data = (const struct mtk_ccifreq_platform_data *)
>> +                of_device_get_match_data(&pdev->dev);
>> +    mutex_init(&drv->reg_lock);
>> +    platform_set_drvdata(pdev, drv);
>> +
>> +    drv->cci_clk = devm_clk_get(dev, "cci");
>> +    if (IS_ERR(drv->cci_clk)) {
>> +        ret = PTR_ERR(drv->cci_clk);
>> +        return dev_err_probe(dev, ret,
>> +                     "failed to get cci clk: %d\n", ret);
>> +    }
>> +
>> +    drv->inter_clk = devm_clk_get(dev, "intermediate");
>> +    if (IS_ERR(drv->inter_clk)) {
>> +        ret = PTR_ERR(drv->inter_clk);
>> +        return dev_err_probe(dev, ret,
>> +                     "failed to get intermediate clk: %d\n", ret);
>> +    }
>> +
>> +    drv->proc_reg = devm_regulator_get_optional(dev, "proc");
> 
> In the devicetree binding for this driver, the "proc" regulator is *not* optional,
> but here you're using devm_regulator_get_optional.
> 
> If this is not optional, you should use devm_regulator_get() instead.
> 
>> +    if (IS_ERR(drv->proc_reg)) {
>> +        ret = PTR_ERR(drv->proc_reg);
>> +        return dev_err_probe(dev, ret,
>> +                     "failed to get proc regulator: %d\n", ret);
> 
> There's no need to print ret... dev_err_probe() takes care of that for you already:
> in this case, you're printing the value of ret twice.
> 

I agree. better to remove the additional 'ret' printing
from dev_err_probe. 

>> +    }
>> +
>> +    ret = regulator_enable(drv->proc_reg);
> 
> If you move this call after the devm_regulator_get_optional() call for the sram
> vreg, you will be able to use dev_err_probe for the latter as well.
> 
>> +    if (ret) {
>> +        dev_err(dev, "failed to enable proc regulator\n");
> 
> Why aren't you using dev_err_probe here, like you've done for the other instances?


dev_err is enough because it means that get to regulator instance
via regulator_get_optional. If error from regulator_enable happen,
it depends on the internal logic of pmic driver.

> 
>> +        return ret;
>> +    }
>> +
>> +    drv->sram_reg = devm_regulator_get_optional(dev, "sram");
>> +    if (IS_ERR(drv->sram_reg))
>> +        drv->sram_reg = NULL;
> 
> When you use regulator_get_optional() (including the devm_ variant of it), you
> shall return an error, if there's any... that's what the _optional() is for.
> 
> if (IS_ERR(drv->sram_reg))
>     return dev_err_probe(dev, PTR_ERR(drv->proc_reg),
>                  "failed to get sram regulator");
> 
>> +    else {
>> +        ret = regulator_enable(drv->sram_reg);
>> +        if (ret) {
>> +            dev_err(dev, "failed to enable sram regulator\n");
>> +            goto out_free_resources;
>> +        }
>> +    }
>> +
> 
> Regards,
> Angelo
> 

Hi Johnson,

Thanks for your work. Before merge, better to remove the 
'ret' printing from dev_err_probe above. I'll merge it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
