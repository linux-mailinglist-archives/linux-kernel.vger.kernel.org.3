Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE5B4BFA76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiBVOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiBVOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:10:29 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A5115F606
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:10:03 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id ba20so11260421qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XR5FZFGaIIKTzVrtc+qtDeldPYFhK+vnor66vP4A6qE=;
        b=d2PXqmoJdsG3+AVpuPryy+/yq70x6q2BsCW0wo1sZ2XTr6NKseHqDZJFWBX5EdjBaj
         lUh2Q62sr7Z6VEHYqQZ9bZeQLO5HNGcAldRPjVodDIoO/jUnZXQIWaH9KqdlHqqZN5bZ
         m6CsUUE5mShjmYVas/8ImoZiaDWRUg0Sbl4UKOLiIDFkFGxD4reVTeEP0U9l8D5TTemm
         apZVoAWDK42QHzKM9M2M8FtvZl2CIxrF516twZ+oet52mrU3UEJZ6a0iIdT1O+lVPX1L
         1ealdeBBMSt62qEBjdRqwPJNYxRyqGgEcRpfAgNobS7zu2sqEY0jNdK+VvnbDrwOyAu2
         WgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XR5FZFGaIIKTzVrtc+qtDeldPYFhK+vnor66vP4A6qE=;
        b=Cyw/+eegaCGY4bk2HdgBRnmZNvj5bNm6qWIf4wHvg2S44k5jvRPE7lS+dUVfz5VxhN
         17N0HZBRdbhfXqwihw/y+v4lDDtl7yFLRlk56/9q8m5PT1Y/7IkWADFelxBbA17tNDEQ
         3ZtXuXGYESEgzGxyVCbFLo/rGtry+aRlFWlDZEgmLha9Pu+Xr+qtgYK9S+x+ARo6yiNA
         R/T473lacQtJkj6dzTAcW+MVuvUno+bR0/vNhxSXKARMioLJ2GvU3Ewd8pdk0erEQQnK
         XM2ZlProptogRm0LdU84MEWXLrs+qJ91EqOd3ONYSyyp2VEqozVV1kKv4OvKtgZ3/kzq
         XXBg==
X-Gm-Message-State: AOAM5302Dlnt1poI5Pw+k+i1NLxeKWQ9FyvGahAkN51kcZwB3tVf160p
        St1Noutm2tO9ADGqMKqHrCI/Ag==
X-Google-Smtp-Source: ABdhPJwWqciVne655CNWHtCM8/p9iRCfk7DpJuRiXA0dp7NT/73hA5DeKFBPUvXQ25aZwkNYKL2lVA==
X-Received: by 2002:a05:622a:206:b0:2dd:dbdb:f598 with SMTP id b6-20020a05622a020600b002dddbdbf598mr13521885qtx.138.1645539002901;
        Tue, 22 Feb 2022 06:10:02 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e9sm306676qkm.27.2022.02.22.06.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:10:02 -0800 (PST)
Message-ID: <a1e26159-f27e-e55f-d376-e43a13294246@linaro.org>
Date:   Tue, 22 Feb 2022 08:10:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 16/25] bus: mhi: ep: Add support for powering up the
 MHI endpoint stack
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-17-manivannan.sadhasivam@linaro.org>
 <10240bc5-ef9f-7555-402e-57ca2b0b0a14@linaro.org>
 <20220222090816.GD5029@thinkpad>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220222090816.GD5029@thinkpad>
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

On 2/22/22 3:08 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 04:39:37PM -0600, Alex Elder wrote:
>> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
>>> Add support for MHI endpoint power_up that includes initializing the MMIO
>>> and rings, caching the host MHI registers, and setting the MHI state to M0.
>>> After registering the MHI EP controller, the stack has to be powered up
>>> for usage.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Very little to say on this one.		-Alex
>>
>>> ---
>>>    drivers/bus/mhi/ep/internal.h |   6 +
>>>    drivers/bus/mhi/ep/main.c     | 229 ++++++++++++++++++++++++++++++++++
>>>    include/linux/mhi_ep.h        |  22 ++++
>>>    3 files changed, 257 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
>>> index e4e8f06c2898..ee8c5974f0c0 100644
>>> --- a/drivers/bus/mhi/ep/internal.h
>>> +++ b/drivers/bus/mhi/ep/internal.h
>>> @@ -242,4 +242,10 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
>>>    int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
>>>    int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
>>> +/* MHI EP memory management functions */
>>> +int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
>>> +		     phys_addr_t *phys_ptr, void __iomem **virt);
>>> +void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t phys,
>>> +		       void __iomem *virt, size_t size);
>>> +
>>>    #endif
>>> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> 
> [...]
> 
>>> +
>>> +static void mhi_ep_enable_int(struct mhi_ep_cntrl *mhi_cntrl)
>>> +{
>>
>> Are channel doorbell interrupts enabled separately now?
>> (There was previously an enable_chdb_interrupts() call.)
>>
> 
> Doorbell interrupts are enabled when the corresponding channel gets started.
> Enabling all interrupts here triggers spurious irqs as some of the interrupts
> associated with hw channels always get triggered.

This is excellent.  Thanks for the explanation.	-Alex

> 
> Thanks,
> Mani

