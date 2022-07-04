Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D8565AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiGDQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiGDQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:09:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165060F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:09:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a13so16494589lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WJVAEEOqZf/c0UJGaBs7tzD5kguOuI1k0LugLIqiQeI=;
        b=Hjd+TBHdBXJ3ZjKAIlKK4sAvD44g9T5vaRgKu1+NgwW5O2e629rfsdmPuYUdsYJIEZ
         96ALf7T4PpJyvuHQ6xfWADOfr3sxdX7Dz0HYmZH3zb6dB/WUTMSUOfG9XEsgBhcqjSAe
         AnRUEMNZuLVaB29RrHS5JhIIsiiVobsrj1KZ6qgKUoMlHN86kxBHKhBG99KbYFHAv2OK
         WmTop1uh63NjguqO330E3NX4CfYo13aRF1Zzc77n2yJqP7FXzTWdDYr0db+8DhPzFt/i
         iC/hleci10i527XXk0rcwtH3m86tAzS0sW3J2W6u0o0KhiOGOsCx6SEcc1yUiu+Etilz
         /f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WJVAEEOqZf/c0UJGaBs7tzD5kguOuI1k0LugLIqiQeI=;
        b=fbcqUZVjS6isvVQbkK/+N8D0DXDsKjZUN54YVzthnQKM/LgHH69cjkbRf0ormjaxz1
         fcf9WwnTWcyK6zZznaVx29CwFGkrdySJZSwfvkWyJmF710mhxzL8Q0YdOPVgE13Jz1DM
         zAANTLDUDHDbWB3DWkceMv+Iz3n+0irTXKYuGUSyINzG02b1wx57qO0Dq9EC9A0uoM6x
         uVx2sVEhYsBs9rnUl9Zmu7BuYjvJ9ro11rpsMBY/VL3JKgEoHDWpE9J3VFKe55OTFNGo
         Y3zYQlIMfAZVQr9Ut6tuBMMrYa8S4Z8es2O2h4eAHDlCx+NNdD+As0Y0iReLoLwFesk8
         w8IA==
X-Gm-Message-State: AJIora+lMqHC7cUMNdkD6te/xM9yVkw/wBJ3N3LVdGDhatpUaR1+iFkM
        +Kp5VCoGJDT52FOWyB0Y1sKqEg==
X-Google-Smtp-Source: AGRyM1uzVAD1qtVQ/MPa7u6NdJY9Fy38K5NEgvbnwQF48G2XtfB8NCLbycRD3bpowOAiYCHUVib8pQ==
X-Received: by 2002:ac2:4a63:0:b0:47f:9e6d:603b with SMTP id q3-20020ac24a63000000b0047f9e6d603bmr19004089lfp.404.1656950984504;
        Mon, 04 Jul 2022 09:09:44 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512314600b004795bcfe953sm5189039lfi.214.2022.07.04.09.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 09:09:43 -0700 (PDT)
Message-ID: <07c29682-41d7-5624-b08a-35dd0c223d1e@linaro.org>
Date:   Mon, 4 Jul 2022 19:09:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/6] Add APSS RSC to Cluster power domain
Content-Language: en-GB
To:     Maulik Shah <quic_mkshah@quicinc.com>, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 16:16, Maulik Shah wrote:
> Changes in v2:
> - First four changes from v1 are already in linux-next, drop them
> - Update dt-bindings change to yaml format
> - Address Ulf's comments from v1 patches
> 
> This series patches 1 to 4 adds/corrects the cpuidle states/
> apps_rsc TCS configuration to make it same as downstream kernel.
> 
> The patches 5, 6 and 7 adds apps_rsc device to cluster power domain such
> that when cluster is going to power down the cluster pre off notification
> will program the 'sleep' and 'wake' votes in SLEEP TCS and WAKE TCSes.
> 
> The patches 8, 9 and 10 are to program the next wakeup in CONTROL_TCS.
> 
> [1], [2] was older way of programming CONTROL_TCS (exporting an API and
> calling when last CPU was entering deeper low power mode). Now with patch
> number 5,6 and 7 the apps RSC is added to to cluster power domain and hence
> these patches are no longer needed with this series.
> 
> The series is tested on SM8250 with latest linux-next tag next-20220107.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20190218140210.14631-3-rplsssn@codeaurora.org/
> [2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=59613

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450

Also please note, that these patches fix the regression on sm8[1234]50, 
which dates back to 5.18 (because the dts parts were merged at that 
point). Amit has responded rpmh clock timeouts on RB5. On SM8450 we 
observed random board stalls. Could you please describe this in the 
cover letter and follow the process described in stable-kernel-rules.rst 
to get these patches backported into 5.18/5.19. It would be critical to 
get them in through the stable queue.

> 
> Lina Iyer (1):
>    soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain
> 
> Maulik Shah (5):
>    dt-bindings: soc: qcom: Update devicetree binding document for
>      rpmh-rsc
>    arm64: dts: qcom: Add power-domains property for apps_rsc
>    PM: domains: Store the closest hrtimer event of the domain CPUs
>    soc: qcom: rpmh-rsc: Save base address of drv
>    soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup
> 
>   .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |   5 +
>   arch/arm64/boot/dts/qcom/sm8150.dtsi               |   1 +
>   arch/arm64/boot/dts/qcom/sm8250.dtsi               |   1 +
>   arch/arm64/boot/dts/qcom/sm8350.dtsi               |   1 +
>   arch/arm64/boot/dts/qcom/sm8450.dtsi               |   1 +
>   drivers/base/power/domain.c                        |  24 ++++
>   drivers/base/power/domain_governor.c               |   1 +
>   drivers/soc/qcom/rpmh-internal.h                   |   9 +-
>   drivers/soc/qcom/rpmh-rsc.c                        | 146 +++++++++++++++++++--
>   drivers/soc/qcom/rpmh.c                            |   4 +-
>   include/linux/pm_domain.h                          |   7 +
>   11 files changed, 184 insertions(+), 16 deletions(-)
> 


-- 
With best wishes
Dmitry
