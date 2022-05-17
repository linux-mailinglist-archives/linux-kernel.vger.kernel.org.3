Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D19529CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbiEQIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbiEQIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:41:48 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F1A403E8;
        Tue, 17 May 2022 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JnpHbAHKIJD181537/cR0smEcalwP0yv2oixjdSOWLo=; b=t5gHAOolWKGfGgeSakfoenFaG1
        GUBhXQRpEqKk5x56BbAsg/D5oOX2a0r7Ovmzb2bberPec9VO13oSrW133HKR+rff/VP25/LHQIfFW
        oQUj5OaS5VbasIJqGd27pUP+hzTlrSdEfik9pMRSwpQLXPnJvoxQgA7IiBjJR5V4whvkLrsIAM2EY
        hjquylPvgoPrBKhTlXt5jqGtf0PywZnlXnOYbjOF46Ev44U2m6pZzyTNQKLPRk16nOs905Bdo9axj
        eXAc1gF3g4uW0hNYRbQn9EdQ/ZCPd4S73+VC3MzxHJMp2sBKhBDZLppRvlOw5rF2gpbp73QlX+8Gp
        OxmOz/ig==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqslu-0000CX-GG; Tue, 17 May 2022 11:41:38 +0300
Message-ID: <3b1e22cf-a439-2d84-a1fc-dd352a3f1b2c@kapsi.fi>
Date:   Tue, 17 May 2022 11:41:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v1 02/13] dt-bindings: Add headers for Host1x and VIC on
 Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <20220516100213.1536571-3-cyndis@kapsi.fi>
 <20a7087d-dddd-134b-4cef-0ebcbc5115f3@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20a7087d-dddd-134b-4cef-0ebcbc5115f3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 11:02, Krzysztof Kozlowski wrote:
> On 16/05/2022 12:02, cyndis@kapsi.fi wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Add clock, memory controller, powergate and reset dt-binding headers
>> for Host1x and VIC on Tegra234.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> 
> All your patches are send from wrong email address and the SoB chain is
> not correct. Please add respective SoB.
> 
> This applies to entire patchset.
> 
> 
> Best regards,
> Krzysztof

I can do

   Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
   Signed-off-by: Mikko Perttunen <cyndis@kapsi.fi>

if that is better.

I used to just send with From: mperttunen@nvidia.com but unsurprisingly 
many mail servers have started rejecting that.

Mikko
