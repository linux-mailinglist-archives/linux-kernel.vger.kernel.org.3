Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F310571A14
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiGLMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGLMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:35:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7D025EA9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:34:58 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220712123457euoutp027628233181c638b87c538d160f20aa73~BFRBASxWy2901329013euoutp02-
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:34:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220712123457euoutp027628233181c638b87c538d160f20aa73~BFRBASxWy2901329013euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657629297;
        bh=nvNjrCZfjjjBRxCcbb5eGCvwKX1Xg7OTSWXIbm52x/E=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=Q6l6whwAvyiZl2AvTU7DHXp+Hex9OSiUpD0QtQeWyk6kjtLWsZwz22YXJ2soA7Wwy
         g/552IO/JLz5JUqt+X1Kc8YIlOAQnGXpB1owqzhDPh5Ap0qOGIXLXOy2pPx+SORLGh
         PwIDUGpNbHSv82y87Mx8oErQ1k+f30cCzAzc6TGQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220712123456eucas1p1c7fafaf16edb6c2c380809741cf53a13~BFRAk38A93067930679eucas1p1O;
        Tue, 12 Jul 2022 12:34:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.6D.09580.07A6DC26; Tue, 12
        Jul 2022 13:34:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220712123456eucas1p16614354ba9af8ff3fd860df7affc90f9~BFRAHiECB1368713687eucas1p1N;
        Tue, 12 Jul 2022 12:34:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712123456eusmtrp211dae25e57bb39a8eca404d7289ab8b9~BFRAGngrP2773227732eusmtrp2d;
        Tue, 12 Jul 2022 12:34:56 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-d1-62cd6a70a5b1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.24.09038.07A6DC26; Tue, 12
        Jul 2022 13:34:56 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220712123455eusmtip20ae356aaae10597057840733e842b4a4~BFQ-Id5F00200002000eusmtip2A;
        Tue, 12 Jul 2022 12:34:55 +0000 (GMT)
Message-ID: <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com>
Date:   Tue, 12 Jul 2022 14:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
In-Reply-To: <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7oFWWeTDKa+N7GYO3sSo8WZ37oW
        O7aLWEz5s5zJ4vKuOWwWh6buZbTYNms5m8XdeydYLP7v2cFu0XXoL5vF8lM7WCyOrw23aPx8
        n9GB12Pb7m2sHmvmrWH0uHztIrPHxLO6Hgs2lXq0HHnL6rFpVSebx51re9g8+v8aeGw+Xe3x
        eZNcAHcUl01Kak5mWWqRvl0CV8aNlzvYC842M1bM2svRwHg4p4uRk0NCwERiet98li5GLg4h
        gRWMEn+XHmSGcL4wStxqn8sE4XxmlFi1aB5rFyMHWMvv2UkQ8eWMEp/7ZrBBOB8ZJa5OmMsG
        MpdXwE5i3aEv7CA2i4CqxPu5F6DighInZz5hAbFFBZIlzp29ChYXFrCVmPj+AxOIzSwgLnHr
        yXwwm03AUKLrbRdYjYhAlcTha5cYQZYxC7QxS1w4dJMRJMEpYC8x7XsLC0SzvETz1tlgP0gI
        rOeUOP+8HepsF4lFn5MhnhaWeHV8CzuELSPxfyfIMpCSfIm/M4whwhUS116vYYawrSXunPvF
        BlLCLKApsX6XPkTYUWLP5fMsEJ18EjfeCkIcwCcxadt0Zogwr0RHmxBEtZrErOPr4HYevHCJ
        eQKj0iykMJmF5PdZSF6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMBEd/rf
        8a87GFe8+qh3iJGJg/EQowQHs5II75+zp5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgU
        EkhPLEnNTk0tSC2CyTJxcEo1MJk1yjSsf7PVVSlQ6UH7pacFshwJQZM3it1/dWunnu+KqKki
        /H5i9zre3b8Qe9fgpJN9ivSdZXMNFGSMre7Vtnt90u5sD9srrjjz3+sblWw8LD6W+1Qci17Z
        Wz4Pnh2cG/5JjD+jijd0vYesquH+asE/6au+mewX4+4Pbdd7vY7Vg33rpavyVZMvaGv3Om77
        /KbM0NHZOs9lup/6kqrXzLsXnrZIFJnVkXlkx0+9F89rspuKTAPv6l/WOfddOOFxQORthvWB
        877NybnPbqOf+te1Kf+JkVJMyv0MkdPi+2KnLDi+yayFv71d4nDOVXd3PzUhz5LM2kLvzk1r
        Xmg8jmrrFWJnKrn0KL1ew0mJpTgj0VCLuag4EQDM11KC4wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7oFWWeTDJqWCFnMnT2J0eLMb12L
        HdtFLKb8Wc5kcXnXHDaLQ1P3Mlpsm7WczeLuvRMsFv/37GC36Dr0l81i+akdLBbH14ZbNH6+
        z+jA67Ft9zZWjzXz1jB6XL52kdlj4lldjwWbSj1ajrxl9di0qpPN4861PWwe/X8NPDafrvb4
        vEkugDtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5B
        L+PGyx3sBWebGStm7eVoYDyc08XIwSEhYCLxe3ZSFyMXh5DAUkaJm7872bsYOYHiMhInpzWw
        QtjCEn+udbFBFL1nlHj48DMzSIJXwE5i3aEvYA0sAqoS7+deYIOIC0qcnPmEBcQWFUiWaN5y
        iAnEFhawlZj4/gOYzSwgLnHryXwwm03AUKLrbRdYr4hAlcTtb5vAljELdDBLbPj/lRFi8xFG
        iX/LFoBN5RSwl5j2vYUFYpKZRNfWLkYIW16ieets5gmMQrOQHDILycJZSFpmIWlZwMiyilEk
        tbQ4Nz232EivODG3uDQvXS85P3cTIzDCtx37uWUH48pXH/UOMTJxMB5ilOBgVhLh/XP2VJIQ
        b0piZVVqUX58UWlOavEhRlNgaExklhJNzgemmLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0
        xJLU7NTUgtQimD4mDk6pBib2CeeXvbxnoHPitegb1rAj6u6vl9yyynj82X6TVNfbE34XThTx
        cnCXvk92Uag4f3GdOnNGY7Khcl+bUT3/0/gCkZ2SabfP7X9quvrSiXzv06rTNhdFqx29x7Ho
        SHyrq/APlquZW3fPevvcTdGBNUB/kmJ0nMmTjawZe368/LBUe4N8cs7jpBuzFDxf7+FIbN5/
        MuqF1wXdqmcBd4Uk2B2FTH2mfItcvVnw1A2l5Fn+Ws6BOz7uPTHRrapT/t+dq/Yqm3hPqTuG
        aF1YuYNt+0PrhJ8HzB/vuT1HO7zF62LaVY3Q6ul3jY+n9Yc4vz+isv9hWYvhTXPmM3cNexS+
        CKw0Mo06O6kl70dIMscHwy9KLMUZiYZazEXFiQAGdmBmeQMAAA==
X-CMS-MailID: 20220712123456eucas1p16614354ba9af8ff3fd860df7affc90f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
        <20220705083934.3974140-1-saravanak@google.com>
        <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 12.07.2022 14:25, Marek Szyprowski wrote:
> Hi Saravana,
>
> On 05.07.2022 10:39, Saravana Kannan wrote:
>> The uevents generated for an amba device need PID and CID information
>> that's available only when the amba device is powered on, clocked and
>> out of reset. So, if those resources aren't available, the information
>> can't be read to generate the uevents. To workaround this requirement,
>> if the resources weren't available, the device addition was deferred and
>> retried periodically.
>>
>> However, this deferred addition retry isn't based on resources becoming
>> available. Instead, it's retried every 5 seconds and causes arbitrary
>> probe delays for amba devices and their consumers.
>>
>> Also, maintaining a separate deferred-probe like mechanism is
>> maintenance headache.
>>
>> With this commit, instead of deferring the device addition, we simply
>> defer the generation of uevents for the device and probing of the device
>> (because drivers needs PID and CID to match) until the PID and CID
>> information can be read. This allows us to delete all the amba specific
>> deferring code and also avoid the arbitrary probing delays.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> ---
>>
>> v1 -> v2:
>> - Dropped RFC tag
>> - Complete rewrite to not use stub devices.
>>
>> v2 -> v3:
>> - Flipped the if() condition for hard-coded periphids.
>> - Added a stub driver to handle the case where all amba drivers are
>>    modules loaded by uevents.
>> - Cc Marek after I realized I forgot to add him.
>>
>> v3 -> v4:
>> - Finally figured out and fixed the issue reported by Kefeng (bus match
>>    can't return an error other than -EPROBE_DEFER).
>> - I tested the patch on "V2P-CA15" on qemu
>> - Marek tested v3, but that was so long ago and the rebase wasn't clean,
>>    so I didn't include the tested-by.
>>
>> Marek/Kefeng,
>>
>> Mind giving a Tested-by?
>
>
> Yes, it looks that it still works fine.
>
> I've tested it by changing the Exynos power domain driver to 
> initialize from late_initcall. This in turn lead me to a bug in 
> generic pm_domains code in __genpd_dev_pm_attach(), which returns -2 
> if the pm domain driver is not yet registered. After fixing that, I've 
> successfully observed the deferred probe of PL330 driver on Exynos 
> 4210 based boards both with this patch and without (with the old timer 
> based code).


While preparing a fix for the above issue in genpd I found that it has 
been introduced by your commit 5a46079a9645 ("PM: domains: Delete usage 
of driver_deferred_probe_check_state()"). I didn't analyze it enough, 
but it looks that something is missing there if we are trying to probe 
amba device. I assume that returning -EPROBE_DEFER unconditionally there 
is also not a valid solution?


>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
>
>> -Saravana
>>
>>   drivers/amba/bus.c | 317 +++++++++++++++++++++------------------------
>>   1 file changed, 145 insertions(+), 172 deletions(-)
>>
>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> index 0e3ed5eb367b..9590c93b2aea 100644
>> --- a/drivers/amba/bus.c
>> +++ b/drivers/amba/bus.c
>> @@ -130,11 +130,100 @@ static struct attribute *amba_dev_attrs[] = {
>>   };
>>   ATTRIBUTE_GROUPS(amba_dev);
>>   +static int amba_read_periphid(struct amba_device *dev)
>> +{
>> +    struct reset_control *rstc;
>> +    u32 size, pid, cid;
>> +    void __iomem *tmp;
>> +    int i, ret;
>> +
>> +    ret = dev_pm_domain_attach(&dev->dev, true);
>> +    if (ret) {
>> +        dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
>> +        goto err_out;
>> +    }
>> +
>> +    ret = amba_get_enable_pclk(dev);
>> +    if (ret) {
>> +        dev_dbg(&dev->dev, "can't get pclk: %d\n", ret);
>> +        goto err_pm;
>> +    }
>> +
>> +    /*
>> +     * Find reset control(s) of the amba bus and de-assert them.
>> +     */
>> +    rstc = 
>> of_reset_control_array_get_optional_shared(dev->dev.of_node);
>> +    if (IS_ERR(rstc)) {
>> +        ret = PTR_ERR(rstc);
>> +        if (ret != -EPROBE_DEFER)
>> +            dev_err(&dev->dev, "can't get reset: %d\n", ret);
>> +        goto err_clk;
>> +    }
>> +    reset_control_deassert(rstc);
>> +    reset_control_put(rstc);
>> +
>> +    size = resource_size(&dev->res);
>> +    tmp = ioremap(dev->res.start, size);
>> +    if (!tmp) {
>> +        ret = -ENOMEM;
>> +        goto err_clk;
>> +    }
>> +
>> +    /*
>> +     * Read pid and cid based on size of resource
>> +     * they are located at end of region
>> +     */
>> +    for (pid = 0, i = 0; i < 4; i++)
>> +        pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
>> +    for (cid = 0, i = 0; i < 4; i++)
>> +        cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
>> +
>> +    if (cid == CORESIGHT_CID) {
>> +        /* set the base to the start of the last 4k block */
>> +        void __iomem *csbase = tmp + size - 4096;
>> +
>> +        dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
>> +        dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 
>> 0xff;
>> +    }
>> +
>> +    if (cid == AMBA_CID || cid == CORESIGHT_CID) {
>> +        dev->periphid = pid;
>> +        dev->cid = cid;
>> +    }
>> +
>> +    if (!dev->periphid)
>> +        ret = -ENODEV;
>> +
>> +    iounmap(tmp);
>> +
>> +err_clk:
>> +    amba_put_disable_pclk(dev);
>> +err_pm:
>> +    dev_pm_domain_detach(&dev->dev, true);
>> +err_out:
>> +    return ret;
>> +}
>> +
>>   static int amba_match(struct device *dev, struct device_driver *drv)
>>   {
>>       struct amba_device *pcdev = to_amba_device(dev);
>>       struct amba_driver *pcdrv = to_amba_driver(drv);
>>   +    if (!pcdev->periphid) {
>> +        int ret = amba_read_periphid(pcdev);
>> +
>> +        /*
>> +         * Returning any error other than -EPROBE_DEFER from bus match
>> +         * can cause driver registration failure. So, if there's a
>> +         * permanent failure in reading pid and cid, simply say that
>> +         * none of the drivers match.
>> +         */
>> +        if (ret)
>> +            return ret == -EPROBE_DEFER ? ret : 0;
>> +        dev_set_uevent_suppress(dev, false);
>> +        kobject_uevent(&dev->kobj, KOBJ_ADD);
>> +    }
>> +
>>       /* When driver_override is set, only bind to the matching 
>> driver */
>>       if (pcdev->driver_override)
>>           return !strcmp(pcdev->driver_override, drv->name);
>> @@ -368,6 +457,42 @@ static int __init amba_init(void)
>>     postcore_initcall(amba_init);
>>   +static int amba_proxy_probe(struct amba_device *adev,
>> +                const struct amba_id *id)
>> +{
>> +    WARN(1, "Stub driver should never match any device.\n");
>> +    return -ENODEV;
>> +}
>> +
>> +static const struct amba_id amba_stub_drv_ids[] = {
>> +    { 0, 0 },
>> +};
>> +
>> +static struct amba_driver amba_proxy_drv = {
>> +    .drv = {
>> +        .name = "amba-proxy",
>> +    },
>> +    .probe = amba_proxy_probe,
>> +    .id_table = amba_stub_drv_ids,
>> +};
>> +
>> +static int __init amba_stub_drv_init(void)
>> +{
>> +    if (!IS_ENABLED(CONFIG_MODULES))
>> +        return 0;
>> +
>> +    /*
>> +     * The amba_match() function will get called only if there is at 
>> least
>> +     * one amba driver registered. If all amba drivers are modules 
>> and are
>> +     * only loaded based on uevents, then we'll hit a chicken-and-egg
>> +     * situation where amba_match() is waiting on drivers and 
>> drivers are
>> +     * waiting on amba_match(). So, register a stub driver to make sure
>> +     * amba_match() is called even if no amba driver has been 
>> registered.
>> +     */
>> +    return amba_driver_register(&amba_proxy_drv);
>> +}
>> +late_initcall_sync(amba_stub_drv_init);
>> +
>>   /**
>>    *    amba_driver_register - register an AMBA device driver
>>    *    @drv: amba device driver structure
>> @@ -410,160 +535,6 @@ static void amba_device_release(struct device 
>> *dev)
>>       kfree(d);
>>   }
>>   -static int amba_read_periphid(struct amba_device *dev)
>> -{
>> -    struct reset_control *rstc;
>> -    u32 size, pid, cid;
>> -    void __iomem *tmp;
>> -    int i, ret;
>> -
>> -    ret = dev_pm_domain_attach(&dev->dev, true);
>> -    if (ret)
>> -        goto err_out;
>> -
>> -    ret = amba_get_enable_pclk(dev);
>> -    if (ret)
>> -        goto err_pm;
>> -
>> -    /*
>> -     * Find reset control(s) of the amba bus and de-assert them.
>> -     */
>> -    rstc = 
>> of_reset_control_array_get_optional_shared(dev->dev.of_node);
>> -    if (IS_ERR(rstc)) {
>> -        ret = PTR_ERR(rstc);
>> -        if (ret != -EPROBE_DEFER)
>> -            dev_err(&dev->dev, "can't get reset: %d\n", ret);
>> -        goto err_clk;
>> -    }
>> -    reset_control_deassert(rstc);
>> -    reset_control_put(rstc);
>> -
>> -    size = resource_size(&dev->res);
>> -    tmp = ioremap(dev->res.start, size);
>> -    if (!tmp) {
>> -        ret = -ENOMEM;
>> -        goto err_clk;
>> -    }
>> -
>> -    /*
>> -     * Read pid and cid based on size of resource
>> -     * they are located at end of region
>> -     */
>> -    for (pid = 0, i = 0; i < 4; i++)
>> -        pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
>> -    for (cid = 0, i = 0; i < 4; i++)
>> -        cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
>> -
>> -    if (cid == CORESIGHT_CID) {
>> -        /* set the base to the start of the last 4k block */
>> -        void __iomem *csbase = tmp + size - 4096;
>> -
>> -        dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
>> -        dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 
>> 0xff;
>> -    }
>> -
>> -    if (cid == AMBA_CID || cid == CORESIGHT_CID) {
>> -        dev->periphid = pid;
>> -        dev->cid = cid;
>> -    }
>> -
>> -    if (!dev->periphid)
>> -        ret = -ENODEV;
>> -
>> -    iounmap(tmp);
>> -
>> -err_clk:
>> -    amba_put_disable_pclk(dev);
>> -err_pm:
>> -    dev_pm_domain_detach(&dev->dev, true);
>> -err_out:
>> -    return ret;
>> -}
>> -
>> -static int amba_device_try_add(struct amba_device *dev, struct 
>> resource *parent)
>> -{
>> -    int ret;
>> -
>> -    ret = request_resource(parent, &dev->res);
>> -    if (ret)
>> -        goto err_out;
>> -
>> -    /* Hard-coded primecell ID instead of plug-n-play */
>> -    if (dev->periphid != 0)
>> -        goto skip_probe;
>> -
>> -    ret = amba_read_periphid(dev);
>> -    if (ret) {
>> -        if (ret != -EPROBE_DEFER) {
>> -            amba_device_put(dev);
>> -            goto err_out;
>> -        }
>> -        goto err_release;
>> -    }
>> -
>> -skip_probe:
>> -    ret = device_add(&dev->dev);
>> -err_release:
>> -    if (ret)
>> -        release_resource(&dev->res);
>> -err_out:
>> -    return ret;
>> -}
>> -
>> -/*
>> - * Registration of AMBA device require reading its pid and cid 
>> registers.
>> - * To do this, the device must be turned on (if it is a part of 
>> power domain)
>> - * and have clocks enabled. However in some cases those resources 
>> might not be
>> - * yet available. Returning EPROBE_DEFER is not a solution in such 
>> case,
>> - * because callers don't handle this special error code. Instead 
>> such devices
>> - * are added to the special list and their registration is retried from
>> - * periodic worker, until all resources are available and 
>> registration succeeds.
>> - */
>> -struct deferred_device {
>> -    struct amba_device *dev;
>> -    struct resource *parent;
>> -    struct list_head node;
>> -};
>> -
>> -static LIST_HEAD(deferred_devices);
>> -static DEFINE_MUTEX(deferred_devices_lock);
>> -
>> -static void amba_deferred_retry_func(struct work_struct *dummy);
>> -static DECLARE_DELAYED_WORK(deferred_retry_work, 
>> amba_deferred_retry_func);
>> -
>> -#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
>> -
>> -static int amba_deferred_retry(void)
>> -{
>> -    struct deferred_device *ddev, *tmp;
>> -
>> -    mutex_lock(&deferred_devices_lock);
>> -
>> -    list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
>> -        int ret = amba_device_try_add(ddev->dev, ddev->parent);
>> -
>> -        if (ret == -EPROBE_DEFER)
>> -            continue;
>> -
>> -        list_del_init(&ddev->node);
>> -        kfree(ddev);
>> -    }
>> -
>> -    mutex_unlock(&deferred_devices_lock);
>> -
>> -    return 0;
>> -}
>> -late_initcall(amba_deferred_retry);
>> -
>> -static void amba_deferred_retry_func(struct work_struct *dummy)
>> -{
>> -    amba_deferred_retry();
>> -
>> -    if (!list_empty(&deferred_devices))
>> -        schedule_delayed_work(&deferred_retry_work,
>> -                      DEFERRED_DEVICE_TIMEOUT);
>> -}
>> -
>>   /**
>>    *    amba_device_add - add a previously allocated AMBA device 
>> structure
>>    *    @dev: AMBA device allocated by amba_device_alloc
>> @@ -575,28 +546,30 @@ static void amba_deferred_retry_func(struct 
>> work_struct *dummy)
>>    */
>>   int amba_device_add(struct amba_device *dev, struct resource *parent)
>>   {
>> -    int ret = amba_device_try_add(dev, parent);
>> -
>> -    if (ret == -EPROBE_DEFER) {
>> -        struct deferred_device *ddev;
>> -
>> -        ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
>> -        if (!ddev)
>> -            return -ENOMEM;
>> +    int ret;
>>   -        ddev->dev = dev;
>> -        ddev->parent = parent;
>> -        ret = 0;
>> +    ret = request_resource(parent, &dev->res);
>> +    if (ret)
>> +        return ret;
>>   -        mutex_lock(&deferred_devices_lock);
>> +    /* If primecell ID isn't hard-coded, figure it out */
>> +    if (!dev->periphid) {
>> +        /*
>> +         * AMBA device uevents require reading its pid and cid
>> +         * registers.  To do this, the device must be on, clocked and
>> +         * out of reset.  However in some cases those resources might
>> +         * not yet be available.  If that's the case, we suppress the
>> +         * generation of uevents until we can read the pid and cid
>> +         * registers.  See also amba_match().
>> +         */
>> +        if (amba_read_periphid(dev))
>> +            dev_set_uevent_suppress(&dev->dev, true);
>> +    }
>>   -        if (list_empty(&deferred_devices))
>> -            schedule_delayed_work(&deferred_retry_work,
>> -                          DEFERRED_DEVICE_TIMEOUT);
>> -        list_add_tail(&ddev->node, &deferred_devices);
>> +    ret = device_add(&dev->dev);
>> +    if (ret)
>> +        release_resource(&dev->res);
>>   -        mutex_unlock(&deferred_devices_lock);
>> -    }
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(amba_device_add);
>
> Best regards

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

