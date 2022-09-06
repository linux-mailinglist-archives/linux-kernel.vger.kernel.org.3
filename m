Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10475AE052
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiIFGz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiIFGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:55:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B61222AB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:55:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q7so15930274lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wh3DrshFuMrtCLf0BuRQmMVBCMCXL0RvjOcQdTVJyLE=;
        b=nUXufdMgiWM6zDHuYCC3ppeM71QKns8eddubLSl/ELC1dCJ9d2BHO8lsm97i9NiVX8
         5tN0FI6S9apPwpq0auM99UuiKFk13F6y7F2cQ0zFbPx1vq58/g9/I7Fic0tx/rk2zKzg
         7XlEenipV9+gLslX8aYvYlO7Cy+nVBcoSgWh7r7oDi0JTCUaz3+YpxhNUvAt91KCGMdY
         gbSCO6/rrUnIa/XnNsG2+aNz1Vm3SVmYKkJiEcUCpz19U3xP6P7W53RTlFYOPTmGK3rN
         xmh2wDRkHwuc2tbMXTu+zWlwkRJk6ukunH0uhWN2mHOaoLRVyZm4KK0Xh7wh9GnWchMb
         NUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wh3DrshFuMrtCLf0BuRQmMVBCMCXL0RvjOcQdTVJyLE=;
        b=xFXm4qxIWe01klq5Eq2AMq9d/wJZVJQH6h4NF2CIU9kr1G4AjsT1VdY4XVkvxBgM5e
         zUGwvnvim7+0MXj0X0mn6hJZPG4u5EmsVR0yjA7GMQ/JI+3ctOmdhpXD3pNyIZ03ciU/
         fU7M/BLYImfIMHgCPZvQ3GS+/13XrSm9dqoiKqm+Gm9LZPlx2Cs/xGy7bjb1vS2jpt6f
         rF+/ePnMvGOrLAZ0akQZNtiKQjmTee0pzCmrrd4oj6425O0PD0jpOe1X8j2s2B3rY54R
         Z1QVrRh/FLF+WFqQnvgBIyTJhdGoLRSNnMXYw7uXOMCJZQ/CQWZ265suMX5EoY3gSSWe
         PCPg==
X-Gm-Message-State: ACgBeo0Fqw4wJdRxzEwHAlC9O264vOWYYj08rbxlCGeHpJK4DlCib+K5
        55tTFlfUKYbFEP11XLyRtajH2A==
X-Google-Smtp-Source: AA6agR7LdYH34j63SniI1HczQAV0VgAxa7UpGGHIt2TnTdCXpcOGSNJ3eDQUhnFuLDNSe7/zFmgs7g==
X-Received: by 2002:a05:6512:401d:b0:496:9971:78c5 with SMTP id br29-20020a056512401d00b00496997178c5mr1268770lfb.337.1662447322997;
        Mon, 05 Sep 2022 23:55:22 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c14-20020ac25f6e000000b004948b61f780sm1534603lfc.144.2022.09.05.23.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 23:55:22 -0700 (PDT)
Message-ID: <8712e2ff-80e1-02e9-974a-c9ffcf83ffab@linaro.org>
Date:   Tue, 6 Sep 2022 08:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH v2 1/6] Documentation: DT: Add entry for CDX
 controller
Content-Language: en-US
To:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <20220817150542.483291-1-nipun.gupta@amd.com>
 <20220817150542.483291-2-nipun.gupta@amd.com>
 <93f080cd-e586-112f-bac8-fa2a7f69efb3@linaro.org>
 <DM6PR12MB308211F26296F3B816F3F005E87F9@DM6PR12MB3082.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM6PR12MB308211F26296F3B816F3F005E87F9@DM6PR12MB3082.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 16:05, Gupta, Nipun wrote:
>>> +
>>> +    cdxbus: cdxbus@@4000000 {
>>
>> Node names should be generic, so "cdx"
> 
> Would be using bus: cdxbus@4000000.
> Kindly correct me if this does not seem to be correct.

I don't understand it. I asked to change cdxbus to cdx, but you said you
will be using "bus" and "cdxbus"? So what exactly are you going to use?
And how does it match generic node name recommendation?

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Do you see any other buses named "xxxbus"?

Best regards,
Krzysztof
