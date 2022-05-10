Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFFF521383
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiEJLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiEJLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:23:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CE1A90CC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:19:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p18so19568160edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u0y4f16c0SOxo3KwwVWJYxBGeIW5Ufwj7qZq0QGv9lQ=;
        b=qNAm9YJPmxvXVHcVJ7IIPrBaO39WMBuQfahQlJMJ9xSTS9HofGYt0F36Bp4m/pxkmW
         pJ804n8QK2Pn7+lT3YoCpvP8HCN7Q9VO2nhFI3WtK5AQfcZG8fwG8+gIVod6mSB7CeZb
         unaEiKt9vmpUf2Z9csxvGgL85ChRlx7adWRL2PdbQcgLNz6GGnq1OWDvC8D8PDieMcxw
         87/fW03PFqdj1Hb9CRJr7KvOza0ejirA9qzgkV1fJdWQtglx4QfpSLmjmtrcQhFIi1QY
         ZwfhqAWr000Qb/AU/Czz3464iHwqChSUmwpTviC7lPm024J9sUNyQlUUYvMJKIPEyGp6
         nCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u0y4f16c0SOxo3KwwVWJYxBGeIW5Ufwj7qZq0QGv9lQ=;
        b=aLKTIadjO8EfbcC4YSdg32XtVsznO4Curkqb77bBrlhqQ4vZxGm0AaWNs+xdwTOn57
         1H2sgojYq0i5+dSbu0Ew+XMOc9cn8vnxdWiHKH8fpIxOvWD6QJLHnk61CTbzNJpD89mm
         E1EaBPXNk+nv9EWdYDN1imjZnrizNPEMcGnj/Z7I75RLbnHeTAZzJE2CwEgJhnk+XZrd
         Uzo2s3baKk2AF/ZKDyt8k6T2RP3/9nVskkmb2hNfphPE+c1UhvxrWWcuP6E1Y6qRsWHb
         c3DH78QgZT2/66z//3jR53DQF4XyHrF6TSjtgOMFPhxcWJ5CY/oHDsZDn2LXFsw1RiDl
         q+xA==
X-Gm-Message-State: AOAM532dS6pPYTbKPwoKnKgKc61cljUun6hd3JNmrKNadTVzFX2Gdwb6
        tmJiu9mtRhnaNm3O/pz6i1Nx+g==
X-Google-Smtp-Source: ABdhPJwllYKDvo2bMIM/15KAP3K8yYn+Ebe9XKBiKYD5ynUUL9BMaCIYSvb+Z5nNlh+dYhulwjptHg==
X-Received: by 2002:aa7:c6c3:0:b0:425:b13b:94f with SMTP id b3-20020aa7c6c3000000b00425b13b094fmr22453853eds.313.1652181584762;
        Tue, 10 May 2022 04:19:44 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b0042617ba63d2sm7391578edt.92.2022.05.10.04.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 04:19:44 -0700 (PDT)
Message-ID: <f1d477d2-13c4-2914-e520-4b2778e52e35@linaro.org>
Date:   Tue, 10 May 2022 13:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-4-rex-bc.chen@mediatek.com>
 <46bc32df-e4e8-ac47-426d-8056714f0d5c@linaro.org>
 <5462209c5afb0a638ed777ec1829bb2717c8d76e.camel@mediatek.com>
 <98505974-afad-9639-d4f2-814097b0523b@linaro.org>
 <85fcdcd0-e7c5-5192-9113-c69f9c3a6385@collabora.com>
 <2a480ca0cf640e59a12d55435d02cb3892035a35.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2a480ca0cf640e59a12d55435d02cb3892035a35.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 03:46, Rex-BC Chen wrote:
>>
>>
>> That's mediatek-drm, and this refers to the HDR block in the display
>> IP...
>>
>> Though, I have no idea of what "ET" stands for in "ETHDR", so, it
>> would be
>> definitely nice if MediaTek can write the meaning in the description,
>> like
>>
>> description:
>>    ETHDR (E??? T??? High Dynamic Range) is designed for HDR video and
>> ...blah
>>
>> Cheers,
>> Angelo
> 
> Hello Krzysztof and Angelo,
> 
> "ET" is actually meaningless.
> ET is one of mediatek departments and it's where the engine from.
> Therefore, I think we will add description like this:
>> ETHDR (ET High Dynamic Range) is a MediaTek internal HDR engine and
>> designed for HDR video...

Sure, sounds good, but then the node name should not have it. Please try
to find some more generic name (DT spec gives examples). Could be
display-controller, "hdr-engine", "isp".


Best regards,
Krzysztof
