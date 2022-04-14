Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B558501B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiDNSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245402AbiDNSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:38:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5CEDB2E1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:35:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so7139951ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ub6If+332buCinL/3BXFdLheY3JvRpim3Rm/PFZigx8=;
        b=VW0aRD7T+wcgoxrACJ+GbC5nEhZz3dZ7wQQS9PmN3Yp3GTV6Jk4ywSz15b+DZBMoQb
         wMzZ1VCWy91Ms7DQr4LkBc2a+7wil12P0S0jXGGGLcSW4d0uS+sOrz1FZ8FFtLchnu0y
         UEf1kqhXcfjYqj/buCV535ziHLyFkIEbJT+SYJeA5bZ69QGJMAYQ4SO0fCj/TyxJ9bCu
         Dtu/MBUfpOjbqseGSIww986b2BrQC95y5la7c06t3yD1N+a18s7s3ueSYrakxZCkQSWT
         I47aMFIM23p0MECgsnCvo6iKhCjXMWw0tf4aghtgqfS/q/vu3zlBNsmXdvZWwnwcd3+u
         U9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ub6If+332buCinL/3BXFdLheY3JvRpim3Rm/PFZigx8=;
        b=CWHITW5AeAJIG5luaxlXB9mvDKfzJXFYxXJzHbxtrjEGWGBur38ae+7k1y2/GMZ3NC
         dtkVH0GJGu+Ubgmebc8Bm+KMwNP45pfwli2b8Pmt4tptK7BaIpUqojVfLSpZNz7f5gQb
         j6/lb0gZOIB/GZFabo3Wc7xtGu5ofxX7Mc6gR3NjryX0fMPv2G7y1+n1X5Fnc0OIp/MC
         gdhq3CsAitC9cVPO9tWTfwFa7ZhW9ce4tIrFaUCSTTXnAwwOn7I1sGhs+91e93lqHgoz
         kOw0o+mlyE2svHuZuji0W8xGVEkZSF8xd8Fzrqlkl6CKLamPFZViVMtXYh/100Sk04sH
         JVRw==
X-Gm-Message-State: AOAM530RMihApia1BQlAwVQD/rv3Do1Dh2P7PRBxI2E8wrI1RsLdni67
        p9/QXNo4/npbB6kwpSToR5gfpPMWcKypdw==
X-Google-Smtp-Source: ABdhPJwnBrxe1rilJp4LSDGlMmGx8LSGayKb/qSUyY7bJqK7KoNxlLsSnCtEArQ2G1HSu4DTCDZzNQ==
X-Received: by 2002:a2e:141e:0:b0:24b:6256:3898 with SMTP id u30-20020a2e141e000000b0024b62563898mr2265515ljd.436.1649961350505;
        Thu, 14 Apr 2022 11:35:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s1-20020ac24641000000b0046d10a0bba2sm71865lfo.176.2022.04.14.11.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 11:35:50 -0700 (PDT)
Message-ID: <27e4cc57-bdfe-42b6-d3eb-0d447ab6c6ca@linaro.org>
Date:   Thu, 14 Apr 2022 21:35:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: delete incorrect ufs
 interconnect fields
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220407172145.31903-1-jonathan@marek.ca>
 <YlXmTbKwYtvLSjgp@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YlXmTbKwYtvLSjgp@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 23:51, Bjorn Andersson wrote:
> On Thu 07 Apr 12:21 CDT 2022, Jonathan Marek wrote:
> 
>> Upstream sm8450.dtsi has #interconnect-cells = <2>; so these are wrong.
>> Ignored and undocumented with upstream UFS driver so delete for now.
>>
> 
> Just to clarify, the binding do document interconnects and the property
> should be there in the end. v1 (why isn't this marked v2?) was correct.
> 
> What I asked for was a statement on why it should be picked up for
> v5.18-rc (as Dmitry requested).

I have a slight preference for fixing the icc rather than dropping it.

However I'm fine with either of the patches.

The ufs/qcom,ufs.yaml describes these interconnects (basing on the 
sm8450 if I understand correctly). Thus if decide to drop interconnect 
properties, we should also update the binding.


> 
> Regards,
> Bjorn
> 
>> Fixes: aa2d0bf04a3c ("arm64: dts: qcom: sm8450: add interconnect nodes")
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 2c18e1ef9e82d..90cdbec3cac99 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -1663,9 +1663,6 @@ ufs_mem_hc: ufshc@1d84000 {
>>   
>>   			iommus = <&apps_smmu 0xe0 0x0>;
>>   
>> -			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
>> -					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
>> -			interconnect-names = "ufs-ddr", "cpu-ufs";
>>   			clock-names =
>>   				"core_clk",
>>   				"bus_aggr_clk",
>> -- 
>> 2.26.1
>>


-- 
With best wishes
Dmitry
