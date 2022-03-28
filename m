Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C514E95C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiC1Ly5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiC1Lyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:54:46 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16712377D0;
        Mon, 28 Mar 2022 04:49:22 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id a17so16574175edm.9;
        Mon, 28 Mar 2022 04:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wbmtuFgYk21OVybrhPNThf688k7OlnshZ2rECopA1sQ=;
        b=DUus5YkXMkLwPHuMSYWpSbAzEXKGC7Ax8I4gLTBEAU+OOe7y2W8iqUcJvefaKdlUrI
         cTo/YO6lFVWMCYHS8k3iPDCUO8bSrg1kjG5dIHkXlsRGeClBuJgjmN2agwAlK9XSljKm
         2/2wRWSwgojkS5EjDMg6E4PPrQe4Z7chakGYt4qow8Ep4l+VJn7JyO+Ag0S2t+fjwCYL
         c44IJDiWb9QMSWWamjJFA7ZgY96yZNmd/NQ1SKXSchyOPI1EwOa9CebK+IfF2CN/g4/q
         SfrXLM41BhL8N1BkC10jatnFv3FTUOkRCOHldzmL50CbUg8QveVEI2Mnzl11ogKOVpeJ
         x6gA==
X-Gm-Message-State: AOAM533/LymGBHtkiU11xyP+BtzLsdrzWp2jVPVZnAr8hNECH7hRtK5h
        /hoi9Zi9srLYcJmeQeKVLC4=
X-Google-Smtp-Source: ABdhPJzWXsy4+GphF1QuoAkcYFlawyiEs4+1gNVRO87F9Ywpbhee44VZa+NoHAfXuvSNPc08MaGPTA==
X-Received: by 2002:a05:6402:3488:b0:419:172c:e287 with SMTP id v8-20020a056402348800b00419172ce287mr15585663edc.87.1648468160467;
        Mon, 28 Mar 2022 04:49:20 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id f3-20020a056402004300b004162aa024c0sm6850041edu.76.2022.03.28.04.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 04:49:19 -0700 (PDT)
Message-ID: <5c24c12b-3a12-1e18-9f03-2c54cad30bf9@kernel.org>
Date:   Mon, 28 Mar 2022 13:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20220327123835.28329-1-aford173@gmail.com>
 <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
 <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
 <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 13:09, Ahmad Fatoum wrote:
> Hello Adam,
> 
> On 28.03.22 12:47, Adam Ford wrote:
>> On Mon, Mar 28, 2022 at 2:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>
>>> Hello Adam,
>>>
>>> On 27.03.22 14:38, Adam Ford wrote:
>>>> The SDHC controller in the imx8mp has the same controller
>>>> as the imx8mm which supports HS400-ES. Change the compatible
>>>> fallback to imx8mm to enable it.
>>>
>>> I believe that's a shortcoming of the Linux driver, which should explicitly list
>>> fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.
>>>
>>> I find dropping compatibles problematic, because like Linux matching
>>> fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
>>> fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.
>>>
>>> I'd prefer that either the kernel driver gains extra compatibles or that
>>> the DTS lists extra compatibles and we refrain from dropping existing
>>> (correct) ones.
>>>
>>
>> I would argue that imx7d is not correct since the IP blocks between
>> imx7d and imx8mm have different flags/quirks.  One of which includes
>> HS400-ES, but there are other differences as well.
> 
> The DTS currently says that an fsl,imx7d-usdhc is a subset of an
> fsl,imx8mm-usdhc. So a driver could treat both HW the exact same
> by focusing on the i.MX7D parts. Linux apparently did exactly
> that so far. Is this not accurate?
> 
> 
>>> What do you think?
>>
>> From my understanding of the fallback compatibility strings is to
>> avoid having to add more and more compatible strings to the drivers
>> when they do not serve a functional purpose. Based On a conversation
>> with Krzysztof [1], he suggested we update the YAML file based on the
>> fallback, but he wanted NXP to give their feedback as to what the
>> right fallback strings should be.  Haibo from NXP sent me a hierarchy
>> [1] which is what I used to update the YAML file.  Based on the YAML
>> file, the fallback in each DTSI file was updated to ensure the use of
>> the proper IP block.
> 
> Myself I am in favor of moving to three compatibles instead of dropping one.
> For some theoretical fsl,imx8mf-usdhc that's supposed to be exactly the same
> as a fsl,imx8mm-usdhc, I don't mind omitting the fsl,imx7d-usdhc compatible,
> but for existing device trees, this may introduce needless potential breakage
> for other software that also uses Linux device trees.
> 

Affecting existing users is indeed a concern with this approach, because
in-kernel DTS might be used in other projects as well.

I still cannot find here the answer whether fsl,imx8mm-usdhc is actually
compatible with fsl,imx7d-usdhc. It's not about driver, but about
hardware and programming model. imx8mm can support additional features
and still be compatible with imx7d. However if any flags of imx7d are
actually not valid for imx8mm, then it's different case.


Best regards,
Krzysztof
