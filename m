Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C6C5726C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiGLTzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiGLTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:54:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118E17E15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:53:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g4so15768792ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkEMW8pioEJXNcilSmirSV/tMhrdW3sLsuYxfKiv9BA=;
        b=hcHuaOh4Y0w7OLHzkDCF0Me5iaZckKV38FsP4ZTpisaHbmz4PuGrh9Ko8mylhhrn6J
         v+qhGu9uUGusnXOkKF+uIyY+9VdovVaxbueGhqgz/n4YSXVG62SliIr0oZ+0dSK7eAqc
         MDth7b8RQqo/S4KunbSE/81KGwhekzACqET8vpdDPwzI2LSvDTjhYST6vKyoku2EIuQG
         5FfrEdPfIOq9xAAxO2RJF49HcdxNRI9TWabIPdIBEsOlNS8hYK7zn1JU2W9qnvoTpodt
         XIfIKnemntLeQUbPAqx/alPSAQwe1KP997z0jEBnYGxvTSCzl8DEhrTbKh5jZuA68c+V
         K54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkEMW8pioEJXNcilSmirSV/tMhrdW3sLsuYxfKiv9BA=;
        b=K2gM+hq2AqzglafEMZ/nb0GD8G+13j8Czg5Q4yfZJKg5NoDUynB5awkMZw2P17Kil9
         2RHFj7l7mFnZ9alNwkWAMU+NAkituHER7dYKPsQTfJPgza1gOExaiU67deZGzq2dPyaU
         20Cd2ZQUYw/SeBY+jyBz7LFBaEDiiL+GhDyloyDMtTlWodslI6IKSVmw+rmzSPnDzBWw
         s9Ypahikxti4HcT8+/vmehS/vzf1ZyTNaHJ7V34ez2vPpNYGQ1MHSP7jYlDsM3NpvteL
         SbYm2Dq/FRJ5mlqkE5qhz8ArEJSX/v3H5jqPwkjZkk8/kcTAc/A8leAfyocLIzs/9MFU
         ICxQ==
X-Gm-Message-State: AJIora9A3gJq7Ti40t9MdUCC6XGLQ05ww4urJAoZ+9Bcrek9SD3XzWMa
        zeY7qZDT0Y6INmvds0+hfWYF8icvnnk8JLGZ/pDjxA==
X-Google-Smtp-Source: AGRyM1vil1VBE8Ha6GlKPOrGqpdRfthPu5iFtyB3EMVBOkBHg6VPvgsQ13b8/Nkv7CaqACD1xn4N1+00fU33lt1mr18=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr25090883ybo.115.1657655636666; Tue, 12
 Jul 2022 12:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com> <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com> <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
In-Reply-To: <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 12 Jul 2022 12:53:20 -0700
Message-ID: <CAGETcx8spsUv57AFURZHiTX_j5jaLQ=5fStsc3=GhRJ9ti9xJQ@mail.gmail.com>
Subject: Re: [PATCH v4] amba: Remove deferred device addition
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:38 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Jul 12, 2022 at 5:34 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi Saravana,
> >
> > On 12.07.2022 14:25, Marek Szyprowski wrote:
> > > Hi Saravana,
> > >
> > > On 05.07.2022 10:39, Saravana Kannan wrote:
> > >> The uevents generated for an amba device need PID and CID information
> > >> that's available only when the amba device is powered on, clocked and
> > >> out of reset. So, if those resources aren't available, the information
> > >> can't be read to generate the uevents. To workaround this requirement,
> > >> if the resources weren't available, the device addition was deferred and
> > >> retried periodically.
> > >>
> > >> However, this deferred addition retry isn't based on resources becoming
> > >> available. Instead, it's retried every 5 seconds and causes arbitrary
> > >> probe delays for amba devices and their consumers.
> > >>
> > >> Also, maintaining a separate deferred-probe like mechanism is
> > >> maintenance headache.
> > >>
> > >> With this commit, instead of deferring the device addition, we simply
> > >> defer the generation of uevents for the device and probing of the device
> > >> (because drivers needs PID and CID to match) until the PID and CID
> > >> information can be read. This allows us to delete all the amba specific
> > >> deferring code and also avoid the arbitrary probing delays.
> > >>
> > >> Cc: Rob Herring <robh@kernel.org>
> > >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > >> Cc: John Stultz <john.stultz@linaro.org>
> > >> Cc: Saravana Kannan <saravanak@google.com>
> > >> Cc: Linus Walleij <linus.walleij@linaro.org>
> > >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> > >> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > >> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >> Cc: Russell King <linux@armlinux.org.uk>
> > >> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >> ---
> > >>
> > >> v1 -> v2:
> > >> - Dropped RFC tag
> > >> - Complete rewrite to not use stub devices.
> > >>
> > >> v2 -> v3:
> > >> - Flipped the if() condition for hard-coded periphids.
> > >> - Added a stub driver to handle the case where all amba drivers are
> > >>    modules loaded by uevents.
> > >> - Cc Marek after I realized I forgot to add him.
> > >>
> > >> v3 -> v4:
> > >> - Finally figured out and fixed the issue reported by Kefeng (bus match
> > >>    can't return an error other than -EPROBE_DEFER).
> > >> - I tested the patch on "V2P-CA15" on qemu
> > >> - Marek tested v3, but that was so long ago and the rebase wasn't clean,
> > >>    so I didn't include the tested-by.
> > >>
> > >> Marek/Kefeng,
> > >>
> > >> Mind giving a Tested-by?
> > >
> > >
> > > Yes, it looks that it still works fine.
> > >
> > > I've tested it by changing the Exynos power domain driver to
> > > initialize from late_initcall. This in turn lead me to a bug in
> > > generic pm_domains code in __genpd_dev_pm_attach(), which returns -2
> > > if the pm domain driver is not yet registered. After fixing that, I've
> > > successfully observed the deferred probe of PL330 driver on Exynos
> > > 4210 based boards both with this patch and without (with the old timer
> > > based code).
>
> Thanks for testing it again Marek! I was hoping you'll hit the crash
> that Sudeep was hitting and it would give me some more clues.
>
> Sudeep,
>
> This makes me think the issue you are seeing is related to your
> hardware drivers. Can you look into those please? I'm leaning towards
> merging this amba clean up and adding delays (say 1ms) to your
> clock/power domain drivers to avoid the crash you are seeing. And then
> you can figure out the actual delays needed and update it.

Sudeep,

Is there a DTS (not dtsi) file that corresponds to the board you were
testing this on?

-Saravana

>
> > While preparing a fix for the above issue in genpd I found that it has
> > been introduced by your commit 5a46079a9645 ("PM: domains: Delete usage
> > of driver_deferred_probe_check_state()"). I didn't analyze it enough,
> > but it looks that something is missing there if we are trying to probe
> > amba device. I assume that returning -EPROBE_DEFER unconditionally there
> > is also not a valid solution?
>
> Yeah, the unconditionally returning -EPROBE_DEFER wouldn't work
> because if the supplier is optional but not present, the consumer
> driver would never stop waiting for it. I'm looking into issues
> similar to the one you saw in other threads [1]. The problem always
> boils down to the supplier device's DT node not having "compatible"
> property and therefore fw_devlink creating the device link between the
> consumer and the supplier's parent.
>
> Basically if the drivers/DT are implemented "properly", you would
> never get to the failure case (-2) if the driver is actually present.
> I have some other ideas on how to get these to work better (not sure
> if it'll be for 100% of the cases), but until I get those ideas sorted
> out, I might do a partial revert of the change you mentioned.
>
> [1] - https://lore.kernel.org/lkml/4799738.LvFx2qVVIh@steina-w/
>
> -Saravana
>
> >
> >
> > >
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > >
> > >
> > >> -Saravana
> > >>
> > >>   drivers/amba/bus.c | 317 +++++++++++++++++++++------------------------
> > >>   1 file changed, 145 insertions(+), 172 deletions(-)
> > >>
> > >> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > >> index 0e3ed5eb367b..9590c93b2aea 100644
> > >> --- a/drivers/amba/bus.c
> > >> +++ b/drivers/amba/bus.c
> > >> @@ -130,11 +130,100 @@ static struct attribute *amba_dev_attrs[] = {
> > >>   };
> > >>   ATTRIBUTE_GROUPS(amba_dev);
> > >>   +static int amba_read_periphid(struct amba_device *dev)
> > >> +{
> > >> +    struct reset_control *rstc;
> > >> +    u32 size, pid, cid;
> > >> +    void __iomem *tmp;
> > >> +    int i, ret;
> > >> +
> > >> +    ret = dev_pm_domain_attach(&dev->dev, true);
> > >> +    if (ret) {
> > >> +        dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
> > >> +        goto err_out;
> > >> +    }
> > >> +
> > >> +    ret = amba_get_enable_pclk(dev);
> > >> +    if (ret) {
> > >> +        dev_dbg(&dev->dev, "can't get pclk: %d\n", ret);
> > >> +        goto err_pm;
> > >> +    }
> > >> +
> > >> +    /*
> > >> +     * Find reset control(s) of the amba bus and de-assert them.
> > >> +     */
> > >> +    rstc =
> > >> of_reset_control_array_get_optional_shared(dev->dev.of_node);
> > >> +    if (IS_ERR(rstc)) {
> > >> +        ret = PTR_ERR(rstc);
> > >> +        if (ret != -EPROBE_DEFER)
> > >> +            dev_err(&dev->dev, "can't get reset: %d\n", ret);
> > >> +        goto err_clk;
> > >> +    }
> > >> +    reset_control_deassert(rstc);
> > >> +    reset_control_put(rstc);
> > >> +
> > >> +    size = resource_size(&dev->res);
> > >> +    tmp = ioremap(dev->res.start, size);
> > >> +    if (!tmp) {
> > >> +        ret = -ENOMEM;
> > >> +        goto err_clk;
> > >> +    }
> > >> +
> > >> +    /*
> > >> +     * Read pid and cid based on size of resource
> > >> +     * they are located at end of region
> > >> +     */
> > >> +    for (pid = 0, i = 0; i < 4; i++)
> > >> +        pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
> > >> +    for (cid = 0, i = 0; i < 4; i++)
> > >> +        cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
> > >> +
> > >> +    if (cid == CORESIGHT_CID) {
> > >> +        /* set the base to the start of the last 4k block */
> > >> +        void __iomem *csbase = tmp + size - 4096;
> > >> +
> > >> +        dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
> > >> +        dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) &
> > >> 0xff;
> > >> +    }
> > >> +
> > >> +    if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> > >> +        dev->periphid = pid;
> > >> +        dev->cid = cid;
> > >> +    }
> > >> +
> > >> +    if (!dev->periphid)
> > >> +        ret = -ENODEV;
> > >> +
> > >> +    iounmap(tmp);
> > >> +
> > >> +err_clk:
> > >> +    amba_put_disable_pclk(dev);
> > >> +err_pm:
> > >> +    dev_pm_domain_detach(&dev->dev, true);
> > >> +err_out:
> > >> +    return ret;
> > >> +}
> > >> +
> > >>   static int amba_match(struct device *dev, struct device_driver *drv)
> > >>   {
> > >>       struct amba_device *pcdev = to_amba_device(dev);
> > >>       struct amba_driver *pcdrv = to_amba_driver(drv);
> > >>   +    if (!pcdev->periphid) {
> > >> +        int ret = amba_read_periphid(pcdev);
> > >> +
> > >> +        /*
> > >> +         * Returning any error other than -EPROBE_DEFER from bus match
> > >> +         * can cause driver registration failure. So, if there's a
> > >> +         * permanent failure in reading pid and cid, simply say that
> > >> +         * none of the drivers match.
> > >> +         */
> > >> +        if (ret)
> > >> +            return ret == -EPROBE_DEFER ? ret : 0;
> > >> +        dev_set_uevent_suppress(dev, false);
> > >> +        kobject_uevent(&dev->kobj, KOBJ_ADD);
> > >> +    }
> > >> +
> > >>       /* When driver_override is set, only bind to the matching
> > >> driver */
> > >>       if (pcdev->driver_override)
> > >>           return !strcmp(pcdev->driver_override, drv->name);
> > >> @@ -368,6 +457,42 @@ static int __init amba_init(void)
> > >>     postcore_initcall(amba_init);
> > >>   +static int amba_proxy_probe(struct amba_device *adev,
> > >> +                const struct amba_id *id)
> > >> +{
> > >> +    WARN(1, "Stub driver should never match any device.\n");
> > >> +    return -ENODEV;
> > >> +}
> > >> +
> > >> +static const struct amba_id amba_stub_drv_ids[] = {
> > >> +    { 0, 0 },
> > >> +};
> > >> +
> > >> +static struct amba_driver amba_proxy_drv = {
> > >> +    .drv = {
> > >> +        .name = "amba-proxy",
> > >> +    },
> > >> +    .probe = amba_proxy_probe,
> > >> +    .id_table = amba_stub_drv_ids,
> > >> +};
> > >> +
> > >> +static int __init amba_stub_drv_init(void)
> > >> +{
> > >> +    if (!IS_ENABLED(CONFIG_MODULES))
> > >> +        return 0;
> > >> +
> > >> +    /*
> > >> +     * The amba_match() function will get called only if there is at
> > >> least
> > >> +     * one amba driver registered. If all amba drivers are modules
> > >> and are
> > >> +     * only loaded based on uevents, then we'll hit a chicken-and-egg
> > >> +     * situation where amba_match() is waiting on drivers and
> > >> drivers are
> > >> +     * waiting on amba_match(). So, register a stub driver to make sure
> > >> +     * amba_match() is called even if no amba driver has been
> > >> registered.
> > >> +     */
> > >> +    return amba_driver_register(&amba_proxy_drv);
> > >> +}
> > >> +late_initcall_sync(amba_stub_drv_init);
> > >> +
> > >>   /**
> > >>    *    amba_driver_register - register an AMBA device driver
> > >>    *    @drv: amba device driver structure
> > >> @@ -410,160 +535,6 @@ static void amba_device_release(struct device
> > >> *dev)
> > >>       kfree(d);
> > >>   }
> > >>   -static int amba_read_periphid(struct amba_device *dev)
> > >> -{
> > >> -    struct reset_control *rstc;
> > >> -    u32 size, pid, cid;
> > >> -    void __iomem *tmp;
> > >> -    int i, ret;
> > >> -
> > >> -    ret = dev_pm_domain_attach(&dev->dev, true);
> > >> -    if (ret)
> > >> -        goto err_out;
> > >> -
> > >> -    ret = amba_get_enable_pclk(dev);
> > >> -    if (ret)
> > >> -        goto err_pm;
> > >> -
> > >> -    /*
> > >> -     * Find reset control(s) of the amba bus and de-assert them.
> > >> -     */
> > >> -    rstc =
> > >> of_reset_control_array_get_optional_shared(dev->dev.of_node);
> > >> -    if (IS_ERR(rstc)) {
> > >> -        ret = PTR_ERR(rstc);
> > >> -        if (ret != -EPROBE_DEFER)
> > >> -            dev_err(&dev->dev, "can't get reset: %d\n", ret);
> > >> -        goto err_clk;
> > >> -    }
> > >> -    reset_control_deassert(rstc);
> > >> -    reset_control_put(rstc);
> > >> -
> > >> -    size = resource_size(&dev->res);
> > >> -    tmp = ioremap(dev->res.start, size);
> > >> -    if (!tmp) {
> > >> -        ret = -ENOMEM;
> > >> -        goto err_clk;
> > >> -    }
> > >> -
> > >> -    /*
> > >> -     * Read pid and cid based on size of resource
> > >> -     * they are located at end of region
> > >> -     */
> > >> -    for (pid = 0, i = 0; i < 4; i++)
> > >> -        pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
> > >> -    for (cid = 0, i = 0; i < 4; i++)
> > >> -        cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
> > >> -
> > >> -    if (cid == CORESIGHT_CID) {
> > >> -        /* set the base to the start of the last 4k block */
> > >> -        void __iomem *csbase = tmp + size - 4096;
> > >> -
> > >> -        dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
> > >> -        dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) &
> > >> 0xff;
> > >> -    }
> > >> -
> > >> -    if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> > >> -        dev->periphid = pid;
> > >> -        dev->cid = cid;
> > >> -    }
> > >> -
> > >> -    if (!dev->periphid)
> > >> -        ret = -ENODEV;
> > >> -
> > >> -    iounmap(tmp);
> > >> -
> > >> -err_clk:
> > >> -    amba_put_disable_pclk(dev);
> > >> -err_pm:
> > >> -    dev_pm_domain_detach(&dev->dev, true);
> > >> -err_out:
> > >> -    return ret;
> > >> -}
> > >> -
> > >> -static int amba_device_try_add(struct amba_device *dev, struct
> > >> resource *parent)
> > >> -{
> > >> -    int ret;
> > >> -
> > >> -    ret = request_resource(parent, &dev->res);
> > >> -    if (ret)
> > >> -        goto err_out;
> > >> -
> > >> -    /* Hard-coded primecell ID instead of plug-n-play */
> > >> -    if (dev->periphid != 0)
> > >> -        goto skip_probe;
> > >> -
> > >> -    ret = amba_read_periphid(dev);
> > >> -    if (ret) {
> > >> -        if (ret != -EPROBE_DEFER) {
> > >> -            amba_device_put(dev);
> > >> -            goto err_out;
> > >> -        }
> > >> -        goto err_release;
> > >> -    }
> > >> -
> > >> -skip_probe:
> > >> -    ret = device_add(&dev->dev);
> > >> -err_release:
> > >> -    if (ret)
> > >> -        release_resource(&dev->res);
> > >> -err_out:
> > >> -    return ret;
> > >> -}
> > >> -
> > >> -/*
> > >> - * Registration of AMBA device require reading its pid and cid
> > >> registers.
> > >> - * To do this, the device must be turned on (if it is a part of
> > >> power domain)
> > >> - * and have clocks enabled. However in some cases those resources
> > >> might not be
> > >> - * yet available. Returning EPROBE_DEFER is not a solution in such
> > >> case,
> > >> - * because callers don't handle this special error code. Instead
> > >> such devices
> > >> - * are added to the special list and their registration is retried from
> > >> - * periodic worker, until all resources are available and
> > >> registration succeeds.
> > >> - */
> > >> -struct deferred_device {
> > >> -    struct amba_device *dev;
> > >> -    struct resource *parent;
> > >> -    struct list_head node;
> > >> -};
> > >> -
> > >> -static LIST_HEAD(deferred_devices);
> > >> -static DEFINE_MUTEX(deferred_devices_lock);
> > >> -
> > >> -static void amba_deferred_retry_func(struct work_struct *dummy);
> > >> -static DECLARE_DELAYED_WORK(deferred_retry_work,
> > >> amba_deferred_retry_func);
> > >> -
> > >> -#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
> > >> -
> > >> -static int amba_deferred_retry(void)
> > >> -{
> > >> -    struct deferred_device *ddev, *tmp;
> > >> -
> > >> -    mutex_lock(&deferred_devices_lock);
> > >> -
> > >> -    list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
> > >> -        int ret = amba_device_try_add(ddev->dev, ddev->parent);
> > >> -
> > >> -        if (ret == -EPROBE_DEFER)
> > >> -            continue;
> > >> -
> > >> -        list_del_init(&ddev->node);
> > >> -        kfree(ddev);
> > >> -    }
> > >> -
> > >> -    mutex_unlock(&deferred_devices_lock);
> > >> -
> > >> -    return 0;
> > >> -}
> > >> -late_initcall(amba_deferred_retry);
> > >> -
> > >> -static void amba_deferred_retry_func(struct work_struct *dummy)
> > >> -{
> > >> -    amba_deferred_retry();
> > >> -
> > >> -    if (!list_empty(&deferred_devices))
> > >> -        schedule_delayed_work(&deferred_retry_work,
> > >> -                      DEFERRED_DEVICE_TIMEOUT);
> > >> -}
> > >> -
> > >>   /**
> > >>    *    amba_device_add - add a previously allocated AMBA device
> > >> structure
> > >>    *    @dev: AMBA device allocated by amba_device_alloc
> > >> @@ -575,28 +546,30 @@ static void amba_deferred_retry_func(struct
> > >> work_struct *dummy)
> > >>    */
> > >>   int amba_device_add(struct amba_device *dev, struct resource *parent)
> > >>   {
> > >> -    int ret = amba_device_try_add(dev, parent);
> > >> -
> > >> -    if (ret == -EPROBE_DEFER) {
> > >> -        struct deferred_device *ddev;
> > >> -
> > >> -        ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
> > >> -        if (!ddev)
> > >> -            return -ENOMEM;
> > >> +    int ret;
> > >>   -        ddev->dev = dev;
> > >> -        ddev->parent = parent;
> > >> -        ret = 0;
> > >> +    ret = request_resource(parent, &dev->res);
> > >> +    if (ret)
> > >> +        return ret;
> > >>   -        mutex_lock(&deferred_devices_lock);
> > >> +    /* If primecell ID isn't hard-coded, figure it out */
> > >> +    if (!dev->periphid) {
> > >> +        /*
> > >> +         * AMBA device uevents require reading its pid and cid
> > >> +         * registers.  To do this, the device must be on, clocked and
> > >> +         * out of reset.  However in some cases those resources might
> > >> +         * not yet be available.  If that's the case, we suppress the
> > >> +         * generation of uevents until we can read the pid and cid
> > >> +         * registers.  See also amba_match().
> > >> +         */
> > >> +        if (amba_read_periphid(dev))
> > >> +            dev_set_uevent_suppress(&dev->dev, true);
> > >> +    }
> > >>   -        if (list_empty(&deferred_devices))
> > >> -            schedule_delayed_work(&deferred_retry_work,
> > >> -                          DEFERRED_DEVICE_TIMEOUT);
> > >> -        list_add_tail(&ddev->node, &deferred_devices);
> > >> +    ret = device_add(&dev->dev);
> > >> +    if (ret)
> > >> +        release_resource(&dev->res);
> > >>   -        mutex_unlock(&deferred_devices_lock);
> > >> -    }
> > >>       return ret;
> > >>   }
> > >>   EXPORT_SYMBOL_GPL(amba_device_add);
> > >
> > > Best regards
> >
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> >
