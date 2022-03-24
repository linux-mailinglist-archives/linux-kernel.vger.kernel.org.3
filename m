Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15584E61DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349555AbiCXKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:37:12 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43CD6E343;
        Thu, 24 Mar 2022 03:35:40 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h23so5957169wrb.8;
        Thu, 24 Mar 2022 03:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hl2300Q3yIYem3DeC+yC//jG0rxJse6f6bzV8oQgUaM=;
        b=ntpYkL11pqS1uDnrG5GLYj2kGVH0oAkfy+4GEMgGEiXezRxPAj7CYovBiJtKllgRWH
         8deT7boIS+q4Ha+uQpI0Rdap0mgkAL2ABnJ10FAQOPXhHW0p8ZsXRcgVfJC+Kf/yRMhj
         DbwHuWO1cP8/B6cFxhsS9YejIAaaqptiE3kGIAJpz8ttP8fKHP63nhvQpO/uawLl7epk
         5BVLh1BqYFVA2njF1IHntUyDcpCxvN/yVvAC75twPXjo9vnDGuTSxZZzzzMMD9cV5ZzA
         LCmL5N4lWiDT/E3Cg4+BdcbMZaM3lqrsVf0eum21z4/Zb5YbnMFqjC4xJDJDujWLoIlR
         Oygg==
X-Gm-Message-State: AOAM5334uXguZa3bYLGkpBt0/2mCFpI0dxQf7MZrSYsK18ozTgZO8pe+
        8DUcLorZ6Sj9jR2gviR1aCk=
X-Google-Smtp-Source: ABdhPJwANYW3gavd2FfSPJq7cxASPsyPRneOA9YZPkOtAZJvpNCCGUbBtreV69ExMOluQQWYohSkSg==
X-Received: by 2002:adf:fc47:0:b0:203:dda1:4311 with SMTP id e7-20020adffc47000000b00203dda14311mr3975119wrs.301.1648118139226;
        Thu, 24 Mar 2022 03:35:39 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id z18-20020a5d6412000000b0020400dde72esm2233790wru.37.2022.03.24.03.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 03:35:38 -0700 (PDT)
Message-ID: <18c791ce-059a-87a5-eaf4-057f8e232fe7@kernel.org>
Date:   Thu, 24 Mar 2022 11:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq
 dt-bindings
Content-Language: en-US
To:     Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-3-jia-wei.chang@mediatek.com>
 <d5c5e3f7-7f50-6c57-f82a-41d5494ea514@canonical.com>
 <c150e9ed7faa4c06f55f7d7623655b65c8575121.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c150e9ed7faa4c06f55f7d7623655b65c8575121.camel@mediatek.com>
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

On 24/03/2022 10:42, Jia-Wei Chang wrote:
> On Mon, 2022-03-07 at 19:59 +0100, Krzysztof Kozlowski wrote:
>> On 07/03/2022 13:21, Tim Chang wrote:
>>> 1. add cci property.
>>> 2. add example of MT8186.
>>
>> One logical change at a time. Are these related? Why entirely new
>> example just for "cci" node? Maybe this should be part of existing
>> example?
> 
> Yes, the cci property is required in some SoC, e.g. mt8183 and mt8186,
> because cpu and cci share the same power supplies.

I asked why this cannot be part of existing example.

> I will update the commit message and add an example of mt8186 to
> present usage of cci.

You added the example here, didn't you?

Best regards,
Krzysztof
