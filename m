Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7409353752B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiE3GrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiE3GrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:47:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847C4ECD6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:47:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id wh22so18917955ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xrqwB2lGToCBc+n6yqgpAq/qwvJrPGHrojmotRDLsjc=;
        b=IKtAyaclv+/udvM4J1zeyH39xL8DS2lor2+PCVpwyLvM8oa/ONWMY8HwrpoASrocHn
         HwbzPjz/cFil7MUweoTBV2wGpvHjq8BesQwmCVE3OEFurYL2s5mlP0JklIjmn7SMA42A
         YIOcQvTvQedjzTmlbqpZgpFME4pIQPJGhtb1t9wnIt+62g3xCUUPBH5WyJ3RE8O/PyM4
         rbBwjnsgusdAnWyBXhgNK+DrJMfuvb2y2R+VwnO/98oxKdCrbLbmF4RjplmSSEXaf9Le
         gpG0WFhnyknCCoz0NStiVkltHsk8j/FWMU21QluswTJxrlh2ELLz4rGA3NwBLIflplBi
         QcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xrqwB2lGToCBc+n6yqgpAq/qwvJrPGHrojmotRDLsjc=;
        b=piScc8BJrTR1/z8vIsPoys3RqErFwBD5BTFqNJdePQyjIOb8QqeMgf6sD8zDQrfm04
         4Rt9VXUEIoeDsR7gEF6Zf5NmMJgmISIU/c/TXJYcTwb+MKiD39QFcU4hNrQuuRM4yaEm
         mYhNXjvHRwC35VjHYExiDDxkuHuYnytvb59w/FKBN1/qCdw8rS3trEG3AMcFHl+wM8va
         c6eDQvwdXO+NqRo79xN+GD21i5ryJ8VUKTfJg+rKE7Hm5ZRCBTAVRxDQ+VoxayFdar9N
         zeKsiQANzyRduAUBGr/xJGoiwirQJzxTxL0m2d9iGw8tXUtJ6FEJ9sLWguSaaqmPD2My
         hQzg==
X-Gm-Message-State: AOAM5337wMWcBo4lRcT9VM+xCOgsolZhfYroJQKH4BZT6iTmfJ/Ggtsy
        zLkcBcDItvm+0VHJHj8mIgxPIA==
X-Google-Smtp-Source: ABdhPJxZjFdYQDaVPyTg6JpwNiieMtj79Gp3rSb2rXFI/eDktSp6zcMdBjr7J6dYdib+0gbBXfr6Sw==
X-Received: by 2002:a17:907:7ea2:b0:6fe:d945:7fe with SMTP id qb34-20020a1709077ea200b006fed94507femr28896841ejc.228.1653893234983;
        Sun, 29 May 2022 23:47:14 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kx17-20020a170907775100b006feded0fa87sm3682213ejc.218.2022.05.29.23.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:47:14 -0700 (PDT)
Message-ID: <f284612d-c511-9a31-3e0a-e4fb1cc77c6e@linaro.org>
Date:   Mon, 30 May 2022 08:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
 <1653647172-2569-2-git-send-email-spujar@nvidia.com>
 <149fbcfe-b62c-63a9-6c38-100d493788c3@linaro.org>
 <df57de4e-770d-7331-89e5-a2404fb42f96@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df57de4e-770d-7331-89e5-a2404fb42f96@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 06:21, Sameer Pujar wrote:
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>>> @@ -0,0 +1,47 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Tegra210 MBDRC Device Tree Bindings
>> Previous comments - s/Device Tree Bindings//
>>   -  still applies. Please do not ignore it.
> 
> I did not ignore this. There was a comment from Mark on this earlier (v1) and I did not see further reply from you. I thought you were OK with the way it is. So if you are saying acronym part is OK and just to remove "Device Tree Bindings" I can send a v3 for this.

Yes, acronym is okay. Just remove the "Device Tree Bindings".


Best regards,
Krzysztof
