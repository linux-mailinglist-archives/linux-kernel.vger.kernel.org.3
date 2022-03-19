Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0014DE892
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiCSOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbiCSOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:39:15 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF31706A;
        Sat, 19 Mar 2022 07:37:53 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id w4so13275680edc.7;
        Sat, 19 Mar 2022 07:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=gH+r24fAOpSiIXUxUgbqmc3qpzbLfZoMAp2lb+50FuA=;
        b=avhp066WuJmb92QOLRCFk2g9Cefe7kON8y7lITRbCFXqB695bceR7DmQaRoOb63rjS
         /4me/u4q9mckMbzq1KKl3dZQ8kMs+pNtE8ilQhlz4ROe1j+XUTI44OAsM5eJMOmYvNhs
         /ULqqOK4U07diKrtxdAW71vnIGxLUV0ai9YfKnG45mUxCyXRcTHpAqV0OUnR4iDlaXKM
         JrS7VnksulsUKK2v+gJYotkj3L0Gs1OZSs1ix/OXtsFHkb/FYr32UNNA2Nib91Pzsc6Z
         +RHg9W7K8KYmgjSX5aowSQkpkyqadutS14C71/FwEu0IQXKb2erdvSnZ+bk/zpYBd9HT
         /OJg==
X-Gm-Message-State: AOAM533jtO6eolELPb02BQhPe5MZVMdk0vePCC90+LFwKz9ZkihXGW6v
        j6ZS8HMTMa0hZdhOJAF86JQ=
X-Google-Smtp-Source: ABdhPJw3AzPtLQ+UjmKGVdKdQ4/84l1LKMcvSVPBB31aH0LaT4n0AZsECARqUGXu1wKRakT9dELALw==
X-Received: by 2002:aa7:d6ca:0:b0:419:2804:d094 with SMTP id x10-20020aa7d6ca000000b004192804d094mr1757895edr.388.1647700672159;
        Sat, 19 Mar 2022 07:37:52 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm4882063eje.173.2022.03.19.07.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:37:51 -0700 (PDT)
Message-ID: <6729d4cd-45df-f554-708b-d353dc522cdf@kernel.org>
Date:   Sat, 19 Mar 2022 15:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20220318113526.15986-1-sherry.sun@nxp.com>
 <57e516d4-68aa-44a6-4ea2-a7fdd4d9ed95@kernel.org>
 <AS8PR04MB8404817B9ECE889A19A2186692149@AS8PR04MB8404.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8404817B9ECE889A19A2186692149@AS8PR04MB8404.eurprd04.prod.outlook.com>
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

On 19/03/2022 10:53, Sherry Sun wrote:
> Hi Krzysztof,
> 
>> Subject: Re: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
>> EDAC on imx8mp
>>
>> On 18/03/2022 12:35, Sherry Sun wrote:
>>> i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support for
>>> i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.
>>
>> One more point - I think it might be worth to add dedicated compatible for
>> v3.70, as it is clearly a different version (with fallback to v3.80a).
> 
> Thanks for the review, I have check the V3.70a and V3.80a Synopsys ddr controller databook, there is no difference for the inline ECC part.
> So do you think we still need to add a new compatible for V3.70a even the EDAC driver operation is totally same with V3.80a?
> 

Thanks for checking. In such case you don't have to add the compatible.
It still might be beneficial in case there is some difference in
hardware, but looks like not required.


Best regards,
Krzysztof
