Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78F57C475
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGUGab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiGUGa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:30:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B21759F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:30:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a9so1212671lfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xcSHceWIQnF46q/aNVeBbb+LJ3IAPo1mZRJeq73EWJs=;
        b=xkdjRXXSKPFngXKEevyXaU6z0Y4JPA+fQd9I+gp/Lw7u8+x3nQosofoJWDqHP5v7fL
         cMqHLlHUgmhIDEw8zlaeWcjljCrryhNz5czqOb1RIqBkL2A7BTnV4szadOf6lPfxyxgh
         f194VDrtFYHEi9uNROPbahBnY4H6507IaiVlMUsOkNojLaxTT9d1Kmi++zHFLCeBqhZC
         eIyLpQ3qbDLhS39KdK+gZ/Q0y4POeXAS3V2i6L2IvUqz5IQGAmglGpEukT4jp1lGSop8
         rDUmAJ+tPX/v479s07umER1RNq+c1kbuOdw1qnUJySCkgjXwuRAzMLnzSMWsra+QLDaO
         umvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xcSHceWIQnF46q/aNVeBbb+LJ3IAPo1mZRJeq73EWJs=;
        b=14AqGcgBZvoZW5t37wXD7GhTkn5xaijEPPWhSED26TOIj2PWk6sZPuqiwxYoT05GN8
         PP+2eaiddX68aOigRLhag/u9b5XtK/YM27hgEEDFmCcgLVbJbyYOilJSZqnGOiy/Mdpb
         DZRpuMU+eqVRTSAC62DNaETL5dyrIvcDZP1D2NsevJFVEGtGjsjMi5718px949iUy+dK
         VRN0ncA4Er6PKEs6X8HTnId7qBuB71UQCnRUX/X77F2AXW0vSM2hhJI5Ikl4TZYzXv4V
         uuve3VHmBtpaQV3bu3vVuls/DShBFKw541CYI7qLvXCohUAFHUni3yb+FhQlYnf+zdZL
         qKRA==
X-Gm-Message-State: AJIora/AmooxbXCCopVqludBMoOBAEOVKCAfALqW9dKkhvNyz5u9vjY+
        Me13hKfsHzqlgcKzp56p4aWpGw==
X-Google-Smtp-Source: AGRyM1shdQ1GO2vnK0GUcjpj/QQkvO+5wEzFWMbgSm9Shki8ovwWtZ4Z1Qxwdi2ud9QCMxp1+vVxpg==
X-Received: by 2002:a05:6512:1043:b0:48a:4996:a62c with SMTP id c3-20020a056512104300b0048a4996a62cmr7863341lfb.416.1658385025242;
        Wed, 20 Jul 2022 23:30:25 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651234c200b0048a6cb721ecsm240496lfr.26.2022.07.20.23.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 23:30:24 -0700 (PDT)
Message-ID: <fb1b5eed-41ed-2c4b-c984-235ec4b3b0f6@linaro.org>
Date:   Thu, 21 Jul 2022 08:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: document several
 vendors for Aspeed BMC boards
Content-Language: en-US
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     David Wang <David_Wang6097@jabil.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <c86be8e0-8350-5d73-8055-e04a4e88f3b6@linaro.org>
 <42fb4884-e2c3-4d7f-9049-f14c19701b20@www.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <42fb4884-e2c3-4d7f-9049-f14c19701b20@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 04:34, Andrew Jeffery wrote:
>> Any comments on this patchset? Are you going to pick it up? If you
>> prefer me taking it, I can, but new boards depend on the bindings, so
>> this should rather go via your tree.
> 
> Apologies for not getting to this earlier, but I see Rob's applied it.

Rob took only the first patch - vendor-prefix. The DTS patches I sent to
arm-soc.

However the second bindings patch [1] will miss merge window as I did
not send it to arm-soc. I have it in my tree but I am not planning to
push it out before merge window.

[1]
https://lore.kernel.org/all/165589284658.28441.1588047978357747292.b4-ty@linaro.org/


Best regards,
Krzysztof
