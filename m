Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8A53B65E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiFBJv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiFBJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:51:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469212A5D41
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:51:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h19so5590785edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MjN3QAPXaLu5asd6/V8KFEW3wXF4UjKGCU1d2AqsWJY=;
        b=tGk9DbU4Vc2+x4lxBEGT4A/vmPlacop3egLMcF/79UBOenFdesqSP1zeyAx3zhqH0q
         y6cMMD2KP+FspuohWKtEyKbYtfVI5mzwy8cpVp59q31yCD/Vj3fvZxBg4vEhFPhIiQGH
         4+qAvMDyiJT9xvyhEGzkSeZGfLgZVW6a+E2btw0aZoCchiJmH/MXlaMCUh1491PhiSMM
         plVc6cnJCnaGm81FAmC14eFfu13jHFM3Aei/7Z9dzpgxQA8zyti/7wamhn8bC7Wyg0WM
         TjCqvhDNH8/hUZlLOXo+y/xYKphNABNi3f8aLFV8VLIaRm9MrNZr9da2zZj0DsnPlsHb
         37vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MjN3QAPXaLu5asd6/V8KFEW3wXF4UjKGCU1d2AqsWJY=;
        b=jNVvs04j2DIX5JhHpz3MB0D/li0Q+TtzLFNkGZYNrJbxoynO/1+cfKV1yKS0GaIyJe
         wtAUJgs7XshOmJiVkicCiwO7+mhYTE5NFGzKgtyPnvw8ujhQua3eZd0egRFSKd03avD0
         yeZYirasJxcVo5MHTYF40/geZGyUvZJ/36/+xXwp+OuHqj/HXcU8eaDiPFk7x6r9oGpx
         bcMmIhXJHSiRZPcq94PMc4C0jlCO68GM95t2KD4YnqEYYzQ6Vnww42PehTUQN6MSshOZ
         kQ1+iYSWZtSWJfOol8RYLlWOL+yRwcJpdL5gA/ZWtQUL9DuxEbyJkPVjjLox4IWFZ8e7
         3HFw==
X-Gm-Message-State: AOAM530O4boBf7qoAbUkvCmiCKYKjHhxmv72fbwgxLiIIlE+Dojyy7/h
        vDyh1ifPSy2aP7K95PJcBUWVqg==
X-Google-Smtp-Source: ABdhPJyg0zDfRZBzZGhi4dzXWG591XdASf/OW4eBJ5t4TQxpfa4I1d+/cFejfsHd6Uglaf26Azcsjg==
X-Received: by 2002:a05:6402:1c91:b0:42d:c9b6:506b with SMTP id cy17-20020a0564021c9100b0042dc9b6506bmr4354589edb.166.1654163481859;
        Thu, 02 Jun 2022 02:51:21 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lo27-20020a170906fa1b00b006fe9209a9edsm1546466ejb.128.2022.06.02.02.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 02:51:21 -0700 (PDT)
Message-ID: <5e73e87d-4133-9a1b-27bd-1c4ca25e4b0d@linaro.org>
Date:   Thu, 2 Jun 2022 11:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual
 Platform
Content-Language: en-US
To:     wen.ping.teh@intel.com
Cc:     catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dinguyen@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, will@kernel.org
References: <2cf38dea-0754-e63b-4832-a0b2aa966c61@linaro.org>
 <20220602034616.2840946-1-wen.ping.teh@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220602034616.2840946-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 05:46, wen.ping.teh@intel.com wrote:
> From: wen.ping.teh@intel.com
> 
> Hello Krzysztof,
> 
>>> +	chosen {
>>> +		bootargs = "rdinit=/sbin/init ip=dhcp mem=2048M";
>>
>> Bo bootargs,
> Could you clarify what does "Bo bootargs," mean?

Ah, there was a typo. Should be: "No bootargs".

Please remove such bootargs because this is not a property of a hardware
and different user system could use different bootargs.


Best regards,
Krzysztof
