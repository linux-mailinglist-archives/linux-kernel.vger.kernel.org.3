Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAB4E7554
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359379AbiCYOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359393AbiCYOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:47:59 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A66ED7639;
        Fri, 25 Mar 2022 07:46:24 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id lr4so7406954ejb.11;
        Fri, 25 Mar 2022 07:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bpq5gtk8EejF2z7A/CgfRZsuOjEeMbN73SklR5gGCds=;
        b=eXUqokGGv1RuTjiVRLOmtzSorJXzdnYr/esG4Uw13rUNbwrCRenONctqz7/IIzWIEA
         j5e4zGQgKE+n92X/ki3u/LVV9IH1mJjWGOYvIkKiVD8xXb6LHLo/Bz90fHTa8k9VLtJg
         4HP0jHybbw9/IBJP2/zSQ/B+1hc2b3BWBzt7Y+QVKEBItfh3hnZzcQMKDYDjLR7tKU13
         54FcMlrWfnlTY2j4BDtHE8P04LUL3aCcy/gSd+xFgPxpRyNZ6cPcVLwEll12PCS+NAlE
         Rljwn47C9sY1dsWSfLkAehP3qfSwX++cOo9aITdzeNs5l7sTQNUO/sFyfKePbX0PV2v9
         m/tQ==
X-Gm-Message-State: AOAM530qLUubB+BuecBmOv8csS/TgtQ4va7zzIZk8fP7b9Bf54vlOS0I
        6aWqdBVJSJSxdcKdziiMe//zTrI/NCc=
X-Google-Smtp-Source: ABdhPJwlLUiKAo0A83F2IFPmUMaCWcglyBIcBnzp4Fhug0b2NdhN0hIdBFaoTjTh1hc19Ez7S4XlWA==
X-Received: by 2002:a17:906:5597:b0:6ce:f3cc:14e8 with SMTP id y23-20020a170906559700b006cef3cc14e8mr11803997ejp.426.1648219582756;
        Fri, 25 Mar 2022 07:46:22 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id a4-20020a170906274400b006da9456e802sm2417763ejd.102.2022.03.25.07.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:46:22 -0700 (PDT)
Message-ID: <db3efe0f-b6ca-e183-8562-bcf5e6b02679@kernel.org>
Date:   Fri, 25 Mar 2022 15:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add binding for Richtek
 RT5759 DCDC converter
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-2-git-send-email-u0084500@gmail.com>
 <d9b883d2-8269-8419-3bcd-3761074bea96@kernel.org>
 <CADiBU3_06mCfBFXc5XAaeNd+G=Yf4MK5Ze429H8iUm=kpFMa5A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CADiBU3_06mCfBFXc5XAaeNd+G=Yf4MK5Ze429H8iUm=kpFMa5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 14:44, ChiYuan Huang wrote:

(...)

>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  # example 1 for RT5759
>>> +  - |
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      rt5759@62 {
>>
>> Generic node name, so pmic.
>>
> As my understanding, 'pmic' means there must be multiple channels of
> buck or ldo.
> But  rt5759 is only one channel buck converter.

Then "regulator". rt5759 is not a generic name but specific.

Best regards,
Krzysztof
