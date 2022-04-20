Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E49508843
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378615AbiDTMim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiDTMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:38:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F313F50;
        Wed, 20 Apr 2022 05:35:53 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y11so873908ilp.4;
        Wed, 20 Apr 2022 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BiLwiwddtSMnlQ0M8iHv3+ugnw2GAfojyhyoRie29Vk=;
        b=e0EtYUunQZ84wIdzf8zq9LY2W4oa9WeNkY3QlCIPHvOdI9e1Fvvx6d4qj9MXxi4wjR
         krYzb67qgZBV7++16zQnXvLEKOTtCAxEaaDfFh1G/FyibNSfky00SQK6ugA08KTlQ1Sl
         B+C3D3cXbP16iHNDNCzhcWgCICEZvPPZurQMgF0k5YTxbGxj72Y7B2SWf1XEWwFHb/v2
         bvo5RW+3cZx3JTX4KSV+ibiWiNFVA06CD0Lmh3b5kFyrJXz85udbpJ35zjdxwSspcSeB
         rf5Dm6bYxTrk1b/Yvv32dRRxvB/O2nAzZdADDbSVrRJ1RpIKNBQtkrJdh/PIaQ5wxf4I
         RDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BiLwiwddtSMnlQ0M8iHv3+ugnw2GAfojyhyoRie29Vk=;
        b=6uc1Lhb1xawrVihdvcCvJGnkeZa+hqEx0vUBJtsCJ8mGm/RLob23j31HJNBh9oTcTr
         9pLR3CAA9Fz4WI0k5HZSPgTJ703uZYaYMxygffre7pjceyHksiEmlrp3S1X+6rvyJu8k
         HWn6KFnQ801eWdxFqijgbWcbMjOuFegVMRzL205SdQui+SAQNkVnpXNu/Uz8o+JfbFLV
         C5Tfxc3MvkYUjNa4qLNpldHqW7kTP7KKntytnq91CgaoMsIkwTMGWFB1+pnKLZ5FlNAK
         qePewokZMG9wgNChzxLrxBJ7QumruxPW80irb9NQpywqbk328QEhJuWgqn1uc1E/ZQc4
         wuJQ==
X-Gm-Message-State: AOAM531fnJuMW3K/cUDPEacLQ6ZL/LsTuV+yZAYAIqTePAyl+DPDus8j
        03XzhOJ1GiatGV5UvQxxsQ8=
X-Google-Smtp-Source: ABdhPJzKIwd8l2yZZ031MUP9S0Jjf7C8b5CPjV3TsOHP+MKPFXEdaMvbfQGutKPOvnvuukrfm4Meeg==
X-Received: by 2002:a92:c26e:0:b0:2c9:e7f7:5eb0 with SMTP id h14-20020a92c26e000000b002c9e7f75eb0mr8926130ild.143.1650458153081;
        Wed, 20 Apr 2022 05:35:53 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8553000000b00649f02b1b0csm11330099ios.39.2022.04.20.05.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:35:52 -0700 (PDT)
Message-ID: <38f29c29-e3c2-240a-23a0-509c4febf1ca@gmail.com>
Date:   Wed, 20 Apr 2022 14:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mt8183-kukui: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220407142143.293740-1-krzysztof.kozlowski@linaro.org>
 <165044570803.75184.17759035800452933385.b4-ty@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <165044570803.75184.17759035800452933385.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2022 11:10, Krzysztof Kozlowski wrote:
> On Thu, 7 Apr 2022 16:21:43 +0200, Krzysztof Kozlowski wrote:
>> The node names should be generic and SPI NOR dtschema expects "flash".
>>
>>
> 
> Looks like no one wants to take this, so let me take care of it.
> 

First thing would have been a ping on the patch, don't you think? Anyway as I 
said the last time, if you take DTS patches for mediatek, I'd need a stable 
branch I can merge so that we don't have any merge conflicts in the end.

Regards,
Matthias

> Applied, thanks!
> 
> [1/1] arm64: dts: mt8183-kukui: align SPI NOR node name with dtschema
>        commit: 4e3ffebd69e0aada1ce6bf4bf832e14a3c4f50db
> 
> Best regards,
