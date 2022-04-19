Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB95067AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiDSJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiDSJ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:28:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400E27FD3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:25:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g18so21537351wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVmGu64HyeyAZzKuzIehzK+dbcp+uasGY7c7tKrsK6Q=;
        b=loDeX0yVrkg3GluWrjP7aZ7M3FT9n22j6L1qrs9YsQTltHHvJJCc3y56KmhBl3sqe8
         1LKe5YEzPqftEuYMRf4RiH/f53uwFsmqW82h8kbkRJUnBsQX6m6cZ1VnrzK7kt/eogUe
         HQi+s1ZlhtyPtqgNaJFM4vdbicAEfgW1CBJb7vR9+DQm3mlP+FQ+cjMhfK+gWEyE0f65
         SD1Cc52YV8G/wx5ssRH4+cI6fVudIpSubBFVKZ7cxin/BYx2afWDUi6/irEjS0sgfAT+
         oxMBua1lMOBRSQ1hK/38tE4EKKZGX746oo/4dza5QRfaFbXu0uzjiKIw5xYnbcnHvOt4
         kpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVmGu64HyeyAZzKuzIehzK+dbcp+uasGY7c7tKrsK6Q=;
        b=L3kIMqzvkvT4cb8E4EAo2QWur4k0I6Zyg/CAnLzH63anBpc6AYIsXlJVPFfAHsHoxD
         e4mBmIskBVH1aWwBkUGBw80RzyS+35Ex87ED3swCw1qyCHM4Agey1237s/WfRP0X98fU
         /OfEnCDfWjugiwpEYF33ta507yFj9KRkfDhMd+cDM6yQsWDCmLNcvAAbOwDUTKDMMVmS
         fDXIq9BUZB3kYx7UEasg3eCz7wnTuFYuEBgkfjpAVoP6MRZu9Reem6odogkf4JsDkl0Q
         GneE9EAgrZuVEIdtYmvbr7UdrAopyelA3bOweopeVSsF6QxfplNL4bS7ajSo3/d42eyb
         K3bQ==
X-Gm-Message-State: AOAM530wWIE4pNkg57OKyoBM5O8vlb0+63YnvAelLiczDcUZTZvaVoQX
        vn4MxIZIrEAprj4II/FO/U7SrpXoKOm8vWPVcf5l5g==
X-Google-Smtp-Source: ABdhPJy4LMvCOsIcHOlbW8mjefXgM4G+1U2IhqdZHfwseqUoR7C9D/OvU5jpEERqI1ZhVeYS+IGjUmTZu2Dq7hPIn8g=
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id
 t8-20020adfe108000000b001ef97ad5372mr10746333wrz.658.1650360340796; Tue, 19
 Apr 2022 02:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-7-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-7-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 19 Apr 2022 10:25:39 +0100
Message-ID: <CAJ9a7VjL_EPLGubKVjCyng=yhHOfa4TToMtCk3JN6fNJTnsK_g@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
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

Hi

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Add API usage document for sysfs API in TPDM driver.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tpdm    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> new file mode 100644
> index 000000000000..d70ba429f38d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -0,0 +1,13 @@
> +What:          /sys/bus/coresight/devices/<tpdm-name>/integration_test
> +Date:          April 2022
> +KernelVersion  5.18
> +Contact:       Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +               (Write) Run integration test for tpdm. Integration test
> +               will generate test data for tpdm. It can help to make
> +               sure that the trace path is enabled and the link configurations
> +               are fine.
> +
> +               value to this sysfs node:
> +               1 : Genreate 64 bits data
s/Genreate/Generate

> +               2 : Generate 32 bits data
> --
> 2.17.1
>

Reviewed by: Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
