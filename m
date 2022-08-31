Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3540C5A7895
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiHaILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiHaIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:11:28 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA97642E3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:11:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11eb44f520dso18197568fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IThx7ewIU6azW3sLn1BeaFcNjprihRTPt0DjgsNUm7k=;
        b=pM7HEjYq3ykY2Jtr2/pjZObHyCoUdu3gmLHwwYTyyGhI5HMOpq+emabjGGqdY1r+ue
         f+rekOkFSEEubZgRhOVX3vwbDwq21m5x/k/YOPLKvDCewEgANxOsxnZrEGGFufaIUeJP
         n+VIlK8Pditi8CWIXKv0WNOoHH77LWW2vpESN4l/1K81ltcYKF2TwqbMEYpGyKtRTajB
         kJcZFbRyNesHZSjH5iITgTSOFuGuoFI24BwGVCmCZ/uXgaSLaReTjAQnHlhuIAQMgPHj
         h2jJCDzkk9DcwQdnNoxps/OFFq+tn7UWc5c5aZST5kx3gs2tOnelJrKuJEZEMowK3Fhw
         pA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IThx7ewIU6azW3sLn1BeaFcNjprihRTPt0DjgsNUm7k=;
        b=DKp93mPXi6X8O8PZUNlvDyHFB61mLAh1ZEBpF0TiPRsVSREduGkyG23U3LhUqJi4cs
         b8MyRTRyy5AVRzk60J3HIPDRzB5d9eYyO9fEFePFOMoMiOCYO8ACSWX2hlL4sNTUKy1W
         AY6Lko+3CSF77XW2R5eqtWFXdbyYIKzCB0pVz1i4JILH2kmjU9MeD7ExyqxRr77x3D9c
         LaWEkHo9zAaQOTQrKH7tzzG1pUwYAdIF4+GE+gdZ/C5UpGPW5JnhcX6Zvg3jJj5i2EkK
         f7J39dwiv53yI5FN55aIFLTun+M2BXka+PolrUYDOSh/QjsUyQDhrWRjWC+Oq3KDEczO
         EWrg==
X-Gm-Message-State: ACgBeo3/L3f3V1touMeE7Jlz2deDYmhBj0f8hWLND7tHhkHepQpkiYZd
        X5ObI/dILorEqNi2bDKERNpSRHhYNMiLx4QxAUxetQ==
X-Google-Smtp-Source: AA6agR5BQP0YZDeoqoxupBK9/08QOD/DF2ceSgx9W2keBirZJCnci8BcWoypJX+YJum+Aqx9YzC7yXn5ejpJwAzFuCY=
X-Received: by 2002:a05:6808:8db:b0:344:fb71:2159 with SMTP id
 k27-20020a05680808db00b00344fb712159mr706259oij.34.1661933485314; Wed, 31 Aug
 2022 01:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172614.340962-1-james.clark@arm.com> <20220830172614.340962-2-james.clark@arm.com>
In-Reply-To: <20220830172614.340962-2-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 31 Aug 2022 09:11:14 +0100
Message-ID: <CAJ9a7Vg41LZSLYvvk440-rR=BqU=qn80ZqHCJSfHUfkEQb8_UA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] coresight: Remove unused function parameter
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 at 18:26, James Clark <james.clark@arm.com> wrote:
>
> The ability to use a custom function in this sysfs show function isn't
> used so remove it.
>
> No functional changes.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index ff1dd2092ac5..f2458b794ef3 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -40,31 +40,23 @@
>  #define ETM_MODE_EXCL_KERN     BIT(30)
>  #define ETM_MODE_EXCL_USER     BIT(31)
>
> -typedef u32 (*coresight_read_fn)(const struct device *, u32 offset);
> -#define __coresight_simple_func(type, func, name, lo_off, hi_off)      \
> +#define __coresight_simple_show(type, name, lo_off, hi_off)            \
>  static ssize_t name##_show(struct device *_dev,                                \
>                            struct device_attribute *attr, char *buf)    \
>  {                                                                      \
>         type *drvdata = dev_get_drvdata(_dev->parent);                  \
> -       coresight_read_fn fn = func;                                    \
>         u64 val;                                                        \
>         pm_runtime_get_sync(_dev->parent);                              \
> -       if (fn)                                                         \
> -               val = (u64)fn(_dev->parent, lo_off);                    \
> -       else                                                            \
> -               val = coresight_read_reg_pair(drvdata->base,            \
> -                                                lo_off, hi_off);       \
> +       val = coresight_read_reg_pair(drvdata->base, lo_off, hi_off);   \
>         pm_runtime_put_sync(_dev->parent);                              \
>         return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);              \
>  }                                                                      \
>  static DEVICE_ATTR_RO(name)
>
> -#define coresight_simple_func(type, func, name, offset)                        \
> -       __coresight_simple_func(type, func, name, offset, -1)
>  #define coresight_simple_reg32(type, name, offset)                     \
> -       __coresight_simple_func(type, NULL, name, offset, -1)
> +       __coresight_simple_show(type, name, offset, -1)
>  #define coresight_simple_reg64(type, name, lo_off, hi_off)             \
> -       __coresight_simple_func(type, NULL, name, lo_off, hi_off)
> +       __coresight_simple_show(type, name, lo_off, hi_off)
>
>  extern const u32 coresight_barrier_pkt[4];
>  #define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
