Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14F047762F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhLPPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhLPPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:42:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA1AC061574;
        Thu, 16 Dec 2021 07:42:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b40so50415576lfv.10;
        Thu, 16 Dec 2021 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xT/SiTniM/eQ/R5+rML11O3ecWALbJayKGmVc/zKnAs=;
        b=eDUAjQFU4pujVpoke1B2Ce2DlcWwNzL17RKV9V6JUts6HbLEXAMq2STRc4kzJ8boUz
         B7R9RJQgQtdt7cf6pcTPa16ZtGntHnvNS/J6bkb4xkNIuPZNWGESjob6LMV/pMuHyICu
         nYzW3fRQ53vO+WuuHmtrmiiniG4zHgvBLTejeiJoYfInfvBfY2GGSwa6AlrJab6TdBbC
         7Ma5VKLSWQKxuaEiwraTPfbJu7DGXNjBlvp/0ApwrqiRRK42WF5XjYMh5X0odMOZEQqy
         KgbIV7sRQsbC0b5IsQmdPRAE3kB3j11KRct2kNJRRrY7oSoKUemT9npq2rI/I/jytwJo
         op4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xT/SiTniM/eQ/R5+rML11O3ecWALbJayKGmVc/zKnAs=;
        b=72r10DjQxS6P3avX+vHvXgvErI8VZS/XDPKELALZA0IuGv3iOxMkPSBzydqptYgr/c
         tL/KbFigAc0/7XI3NzXF+1MVxqNk/YspuNxhXr4aMVTGcnCE/44w3h64i8qQhLVbOgai
         YgwaLa+9LT232dRkjr2rg3Phhqpr3kxtBp3qe4Llwpy3EJ0cnicMhIISggyqsvxgyW33
         qyo3J2XbWG5jDA9763uNnM09Voy7My69l7HTOF6paFOXw8hPewz7ixS9IWITx4mz6z8/
         T/UpcsobT/ZHLrH+8kygbK7x4NfTLcsIdHNJ/CG6RNjQzBaRlFjhNaLiu5vsnWNaSmfm
         7xnA==
X-Gm-Message-State: AOAM531oNnxipyxIm6cUXYzxWe/Gi7g8scjRxT8gOjYVhtV+QzaXexhM
        /gWLFsaXLO+lcNQsbLweo5tgJBt/vBU=
X-Google-Smtp-Source: ABdhPJzrTLDA1Jn72VfYP7tscsKDTD/B1+9QqstauFMJLrAGBEUP0kWlPKjLAbc2kgKzJNPD0OB4zg==
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr14590038lfe.503.1639669374608;
        Thu, 16 Dec 2021 07:42:54 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id o19sm1184608ljp.124.2021.12.16.07.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:42:54 -0800 (PST)
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert
 multiple txt bindings to yaml
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211211224946.79875-1-david@ixit.cz>
 <a84213cb-272a-f1b2-338f-ed8ed0bf133d@gmail.com> <YbtC2I49D0pdcyLY@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <75214d23-3b5f-48d7-be80-8ea17637f3ac@gmail.com>
Date:   Thu, 16 Dec 2021 18:42:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbtC2I49D0pdcyLY@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2021 16:44, Thierry Reding пишет:
> On Thu, Dec 16, 2021 at 05:52:12AM +0300, Dmitry Osipenko wrote:
>> 12.12.2021 01:49, David Heidelberg пишет:
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    sound {
>>> +        compatible = "nvidia,tegra-audio-rt5677-ryu",
>>> +                     "nvidia,tegra-audio-rt5677";
>>> +        nvidia,model = "NVIDIA Tegra Ryu";
>>> +
>>> +        nvidia,audio-routing =
>>> +                "Headphone", "LOUT2",
>>> +                "Headphone", "LOUT1",
>>> +                "Headset Mic", "MICBIAS1",
>>> +                "IN1P", "Headset Mic",
>>> +                "IN1N", "Headset Mic",
>>> +                "DMIC L1", "Internal Mic 1",
>>> +                "DMIC R1", "Internal Mic 1",
>>> +                "DMIC L2", "Internal Mic 2",
>>> +                "DMIC R2", "Internal Mic 2",
>>> +                "Speaker", "PDM1L",
>>> +                "Speaker", "PDM1R";
>>> +
>>> +        nvidia,i2s-controller = <&tegra_i2s1>;
>>> +        nvidia,audio-codec = <&rt5677>;
>>> +
>>> +        nvidia,hp-det-gpios = <&gpio 143 0>;
>>> +        nvidia,mic-present-gpios = <&gpio 132 1>;
>>> +        nvidia,hp-en-gpios = <&rt5677 1 0>;
>>> +        nvidia,dmic-clk-en-gpios = <&rt5677 2 1>;
>>
>> I spotted that nvidia,dmic-clk-en-gpios is undocumented, but DTs and
>> binding are passing the validation. We will make another patch to fix it.
>>
>> Rob, could you please tell whether this is because unevaluatedProperties
>> doesn't work yet or we're missing something?
> 
> If you update dt-schema.git to the latest "main" branch you should have
> most of what's needed to make unevaluatedProperties work. However, there
> seems to be an issue with some $referenced schemas setting
> additionalProperties to true and then that gets propogated to the schema
> that included it.
> 
> Rob came up with the patch below to fix that:
> 
> --- >8 ---
> diff --git a/dtschema/lib.py b/dtschema/lib.py
> index 3cc5e428b0eb..a0f22aab935a 100644
> --- a/dtschema/lib.py
> +++ b/dtschema/lib.py
> @@ -367,6 +367,9 @@ def fixup_sub_schema(schema, is_prop):
>      if not isinstance(schema, dict):
>          return
> 
> +    if 'additionalProperties' in schema and schema['additionalProperties'] == True:
> +        schema.pop('additionalProperties', None)
> +
>      schema.pop('description', None)
>      fixup_interrupts(schema)
>      if is_prop:
> --- >8 ---
> 
> I'm currently running the tools based on that and it's indeed been
> flagging some properties as unevaluated that weren't there before.

Thank you! The unevaluatedProperties indeed works properly using this patch.
