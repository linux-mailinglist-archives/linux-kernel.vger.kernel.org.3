Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3775825C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiG0Ljm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiG0LjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:39:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0E49B73
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:38:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u17so9348953lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MGUgabyld/EeWL+9XhnAgZD2EBdXnWluJ901k882Jpg=;
        b=V5XzwXTKWH6s0hot7/PtPjtvOzCNi+SEBJkUHj157j7tvL/Phb8KT6SkItkdoTzpdv
         09lGUuIsJCRieoy8cD/BkLtkvdLkAC+Ynp5sYksR+lEfretIPqExC24P+7yLAGMZAA3H
         IxNPafDhUZnmPzYo/AfBuGPNAvHsvc46Yq5AJ+fbBBDq+jtmq78lIJLpO/escX0NsAvL
         blF3F1+C3UyTXku/Bq5X2ONn8bgig2lGmvv8KQ+dKBt2X7ojSgdFclTKqYAFOw0umPmO
         UuzCKUgYVWNiExNmMNR/KYE+Eenoeds+rzdMsehNhKdBnTox9340mpgyvjVmolJUtKuV
         pNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MGUgabyld/EeWL+9XhnAgZD2EBdXnWluJ901k882Jpg=;
        b=W9xY07wNpHuPdlbn52tIHX2xbXUpSQPTicI2Kh+SHcFQwICXoASlffraTIaJgwZp8J
         /hAtKb8TXpFvbEo+j4qy35/tURKcr+5VpRqXWcbjPRMmkoaip4fnx8iPVZG3QkA/4Am0
         4ozW49NismrRbocU4mFtmemFpkVbpFAnjoPjP18ynGV0SDaHbFrYVgDynYZNgA/7PhIr
         kV3H4S/RS6j1nx4/SWVYkzSj5V6oNpoBf/IexNxC+DseUlv14iATYug2BqDmtmJXbLN/
         ZXfsrFkw3Awq6Kel6PkAGVsEUYpHrFOMWlhNOHfOWn0ecG6dQkjuRJo8h71iEN/EQdeM
         GSxQ==
X-Gm-Message-State: AJIora8ujT3lFL3QHA++zsM0tOREkwpXrlLv3mcWhWLyQmKNiUbW1B8f
        U3LamTW+4CdG20N5w9Qs9LW/8w==
X-Google-Smtp-Source: AGRyM1sQ74WtezfGlT4uCwItsqqfEXVEkE7x/nMn5V7yq4uiRQSeAryO4OrKcJgV8n1vzGNnBcDCRA==
X-Received: by 2002:a2e:87ce:0:b0:25d:e933:f76c with SMTP id v14-20020a2e87ce000000b0025de933f76cmr7174054ljj.99.1658921937293;
        Wed, 27 Jul 2022 04:38:57 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id z10-20020a056512376a00b00486d8a63c07sm3628641lft.121.2022.07.27.04.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 04:38:56 -0700 (PDT)
Message-ID: <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
Date:   Wed, 27 Jul 2022 13:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 19:01, Maximilian Luz wrote:
> On 7/26/22 17:41, Sudeep Holla wrote:
>> On Tue, Jul 26, 2022 at 05:15:41PM +0200, Maximilian Luz wrote:
>>>
>>> So ultimately I think it's better to add a DT entry for it.
>>
>> I disagree for the reason that once you discover more apps running on the
>> secure side, you want to add more entries and update DT on the platform
>> every time you discover some new firmware entity and you wish to interact
>> with it from the non-secure side.
> 
> Just as you'll have to add a driver to the kernel and update whatever is
> probing the TrEE interface and add those strings to that interface. If
> you then start doing SoC-specific lists, I think you'd be pretty much
> re-implementing a DT in the kernel driver...

But you don't have any of these names in the DT either. Your DT node
only indicates the presence of your driver, but does not hold any
additional information like these IDs.

Basically we start modelling firmware components in devicetree. :/

Best regards,
Krzysztof
