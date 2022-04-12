Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3B4FE9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiDLVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiDLVcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:32:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABEE2F74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:10:44 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g11so13714065qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBhTpRFFi4S1YoI6Y47NqVUBm/Z+66ScwXGZSk0rfic=;
        b=T7Sy6FLDrgLsr08CJMXwUmg3ph+n2SbtlANeDVJRGcYPLZPNFdqkGA3rd9EyBtlS3H
         kTjnzK8J7gmq/Ix5hk869IWHjRfyAZapgFeo9WcQo6acOPkngS7ZgD606xHdWRwdkcf4
         uCNDsXroeiGCJ2dnoQVzb34/K2VNl7m6HbgnUp42Td7ihjuVDiePRgyor7tcwAF0jphx
         dTPNgA/R3nPsTcwHOh8eDEn9xpE1Mq90riz3Mr6D8Z7h12iUd2IXjDQeAooIdIWVePAB
         qgC8WMTKShtEFXeXyQDjMUSArChIukeGYjH3EdJ1+FacKEyrgQ1FlRi6Ir+VmO/dOMBJ
         H7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBhTpRFFi4S1YoI6Y47NqVUBm/Z+66ScwXGZSk0rfic=;
        b=NwWj9Gid0SRAoPmDY0cNrjJFTP29sf90bV9qHYl5su7+rD605Be7JfV+fYjz11j9TO
         WY5sfAwc+lsya4OBtUCaWoeXeZoMy3Yi7mPsyOD4GXGlJqNieom6STlhmreent1AiXyx
         C+RXp20a9nX7qsbkZE4jSPNUqDQ0RIGS5HQjehkZ0aP5n5pghZNBlbKB7E8SXbQME+Ha
         RAMZ5Xu2aM4byO3iul8MmgM0I79jMstzw13pNTCynBkdyAW5Nk8P3XKbyYbFTaEZlMh3
         pGYS3iTrgw/Flsks/MX5RU+Qt5c+h5bV5zSKoInwJ7PP8Z2VzAjLXcSNFvPvUcx1ROLA
         afDA==
X-Gm-Message-State: AOAM531x6UFvI4L6SbZNS0qehyVtMGQlPpL01+D3VyTh15OtmIZkjanx
        MJ3itLp70tABULo1zP4H1lXuZUCeukdk9DwArPk=
X-Google-Smtp-Source: ABdhPJxG82CB33uGk+QRkThCYGAsp4gaOqXjPDvytyFIgAT/f1JvMa50XJo0MGciBKEXLs71MyqZMA==
X-Received: by 2002:a05:620a:4310:b0:67e:8460:5a10 with SMTP id u16-20020a05620a431000b0067e84605a10mr4475122qko.636.1649797633718;
        Tue, 12 Apr 2022 14:07:13 -0700 (PDT)
Received: from [192.168.0.189] (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a034a00b0069c06c95bf7sm6104251qkm.14.2022.04.12.14.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 14:07:13 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: delete incorrect ufs
 interconnect fields
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220407172145.31903-1-jonathan@marek.ca>
 <YlXmTbKwYtvLSjgp@builder.lan>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <b70f4ecf-93c6-49df-0d8d-a5899075ca63@marek.ca>
Date:   Tue, 12 Apr 2022 17:07:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YlXmTbKwYtvLSjgp@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/22 4:51 PM, Bjorn Andersson wrote:
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
> 

This isn't a v2, I sent this without seeing there was already patch for 
the same "problem".

A reason for picking it up is that if you have a patch adding the 
interconnect support to the UFS driver in your tree, the incorrect dts 
will prevent it from probing  (so the 5.18-rc1 dts could fail with newer 
kernel eventually, not sure if upstream cares about that?)

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
