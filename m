Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8CA50A30A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389596AbiDUOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356573AbiDUOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:48:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98CE0C5;
        Thu, 21 Apr 2022 07:45:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q1so3907327plx.13;
        Thu, 21 Apr 2022 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=in+b1t9I/AYFyIFkIgqViKXfibDH0DzRL81hOpx46Hg=;
        b=aKNDJIvDaQEaNjOttYctXSuU+OojPCpvcEPTlJzo3aBjl3TR/ZL3n++yus4u1X2nPc
         nfLNLM8K35XhHj5tawqk7Nbb9RMOZ8/pJbz10pXSjx/SUyw1jQQ0CVmaHKBp3Ts23FpR
         8OqfLngAUPW4itxqQL+jeMtaFBausBaheUKifREXWJoYZSrmtbKYZ2L1yKAistQNarqv
         g4Ahzgcaa5kh9eVw+pE/qDiBXsl8iJpkrLETVf3PD0gUjd9xGdfMUg2E4m5errtRg/jd
         +Q8govggq8FGcUrRqX4Mc5ERdDqIbS0/ww94X8aZBRIpNKHHbCThtEu85l+H/ndt9H5m
         eUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=in+b1t9I/AYFyIFkIgqViKXfibDH0DzRL81hOpx46Hg=;
        b=SRynx9EUme+VQd+a4j4IpcIWtw1c2zpYZlPXD5LlagI4VnzYaMyK6dloIq01E9gi01
         4O/qvSnLTTWTHhKvUWYO1kL7pYV5lhhCV9rg4z/PaBYYr523yYuVpek3kxLdugsQ/w8y
         s57ovlOFxnaowgL/7pwygkcsRGNcunJGLH55YhYpjzDQY6Z7+mtqkCvcWuATVtR0CDKp
         UXTyUAekhrxBNORn25c7OsYgMPHkGALYdEYLGn+f1k7oRDspkhjWjSroyAxTJvkgtFgc
         SEntL2e5aP3Svnqv+uAGiC11KCsylfJwqczVoqBGPuohkXPVg9ppcR7Apl9RtWlYBuWG
         rTFg==
X-Gm-Message-State: AOAM533dvhYEI8BHVyI9jIkwhQSsmgBkUMRPHUyW/bae1BOkYuvo84UF
        0RjfW0iJdDITytO+xL2psGA=
X-Google-Smtp-Source: ABdhPJz4pO+ROCT3iAGkudRxxwypK297Bt7LuQdQt7oIFrXxI/o+XMM8+GSll+FYjqSQdjMK/i2jiA==
X-Received: by 2002:a17:90a:178e:b0:1d2:e998:85e1 with SMTP id q14-20020a17090a178e00b001d2e99885e1mr10790308pja.234.1650552346989;
        Thu, 21 Apr 2022 07:45:46 -0700 (PDT)
Received: from ?IPV6:240b:11:ea00:8f10:a9e9:6bed:bfb0:9151? ([240b:11:ea00:8f10:a9e9:6bed:bfb0:9151])
        by smtp.gmail.com with ESMTPSA id t19-20020a17090aae1300b001d2b4d3e900sm3004360pjq.41.2022.04.21.07.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:45:46 -0700 (PDT)
Message-ID: <09bebb90-7792-a728-6bc5-775b1c482d3d@gmail.com>
Date:   Thu, 21 Apr 2022 23:45:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add DT for Buffalo WZR-1166DHP2
Content-Language: en-US
From:   SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, takayoshi.shimamoto.360@gmail.com
References: <20220412154432.12124-1-takayoshi.shimamoto.360@gmail.com>
 <ab529968-7dc5-f4c9-5ce4-5dc95b64838f@gmail.com>
 <52225285-3b64-f709-81ff-0c26a9b13c02@gmail.com>
In-Reply-To: <52225285-3b64-f709-81ff-0c26a9b13c02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I got a collaborator and decided to make a DT about the previous model 
WZR-1166DHP2, the WZR-1166DHP.
These two models differ only in memory capacity.

I will rework some of them into a common patch as dtsi and post it.

Therefore, please discard this patch.

Best regards.

On 2022/04/13 22:09, SHIMAMOTO Takayoshi wrote:
> 
> Thank you for the replies.
> 
> On 2022/04/13 2:49, Rafał Miłecki wrote:
>>>   - 4x 10/100M ethernet switch
>>
>> Isn't that 10/100/1000?
> 
> You are right.
> It supports 10/100/1000Mbps.
> 
>>> +    model = "Buffalo WZR-1166DHP2 (BCM4708)";
>>
>> We stopped adding SoC name to the "model" value, please drop it.
> 
> Understood.
> 
> I will fix it as follows
> model = "Buffalo WZR-1166DHP2";
> 
>>> +
>>> +        wireless1 {
>>> +            label = "bcm53xx:amber:wireless";
>>> +            gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
>>> +        };
>>> +    };
>>
>> I'm wondering if all new DTS files should use "function" and "color"
>> instead of "label". That's preferred solution and I guess it's good idea
>> to use it for new code.
> 
> Understood.
> 
> I will rewrite it with "function" and "color."
> 
> I will post the patch again after testing.
> 
> Best regards
