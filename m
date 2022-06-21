Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA23E553A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353693AbiFUTZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353653AbiFUTZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:25:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAFA1B1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:25:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g27so13658746wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWOOtwuch2pR8dNc7sCruhWykxDxqzJLTpOmV1VMmXk=;
        b=ekmRHn/PmRshg6mNF6L9A3ic7KQBPAVwqwB54Tr5uLJuMmxzWDVE2EbX4ysW4EAVfy
         VEfcWhmR/9AXphxVHk+zQKXBPlsxzo3cqiip2iG/y7w6Fk/iZfKKMfITFhF36lFvHGOI
         nQfBmH+IeYcLHNlv7sBcWPX7P73VQ6ws8dz4ST1tdDxIXzwSCR4Cc0p7LPKe8gh1ltIF
         Cw/cDg7F9hRjoCidrjq08QqbIGVvoNLo3glWnBWVQjzJB1rtzHT/OONoUlXlHCZ4OKOl
         lPNH4oO9I9WPrQ8OOlXQAcFYQe9wWzz+i7EWNlKedBYzlawL00ZnGpE4V1dREWmnApiJ
         fAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWOOtwuch2pR8dNc7sCruhWykxDxqzJLTpOmV1VMmXk=;
        b=eIzNhSHIVSgpYgehhpA0sZ93ETG+WEfgK2YxMuv7AJiXHTH1qdRWWZk5al8539iGXI
         CwYIzsQD/u9Uj0NesKS33WHNbfnNgWf5GaCOqfgZQGxEtnJYIGqiT+ix+XsZ5+aJp8DZ
         fArtaZMmilzIZxsGtgjsVyInSfO0u6DISy/x65Zxyv7w5x2qjzIbn6T5dYxBF8enA3Pw
         zkmGP8knC7Bj+ZscdTKt2k4YqWnrdCjyl015RlkB8sL4Q0DGZnnfWR5cputuAMqL2gTi
         V1etXwLMXIx433aj++KX+wc8QztoNtJCfttXGkKlX/Fv+C0ofzbx1jzlGrh1QVcyCdTE
         39Hw==
X-Gm-Message-State: AJIora///3mqRaE9MMq64WqZ2TPDZwhBJ1NUTI3KA1Bk2kEua/0Y0F51
        C4o4vzqeEPlto9NmHMGwc42c4Yb6mlr5ILNulJCTkg==
X-Google-Smtp-Source: AGRyM1tywJ8s0GvfVaqfGYApPEuglWdEpM9di3DFQpYPxmbGs6ObvJwXVkIFrGRa9NJAwK3shX3D0qWGAt9xYxqF20c=
X-Received: by 2002:a05:6000:1546:b0:218:555b:98ff with SMTP id
 6-20020a056000154600b00218555b98ffmr29059887wry.698.1655839515231; Tue, 21
 Jun 2022 12:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-7-tanmay.shah@xilinx.com> <20220607165245.GA890059@p14s>
 <2d905471-34f0-60d9-90f8-17ea34683836@amd.com>
In-Reply-To: <2d905471-34f0-60d9-90f8-17ea34683836@amd.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 21 Jun 2022 13:25:03 -0600
Message-ID: <CANLsYkxQQMyUsLoy7C-hyJpK-McNT7jGepdFifGoePdACncKCQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc driver
To:     "Shah, Tanmay" <tanmay.shah@amd.com>
Cc:     Tanmay Shah <tanmay.shah@xilinx.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ben.levinsky@xilinx.com" <ben.levinsky@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "openamp-system-reference@lists.openampproject.org" 
        <openamp-system-reference@lists.openampproject.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >> + */
> >> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> >> +{
> >> +    int tcm_bank_count, tcm_node;
> >> +    int i, j;
> >> +    struct zynqmp_r5_core *r5_core;
> >> +    struct device *dev = cluster->dev;
> >
> >        struct device *dev = cluster->dev;
> >          struct zynqmp_r5_core *r5_core;
> >        int tcm_bank_count, tcm_node;
> >        int i, j;
>
> Do you want to change this style for all local variables throughout the
> driver? or just for this function?

I'm not sure what you mean by "local variables"...  What I am
highlighting here is how variables are declared, i.e in a neat reverse
Xmass tree rather than in no particular order.  The same heuristic
should be applied throughout when possible.

>
> >
> >> +
> >> +    /*
> >> +     * ToDo: Use predefined TCM address space values from driver until
> >
> > s/until/while
> >
> >> +     * system-dt spec is not final for TCM
> >> +     */
> >> +    tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> >> +
> >> +    /* count per core tcm banks */
> >> +    tcm_bank_count = tcm_bank_count / cluster->core_count;
> >> +
> >> +    /*
> >> +     * r5 core 0 will use all of TCM banks in lockstep mode.
> >> +     * In split mode, r5 core0 will use 128k and r5 core1 will use another
> >> +     * 128k. Assign TCM banks to each core accordingly
> >> +     */
> >> +    tcm_node = 0;
> >> +    for (i = 0; i < cluster->core_count; i++) {
> >> +            r5_core = cluster->r5_cores[i];
> >> +            r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> >> +                                              sizeof(struct mem_bank_data *),
> >> +                                              GFP_KERNEL);
> >> +            if (!r5_core->tcm_banks)
> >> +                    return -ENOMEM;
> >> +
> >> +            for (j = 0; j < tcm_bank_count; j++) {
> >> +                    /*
> >> +                     * Use pre-defined TCM reg values.
> >> +                     * Eventually this should be replaced by values
> >> +                     * parsed from dts.
> >> +                     */
> >> +                    r5_core->tcm_banks[j] =
> >> +                            (struct mem_bank_data *)&zynqmp_tcm_banks[tcm_node];
> >> +                    tcm_node++;
> >> +            }
> >> +
> >> +            r5_core->tcm_bank_count = tcm_bank_count;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * zynqmp_r5_get_mem_region_node()
> >> + * parse memory-region property from dt node and add
> >> + * memory region carveouts
> >> + *
> >> + * @r5_core: pointer to zynqmp_r5_core type object
> >> + *
> >> + * Return: 0 for success and error code for failure.
> >> + */
> >> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> >> +{
> >> +    int res_mem_count, i;
> >> +    struct device *dev;
> >> +    struct device_node *np, *rmem_np;
> >> +    struct reserved_mem **rmem;
> >> +
> >> +    dev = r5_core->dev;
> >> +
> >
> > Extra newline.
> >
> >> +    np = r5_core->np;
> >> +
> >> +    res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> >> +                                                    sizeof(phandle));
> >> +    if (res_mem_count <= 0) {
> >> +            dev_warn(dev, "failed to get memory-region property %d\n",
> >> +                     res_mem_count);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    rmem = devm_kcalloc(dev, res_mem_count,
> >> +                        sizeof(struct reserved_mem *), GFP_KERNEL);
> >> +    if (!rmem)
> >> +            return -ENOMEM;
> >> +
> >> +    for (i = 0; i < res_mem_count; i++) {
> >> +            rmem_np = of_parse_phandle(np, "memory-region", i);
> >> +            if (!rmem_np)
> >> +                    goto release_rmem;
> >> +
> >> +            rmem[i] = of_reserved_mem_lookup(rmem_np);
> >> +            if (!rmem[i]) {
> >> +                    of_node_put(rmem_np);
> >> +                    goto release_rmem;
> >> +            }
> >> +
> >> +            of_node_put(rmem_np);
> >> +    }
> >> +
> >> +    r5_core->rmem_count = res_mem_count;
> >> +    r5_core->rmem = rmem;
> >> +    return 0;
> >> +
> >> +release_rmem:
> >> +    for (i--; i > -1; i--)
> >
> > s/"i > -1"/"i >= 0"
> >
> >> +            kfree(rmem[i]);
> >> +    devm_kfree(dev, rmem);
> >> +    return -ENOMEM;
> >> +}
> >> +
> >> +/*
> >> + * zynqmp_r5_core_init()
> >> + * Create and initialize zynqmp_r5_core type object
> >> + *
> >> + * @cluster: pointer to zynqmp_r5_cluster type object
> >> + *
> >> + * Return: 0 for success and error code for failure.
> >> + */
> >> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >> +                           enum rpu_oper_mode fw_reg_val, int tcm_mode)
> >
> > I would have expected @tcm_mode to be of type "enum rpu_tcm_comp".
> >
> >> +{
> >> +    int ret, i;
> >> +    struct zynqmp_r5_core *r5_core;
> >> +    struct device *dev = cluster->dev;
> >> +
> >> +    ret = zynqmp_r5_get_tcm_node(cluster);
> >> +    if (ret < 0) {
> >> +            dev_err(dev, "can't get tcm node, err %d\n", ret);
> >> +            return ret;
> >> +    }
> >> +
> >> +    for (i = 0; i < cluster->core_count; i++) {
> >> +            r5_core = cluster->r5_cores[i];
> >> +
> >> +            ret = zynqmp_r5_get_mem_region_node(r5_core);
> >> +            if (ret)
> >> +                    dev_warn(dev, "memory-region prop failed %d\n", ret);
> >> +
> >> +            /* Initialize r5 cores with power-domains parsed from dts */
> >> +            ret = of_property_read_u32_index(r5_core->np, "power-domains",
> >> +                                             1, &r5_core->pm_domain_id);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to get power-domains property\n");
> >> +                    return ret;
> >> +            }
> >> +
> >> +            ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> >> +                            cluster->mode, ret);
> >> +                    return ret;
> >> +            }
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/*
> >> + * zynqmp_r5_cluster_init()
> >> + * Create and initialize zynqmp_r5_cluster type object
> >> + *
> >> + * @cluster: pointer to zynqmp_r5_cluster type object
> >> + *
> >> + * Return: 0 for success and error code for failure.
> >> + */
> >> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> >> +{
> >> +    struct device *dev = cluster->dev;
> >> +    struct device_node *dev_node = dev_of_node(dev);
> >> +    struct device_node *child;
> >> +    struct platform_device *child_pdev;
> >> +    int core_count, ret, i;
> >> +    enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> >> +    struct zynqmp_r5_core **r5_cores;
> >> +    enum rpu_tcm_comb tcm_mode;
> >> +    enum rpu_oper_mode fw_reg_val;
> >> +
> >> +    ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
> >> +
> >> +    /*
> >> +     * on success returns 0, if not defined then returns -EINVAL,
> >> +     * In that case, default is LOCKSTEP mode
> >> +     */
> >> +    if (ret != -EINVAL && ret != 0) {
> >> +            dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    /*
> >> +     * For now driver only supports split mode and lockstep mode.
> >> +     * fail driver probe if either of that is not set in dts.
> >> +     */
> >> +    if (cluster_mode == LOCKSTEP_MODE) {
> >> +            tcm_mode = PM_RPU_TCM_COMB;
> >> +            fw_reg_val = PM_RPU_MODE_LOCKSTEP;
> >> +    } else if (cluster_mode == SPLIT_MODE) {
> >> +            tcm_mode = PM_RPU_TCM_SPLIT;
> >> +            fw_reg_val = PM_RPU_MODE_SPLIT;
> >> +    } else {
> >> +            dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    /*
> >> +     * Number of cores is decided by number of child nodes of
> >> +     * r5f subsystem node in dts. If Split mode is used in dts
> >> +     * 2 child nodes are expected.
> >> +     * In lockstep mode if two child nodes are available,
> >> +     * only use first child node and consider it as core0
> >> +     * and ignore core1 dt node.
> >> +     */
> >> +    core_count = of_get_available_child_count(dev_node);
> >> +    if (core_count <= 0) {
> >> +            dev_err(dev, "Invalid number of r5 cores %d", core_count);
> >> +            return -EINVAL;
> >> +    } else if (cluster_mode == SPLIT_MODE && core_count != 2) {
> >> +            dev_err(dev, "Invalid number of r5 cores for split mode\n");
> >> +            return -EINVAL;
> >> +    } else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
> >> +            dev_warn(dev, "Only r5 core0 will be used\n");
> >> +            core_count = 1;
> >> +    }
> >> +
> >> +    r5_cores = kcalloc(core_count,
> >> +                       sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
> >> +    if (!r5_cores)
> >> +            return -ENOMEM;
> >> +
> >> +    i = 0;
> >> +    for_each_available_child_of_node(dev_node, child) {
> >> +            child_pdev = of_find_device_by_node(child);
> >
> > Here a reference to child_pdev->dev is taken...
> >
> >> +            if (!child_pdev) {
> >> +                    of_node_put(child);
> >> +                    ret = -ENODEV;
> >> +                    goto release_r5_cores;
> >> +            }
> >> +
> >> +            /* create and add remoteproc instance of type struct rproc */
> >> +            r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
> >> +            if (IS_ERR(r5_cores[i])) {
> >> +                    of_node_put(child);
> >
> > If devm_rproc_alloc() fails in zynqmp_r5_add_rproc_core() the reference to
> > child_pdev-dev taken above is not released.
> >
> >
> >> +                    ret = PTR_ERR(r5_cores[i]);
> >> +                    goto release_r5_cores;
> >> +            }
> >> +
> >> +            i++;
> >> +
> >> +            /*
> >> +             * If two child nodes are available in dts in lockstep mode,
> >> +             * then ignore second child node.
> >> +             */
> >> +            if (i == core_count) {
> >> +                    of_node_put(child);
> >> +                    break;
> >> +            }
> >> +    }
> >> +
> >> +    cluster->mode = cluster_mode;
> >> +    cluster->core_count = core_count;
> >> +    cluster->r5_cores = r5_cores;
> >> +
> >> +    ret = zynqmp_r5_core_init(cluster, fw_reg_val, tcm_mode);
> >> +    if (ret < 0) {
> >> +            dev_err(dev, "failed to init r5 core err %d\n", ret);
> >> +            cluster->core_count = 0;
> >> +            cluster->r5_cores = NULL;
> >> +            goto release_r5_cores;
> >> +    }
> >> +
> >> +    return 0;
> >> +
> >> +release_r5_cores:
> >> +    for (i--; i > -1; i--) {
> >
> > s/"i > -1"/"i >= 0"
> >
> >> +            put_device(r5_cores[i]->dev);
> >> +            rproc_del(r5_cores[i]->rproc);
> >> +    }
> >> +    kfree(r5_cores);
> >> +    return ret;
> >> +}
> >> +
> >> +static void zynqmp_r5_core_exit(struct zynqmp_r5_core *r5_core)
> >> +{
> >> +    /* release r5_core device */
> >> +    put_device(r5_core->dev);
> >> +
> >> +    rproc_del(r5_core->rproc);
> >> +}
> >> +
> >> +static void zynqmp_r5_cluster_exit(void *data)
> >> +{
> >> +    struct platform_device *pdev = (struct platform_device *)data;
> >> +    struct zynqmp_r5_cluster *cluster;
> >> +    int i;
> >> +
> >> +    cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
> >> +    if (!cluster)
> >> +            return;
> >> +
> >> +    for (i = 0; i < cluster->core_count; i++) {
> >> +            zynqmp_r5_core_exit(cluster->r5_cores[i]);
> >
> > I don't see a need for this extra function.  Just call put_device() and
> > rproc_del() here.
> >
> >> +            cluster->r5_cores[i] = NULL;
> >
> > Not sure this is useful since both cluster->r5_cores and cluster are freed
> > below.
> >
> > I will review zynqmp_r5_rproc_ops and up tomorrow and Thursday.
> >
> > Thanks,
> > Mathieu
> >
> >> +    }
> >> +
> >> +    kfree(cluster->r5_cores);
> >> +    kfree(cluster);
> >> +    platform_set_drvdata(pdev, NULL);
> >> +}
> >> +
> >> +/*
> >> + * zynqmp_r5_remoteproc_probe()
> >> + *
> >> + * @pdev: domain platform device for R5 cluster
> >> + *
> >> + * called when driver is probed, for each R5 core specified in DT,
> >> + * setup as needed to do remoteproc-related operations
> >> + *
> >> + * Return: 0 for success, negative value for failure.
> >> + */
> >> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> >> +{
> >> +    int ret;
> >> +    struct zynqmp_r5_cluster *cluster;
> >> +    struct device *dev = &pdev->dev;
> >> +
> >> +    cluster = kzalloc(sizeof(*cluster), GFP_KERNEL);
> >> +    if (!cluster)
> >> +            return -ENOMEM;
> >> +
> >> +    cluster->dev = dev;
> >> +
> >> +    ret = devm_of_platform_populate(dev);
> >> +    if (ret) {
> >> +            dev_err_probe(dev, ret, "failed to populate platform dev\n");
> >> +            kfree(cluster);
> >> +            return ret;
> >> +    }
> >> +
> >> +    /* wire in so each core can be cleaned up at driver remove */
> >> +    platform_set_drvdata(pdev, cluster);
> >> +
> >> +    ret = zynqmp_r5_cluster_init(cluster);
> >> +    if (ret) {
> >> +            zynqmp_r5_cluster_exit(pdev);
> >> +            dev_err_probe(dev, ret, "Invalid r5f subsystem device tree\n");
> >> +            return ret;
> >> +    }
> >> +
> >> +    ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/* Match table for OF platform binding */
> >> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> >> +    { .compatible = "xlnx,zynqmp-r5fss", },
> >> +    { /* end of list */ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> >> +
> >> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> >> +    .probe = zynqmp_r5_remoteproc_probe,
> >> +    .driver = {
> >> +            .name = "zynqmp_r5_remoteproc",
> >> +            .of_match_table = zynqmp_r5_remoteproc_match,
> >> +    },
> >> +};
> >> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> >> +
> >> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> >> +MODULE_AUTHOR("Xilinx Inc.");
> >> +MODULE_LICENSE("GPL");
> >> --
> >> 2.25.1
> >>
>
> --
> Thanks,
> Tanmay
> tanmay.shah@amd.com
