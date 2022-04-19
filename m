Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC46950709B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbiDSOeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiDSOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:34:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5F211140;
        Tue, 19 Apr 2022 07:32:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o127so12490565iof.12;
        Tue, 19 Apr 2022 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=iPD1iR5qd5xmFxqoNP+9ShsEquOYqKS33gFTSRsPZro=;
        b=Z7LxYAUbZnVFiFy71HCGAnsd0qRNreWPi93Lf3JHld6XjimOV92Fr8+6ProAPK2UtX
         NEWGht0ORsquv+fNRKONaJYbpqKKBW8d22vmuMjdiSZxC0gM7rvMBeaGzboazwzAxXGA
         mDvxXALWBzew3j1hguficgc8qmUB/vYIsCquZFmJFBFN92Q41mrqxax8L4Q7VHS9BI3v
         sxaERl9GP3TP7D696rUbdqBfFfB3KegF1lkwklp6Wj4tWxdqH1r3RNRx+ipoHoEDpmde
         O+AMs+j7ocD2qKdCVl024eKgvYt8P1F6AGr7MqzcUZmG1JiwUJxfmbZqC/T+KKrBmD8O
         HYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=iPD1iR5qd5xmFxqoNP+9ShsEquOYqKS33gFTSRsPZro=;
        b=X4Nqdyl34VdhfjjwpW9g50DRf5dszr+229W54JW0vVOOsrE9hIEsKgG3D0RY6rmTRZ
         hluRRH/V56TAac+tyeYxSD4MpHrWciDNBSOI3A8ftJH60AYzYSckJoR5kYpuL93nHA8V
         iz2o7sf8Pnji01kB2HFf98dpmCT+DNxglgnbFE4Lc91YpslLh2OX+f+NCs8JHhb8dSBr
         5QD6NJa2snBWwiXl5699RmJWbChxecmujXz82QT7MnUEW/L37j5WDddnm85cU963/Dc0
         XLt0Li7bCudwp+Z8v/fio8La8HmdCbaEDPJjIkrIl+f1P9lNvsuEfoVJpJ+i7/sqSxC3
         4Zkg==
X-Gm-Message-State: AOAM532NLobyzk2VtEoJflxZ5T9kb52A5qWINMfFMMy5EELM8UyOHpiC
        jg8qM7TE8BGM6nSwrzdDsYw=
X-Google-Smtp-Source: ABdhPJzL2cpCI4DDYEF14wIz+iVDK+70GBOSOBRKi+gYopggEMfFhTfSw6J23ZbocFRaz59bj9/WaQ==
X-Received: by 2002:a6b:ce01:0:b0:64c:ad0b:9a65 with SMTP id p1-20020a6bce01000000b0064cad0b9a65mr6527353iob.147.1650378722931;
        Tue, 19 Apr 2022 07:32:02 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r14-20020a92ac0e000000b002ca8eb05174sm8934717ilh.57.2022.04.19.07.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:32:02 -0700 (PDT)
Message-ID: <448093df-288f-3c49-270e-5d830a986b27@gmail.com>
Date:   Tue, 19 Apr 2022 16:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
 <165036314214.180327.9860190048104061653.b4-ty@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: align operating-points table
 name with dtschema
In-Reply-To: <165036314214.180327.9860190048104061653.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 12:12, Krzysztof Kozlowski wrote:
> On Fri, 20 Aug 2021 10:16:15 +0200, Krzysztof Kozlowski wrote:
>> Align the name of operating-points node to dtschema to fix warnings like:
>>
>>    arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
>>      opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'
>>
>>
> 
> Applied, thanks!

Could you please provide a stable branch for this patches? So that I can pull 
that into my branch. This will help to reduce merge conflicts later on.

Thanks,
Matthias

> 
> [1/2] arm64: dts: mediatek: align operating-points table name with dtschema
>        commit: c743bb394d35b782ae9d9ab815d6053500914533
> [2/2] arm64: dts: mediatek: align thermal zone node names with dtschema
>        commit: 54ff423f837db59db0626a00d091e45dcc46787e
> 
> Best regards,
