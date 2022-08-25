Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B45A0E86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiHYKz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiHYKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:55:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB1A3D12;
        Thu, 25 Aug 2022 03:55:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d16so18806398wrr.3;
        Thu, 25 Aug 2022 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oyZcoTjyMEtcZwV3/B5W+C8C7NFVH52CzyEkKb2OUx8=;
        b=HyQhg4wiLRifkwd4Ez1urfVRyWOqbp8ET3k+QElmPkt7sCxV5boK9k2iU13762E8+e
         zdoCcBKNoJDiwmfqijDkGwjilQgzui09HRSUDb2C6eBsW8rg90iJw9cxa8YPBWiB34xT
         2KhyRqE4JisnQhAJSiPyRjxwDaABHbBFSVLlj5TwCroYRaFanXzRqwqr2DdINe/Z0M3a
         i7lGePKh32lclpl2LYBg7h5MIKhH/zAfWTBqmcebxrYiO+ncf3owoh4dECebwosQXDCF
         jJYG1gtp9Ve/nQHVyqPPC2QM0oOsl41xu/nCEKHJluDdILGBvf8H4bAM9WzMhU09Uvxp
         genQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oyZcoTjyMEtcZwV3/B5W+C8C7NFVH52CzyEkKb2OUx8=;
        b=3cGuEkMsAIzdMDgvqZwW/s2NhxZCu8MhWP+rSDx2bS6WKtocPDBsvo+jWbAmJEigez
         szDCmbgGJh3ZV0gTx8qY2nchqHSSIZ9PSbYE3xqCe+xI+6fr3whem5uJeiUBqi/q3IRA
         Oj2F1HpxosePOpLRJ2p9gbsulQIRL4XjAovwCKxBMRPOJj9zefO51ABPG/xBDktJQWMm
         /Q9woEI/3dhKJEsAy3EiIwnefUpDvo5e1WmxIKidLtOiT/2DKbho5iokPRJ4kkmFfCQA
         Ell2zaNBbn8IvKUalgr8FAX1ivOhutdfAfzaARNVaccgGg8GO5SC04FfsTRLpTNNQZ2X
         AP7g==
X-Gm-Message-State: ACgBeo0wfzE2ow+YEQM44MXf9v4MR76s5SaEG8jpmOpwp+CpHgg+jnKu
        8/4vyC4GGjcyyh6OmTRi3xg=
X-Google-Smtp-Source: AA6agR5MIH97H7VnI/JMrU8PJjngbC1n3DjQcGnGPLXQLX5ZM2HtkMsxgBi+UZuCs5VUBb+oKGw8EQ==
X-Received: by 2002:a5d:5a83:0:b0:225:62e3:9d38 with SMTP id bp3-20020a5d5a83000000b0022562e39d38mr1924361wrb.37.1661424920903;
        Thu, 25 Aug 2022 03:55:20 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b0021e4829d359sm19068761wrv.39.2022.08.25.03.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 03:55:19 -0700 (PDT)
Message-ID: <f7ec45b8-ccd7-4776-0524-269e3188883d@gmail.com>
Date:   Thu, 25 Aug 2022 12:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible for
 MT8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
 <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
 <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 08:59, Bo-Chen Chen wrote:
> On Thu, 2022-08-25 at 14:11 +0800, Krzysztof Kozlowski wrote:
>> On 25/08/2022 08:56, Bo-Chen Chen wrote:
>>> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>>>
>>> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
>>> pipelines binding to 1 mmsys with the same power domain, the same
>>> clock driver and the same mediatek-drm driver.
>>>
>>> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding
>>> to
>>> 2 different power domains, different clock drivers and different
>>> mediatek-drm drivers.

drop clock driver example here.

>>
>> I don't see binding to different clock drivers and anyway that's not
>> really an argument here. Please focus in description on hardware
>> properties, IOW, are devices compatible or different. What is the
>> incompatible difference between VDOSYS0 and 1?
>>
>> Best regards,
>> Krzysztof
> 
> Hello Krzysztof,
> 
> Thanks for yor review.
> 
>  From the functions perspective:
> 
> Hardware pipeline of VDOSYS0 has these components: COLOR, CCORR, AAL,
> GAMMA, DITHER.
> They are related to PQ (Picture Quality) functions and they makes
> VDOSYS0 supports PQ function while they are not including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component).
> It makes VDOSYS1 supports the HDR function while it's not including in
> VDOSYS0.
> 

Please include a description of this in the commit message.

> About mediatek ETHDR, you can refer to this series:
> 
> https://lore.kernel.org/all/20220819061456.8042-2-nancy.lin@mediatek.com/
> 
> To summary:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Is this description ok for you?
> If it is ok, I will put them into commit message in next version.
> 
> BRs,
> Bo-Chen
> 
