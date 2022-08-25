Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57E65A0842
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiHYFAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHYFAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:00:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A45A6CD32
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:00:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so17544212plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UWjij6HfXG1L6CDyEPygsAN2cmdpPEE9uumQe7csasE=;
        b=P/1STGabxCTV+e4rAyeIpVbH6ReMZxIVb5Tz8/mIn2Gc6FfVZg0fXX+kGME4tH51k5
         bpK3eaEVFAHO70cLUuAEUOWPFtmJ3EikhPydwufSF9m+778sFoE23IhIbGf1E2RfYJJH
         uDrpoVcnv3bqzteAwjCOp/5c2pBPjJ4PVXgMOIJgapcJMUu5q5nl6lSPXPhHen30bzxJ
         wRbPSd2IThnOIS10K4DAw7sZYFrsb+IOhDrNv2nFtemgzK5iWuq1EeeH0qyC57aDX/oN
         bvwdZUSC8MXf8lHejbX1sMHonI7E4ADASU1UBDJNpmMghc3RI2qtq++TIXt8djQl0RrF
         1mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UWjij6HfXG1L6CDyEPygsAN2cmdpPEE9uumQe7csasE=;
        b=lV4bsDeIecscCmNDukr43XjULBfwDTMLDeWtlJzoqJXu7G5JFcliANJJbsWRwNMhnO
         PG3g8DiCrvFX/pVCSoGKK18QvyixyRkPn8OWUvsYvNe7Me6xJQQtT78ycHlz0T8LhR3A
         aWKOjxdc0kIryWBjO/ZrLwTbNusE6V8Nvtx6Rp7Z0Lk8Sdjx5trTvkFufZgBFlT0l/Ct
         9///SVSFePsJYGmvUDRXqO1FAW1vtguUR05BgtoVVVEsUhwsjH7Uld1SgQLP79XQk4RL
         rOCsYEq0Fkx6LGJNukxb9fJI1XT1OraokeRkSXHppyoZxncu3RFpUneiusXYEEdg2r0p
         O8EA==
X-Gm-Message-State: ACgBeo0Lp60ydxBaeCgauXIq6z7f7s4opa60IUoTjgfR59Vg63lmiZdI
        LtWbhFvPmkVMHuhOVY4iuFsFkg==
X-Google-Smtp-Source: AA6agR7ghZumwKN6U4xN03qeYZ/JcfJw21XBoLkuYVevA3Pbl8s7GAHmo+fiKyLq1SwMehMoKpeuuw==
X-Received: by 2002:a17:903:187:b0:172:f1c0:ff37 with SMTP id z7-20020a170903018700b00172f1c0ff37mr2209242plg.113.1661403645464;
        Wed, 24 Aug 2022 22:00:45 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090a698600b001f04479017fsm2359523pjj.29.2022.08.24.22.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 22:00:45 -0700 (PDT)
Message-ID: <67080ec0-9947-0521-63b1-bb6bee7aeea7@linaro.org>
Date:   Thu, 25 Aug 2022 10:30:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/4] Add support for tsens controller reinit via
 trustzone
Content-Language: en-US
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/22 11:16 AM, Bhupesh Sharma wrote:
> Changes since v2:
> -----------------
> - v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220724122424.2509021-1-bhupesh.sharma@linaro.org/
> - Dropped sm6375 specific patch from v3, as suggested by Konrad.
> - Rebased on latest linux-next (master branch) tip.
> 
> Changes since v1:
> -----------------
> - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220701145815.2037993-1-bhupesh.sharma@linaro.org/
> - Addressed several comments from Bjorn regarding locking, serialization
>    etc received on v1.
> - Addressed Konrad's concerns about the tsens controller found on sm6375
>    SoC which seems to start in a bad state or is disabled when entering
>    the linux world.
> - This series would depend on sm6375 tsens controller changes being
>    added by Konrad. It is based on linux-next (master branch) tip.
> 
> Some versions of Qualcomm tsens controller might enter a
> 'bad state' causing sensor temperatures/interrupts status
> to be in an 'invalid' state.
> 
> It is recommended to re-initialize the tsens controller
> via trustzone (secure registers) using scm call(s) when that
> happens.
> 
> This patchset adds the support for the same.
> 
> Cc: bjorn.andersson@linaro.org
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> 
> Bhupesh Sharma (4):
>    firmware: qcom: scm: Add support for tsens reinit workaround
>    thermal: qcom: tsens: Add hooks for supplying platform specific reinit
>      quirks
>    thermal: qcom: tsens: Add driver support for re-initialization quirk
>    thermal: qcom: tsens: Add reinit quirk support for tsens v2
>      controllers
> 
>   drivers/firmware/qcom_scm.c     |  15 +++
>   drivers/firmware/qcom_scm.h     |   4 +
>   drivers/thermal/qcom/tsens-v2.c |  15 +++
>   drivers/thermal/qcom/tsens.c    | 200 ++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.h    |  18 ++-
>   include/linux/qcom_scm.h        |   2 +
>   6 files changed, 253 insertions(+), 1 deletion(-)
> 

Gentle ping.

Thanks,
Bhupesh
