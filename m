Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7E4BDCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356078AbiBUKmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:42:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355175AbiBUKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:40:01 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C2E9B;
        Mon, 21 Feb 2022 02:01:53 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id m27so14267219wrb.4;
        Mon, 21 Feb 2022 02:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YZ+si3odyYtBfKCwmZtlljyYoUebhhvf4uslsh/s+F4=;
        b=7j90WRpima8SkDjbxZ99PgrwljlxTuf3uJ0AEu8yOKNK0T8/TrPJBEKduV1EssbyI5
         HnQO4t0f03epmXHqXpZE4j4+gQkH/cPMXLSF4ewvft/IG6mY+eDjOMGPdt9/BJ01T+Dm
         o/mBlqmwuXn78aIZzzDSMcqwXMEQ7X2CMwXdxqpAQwTx4ZjAAHnVlNwlggvNcpaRvFPA
         VgikTqi1Hbg1jKVQago4AbxrcOVhu2M7ZbQYgEo9d3RBhxJ1WINAOSFkO3BNpizkfVBb
         gjIGMqA/1lwArnLlBmJfY6gkcN8zIzBaJ0vNY7I9JYlfaW8pEp65NcRbpwBeeSqOTDK2
         hOSg==
X-Gm-Message-State: AOAM533huutrR9fSqTSiT3QCh69Z9QXiz2Sgh2t7zzNyVxD6pYDuInOG
        7H8GCRuzyCdvxct8r8eENYTeUl/SEt0=
X-Google-Smtp-Source: ABdhPJxiSwRwEHfd8Q+eqMRaMd1mC5EXxdtAwlKOfu4jlIozdrPKqmXsyZiymQ3sUemzBc2KSw7yWQ==
X-Received: by 2002:adf:fb8e:0:b0:1e3:241b:218c with SMTP id a14-20020adffb8e000000b001e3241b218cmr15194533wrr.359.1645437712057;
        Mon, 21 Feb 2022 02:01:52 -0800 (PST)
Received: from [192.168.0.120] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id q76sm7668095wme.1.2022.02.21.02.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 02:01:51 -0800 (PST)
Message-ID: <acf6d02d-0e17-b84a-5bd8-9f5165f73915@kernel.org>
Date:   Mon, 21 Feb 2022 11:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 1/4] MIPS: Loongson64: dts: update the display
 controller device node
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-2-15330273260@189.cn>
 <08abcb14-f1f6-8be5-6309-cd16e0578c05@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <08abcb14-f1f6-8be5-6309-cd16e0578c05@gmail.com>
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

On 21/02/2022 10:19, Sergei Shtylyov wrote:
> On 2/20/22 5:55 PM, Sui Jingfeng wrote:
> 
>> From: suijingfeng <suijingfeng@loongson.cn>
>>
>> The display controller is a pci device, its PCI vendor id is 0x0014
>> its PCI device id is 0x7a06.
>>
>> 1) In order to let the driver to know which chip the DC is contained
>>    in, the compatible string of the display controller is updated
>>    according to the chip's name.
>>
>> 2) Add display controller device node for ls2k1000 SoC
>>
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> ---
>>  arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 8 ++++++++
>>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 7 ++-----
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> index 768cf2abcea3..af9cda540f9e 100644
>> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> @@ -209,6 +209,14 @@ gpu@5,0 {
>>  				interrupt-parent = <&liointc0>;
>>  			};
>>  
>> +			lsdc: display-controller@6,0 {
> 
>    Shouldn't the node name just be "display", according to the section 2.2.2
> of the DT spec?

lcd-controller, led-controller. As I understood from the bindings, this
is not physical device displaying something (like a panel) but rather a
device controlling such panel. Therefore display-controller feels
appropriate.


Best regards,
Krzysztof
