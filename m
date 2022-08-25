Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5745A08B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiHYGP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiHYGPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:15:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE76C9F77C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:15:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n15so5811648lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3Nti9hv6DeyPKfJj5p6BSfYPiwYGhxhttJgua1AQjnM=;
        b=qEkujIEiAGOsvsa+AZMtnZJSHXCDxAxY7Y/fPg6MN6K06AhRrf0Ifzgscpjl/WUBQc
         yHtQ3lS79ivsiXdlUee54uzNS5zpVtLsbybCLHGjT9Ir6BlerPw8HOSKjDi7kLtcZvGL
         I0EUfGbLnSw5YwthZFK2RpHn6x9ZzYnszG81/kPUxEy2knM9xKqJOBSC3PEZ3G83GVlO
         wdvGwH3S3Ax+XXMOzBcl0Jfrc6lCpFSRiRmlCcBOgfaN8BGHp/Ffjjg26emEJ+EjgwPH
         N4PjpMwEouEpz9nYpv5eQo6ldifiqsYJ+/DxiXr75Ifbvb+BhamuKugaTgs5KU8W33/8
         yuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3Nti9hv6DeyPKfJj5p6BSfYPiwYGhxhttJgua1AQjnM=;
        b=n2dGpxToewn3hiLE15B0R+FHM3+085oMP0vxv3//7RVs1EY9HTIzYvT8FqPlI0WGjG
         L/aMGJYZXT0aW8e1yr4dIHe7xgnw97VvrvLBlf95MbmqcWjSFcVF3wJkOAlyge/yQJg+
         fQ/plRG0qcgwFFAllB4iMpXSnHwBP9fO9peWDZ3GlnV2UlWgoDaDxAigshRqduVNWE97
         6oHju0H3NUq8+Ob5La7b+IGMNiowVI57XbI7+wAB8CvcUeB+L5raxkuxjd/MJwxnSYtY
         yhnAFJCpOd3MiStYR9MoNko5d8f2A6feGPs6+CFx5p1lDSayuPpX+kSPCtIsqMOKPUFh
         Q7Yg==
X-Gm-Message-State: ACgBeo3fNiYtmXrwjnG7eW3/jaYnAf65myuni5AAF1cmvPhi0+6Md5WG
        mMnjceRy3PFoA0La3TpBu2HR3A==
X-Google-Smtp-Source: AA6agR4tiaowhUIgTlsa8a2jWIDtSbCYO5nt3pM1ZBue2+MYGKUaweFGXAu//9a9AXmDYtCozTtkqA==
X-Received: by 2002:a05:6512:4012:b0:492:c667:c899 with SMTP id br18-20020a056512401200b00492c667c899mr645201lfb.48.1661408120185;
        Wed, 24 Aug 2022 23:15:20 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651234cc00b0048b37d29256sm322714lfr.63.2022.08.24.23.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:15:19 -0700 (PDT)
Message-ID: <aa76756f-6f0a-0342-c654-5fb8fee54bcd@linaro.org>
Date:   Thu, 25 Aug 2022 09:15:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 1/7] dt-bindings: net: dsa: mediatek,mt7530: make
 trivial changes
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220824104040.17527-1-arinc.unal@arinc9.com>
 <20220824104040.17527-2-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824104040.17527-2-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 13:40, Arınç ÜNAL wrote:
> Make trivial changes on the binding.
> 
> - Update title to include MT7531 switch.
> - Add me as a maintainer. List maintainers in alphabetical order by first
> name.
> - Add description to compatible strings.
> - Stretch descriptions up to the 80 character limit.
> - Remove lists for single items.
> - Remove quotes from $ref: "dsa.yaml#".


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
