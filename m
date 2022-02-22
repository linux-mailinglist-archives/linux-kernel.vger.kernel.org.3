Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF44BF711
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiBVLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiBVLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:17:12 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F19DC1;
        Tue, 22 Feb 2022 03:16:43 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id vz16so41900955ejb.0;
        Tue, 22 Feb 2022 03:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WwDXAlkiy3+YlZK/3sn0Jy6CycbFWlmiZrjsW+HpUsE=;
        b=GJvsw9Vn8I5c7RuahXagSYQCfOVJ38rR7XujRR4+LBXtVcHUsWOsZdcPr1IBpWJVqh
         JAhYF+9Uq6+b0C/GS3pHERm+aBFl9cGwq8FKwU91sc7m0+BwLIQDU8uxvhNePGyBUVs0
         Kex6Y4mvDYRLd3KLadV6nOa9VdrWj+etjvsL5spzkMqFEAd1UhbDZoKPbONK3rgsflqM
         Z95dlI2bofNisYlkWh4Hfniktr7Z4imHrMebHr5HjJoTVkYvOPdbbBePonNLAdeFgNZ7
         rbQBXm6YTdBAnmlQQ9OsxvQ9To0YHerJI2em8AkpKU2TXKY0MPpkVg2gzbMtutr4QGak
         pHjw==
X-Gm-Message-State: AOAM532abE3VEbgK8pf4AAG7c/xkcHQikQT61uS/VntaGTm9vYpsWbpA
        mvVe1GjmZna03RSObV7HWYPbHoEJsMw=
X-Google-Smtp-Source: ABdhPJy+O2Bvms1qQ8FoJFM8l5trbpmkAnwzFf1GPjH7v/qnf56VjQD76Ifkj9LzBepspvc5GLJGMg==
X-Received: by 2002:a17:907:205a:b0:6cf:ced7:4e73 with SMTP id pg26-20020a170907205a00b006cfced74e73mr19272931ejb.536.1645528602353;
        Tue, 22 Feb 2022 03:16:42 -0800 (PST)
Received: from [192.168.0.123] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id n13sm5039203edw.20.2022.02.22.03.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 03:16:41 -0800 (PST)
Message-ID: <e2cc06e9-df8b-696f-50c5-bea28fe53e42@kernel.org>
Date:   Tue, 22 Feb 2022 12:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222085532.GA439897@EPUAKYIW015D>
 <e9ef5936-63dc-f959-13f3-6ab3e9bf140b@kernel.org>
 <20220222103022.GA496631@EPUAKYIW015D>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220222103022.GA496631@EPUAKYIW015D>
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

On 22/02/2022 11:30, Oleksii Moisieiev wrote:
> Hi Krzysztof,
> 
>>>
>>> Also what do you think about maintainers: field? Is it correct? I'm not
>>> sure if I used it correctly.
>>
>>
>> I think you should add arm,scmi maintainer next to you.
>>
> 
> Should I update MAINTAINERS file as well?

Yes, the bindings file should be added to the SCPI/SCMI entry. You can
just add a wildcard * to cover all files.


Best regards,
Krzysztof
