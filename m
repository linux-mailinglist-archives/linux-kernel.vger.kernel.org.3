Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65A514A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359779AbiD2Nad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiD2Nab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:30:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362B22C10F;
        Fri, 29 Apr 2022 06:27:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id c125so9713977iof.9;
        Fri, 29 Apr 2022 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LUkIerDD9yFWiQ4XjK59IaNhq21fsN5VuxYrogYKEo0=;
        b=c5HmS9fg/usITYA5aQsq+UT5PKinstTEHXzxuJp+WNbF7kHb07BNF5dCSWubg+XvpS
         RbW/eU9mLwyx1r3Wrto3Bg1hCFsZX6mogDTCLXHeSo1clWNbu0mIc7mXZP42z328iYD1
         81X2iFcf4av/Rhop7TW7zb7gSKWzGCI3mxmEJLkap/lxDRO2unIAIlrjCE2eCjdcsBQi
         8EQNmm5rP0baNIVXgqZIbXmV7ej+C6f9yLcYd42sxjN8stadWOxA6l3K69GcoineDPLR
         LJDLq8UMD3q7tKFwnqeRXssNJWyp/obgVve15VQ//yH48gZPOLWyYAvT9qcfBjDlg6db
         8H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LUkIerDD9yFWiQ4XjK59IaNhq21fsN5VuxYrogYKEo0=;
        b=Xug3RcT/123VSqmMGrJJp9X8OJjprd0OPWFCHngt4tQOxquQhB/AbrhWPiuvV4zl2i
         E61/TDer5KfWJ7e1WaNH6FDD091lS6vxrofGiiq7K9prn2kNr7ddfkZPh+dOYPkaAaH2
         F1r8jTslP65wQlnEYFwIITfghA+wm9nTc+vWQmCXzPkJyCET7LC2qcrbsMHfmrmeMFWB
         nFj0bXHoGhFYAtkIGMts72GRsXezO/VYkZZI7kg+djJNasWqAIW43xQeQt20r9BTLvGb
         pPQ2/JAaP5qPZRjm9iwBknZnPkvlz5jxncm64veTQZP8LanKdB8pFEcZt4DRc95A6uvK
         cfIg==
X-Gm-Message-State: AOAM531rgNTVb4/m9rwzY66aT2znzkPdaQABww3o0p1vdB8X0uB6CXx2
        gKIRit/pickXqLp3WVKHeTo=
X-Google-Smtp-Source: ABdhPJwJ77CkMkxkuzo6DHghxnW2F1yf3HeMQeDTYShK7oHLdqIgO4ebwcCDZRrGdkz+i5odFyUPrQ==
X-Received: by 2002:a05:6638:2610:b0:32a:fed1:a4c7 with SMTP id m16-20020a056638261000b0032afed1a4c7mr9099242jat.1.1651238832526;
        Fri, 29 Apr 2022 06:27:12 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id u14-20020a056638304e00b0032b3a7817cfsm572163jak.147.2022.04.29.06.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 06:27:11 -0700 (PDT)
Message-ID: <a3e566a5-bff7-10c5-724a-dde52e574c5e@gmail.com>
Date:   Fri, 29 Apr 2022 15:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-pumpkin: fix bad thermistor
 node name
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220426164755.435372-1-fparent@baylibre.com>
 <3ae5b1ea-4721-3e61-9b5f-505ab2d5f037@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3ae5b1ea-4721-3e61-9b5f-505ab2d5f037@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2022 15:50, AngeloGioacchino Del Regno wrote:
> Il 26/04/22 18:47, Fabien Parent ha scritto:
>> Fix the following dtbs_check error by using the correct node name:
>> /home/fabo/build/linux/mt8183-pumpkin/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: 
>> ntc: $nodename:0: 'ntc' does not match '^thermistor(.*)?$'
>>     From schema: 
>> /home/fabo/devel/baylibre/linux-mainline/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml 
>>
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Applied, thanks!
