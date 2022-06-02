Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF68853B89F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiFBMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiFBMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:02:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9C1004
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:02:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er5so5945847edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U+8T6fn4T3vaS0Pi2aB2h1k72+HYKHqTINehwyE+Qxw=;
        b=WgJo3UOrlWF/xukiH2Ku/H4mdceQ13UjCa+NEb9eL5GFxciQb2m/H0biH39C8/iyoC
         UiorpjyI/JVwc5x53o5eiy8NCi3h6nJmU8Rk9KIT8GaOKNKLmN3LegL1M9r+RA9cnJLX
         0DJtMJfNukuJqKElDBGjAkXwePDty6ctIvt+5JhABmGuOTBy23VV8UeP7SEl2/bHl96G
         qy4eTw7224jmjab9pUBps6c0AQd+dXl3i0VGUN8h/6JgRErzSyA58TmBAsJuVvOzjlZd
         Hxl6dDWlth12mYKgJ/B9bJYwO0pSLB4e1NXvXKd4av+jDkIZf18lh0UHkcX+TqvmV6PI
         dTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U+8T6fn4T3vaS0Pi2aB2h1k72+HYKHqTINehwyE+Qxw=;
        b=EDjO+35D2+rYhKjJNVW1Gu9ra0yllqENwSY4LpBuW5pPVv7gvjNbbswU09ZBY05XQ/
         EgrLOlLvgbSRv2SV2HcLozJJURkUP6D0mXN4QefT2/somOPGhMyPscEwtNJwO7EzU/kw
         dL5tu4LqDSqVQyZjpuEOlewU3WCBjFgB0/RstU/7+29Xfjr1XiNgIvRB/6RcZrRdOo1L
         erOY8kf1ooWQMaeGTMCzbJ9s+SNSoBWAIR7NAcCS/1g+vzlnW53ASW2PfgA+pjWm2uQm
         Jm7SLd6AM/9h6m/aDCbQJt6pCoLk7RIOd1EJ4aWq95P8+9i6qKukmpPDbR/Tjnhu7aOR
         sR9g==
X-Gm-Message-State: AOAM532XT71OsRDVBGw+13E3vGGpvPMjr5pKBMaTpeL10TY1a2ILeDRP
        sG1NWW9RDZYPMsrXN3zLQ3/cCg==
X-Google-Smtp-Source: ABdhPJx4oO7YkUav5hDFlqrl3kvMLXszr+upvgPvjdffSEadzOq3Ofn3+ntG6LnID8A7MNz5hB5ENQ==
X-Received: by 2002:a05:6402:1f0e:b0:42d:e38a:51f7 with SMTP id b14-20020a0564021f0e00b0042de38a51f7mr5117059edb.68.1654171361576;
        Thu, 02 Jun 2022 05:02:41 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c6c8000000b0042617ba637bsm2480855eds.5.2022.06.02.05.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:02:41 -0700 (PDT)
Message-ID: <e084e508-d886-3e6c-53ab-1f0b22706964@linaro.org>
Date:   Thu, 2 Jun 2022 14:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 01/15] dt-binding: remoteproc: mediatek: Support
 dual-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        weishunc@google.com
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
 <20220601112201.15510-2-tinghan.shen@mediatek.com>
 <dd3ea397-fa21-abe5-85ad-b8a4818dc011@linaro.org>
 <3c837acfbefa5b7e23e1121678b5b878f08e4ef2.camel@mediatek.com>
 <476baef8-0255-45ed-85f4-2b9d877c4af1@linaro.org>
 <287d88a62fd13cd762b20faa3e9df826632fe1eb.camel@mediatek.com>
 <45c8050e-16d3-80d6-0799-8b067a38d956@linaro.org>
 <5c614dc0947aba6ce2eb0cdc3055a390da723d08.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5c614dc0947aba6ce2eb0cdc3055a390da723d08.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 13:29, Tinghan Shen wrote:
>> Maybe the hardware property is that one core has its sibling and you
>> provide here that sibling?
> 
> Yes, exactly. I'm sorry for misreading your argument.
> 
> How about this one,
>    
>   Reference to the sibling SCP core. This is required when 
>   dual-core SCP support is enabled.

Yes, sounds good. Thank you.


Best regards,
Krzysztof
