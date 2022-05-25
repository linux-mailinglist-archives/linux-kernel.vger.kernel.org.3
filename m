Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE636533E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiEYNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiEYNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:46:59 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE62C67B;
        Wed, 25 May 2022 06:46:57 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3003cb4e064so42622897b3.3;
        Wed, 25 May 2022 06:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAZ+DgPPDDVzcDc1w8sv+0S0ncjGvCusX7p+z8GYQSA=;
        b=CTrWiy1je9tiZ2ij1TQfUYG9Z7uNCWZlztLd+exIxrv991R6bWWeLN6ZMgZPdbcUST
         DshJf8yixzS1k3jIx9IhdgqcnY0CCp4D22Xrbx832euL5KBbc8RmsrF//Xo5kn5Bexkz
         UWNuyHc2L8lJ3cSHkVndyr4q2PQkpWlbrhRDzRkcWCu15uifi2qiMIkmzoMN68DvmNTy
         +YfsTinDJxOGcBeA2Q36saoU2MLQP01u++RcfvtWxh9GDWSly1Rkcoo0zUHOL2TUVsYY
         LhKjtg5VLkKtXiZoKdBXtgcjWTzNuhG9Dc71OO3CoybdeA6HBNTb/PtGQVSMWfdakSF1
         cf/g==
X-Gm-Message-State: AOAM533mrS3JT4/u9/+4L+dpcsStVWAWyxOjHMsYdBUWZ6bZJdS27R77
        to0WlfRb1GejDAO5JBj2MhfjgTGgRtyOFAbFZyE=
X-Google-Smtp-Source: ABdhPJz2UmrIsRVznag5o2/K+C1hQquZo+a1ndUPE067SJI5JbLTZS/Ql0Vf0ys9oGueNLcirzlmjJxwOrdOphckCpE=
X-Received: by 2002:a81:8844:0:b0:2fe:a7de:20c2 with SMTP id
 y65-20020a818844000000b002fea7de20c2mr34059926ywf.515.1653486416716; Wed, 25
 May 2022 06:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174852.30725-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20220523174852.30725-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 15:46:45 +0200
Message-ID: <CAJZ5v0ikhR+fhVz0HW63RhaEJ6C1OxqhBgW1EzRPS0ghmBCCsg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: int340x: Add Meteor Lake PCI device id
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Antoine Tenart <atenart@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 7:51 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add Meteor Lake PCI ID for processor thermal device.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2: Replaced Signed-off-by with Reviewed-by as per comment from
>     Srinivas Pandruvada
> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
>  .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 49932a68abac..7d52fcff4937 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -24,6 +24,7 @@
>  #define PCI_DEVICE_ID_INTEL_HSB_THERMAL        0x0A03
>  #define PCI_DEVICE_ID_INTEL_ICL_THERMAL        0x8a03
>  #define PCI_DEVICE_ID_INTEL_JSL_THERMAL        0x4E03
> +#define PCI_DEVICE_ID_INTEL_MTLP_THERMAL       0x7D03
>  #define PCI_DEVICE_ID_INTEL_RPL_THERMAL        0xA71D
>  #define PCI_DEVICE_ID_INTEL_SKL_THERMAL        0x1903
>  #define PCI_DEVICE_ID_INTEL_TGL_THERMAL        0x9A03
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index ca40b0967cdd..c2dc4c158b9d 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -358,6 +358,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
>
>  static const struct pci_device_id proc_thermal_pci_ids[] = {
>         { PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> +       { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
>         { PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
>         { },
>  };
> --

Applied as 5.19-rc material, thanks!
