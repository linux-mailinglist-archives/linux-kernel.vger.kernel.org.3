Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5725A6935
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiH3REK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiH3REF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:04:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895512608
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:04:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c66so1682108pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mITTU0JUdJBVWxufdBgXC/bZoCiqWhtDy6UOJ+PtbWI=;
        b=z87+nW/xi7tXZ91FTBXqyjQkdBpGPgv77brysCESoyftv3sOzFpZ9SF1bn1hgP8Y5c
         22hBaKUqJaqD6pCoJZlAp82JKeqPfMJpyQJ/sMGo3moRe5HvR7TfBXUHTsivQOCoPqXa
         GuCcYa+WHQwhO6qBD5on4vz0ppsnGW3JsDydF+4VQcjHLqN4Ox5NiujzE6CuqY/ZCFyQ
         cnUi8KpG5CsZk24TYGJhddet7/6O4RMB1VoyVxBrcDtZIerNylvVUqcFsqSavEa/I9Zv
         rOFMu9WbIYLS7Uph2HFuqM662hgO3jSuFTsd+qrXJC0ymesawLoJCfbCOs1E7CLd7pbj
         KKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mITTU0JUdJBVWxufdBgXC/bZoCiqWhtDy6UOJ+PtbWI=;
        b=slUadhIGOElgaP9+Nsf6c//nE0CEPMcS7cp2KyToh7P0RRc1KS2XeKIjMxz06VmYZr
         DjS2mYNqbgiPVA0MJX7tcgOVuzMol+yaG7A8vrAKHK85vcTBaf7X7upEBG4u7PaRsysg
         dMpXPIJz0gffUqVaqZJhN3YL3HRRK8ieH7s+U+nYZokb84hnxgZmCcHpWtqF+s3Qh7kX
         Q6iCzJRMZ+rq4eVee8KAt+iaDNz83tLj2vB9bsLQ98+uSdJO4fE4bV8x5YuyNv56h+RR
         XVG/O/PpvmqWZWQ/0+2l9r9S92tX08nXqWYouKMrZ6NN7F6h0YPa6ZpkIThe+Oa/gcLn
         FPSQ==
X-Gm-Message-State: ACgBeo3wDJa2nAlvzWxrx2L2v3DglfM20PZeNoL6ENlQOZZARWzU8S8I
        cEo1WaFr+gW7fOC/cvJrvYtdWg==
X-Google-Smtp-Source: AA6agR6dRTu4OFyj4OnDRjT05ZFU3Db4NLRFQDVl6LpqvWdRCnhMttqhurD1VcXdOLvM8SDWo9oCVA==
X-Received: by 2002:a63:e507:0:b0:42c:65d3:f3b6 with SMTP id r7-20020a63e507000000b0042c65d3f3b6mr5967820pgh.395.1661879042894;
        Tue, 30 Aug 2022 10:04:02 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id p125-20020a62d083000000b00537e40747b0sm7771654pfg.42.2022.08.30.10.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:04:02 -0700 (PDT)
Message-ID: <99a569fd-6a7c-0ed2-3a32-aab16f3bad92@linaro.org>
Date:   Tue, 30 Aug 2022 22:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] firmware: qcom: scm: Add support for tsens reinit
 workaround
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
 <20220804054638.3197294-2-bhupesh.sharma@linaro.org>
 <20220829221551.uch6jdtaglzebu23@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220829221551.uch6jdtaglzebu23@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/22 3:45 AM, Bjorn Andersson wrote:
> On Thu, Aug 04, 2022 at 11:16:35AM +0530, Bhupesh Sharma wrote:
>> Some versions of Qualcomm tsens controller might enter a
>> 'bad state' while running stability tests causing sensor
>> temperatures/interrupts status to be in an 'invalid' state.
>>
>> It is recommended to re-initialize the tsens controller
>> via trustzone (secure registers) using scm call(s) when that
>> happens.
>>
>> Add support for the same in the qcom_scm driver.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   drivers/firmware/qcom_scm.c | 15 +++++++++++++++
>>   drivers/firmware/qcom_scm.h |  4 ++++
>>   include/linux/qcom_scm.h    |  2 ++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index cdbfe54c8146..93adcc046a62 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -858,6 +858,21 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>>   }
>>   EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
>>   
>> +int qcom_scm_tsens_reinit(void)
>> +{
>> +	int ret;
>> +	const struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_TSENS,
>> +		.cmd = QCOM_SCM_TSENS_INIT_ID,
>> +	};
>> +	struct qcom_scm_res res;
>> +
>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +
>> +	return ret ? : res.result[0];
>> +}
>> +EXPORT_SYMBOL(qcom_scm_tsens_reinit);
>> +
>>   static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
>>   				 size_t mem_sz, phys_addr_t src, size_t src_sz,
>>   				 phys_addr_t dest, size_t dest_sz)
>> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
>> index 0d51eef2472f..495fa00230c7 100644
>> --- a/drivers/firmware/qcom_scm.h
>> +++ b/drivers/firmware/qcom_scm.h
>> @@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>>   #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
>>   #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
>>   
>> +/* TSENS Services and Function IDs */
>> +#define QCOM_SCM_SVC_TSENS		0x1E
> 
> It would be nice if this 'E' was lowercase.

Sure, will fix this in v4.

> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks,
Bhupesh

>> +#define QCOM_SCM_TSENS_INIT_ID		0x5
>> +
>>   #define QCOM_SCM_SVC_IO			0x05
>>   #define QCOM_SCM_IO_READ		0x01
>>   #define QCOM_SCM_IO_WRITE		0x02
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index f8335644a01a..5c37e1658cef 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>>   extern int qcom_scm_lmh_profile_change(u32 profile_id);
>>   extern bool qcom_scm_lmh_dcvsh_available(void);
>>   
>> +extern int qcom_scm_tsens_reinit(void);
>> +
>>   #endif
>> -- 
>> 2.35.3
>>
