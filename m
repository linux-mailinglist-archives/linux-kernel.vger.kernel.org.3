Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD564C0124
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiBVSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiBVSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:22:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC357152
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:21:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso2505658wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dSxkVeNACVhXNOyAclYVu585cWApPTR7Lum44hdkYwM=;
        b=KUp9ejm7G/GDzW/HgFDmPcHSUo6BgrU8As2BQ++t4QDBGfqRUPdCJ4EDEsjBairuee
         YDO5THZCMsfIaytQ35sv4VZveVmQQfw+bc8KlBtbYnMgcRvakUuOdAIlIWwVEaETUOvQ
         I33Apnbr3OkKJg7rtXHkFZdJnAjr1RBL6/xzmSay2169bZQHv/rdMdGk50fcefuiS3/X
         ry1Wzeji4n4S4mL3rJCfn/6TIBdjSTqp/h6HjpffDm74faKqBA5ygVfuzVZv8S+Ws8zy
         joQE9cc+2X0KZWzURVkjpragffCG1UUjDX9dGZ/bUccHJzMd9mzBKel4+PtKjrK0nw24
         vntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dSxkVeNACVhXNOyAclYVu585cWApPTR7Lum44hdkYwM=;
        b=KxUpD2XZEIZWEi5iL39HWn3r7nVBMlF35pbCJinM6YMW2OW/7ja9Z1R2KlyUTyHH8p
         FC5+uTHveVfhro8Px9Vh26lzx9SopSYCmD+lgLnH0JTQRnLDjSSB1jM0IFbzAOutMK9M
         JPexezDKVnWEkrbz0ZPieaopNCQ4Cfb7jLxIyEnZDNynra11IklSf9rpuTQXwWVKc3j3
         DiOBubIxOOzZL1SlkwAjRHVuC1/voAHnFAhuTglki0RwDlnT4lOVb84Ws2PL5QDlf/kf
         Lr7x4SsekSEzkalrYbhTT7zaSMPJI5R2Y+Y/fFmt3uS/7R0UHZG3KuDp2C2ij03cR0bo
         K3iQ==
X-Gm-Message-State: AOAM530dga+J1HTKCWH056/LGR3HLysnJAS760ES8f+P363FSRtpbRNp
        zWY6O+36imjbf8Vr1LzsLq89tA==
X-Google-Smtp-Source: ABdhPJwRUV2AEHrfZaJhwuqauojIOkr7b975DSxtTUzdw9CR8yoOTabV2gW7611r27lHdCT6Q93MiQ==
X-Received: by 2002:a7b:c143:0:b0:37b:dacd:bf2f with SMTP id z3-20020a7bc143000000b0037bdacdbf2fmr4337818wmi.16.1645554108175;
        Tue, 22 Feb 2022 10:21:48 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f3sm20861563wri.6.2022.02.22.10.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:21:47 -0800 (PST)
Message-ID: <9919c5f2-6c7c-b041-e5c5-fe7488de3a8a@linaro.org>
Date:   Tue, 22 Feb 2022 18:21:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/16] ASoC: codecs: rx-macro: fix tlv min max range
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
 <20220222115933.9114-11-srinivas.kandagatla@linaro.org>
 <YhUlxX461J9bskg3@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhUlxX461J9bskg3@sirena.org.uk>
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



On 22/02/2022 18:04, Mark Brown wrote:
> On Tue, Feb 22, 2022 at 11:59:27AM +0000, Srinivas Kandagatla wrote:
>> on Qualcomm codecs gain tlv control specifies min max range as both
>> negative to positive numbers like
>>
>> SOC_SINGLE_S8_TLV("... Volume", ..,  -84, 40, gain)
>>
>> However with recent boundary checks added in commit 817f7c9335ec0
>> ("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw())
>> setting a value above 40 gain will fail.
>>
>> So fix this min max range correctly to
>> SOC_SINGLE_S8_TLV("... Volume", ..,  0, 124, gain)
>> so that users can now set gain correctly
> 
> Are you sure this isn't a bug in the core?  -84..40 should be a valid
> range for a signed control.  See Marek's fix in 9bdd10d57a ("ASoC: ops:
> Shift tested values in snd_soc_put_volsw() by +min") though that onlyNice, This works for me. Will drop all he tlv patches.

--srini

> kicks in for systems with a platform_max.  I can't immediately spot any
> other issues for S8 but I could be missing something.
