Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EA493B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiASNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiASNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:41:38 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E15C061574;
        Wed, 19 Jan 2022 05:41:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x7so9477431lfu.8;
        Wed, 19 Jan 2022 05:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E80AIJuq6LPMF9rIykqm1KYtwvgVA/MlGMAu7dFX5Ek=;
        b=I8N4zkeDQGGY+JpK17xsljhDGBSRjOz6IoY+IvPzfLzIsFqc/aeNBrxqiYPZfu7Z6E
         M3KNBjEfrHTfo0tU0u25PgeXtLPcrorYRrRRDtG0bMg376P4rHZk+s0kOfeh6iH8NcYL
         8MhFzMA+H3J/EtNE12KqmWnrgPPjlzDzkScC0U1FOrAoNBQb73/xJ4SQS7djRna5pkhQ
         yAViVWJFyZsD8x4kVBIGoLCK0TkCvpDNVGkeDhCL+b9TdrYIdF5cQjrPTeXPXavAM2sf
         tHHIFi0sn7/9UpXbx7SqjQtVtSWOPLVtJQXCk7SLrrxv5Oln4MwBs26mf62xQMdiM0BL
         9eWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E80AIJuq6LPMF9rIykqm1KYtwvgVA/MlGMAu7dFX5Ek=;
        b=DtGIeB/SJUW9GYHXMDQKHsIpYOAJw5ZdKKfaCUujJ8UwZgnN2d68jUfShnCZTzB2oL
         /NoLymdmSh7pqLN3SLr0wh13cUOwRrSe92Gcnej33WlgGDb8vWHd36n12FYwBv/9JV1C
         YxgEhxKXPOyq8/eE8SlfDEzhx/v2z3kQrH30ydVzAkyVXhIBagJri+krimisOsNOcW4L
         E5B4BYgT7oaFAz5XIJeTCQ0TUiTrQhvBC4bGNU8DO8XWhdyZn8QuUPxsiVKss7BfLTUD
         si4waWN8hslMj3C0FlMbb3iCo3A1wIYQd8rwXd3J03qj7AD97rONkQ7WW4aZsB0MXRnT
         n2qQ==
X-Gm-Message-State: AOAM532xSFZ4kfoIyxBD68iC8aA0OT4x1DoTVqozAOMoWcNO/ZoGV88Y
        OpDH5Kan2fFfMhKLABxUyiY=
X-Google-Smtp-Source: ABdhPJw7CcqTRgFq0l669xagB3fK6l3pm0gwEuRtaDo2RiKzIhH+cD3GgxZzsX4rtvxoAOZ0tXrIkg==
X-Received: by 2002:a2e:953:: with SMTP id 80mr24515560ljj.134.1642599696661;
        Wed, 19 Jan 2022 05:41:36 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id f30sm1825612lfv.40.2022.01.19.05.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 05:41:36 -0800 (PST)
Message-ID: <f98df604-1b2b-3803-b415-445656a6fa4b@gmail.com>
Date:   Wed, 19 Jan 2022 16:41:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
 <f9ca5794-55ac-803f-8606-f0b48e826eb7@gmail.com>
 <a926e5aa-4872-5585-d367-da815518915c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <a926e5aa-4872-5585-d367-da815518915c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.01.2022 11:53, Ashish Mhetre пишет:
> 
> 
> On 1/12/2022 4:31 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 11.01.2022 21:45, Ashish Mhetre пишет:
>>> Add all mc-errors supported by T186.
>>> Implement mc interrupt handling routine for T186.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/memory/tegra/mc.h       |  17 +++++++
>>>   drivers/memory/tegra/tegra186.c | 100
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 117 insertions(+)
>>>
>>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
>>> index 2d4f495..7817492 100644
>>> --- a/drivers/memory/tegra/mc.h
>>> +++ b/drivers/memory/tegra/mc.h
>>> @@ -44,6 +44,15 @@
>>>   #define MC_TIMING_CONTROL_DBG                                0xf8
>>>   #define MC_TIMING_CONTROL                            0xfc
>>>
>>
>> this empty line is unnecessary
>>
> I'll fix this in next version.
> 
>>> +#define MC_ERR_VPR_STATUS                            0x654
>>> +#define MC_ERR_VPR_ADR                                       0x658
>>> +#define MC_ERR_SEC_STATUS                            0x67c
>>> +#define MC_ERR_SEC_ADR                                       0x680
>>> +#define MC_ERR_MTS_STATUS                            0x9b0
>>> +#define MC_ERR_MTS_ADR                                       0x9b4
>>> +#define MC_ERR_GENERALIZED_CARVEOUT_STATUS           0xc00
>>> +#define MC_ERR_GENERALIZED_CARVEOUT_ADR                      0xc04
>>> +
>>>   #define MC_INT_DECERR_ROUTE_SANITY                   BIT(20)
>>>   #define MC_INT_WCAM_ERR                                      BIT(19)
>>>   #define MC_INT_SCRUB_ECC_WR_ACK                              BIT(18)
>>> @@ -159,6 +168,14 @@ extern const struct tegra_mc_ops tegra186_mc_ops;
>>>   extern const char * const tegra_mc_status_names[32];
>>>   extern const char * const tegra_mc_error_names[8];
>>>
>>> +struct tegra_mc_error {
>>> +     u32 int_bit;
>>> +     const char *msg;
>>> +     u32 status_reg;
>>> +     u32 addr_reg;
>>> +     u32 addr_reg_hi;
>>> +};
>>> +
>>>   /*
>>>    * These IDs are for internal use of Tegra ICC drivers. The ID
>>> numbers are
>>>    * chosen such that they don't conflict with the device-tree ICC
>>> node IDs.
>>> diff --git a/drivers/memory/tegra/tegra186.c
>>> b/drivers/memory/tegra/tegra186.c
>>> index 6766cc4..4f3ae71 100644
>>> --- a/drivers/memory/tegra/tegra186.c
>>> +++ b/drivers/memory/tegra/tegra186.c
>>> @@ -146,8 +146,107 @@ static void tegra186_mc_clear_interrupt(struct
>>> tegra_mc *mc)
>>>        mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
>>>   }
>>>
>>> +static const struct tegra_mc_error int_mc_errors[] = {
>>> +     {
>>> +             .int_bit = MC_INT_DECERR_EMEM,
>>> +             .msg = "EMEM address decode error",
>>> +             .status_reg = MC_ERR_STATUS,
>>> +             .addr_reg = MC_ERR_ADR,
>>> +     },
>>> +     {
>>> +             .int_bit = MC_INT_SECURITY_VIOLATION,
>>> +             .msg = "non secure access to secure region",
>>> +             .status_reg = MC_ERR_STATUS,
>>> +             .addr_reg = MC_ERR_ADR,
>>> +     },
>>> +     {
>>> +             .int_bit = MC_INT_DECERR_VPR,
>>> +             .msg = "MC request violates VPR requirements",
>>> +             .status_reg = MC_ERR_VPR_STATUS,
>>> +             .addr_reg = MC_ERR_VPR_ADR,
>>> +     },
>>
>> I see that these VPR registers present on all SoCs starting with T124.
>> It doesn't look like you need the separate IRQ handlers at all, instead
>> please extend the common T30 handler. For example, you may add a
>> switch-case statements to handle those T124+ specific bits differently.
>>
>> static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>> {
>> ...
>>          switch (bit) {
>>          case MC_INT_DECERR_VPR:
>>                  status_reg = MC_ERR_VPR_STATUS;
>>                  addr_reg   = MC_ERR_VPR_ADR;
>>                  break;
>>          ...
>>          default:
>>                  status_reg = MC_ERR_STATUS;
>>                  addr_reg   = MC_ERR_ADR;
>>          }
>>
>>          value = mc_readl(mc, status_reg);
>>          ...
>>
>>          value = mc_readl(mc, addr_reg);
> Okay. I'll use same handler as Tegra30 with additional Tegra186 onward
> bits.
> Also, shall I change name of tegra30_mc_handle_irq() to
> tegra_mc_handle_irq() as we are using it across all Tegra SOCs ?

T20 won't use it, no need to change the name.
