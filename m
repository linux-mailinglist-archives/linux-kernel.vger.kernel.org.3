Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF85A5B98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiH3GOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH3GOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:14:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA74DB81DE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:14:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m7so5211614lfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=f7Qyc4+Tcj4HKD3nfJDeYBjnlk9zHLIWyrvpr52gQSY=;
        b=tvoTZD8WzYAXPwu1p166Vdlb+BHgSRLS6+r9sYH4LYgnoEbrzOOIWPlmGHlGUjkASv
         W/cfOTlj142TqatCzxwfDEBv9b1pf/CI+8pSCNOYEJvl+gN+FKrtJ3z4147EZG7bnedi
         0nTyo6CXPSrSkeqvDZt5dfgDhQ48aiX3VeFyqx/Eh04TiRUs6fxyhD8mU+XJU0m9922T
         gZ2C6CEP38fy93AFLhTy2nmo6LGC2GHf6tNcT3idV/Nvc1+U88NtcL8sAbXu2EWxns8W
         gIAen1gn8Et4QKdyM6Um3Hh5osxqzTh2tdFhWPsOvQw5LnhlSCMTdm3wVnzhXzMoTLbe
         /yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=f7Qyc4+Tcj4HKD3nfJDeYBjnlk9zHLIWyrvpr52gQSY=;
        b=4DXepDkiApVLDaUCdag+Y/w/TyiMCSYtBtoSzLlKS8E5qWfKCdfridVD5x5JZAIm47
         m3dAXEUGE7Vr57bQvnDxebsDSdfzfVNWd7YylWGJjTLGVi/WwIBgvhHBbMUOxWsOz6kD
         eBXBK4cstXH2yzFQYEiORwWsGCVeuTy75e7UcKYBsF+EqGv2P5YnW/3iovI3focaiY/o
         csa+jsXlkOtXGXm4lfE32EGogd7I3iWLqFa0kKjLeD2pzNEiS95dKM0HvuXOyC3RH20N
         0TUT5YhqsKD/lBZDwYdWqLAFDl/gbciMsjpe4+I3+2UvIZk5Z8dnoC98cvlIKHI4Z1i8
         sabQ==
X-Gm-Message-State: ACgBeo1213QHHzGQWvp9nfR+eWmKRORZK2FmtHNf670b0ZuBpYW1OcCY
        LLuOmGvZQG/REKb18tnAR7D5HA==
X-Google-Smtp-Source: AA6agR7vf1NbhaiKgNrNi6NAyaevkiM1S2zz7vgqfNCJRkaCV6MnL2fbTb9/0uQISNCPQC0DCakmdQ==
X-Received: by 2002:a05:6512:3b9d:b0:492:d0c5:c3a5 with SMTP id g29-20020a0565123b9d00b00492d0c5c3a5mr6974630lfv.129.1661840042217;
        Mon, 29 Aug 2022 23:14:02 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u7-20020a056512094700b0048aeff37812sm1480396lft.308.2022.08.29.23.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:14:01 -0700 (PDT)
Message-ID: <65e0c02a-41dd-0858-58f2-7b06b8ab5780@linaro.org>
Date:   Tue, 30 Aug 2022 09:13:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 2/3] soc: qcom: socinfo: create soc_id table from
 bindings
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
 <20220705130300.100882-3-krzysztof.kozlowski@linaro.org>
 <20220829204930.27wg2htgbq23kgeg@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829204930.27wg2htgbq23kgeg@builder.lan>
Content-Type: text/plain; charset=UTF-8
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

On 29/08/2022 23:49, Bjorn Andersson wrote:
> On Tue, Jul 05, 2022 at 03:02:59PM +0200, Krzysztof Kozlowski wrote:
>> The Qualcomm SoC ID values are encoded in few places: DTS files,
>> Devicetree bindings (both used by some of Qualcomm bootloaders or tools)
>> and in soc_id table of socinfo driver.  Do not duplicate the actual
>> values in the last one but use the constants from the bindings.
>>
>> Tested by comparing output object file (exactly the same).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I didn't have a strong opinion either way on this, so was hoping someone
> else would chime in. Doesn't seem like that has happened, but
> unfortunately the soc_id[] list has changed.
> 
> Would you mind rebasing the two patches to match the latest list?

Sure.

> 
>> ---
>>  drivers/soc/qcom/socinfo.c | 259 +++++++++++++++++++------------------
>>  1 file changed, 133 insertions(+), 126 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index cee579a267a6..d515d3a97f0e 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -12,11 +12,14 @@
>>  #include <linux/slab.h>
>>  #include <linux/soc/qcom/smem.h>
>>  #include <linux/string.h>
>> +#include <linux/stringify.h>
>>  #include <linux/sys_soc.h>
>>  #include <linux/types.h>
>>  
>>  #include <asm/unaligned.h>
>>  
>> +#include <dt-bindings/arm/qcom,ids.h>
>> +
>>  /*
>>   * SoC version type with major number in the upper 16 bits and minor
>>   * number in the lower 16 bits.
>> @@ -25,6 +28,10 @@
>>  #define SOCINFO_MINOR(ver) ((ver) & 0xffff)
>>  #define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
>>  
>> +/* Helper macros to create soc_id table */
>> +#define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
>> +#define qcom_board_id2(id, name) QCOM_ID_ ## id, (name)
> 
> How about naming this qcom_board_id_named() ?


Yes, sure.


Best regards,
Krzysztof
