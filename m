Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4B59CF78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiHWD0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbiHWDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:25:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC735C963
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:25:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r10so8802848oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=fffmNYLGo81FxNWq7HKUF+9vnBo+ApQB0bLNovia0Ps=;
        b=SqIyFkbC8kfiSGs2nViNZRZfai5SQ+5Ug+q2stJagUm0xUrR4yVJjA/52qOt/F4qTT
         cly9T2LxBvbdeUImfwcXUM3rj1CCjrPIyLbURcoxABrfIhfu/AJB5qXZtM30MDnz51Ps
         dVAGqNNQf2R34R9TvCaUvZvu8S6fdGaWkmlTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fffmNYLGo81FxNWq7HKUF+9vnBo+ApQB0bLNovia0Ps=;
        b=WLY/M5pct6U5j7MJMwizFj1ReJKkwQ8P0DtJX0C6+0X8mQbPxi5fyCN3M5tFDGQZ9R
         pEyFqcM7Tspz9PnIlETG+ZjKSTF/SRUQ4GTiw/3xl04lf+Jc2u/JKv+C7qbJ6QjzNCa9
         sh/5iemtwcoOZkBD3hEIaLqkTVBXqAdV1FTr9bjMQODXfqfIesxjp/L85fhx7qjtSVNy
         /LPvidr+hIsmD2ci7lpeLlsG0WZeGf9H/ZuvNmfAmYWGl6s+uEG0GYXo6gL5sYzG1Nd7
         yVtv+IrxYJTfjM2NT6oDQTnfTrp2YwlZ4SHjbmNF7rV05fk66effPl/dx7fg8jZNREyr
         gtmA==
X-Gm-Message-State: ACgBeo2y0wrEY7InmAvj3ET6VJ5quYocJhlIc1vZ0aPi3RN2fAYGiX15
        R5rxjNHIQY+7WemiwIqgqO1Zw3CKh82idIiUJCSSYA==
X-Google-Smtp-Source: AA6agR68Vx51dJQKbnN0lUPWYa6fMVK+jKC9+sq5Rm2J+Kz+JIetLjkYYPhvnce6qf5O0iGmCr5GPX2KW8CyLhhNQy8=
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id
 o10-20020a0568080bca00b00344ef42930fmr539274oik.0.1661225146600; Mon, 22 Aug
 2022 20:25:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Aug 2022 22:25:46 -0500
MIME-Version: 1.0
In-Reply-To: <1661156523-22611-7-git-send-email-quic_srivasam@quicinc.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com> <1661156523-22611-7-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 22 Aug 2022 22:25:46 -0500
Message-ID: <CAE-0n53G_nKUPDDZtH1i9=G9s9ATV=iTdpuFcU6y1oeKyc0B9w@mail.gmail.com>
Subject: Re: [RESEND v5 6/7] remoteproc: qcom: Add support for memory sandbox
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-08-22 01:22:02)
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index b0a63a0..d01c97e 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -333,6 +336,185 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>         return 0;
>  }
>
> +static void adsp_of_unmap_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
> +{
> +       unsigned long iova;
> +       unsigned int mem_size;
> +       int i;
> +
> +       len /= sizeof(__be32);
> +       for (i = 0; i < len; i++) {
> +               iova = be32_to_cpu(prop[i++]);
> +               /* Skip Physical address*/
> +               i++;
> +               mem_size = be32_to_cpu(prop[i++]);
> +               iommu_unmap(iommu_dom, iova, mem_size);
> +       }
> +}
> +
> +static void adsp_rproc_unmap_smmu(struct rproc *rproc, int len)
> +{
> +       struct fw_rsc_devmem *rsc_fw;
> +       struct fw_rsc_hdr *hdr;
> +       int offset;
> +       int i;
> +
> +       for (i = 0; i < len; i++) {
> +               offset = rproc->table_ptr->offset[i];
> +               hdr = (void *)rproc->table_ptr + offset;
> +               rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
> +
> +               iommu_unmap(rproc->domain, rsc_fw->da, rsc_fw->len);
> +       }
> +}
> +
> +static void adsp_unmap_smmu(struct rproc *rproc)
> +{
> +       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +       const __be32 *prop;
> +       unsigned int len;
> +
> +       iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +
> +       prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
> +       if (prop) {
> +               adsp_of_unmap_smmu(adsp->iommu_dom, prop, len);
> +       } else {
> +               if (rproc->table_ptr)
> +                       adsp_rproc_unmap_smmu(rproc, rproc->table_ptr->num);
> +       }
> +
> +       iommu_domain_free(adsp->iommu_dom);
> +}
> +
> +static int adsp_of_map_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
> +{
> +       unsigned long mem_phys;
> +       unsigned long iova;
> +       unsigned int mem_size;
> +       unsigned int flag;
> +       int access_level;
> +       int ret;
> +       int i;
> +
> +       len /= sizeof(__be32);
> +       for (i = 0; i < len; i++) {
> +               iova = be32_to_cpu(prop[i++]);
> +               mem_phys = be32_to_cpu(prop[i++]);
> +               mem_size = be32_to_cpu(prop[i++]);
> +               access_level = be32_to_cpu(prop[i]);
> +
> +               if (access_level)
> +                       flag = IOMMU_READ | IOMMU_WRITE;
> +               else
> +                       flag = IOMMU_READ;
> +
> +               ret = iommu_map(iommu_dom, iova, mem_phys, mem_size, flag);
> +               if (ret) {
> +                       pr_err("failed to map addr = %p mem_size = %x\n", &(mem_phys), mem_size);

Why can't this be dev_err()?

> +                       goto of_smmu_unmap;
> +               }
> +       }
> +       return 0;
> +of_smmu_unmap:
> +       adsp_of_unmap_smmu(iommu_dom, prop, i);
> +       return ret;
> +}
> +
> +static int adsp_rproc_map_smmu(struct rproc *rproc, int len)
> +{
> +       struct fw_rsc_devmem *rsc_fw;

const?

> +       struct fw_rsc_hdr *hdr;

const?

> +       int offset;
> +       int ret;
> +       int i;
> +
> +       if (!rproc->table_ptr)
> +               return 0;
> +
> +       for (i = 0; i < rproc->table_ptr->num; i++) {
> +               offset = rproc->table_ptr->offset[i];
> +               hdr = (void *)rproc->table_ptr + offset;
> +               rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
> +
> +               ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
> +                                       rsc_fw->len, rsc_fw->flags);
> +               if (ret) {
> +                       pr_err("failed to map addr = %x mem_size = %x\n", rsc_fw->pa, rsc_fw->len);

Why can't this be dev_err()?

> +                       goto  rproc_smmu_unmap;
> +               }
> +       }
> +
> +       return 0;
> +
> +rproc_smmu_unmap:
> +       adsp_rproc_unmap_smmu(rproc, i);

Does i need to be incremented? And/or unmap should be done in reverse.

> +       return ret;
> +}
> +
> +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
> +{
> +       struct of_phandle_args args;
> +       const __be32 *prop;
> +       long long sid;
> +       unsigned int len;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);
> +       if (ret < 0)
> +               sid = -1;

Is it a good idea to set the sid to -1? Does that mean all stream IDs?

> +       else
> +               sid = args.args[0] & SID_MASK_DEFAULT;
> +
> +       adsp->iommu_dom = iommu_domain_alloc(adsp->dev->bus);
> +       if (!adsp->iommu_dom) {
> +               dev_err(adsp->dev, "failed to allocate iommu domain\n");
> +               ret = -ENOMEM;
> +               goto domain_free;
> +       }
> +
> +       ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
> +       if (ret) {
> +               dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
> +               ret = -EBUSY;

Why do we overwrite the error value?

> +               goto detach_device;
> +       }
> +
> +       /* Add SID configuration for ADSP Firmware to SMMU */
> +       adsp->mem_phys =  adsp->mem_phys | (sid << 32);
> +
> +       ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
> +                       adsp->mem_size, IOMMU_READ | IOMMU_WRITE);
> +       if (ret) {
> +               dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
> +               goto sid_unmap;
> +       }
> +
> +       prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);

I find it odd that we're encoding virtual addresses (iovas) into
devicetree. Presumably the physical address needs to be in DT as a
carveout, but after that I would think we're free to allocate the
segments from the carveout however we see fit and then program that into
the SMMU. Maybe DT can be a suggestion, but otherwise can it be ignored?

> +       if (prop) {
> +               ret = adsp_of_map_smmu(adsp->iommu_dom, prop, len);
> +               if (ret) {
> +                       dev_err(adsp->dev, "Unable to map memory regions accessed by ADSP\n");
> +                       goto sid_unmap;
> +               }
> +       } else {
> +               ret = adsp_rproc_map_smmu(rproc, len);
> +               if (ret) {
> +                       dev_err(adsp->dev, "Unable to map memory regions accessed by ADSP\n");

Maybe this should be a different string in case it is confused with the
above print of the same string.

> +                       goto sid_unmap;
> +               }
> +       }
> +       return 0;
> +
> +sid_unmap:
> +       iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +detach_device:
> +       iommu_domain_free(adsp->iommu_dom);
> +domain_free:
> +       return ret;
> +}
> +
> +
>  static int adsp_start(struct rproc *rproc)
>  {
>         struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -343,9 +525,16 @@ static int adsp_start(struct rproc *rproc)
>         if (ret)
>                 return ret;
>
> +       if (adsp->adsp_sandbox_needed) {
> +               ret = adsp_map_smmu(adsp, rproc);
> +               if (ret) {
> +                       dev_err(adsp->dev, "ADSP smmu mapping failed\n");
> +                       goto disable_irqs;
> +               }
> +       }

Newline here please.

>         ret = clk_prepare_enable(adsp->xo);
>         if (ret)
> -               goto disable_irqs;
> +               goto adsp_smmu_unmap;
>
>         ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
>                                     adsp->proxy_pd_count);
