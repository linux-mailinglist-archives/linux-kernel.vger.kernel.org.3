Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3D51B827
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiEEGqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiEEGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:46:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C686847385
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:42:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so6833298ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ed/YN7SZpW0AehsQ0TRZSSDMrgfoZJTJw/aMQm/z/ps=;
        b=uaV9QfHAzNNMFn3vMSpf6pJlvN+ezYaq1CbLnhaMhssIxvyFGrDZms9qA5P94LsTvv
         Mlxsfyt7/C6/TPDKR1Q7Y2/rVe2wFI5leI2m8PRZ2Vonm4IqpV3U0CTThQGC6qXV/TAl
         o3L1IwMWbz5E6MWYIEPAzgkhaWq0Bwlu3Y/y6LvYH8zne8nC1OB+Mk6yiZ1vklYKICY3
         IRt8hympRJgEvd0jHrsHBBCv9fdM5KrlXQDa+9cE1hnmC/hufiDhVRMfvVu0BmLFHk6i
         X1Z4mRTSXYlf71hu93YoaKpFk8JdjtiWvxN6bybD9IgoJZrKq2WDVAONxJNiBUdBybLR
         kVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ed/YN7SZpW0AehsQ0TRZSSDMrgfoZJTJw/aMQm/z/ps=;
        b=rc2pz3RJw6xIdaAj10BsKOVSp0I89I58AaYCSmMrIokxd9ZbGnJ8ibdb7HBaT/vnMT
         v9ZaU0OGkJfQA22zpjEJtBKy6vpLaQHsHaC23z16GoOsyeS9V1w2naFlqP/nJ3Gscu0w
         BrSdtNDT3tc0HldARypYFdpLtyhMYwBh0t1hBHLDl8e/O/aT2nwfwyw1N/ijeBWE2INk
         mVm4smZjJC3uKnRThdYBXiGW8Rb8u0lUD/CmmLiHpayD2PtvzuycrPdVmKF3QzMJKWTl
         3aC7IonJiFi+FRYE3jPwZsFBWa0iJnFDOg8P77Ft3xeu+A4fIHoVF7D4+lvXDkjGMMTi
         5PKA==
X-Gm-Message-State: AOAM533ZHMildYDolxnq54ttTdI+/jUrzFOC5irNxjmEWXo2yLIIBOhx
        /hmAbzPekYf9vKnDdGit58P9cpBHPaKoQk2n
X-Google-Smtp-Source: ABdhPJxghAWrXoUYvA0tjlL9B695cnzP6RNTnJxRd7vwhBy4hj6J/Q85mfkw3/oVdqm+4soehUIYQA==
X-Received: by 2002:a17:907:2da2:b0:6f4:7395:568b with SMTP id gt34-20020a1709072da200b006f47395568bmr13898404ejc.766.1651732964418;
        Wed, 04 May 2022 23:42:44 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ec40-20020a0564020d6800b0042617ba63c2sm367706edb.76.2022.05.04.23.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 23:42:44 -0700 (PDT)
Message-ID: <316d2e11-a12a-3a73-0d07-a606005df159@linaro.org>
Date:   Thu, 5 May 2022 08:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
 <20220503194546.1287679-4-matthew.gerlach@linux.intel.com>
 <608ba746-9116-3f36-d640-07eb8b5d793e@linaro.org>
 <alpine.DEB.2.22.394.2205041415420.2669897@rhweight-WRK1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <alpine.DEB.2.22.394.2205041415420.2669897@rhweight-WRK1>
Content-Type: text/plain; charset=UTF-8
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

On 04/05/2022 23:22, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Wed, 4 May 2022, Krzysztof Kozlowski wrote:
> 
>> On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add a device tree for the n6000 instantiation of Agilex
>>> Hard Processor System (HPS).
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>>> +
>>> +	soc {
>>> +		agilex_hps_bridges: bus@80000000 {
>>> +			compatible = "simple-bus";
>>> +			reg = <0x80000000 0x60000000>,
>>> +				<0xf9000000 0x00100000>;
>>> +			reg-names = "axi_h2f", "axi_h2f_lw";
>>> +			#address-cells = <0x2>;
>>> +			#size-cells = <0x1>;
>>> +			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>>> +
>>> +			hps_cp_eng@0 {
>>
>> No underscores in node names.  dtc W=1 should complain about it.
> 
> I will remove the underscores in the name.  I didn't see a complaint when 
> I compiled it with "make W=1" in the kernel tree.
> 
>> The node name should be generic, matching class of a device. What is
>> this exactly?
> 
> The component is a specialized IP block instantiated in the FPGA directly 
> connected to the HPS.  In one sense the IP block is a simple DMA 
> controller, but it also has some registers for hand shaking between the 
> HPS and a host processor connected to the FPGA via PCIe.  Should I call 
> the node, dma@0?

Then maybe the closest is dma-controller.


Best regards,
Krzysztof
