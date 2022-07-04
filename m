Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51F5659AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiGDPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGDPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:22:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A06304
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:22:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a4so16410427lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8xwHiY+KHdJ36jx2bH5eRwBSG1byM2tLFU+DhcoTg0o=;
        b=YO6UTzSTMoo1MhgbrFxQl5vZNZw780MrwSU4+5AHy0twMe030NRMYhtfLGId2QzwUo
         wI9Q0dAMWIhASJNZGGMhzB7rCu7e49JQzi+DMhsY7o6a9FU8/OfjFmS29nSZsM1ItBu1
         sf8Li67cxkTb2mho9wvlaRMfbsm22r27B+Ekki/bGoWavwR91hDggooJKFfOrLBoYFd0
         /55/ih7UJ8dhNHhTpZOuDRtnd/A/rRnx5FW01bOEkkYhMIZBLrF5Py1qxExpeqDv1HrX
         zLy1O3i0887k5I2I+P8ki47Z4mHXunDfrZipNicldGoA5LivZ1nj0WoQaceZ1nnGIiBa
         dsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8xwHiY+KHdJ36jx2bH5eRwBSG1byM2tLFU+DhcoTg0o=;
        b=sgGUkd/SdhXGKZa7Z/GmdKpaJmdYcjwQEoOE5kKRwajCVkRva/PUelBeFQ4/QZ1+mL
         giq/nhwNaU+CTig1tWcLBxzssguknirGQx9d/f2r1okoCvWAnrX/4YtzDnwIyou1DDup
         fpXxS15DUBg0m2d89Bl1PowIpkrpNoCxJkefcqxCBVOJqVEqhC4SwljRswOeNmK3E+Nk
         6x1PQm5IDfFQLbhLDa74FpcYNTHUQAPknp033M3/0Fj+z36exh4Uivg2/+11ipkWvJju
         UrEy25S3ILpLIhIBXNi9b5NnFClneOxglw8GiXRwtmsXJlhuG6jcV2h3D8xoc5zNKgiF
         2TEg==
X-Gm-Message-State: AJIora8V98ZpU5xUy2ZE05f0QcXVUuv/65HBZuiNUUooXC4ajKCdKllw
        1lLa567sZh4lMwV6PpkN0/1o/A==
X-Google-Smtp-Source: AGRyM1ty3S5JG0vO0h6LwyeRbL9KOVIVLYSgjbipJzz/dJcR241XrZa6IiWEoVI8Jo04igtYlFvBYQ==
X-Received: by 2002:a05:6512:20cb:b0:481:7b9:ffb7 with SMTP id u11-20020a05651220cb00b0048107b9ffb7mr18663646lfr.573.1656948143217;
        Mon, 04 Jul 2022 08:22:23 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9bd6000000b00253c8dfc4e4sm4876809ljj.101.2022.07.04.08.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 08:22:22 -0700 (PDT)
Message-ID: <9cd658cd-3b8c-89d1-651d-ce81794fb68c@linaro.org>
Date:   Mon, 4 Jul 2022 17:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/4] soc: qcom: icc-bwmon: Add bandwidth monitoring
 driver
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
 <20220704121730.127925-3-krzysztof.kozlowski@linaro.org>
 <3770bc6d-b3cc-9e49-a832-4c15af0b5f1a@infradead.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3770bc6d-b3cc-9e49-a832-4c15af0b5f1a@infradead.org>
Content-Type: text/plain; charset=UTF-8
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

On 04/07/2022 17:20, Randy Dunlap wrote:
> Hi,
> 
> On 7/4/22 05:17, Krzysztof Kozlowski wrote:
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index e718b8735444..2c8091535bf7 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -228,4 +228,19 @@ config QCOM_APR
>>  	  application processor and QDSP6. APR is
>>  	  used by audio driver to configure QDSP6
>>  	  ASM, ADM and AFE modules.
>> +
>> +config QCOM_ICC_BWMON
>> +	tristate "QCOM Interconnect Bandwidth Monitor driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	select PM_OPP
>> +	help
>> +	  Sets up driver monitoring bandwidth on various interconnects and
> 
> 	  Sets up driver bandwidth monitoring
> 
> would be better, I think.

It's a driver which monitors bandwidth, so your version sounds a bit
like monitoring of driver's bandwidth.

Maybe should be:
    Sets up driver which monitors bandwidth...
?
> 
>> +	  based on that voting for interconnect bandwidth, adjusting their
>> +	  speed to current demand.
>> +	  Current implementation brings support for BWMON v4, used for example
>> +	  on SDM845 to measure bandwidth between CPU (gladiator_noc) and Last
>> +	  Level Cache (memnoc).  Usage of this BWMON allows to remove some of
>> +	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
>> +	  memory throughput even with lower CPU frequencies.
> 


Best regards,
Krzysztof
