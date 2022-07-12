Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6D5719EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiGLMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGLMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:25:36 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F3B6DBD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:25:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220712122515euoutp02831a1782c9d8944cd9c524ed1a00c52b~BFIirmWup1977019770euoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:25:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220712122515euoutp02831a1782c9d8944cd9c524ed1a00c52b~BFIirmWup1977019770euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657628715;
        bh=MIhe9ppoLMVLs/X+G5XtdaEy5DsTK4tf/ItK5A6tJEk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=uhNxM4HUyWtS03ZEcEuyLFiqVc+nCSIneA0Q0O5kUjWbhnqTjgKOhgcFt2V8lMCuI
         /zYanZTXX6gogpyWdU7Em8Jli8UtQgLoXlEjhDl84LRZovMhYUP2peYJWFUHdleDzD
         YALLOqLU9Ejm3hSqcnoOgjyXDp4VYGMxaSBV1GqE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220712122514eucas1p1cfeaad660ed87acc3d882f72ed616960~BFIiXPcaS2384523845eucas1p1g;
        Tue, 12 Jul 2022 12:25:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 94.BB.09580.A286DC26; Tue, 12
        Jul 2022 13:25:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712122514eucas1p24f517dff4dfecf0aff59b3d84add6f33~BFIh4gaEQ2686426864eucas1p2G;
        Tue, 12 Jul 2022 12:25:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712122514eusmtrp200eac25c344ecd1e62d08758cb214bd2~BFIh3qR-l2133821338eusmtrp2h;
        Tue, 12 Jul 2022 12:25:14 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-48-62cd682a13a0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BE.B2.09038.A286DC26; Tue, 12
        Jul 2022 13:25:14 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220712122513eusmtip28c38470335c2fa13eed14a885e59bfae~BFIhBAqUg2744827448eusmtip2N;
        Tue, 12 Jul 2022 12:25:13 +0000 (GMT)
Message-ID: <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
Date:   Tue, 12 Jul 2022 14:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Content-Language: en-US
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220705083934.3974140-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjd23t7e1stuVy+HnGbpkYTNYCELblx6CTux1XnV/xhxCx4wRta
        LUVbGaJ/MHFMKlhgTruCiglarJUtdbZVaqSVUEGLAlsHC19mqAypoNgsKgVpLzr+neec5+Q5
        581LYnSHOJFUaQ7xWg2nVhAy3N7ypj1phdKXverYjSXMueoqxDx4l8Q4HbHM6UmziOm6VUMw
        np9vI8ZuMhNMX/89nJl2OSWM3hMiGHObE2e813YyxyYG0Do5a2+0i1nreStiu/wdGFvpS2Jr
        bQXs8eaAmLVZSgm21+8iWENoFXv9/lF2wvb5tnmZsvS9vFr1Pa9NWbtHphyfOiE+0Lfv8Ju+
        oKQY/bRDj6QkUF/AtPMipkcykqbqEfSUV+HC8BqBoa8VCcMEgt4zbZIPFveVZ4QgmBG0nH06
        63+JoLG4ObIlp9ZCVdPojECSOLUUhofjBDoaWn8ZwsM4jsqBdt+fRBjHUGugcmxcFMYYlQB/
        D12I4FjqCNz1d0ZSYFQJBo88PSgsEFQq6AP6iFlKpcNg2RmJYF4EjkBNJBBQV6XQNDqGCbG/
        gRcN3biAY2DE+/tsnU9h+mb4GjmD8yFkTBPow+B/bp21fgW97W+J8ApGLYdfb6UIdAa4uh7i
        gjMKugPRQoIoqLKfxQRaDidKaGF7GZi8DR9vuh91YhVIYZrzKKY55U1zupj+v1uLcAtK4At0
        ebm8Lk3DFybruDxdgSY3OSc/z4Zmft39KW/QiepHXiZ7kIhEHgQkpoiVT/rasmn5Xq7oCK/N
        z9IWqHmdBy0kcUWCPEf1G0dTudwhfj/PH+C1H1QRKU0sFh01vPCX1zarHBP81OVM1aR696ut
        NUXG1YvrfJI0t7HwHZ5q2X/PSP5AbPLd8ZVLxt2vnfWnHpfEV5zOClQMvR0cCJb1X/rusycr
        N2+Xxf2T+LhysHPMlfJ8vsu6UOKeXC+1VMsexl/pacf6DyoPRm1p/IS2RT8zG9b/e4Ee7ko2
        fctds9bcLJKGQGeMMYxUOpaVdrpLvmzJ2/Wku3Yjrr6aQTQsnn/3af2irJA4pZDWsNO76Tr7
        tqYbHQMbWst+JKXi2/EZxRuuM1u9ktLRxNWb6KHM4II9vT2BlUs8fyiXmnaWbj4VFKnY4ZP/
        nVvgx+ssjr+yua83pq9zRZ0sCipwnZJLXYFpddx7CBCBBOQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7paGWeTDNoaWCzmzp7EaHHmt67F
        ju0iFlP+LGeyuLxrDpvFoal7GS22zVrOZnH33gkWi/97drBbdB36y2ax/NQOFovja8MtGj/f
        Z3Tg9di2exurx5p5axg9Ll+7yOwx8ayux4JNpR4tR96yemxa1cnmcefaHjaP/r8GHptPV3t8
        3iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        l/HhXwdrwd2sip93v7I3ME4O7mLk5JAQMJE4uPI5WxcjF4eQwFJGiQ/3FjJCJGQkTk5rYIWw
        hSX+XOuCKnrPKLH633sWkASvgJ3EpANvmLsYOThYBFQlXrwQhQgLSpyc+QSsRFQgWaJ5yyEm
        EFtYwFZi4vsPYDazgLjErSfzwWwRgSqJ2982gc1nFuhgltjw/ysjxLJ+RokZfQfAqtgEDCW6
        3oJcwcnBKWAj8aBnGjvEJDOJrq1djBC2vMT2t3OYJzAKzUJyyCwkC2chaZmFpGUBI8sqRpHU
        0uLc9NxiI73ixNzi0rx0veT83E2MwAjfduznlh2MK1991DvEyMTBeIhRgoNZSYT3z9lTSUK8
        KYmVValF+fFFpTmpxYcYTYGBMZFZSjQ5H5hi8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNIT
        S1KzU1MLUotg+pg4OKUamHzbfrX+arr1pvn16uTLDVMLFzO1Nr8sK+NQmnB91ps1wSUPb3PG
        Hs782GCvP0GIebV9B1McX/3h2Pe3jv7nqPosOV08aBH72t39j82v2fWpmU5gM/11VMKsvnXq
        NWm7NNNT1UltKs77/+dKdG/O3mUV4RIUaewvoc+5X0c4VnHZZKm3qckxW/4KtZ0M6AoStu0K
        Vk9gXy+y0qZWRGn2gaOijT86MvJ/bnt+aO55qw/L/r0t5ljwteJb4NvV5us8Y0pCmEWjON9O
        v775SvpRk6r369rW3mfgjlja1ttowfbqVuM/vw13/+W2XnrRnayUcKwop1OxKde547Dk5CUe
        r+J2T72oq3350q/b/aqNSizFGYmGWsxFxYkAqZYdTnkDAAA=
X-CMS-MailID: 20220712122514eucas1p24f517dff4dfecf0aff59b3d84add6f33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
        <20220705083934.3974140-1-saravanak@google.com>
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

On 05.07.2022 10:39, Saravana Kannan wrote:
> The uevents generated for an amba device need PID and CID information
> that's available only when the amba device is powered on, clocked and
> out of reset. So, if those resources aren't available, the information
> can't be read to generate the uevents. To workaround this requirement,
> if the resources weren't available, the device addition was deferred and
> retried periodically.
>
> However, this deferred addition retry isn't based on resources becoming
> available. Instead, it's retried every 5 seconds and causes arbitrary
> probe delays for amba devices and their consumers.
>
> Also, maintaining a separate deferred-probe like mechanism is
> maintenance headache.
>
> With this commit, instead of deferring the device addition, we simply
> defer the generation of uevents for the device and probing of the device
> (because drivers needs PID and CID to match) until the PID and CID
> information can be read. This allows us to delete all the amba specific
> deferring code and also avoid the arbitrary probing delays.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> v1 -> v2:
> - Dropped RFC tag
> - Complete rewrite to not use stub devices.
>
> v2 -> v3:
> - Flipped the if() condition for hard-coded periphids.
> - Added a stub driver to handle the case where all amba drivers are
>    modules loaded by uevents.
> - Cc Marek after I realized I forgot to add him.
>
> v3 -> v4:
> - Finally figured out and fixed the issue reported by Kefeng (bus match
>    can't return an error other than -EPROBE_DEFER).
> - I tested the patch on "V2P-CA15" on qemu
> - Marek tested v3, but that was so long ago and the rebase wasn't clean,
>    so I didn't include the tested-by.
>
> Marek/Kefeng,
>
> Mind giving a Tested-by?


Yes, it looks that it still works fine.

I've tested it by changing the Exynos power domain driver to initialize 
from late_initcall. This in turn lead me to a bug in generic pm_domains 
code in __genpd_dev_pm_attach(), which returns -2 if the pm domain 
driver is not yet registered. After fixing that, I've successfully 
observed the deferred probe of PL330 driver on Exynos 4210 based boards 
both with this patch and without (with the old timer based code).

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> -Saravana
>
>   drivers/amba/bus.c | 317 +++++++++++++++++++++------------------------
>   1 file changed, 145 insertions(+), 172 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 0e3ed5eb367b..9590c93b2aea 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -130,11 +130,100 @@ static struct attribute *amba_dev_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(amba_dev);
>   
> +static int amba_read_periphid(struct amba_device *dev)
> +{
> +	struct reset_control *rstc;
> +	u32 size, pid, cid;
> +	void __iomem *tmp;
> +	int i, ret;
> +
> +	ret = dev_pm_domain_attach(&dev->dev, true);
> +	if (ret) {
> +		dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
> +		goto err_out;
> +	}
> +
> +	ret = amba_get_enable_pclk(dev);
> +	if (ret) {
> +		dev_dbg(&dev->dev, "can't get pclk: %d\n", ret);
> +		goto err_pm;
> +	}
> +
> +	/*
> +	 * Find reset control(s) of the amba bus and de-assert them.
> +	 */
> +	rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
> +	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(rstc);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&dev->dev, "can't get reset: %d\n", ret);
> +		goto err_clk;
> +	}
> +	reset_control_deassert(rstc);
> +	reset_control_put(rstc);
> +
> +	size = resource_size(&dev->res);
> +	tmp = ioremap(dev->res.start, size);
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto err_clk;
> +	}
> +
> +	/*
> +	 * Read pid and cid based on size of resource
> +	 * they are located at end of region
> +	 */
> +	for (pid = 0, i = 0; i < 4; i++)
> +		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
> +	for (cid = 0, i = 0; i < 4; i++)
> +		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
> +
> +	if (cid == CORESIGHT_CID) {
> +		/* set the base to the start of the last 4k block */
> +		void __iomem *csbase = tmp + size - 4096;
> +
> +		dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
> +		dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
> +	}
> +
> +	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> +		dev->periphid = pid;
> +		dev->cid = cid;
> +	}
> +
> +	if (!dev->periphid)
> +		ret = -ENODEV;
> +
> +	iounmap(tmp);
> +
> +err_clk:
> +	amba_put_disable_pclk(dev);
> +err_pm:
> +	dev_pm_domain_detach(&dev->dev, true);
> +err_out:
> +	return ret;
> +}
> +
>   static int amba_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct amba_device *pcdev = to_amba_device(dev);
>   	struct amba_driver *pcdrv = to_amba_driver(drv);
>   
> +	if (!pcdev->periphid) {
> +		int ret = amba_read_periphid(pcdev);
> +
> +		/*
> +		 * Returning any error other than -EPROBE_DEFER from bus match
> +		 * can cause driver registration failure. So, if there's a
> +		 * permanent failure in reading pid and cid, simply say that
> +		 * none of the drivers match.
> +		 */
> +		if (ret)
> +			return ret == -EPROBE_DEFER ? ret : 0;
> +		dev_set_uevent_suppress(dev, false);
> +		kobject_uevent(&dev->kobj, KOBJ_ADD);
> +	}
> +
>   	/* When driver_override is set, only bind to the matching driver */
>   	if (pcdev->driver_override)
>   		return !strcmp(pcdev->driver_override, drv->name);
> @@ -368,6 +457,42 @@ static int __init amba_init(void)
>   
>   postcore_initcall(amba_init);
>   
> +static int amba_proxy_probe(struct amba_device *adev,
> +			    const struct amba_id *id)
> +{
> +	WARN(1, "Stub driver should never match any device.\n");
> +	return -ENODEV;
> +}
> +
> +static const struct amba_id amba_stub_drv_ids[] = {
> +	{ 0, 0 },
> +};
> +
> +static struct amba_driver amba_proxy_drv = {
> +	.drv = {
> +		.name = "amba-proxy",
> +	},
> +	.probe = amba_proxy_probe,
> +	.id_table = amba_stub_drv_ids,
> +};
> +
> +static int __init amba_stub_drv_init(void)
> +{
> +	if (!IS_ENABLED(CONFIG_MODULES))
> +		return 0;
> +
> +	/*
> +	 * The amba_match() function will get called only if there is at least
> +	 * one amba driver registered. If all amba drivers are modules and are
> +	 * only loaded based on uevents, then we'll hit a chicken-and-egg
> +	 * situation where amba_match() is waiting on drivers and drivers are
> +	 * waiting on amba_match(). So, register a stub driver to make sure
> +	 * amba_match() is called even if no amba driver has been registered.
> +	 */
> +	return amba_driver_register(&amba_proxy_drv);
> +}
> +late_initcall_sync(amba_stub_drv_init);
> +
>   /**
>    *	amba_driver_register - register an AMBA device driver
>    *	@drv: amba device driver structure
> @@ -410,160 +535,6 @@ static void amba_device_release(struct device *dev)
>   	kfree(d);
>   }
>   
> -static int amba_read_periphid(struct amba_device *dev)
> -{
> -	struct reset_control *rstc;
> -	u32 size, pid, cid;
> -	void __iomem *tmp;
> -	int i, ret;
> -
> -	ret = dev_pm_domain_attach(&dev->dev, true);
> -	if (ret)
> -		goto err_out;
> -
> -	ret = amba_get_enable_pclk(dev);
> -	if (ret)
> -		goto err_pm;
> -
> -	/*
> -	 * Find reset control(s) of the amba bus and de-assert them.
> -	 */
> -	rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
> -	if (IS_ERR(rstc)) {
> -		ret = PTR_ERR(rstc);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&dev->dev, "can't get reset: %d\n", ret);
> -		goto err_clk;
> -	}
> -	reset_control_deassert(rstc);
> -	reset_control_put(rstc);
> -
> -	size = resource_size(&dev->res);
> -	tmp = ioremap(dev->res.start, size);
> -	if (!tmp) {
> -		ret = -ENOMEM;
> -		goto err_clk;
> -	}
> -
> -	/*
> -	 * Read pid and cid based on size of resource
> -	 * they are located at end of region
> -	 */
> -	for (pid = 0, i = 0; i < 4; i++)
> -		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
> -	for (cid = 0, i = 0; i < 4; i++)
> -		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
> -
> -	if (cid == CORESIGHT_CID) {
> -		/* set the base to the start of the last 4k block */
> -		void __iomem *csbase = tmp + size - 4096;
> -
> -		dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
> -		dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
> -	}
> -
> -	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> -		dev->periphid = pid;
> -		dev->cid = cid;
> -	}
> -
> -	if (!dev->periphid)
> -		ret = -ENODEV;
> -
> -	iounmap(tmp);
> -
> -err_clk:
> -	amba_put_disable_pclk(dev);
> -err_pm:
> -	dev_pm_domain_detach(&dev->dev, true);
> -err_out:
> -	return ret;
> -}
> -
> -static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> -{
> -	int ret;
> -
> -	ret = request_resource(parent, &dev->res);
> -	if (ret)
> -		goto err_out;
> -
> -	/* Hard-coded primecell ID instead of plug-n-play */
> -	if (dev->periphid != 0)
> -		goto skip_probe;
> -
> -	ret = amba_read_periphid(dev);
> -	if (ret) {
> -		if (ret != -EPROBE_DEFER) {
> -			amba_device_put(dev);
> -			goto err_out;
> -		}
> -		goto err_release;
> -	}
> -
> -skip_probe:
> -	ret = device_add(&dev->dev);
> -err_release:
> -	if (ret)
> -		release_resource(&dev->res);
> -err_out:
> -	return ret;
> -}
> -
> -/*
> - * Registration of AMBA device require reading its pid and cid registers.
> - * To do this, the device must be turned on (if it is a part of power domain)
> - * and have clocks enabled. However in some cases those resources might not be
> - * yet available. Returning EPROBE_DEFER is not a solution in such case,
> - * because callers don't handle this special error code. Instead such devices
> - * are added to the special list and their registration is retried from
> - * periodic worker, until all resources are available and registration succeeds.
> - */
> -struct deferred_device {
> -	struct amba_device *dev;
> -	struct resource *parent;
> -	struct list_head node;
> -};
> -
> -static LIST_HEAD(deferred_devices);
> -static DEFINE_MUTEX(deferred_devices_lock);
> -
> -static void amba_deferred_retry_func(struct work_struct *dummy);
> -static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
> -
> -#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
> -
> -static int amba_deferred_retry(void)
> -{
> -	struct deferred_device *ddev, *tmp;
> -
> -	mutex_lock(&deferred_devices_lock);
> -
> -	list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
> -		int ret = amba_device_try_add(ddev->dev, ddev->parent);
> -
> -		if (ret == -EPROBE_DEFER)
> -			continue;
> -
> -		list_del_init(&ddev->node);
> -		kfree(ddev);
> -	}
> -
> -	mutex_unlock(&deferred_devices_lock);
> -
> -	return 0;
> -}
> -late_initcall(amba_deferred_retry);
> -
> -static void amba_deferred_retry_func(struct work_struct *dummy)
> -{
> -	amba_deferred_retry();
> -
> -	if (!list_empty(&deferred_devices))
> -		schedule_delayed_work(&deferred_retry_work,
> -				      DEFERRED_DEVICE_TIMEOUT);
> -}
> -
>   /**
>    *	amba_device_add - add a previously allocated AMBA device structure
>    *	@dev: AMBA device allocated by amba_device_alloc
> @@ -575,28 +546,30 @@ static void amba_deferred_retry_func(struct work_struct *dummy)
>    */
>   int amba_device_add(struct amba_device *dev, struct resource *parent)
>   {
> -	int ret = amba_device_try_add(dev, parent);
> -
> -	if (ret == -EPROBE_DEFER) {
> -		struct deferred_device *ddev;
> -
> -		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
> -		if (!ddev)
> -			return -ENOMEM;
> +	int ret;
>   
> -		ddev->dev = dev;
> -		ddev->parent = parent;
> -		ret = 0;
> +	ret = request_resource(parent, &dev->res);
> +	if (ret)
> +		return ret;
>   
> -		mutex_lock(&deferred_devices_lock);
> +	/* If primecell ID isn't hard-coded, figure it out */
> +	if (!dev->periphid) {
> +		/*
> +		 * AMBA device uevents require reading its pid and cid
> +		 * registers.  To do this, the device must be on, clocked and
> +		 * out of reset.  However in some cases those resources might
> +		 * not yet be available.  If that's the case, we suppress the
> +		 * generation of uevents until we can read the pid and cid
> +		 * registers.  See also amba_match().
> +		 */
> +		if (amba_read_periphid(dev))
> +			dev_set_uevent_suppress(&dev->dev, true);
> +	}
>   
> -		if (list_empty(&deferred_devices))
> -			schedule_delayed_work(&deferred_retry_work,
> -					      DEFERRED_DEVICE_TIMEOUT);
> -		list_add_tail(&ddev->node, &deferred_devices);
> +	ret = device_add(&dev->dev);
> +	if (ret)
> +		release_resource(&dev->res);
>   
> -		mutex_unlock(&deferred_devices_lock);
> -	}
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(amba_device_add);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

