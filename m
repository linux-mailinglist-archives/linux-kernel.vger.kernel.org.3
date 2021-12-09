Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A046F475
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhLIUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLIUCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:02:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D184C061746;
        Thu,  9 Dec 2021 11:58:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m27so14055176lfj.12;
        Thu, 09 Dec 2021 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uM+eFXoWiWetPTI10tceV6UBa9/7Dufz9K7yclEKlI0=;
        b=oCqfCY2JIiJilttvVZHOauO6ECOE6Afie3ANJ3X5Vr0i3pfRV1nmwcCXijTzpzh9wY
         bi7YBYlkFbKiFcSgZo6cBhenPCTubiN4V9FPUJ9YZIioT9j2O9Ixln1xN+qIsClVc1Do
         +EKXvKKkUfWEDljaIXjhfucZxW8ta+H202606N8GoTjulMKAhQHNkQrvYT0I4NVbHFuF
         H09hKK9k/McDAYEwxAzbKUirIj//T9cNDM4e/JI1yrhhnARSjTRVBGyYCEgijek8tPWU
         6DIeF4/ceATr4ZALuEnwXMssodFcxmS/7XWya+Q5QpoFNR5WTWntKlGUtjYW/1ct97d0
         2DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uM+eFXoWiWetPTI10tceV6UBa9/7Dufz9K7yclEKlI0=;
        b=tQBH3a4MEB7Kg+fwC+XVmSdeJ3orUqSQEKlWGI5e5/xyJYbJZJ1XJHXdJ2PlanikJo
         ita77HJQPUAr+YeqO4WKBPIg1WoJqtKm9rnjE17rMIpHe2dz2Kg0nZ0F0hnFNND14VgT
         edAVGwpdfF9eLK3ZyyIPViiyDyJpXIWSiZrc669/QIaFe2Zj8yp/uZZolrJoeMZUqpbU
         mQSlVoLwMr29RLI1m+sOpd6C5cyn7BDob+maA0pjRG3ZxzTwskxHWh2u8tlKnO0zSMd6
         Bdr2n6JNwAQHhIz/8w4L148jAOAbBckkFUJ9VuemRJNVIrBxz43klLrxYYPhXz2Y6n6x
         84Gw==
X-Gm-Message-State: AOAM530c17LJcvPMYJY5kYaKa3/cZIeE78csrCfssnB85WGr2trFF4tv
        dc75albGnyYi1B2e8JL7v5Wh4VpmcGI=
X-Google-Smtp-Source: ABdhPJx7I+soYFAg27UyyMF614X5ml5K/O6igAuGctXo8HGNaRIcXOQdKsUNc8fVwmt4dOF//1/+rw==
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr1252953lfg.85.1639079914011;
        Thu, 09 Dec 2021 11:58:34 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id y11sm83212ljh.54.2021.12.09.11.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:58:33 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, will@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
 <20211209195450.GB35526@Asurada-Nvidia>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
Date:   Thu, 9 Dec 2021 22:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209195450.GB35526@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2021 22:54, Nicolin Chen пишет:
> On Thu, Dec 09, 2021 at 10:44:25PM +0300, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.12.2021 22:24, Nicolin Chen пишет:
>>> On Thu, Dec 09, 2021 at 05:49:09PM +0300, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 09.12.2021 10:38, Nicolin Chen пишет:
>>>>> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
>>>>> +{
>>>>> +     return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
>>>>> +            (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
>>>>> +}
>>>>
>>>> I'd change the return type to u32 here, for consistency.
>>>
>>> The whole file defines iova using "unsigned long", which I see
>>> as the consistency... If we change it to u32, it'd be probably
>>> necessary to change all iova types to u32 too... So I'd rather
>>> keep it "unsigned long" here. If you see a big necessity to do
>>> that, an additional patch would be nicer IMHO.
>>>
>>
>> In general IOVA is "unsigned long", of course. But in case of Tegra
>> SMMU, we know that is always u32.
>>
>> Alright, I see now that there are other places in the driver code that
>> use "unsigned long", so need to change it in this patch.
> 
> I think we should do that in a separate patch that changes the iova
> type in the entire tegra-smmu file. I can add one in this series, if
> this makes you happy...
> 

Please keep it "unsigned long", no need for extra patches.
