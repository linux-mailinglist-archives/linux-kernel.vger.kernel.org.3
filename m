Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6027A508826
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353314AbiDTMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353229AbiDTMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:33:08 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308EF3EAB0;
        Wed, 20 Apr 2022 05:30:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p62so1677834iod.0;
        Wed, 20 Apr 2022 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Xz4W3uwgD5u7Fu/Wu+J5mZSSF4lKujDTVil1iZmmtI0=;
        b=jiXOEm7c4DvyxPMX+4yqBD7wGBJv9Ewoltv+il6LimSG4Haj/7tvVkrCwGc0xwaQa1
         oVlmphccbWXZ9mBwyGpMSdlL7ql3ipHHx9eYVwwhwLIn9yHgLAsZ5KG0EjfRuGHvbURT
         Jk2mJEb+gX3gKQZYDqkNxs/+rZnPzNakkUPj6FUqEONVZddB+UcrDKWJw5Vg2Da9ETCR
         ZjsYChmV5TOc8tq8kQaM4Ml/P9HDzchKNz5jnt0jvg/zClSDiNIv7yiqmKckuIkyZvUF
         +EMDhCjJkH3vcPHhSZE09CwWyQHr7JWxEdzzJt8aSVmoCuwZHNJFFnmCVh4tF8gxbDr8
         depg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Xz4W3uwgD5u7Fu/Wu+J5mZSSF4lKujDTVil1iZmmtI0=;
        b=TwxJkGck1HIs/nX7GXEpRPt0jKSmU3IgtiWg3eOs45HaH6PFiaau8++ClujICyXKTg
         JF0G+NJ0D+Qas+ta8w17Q2mCE9ukM2wih8ePhBEsMCK2ek1eebIlv/D9nTKclkxQfwL0
         z03hbVAGxm38whxXJgZsTqN7O3eEtdc/IfiGg0jhBdKp6/KU8ATbNYs4KIO5At8Eoz5d
         ziUcMziKEh6GA2BjgJvG6UMX1BoeD8WP2MdjYygjo4gXBsEYRXkwqMLiGiBuAOLu2MN8
         CZfG5PyE2KHoCQ3ygAv1zhjY1H0eJ29vXyxOSxjaMKwbmVS2MqdpGKg6lKFXgX9K/5Wq
         bilQ==
X-Gm-Message-State: AOAM5317sKR7KJ6p7Z5O8oIdvUjd4Ene6ruV5A9bourzWOa52EtfZ4OZ
        n8lqrrj0dY3M5W9hhUaG92Y=
X-Google-Smtp-Source: ABdhPJwGRhXFbeJvDhxNl4PQvkHxnDazuTIyslmonAXkW1GqI/MI4eYUOWbmDbDUpAOx49PP1iJ9aA==
X-Received: by 2002:a02:9a07:0:b0:31a:2642:9e1d with SMTP id b7-20020a029a07000000b0031a26429e1dmr9739495jal.159.1650457821518;
        Wed, 20 Apr 2022 05:30:21 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e203-20020a6bb5d4000000b0064dafa0416fsm11356904iof.2.2022.04.20.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:30:20 -0700 (PDT)
Message-ID: <3c24dbdb-7677-bba6-685a-43293a01e777@gmail.com>
Date:   Wed, 20 Apr 2022 14:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220419180938.19397-1-y.oudjana@protonmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings: arm: mediatek: Convert some docs to DT
 schema
In-Reply-To: <20220419180938.19397-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 20:09, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> This series includes DT schema conversions for topckgen, apmixedsys
> and infracfg bindings.
> 

Thanks for the effort. Regarding the bindings Krzysztof mentioned should go into 
bindings/clock/ directory: please add the clock maintainers as maintainers of 
the bindings.

Thanks!
Matthias

> Yassine Oudjana (3):
>    dt-bindings: arm: mediatek: topckgen: Convert to DT schema
>    dt-bindings: arm: mediatek: apmixedsys: Convert to DT schema
>    dt-bindings: arm: mediatek: infracfg: Convert to DT schema
> 
>   .../arm/mediatek/mediatek,apmixedsys.txt      | 35 --------
>   .../arm/mediatek/mediatek,apmixedsys.yaml     | 60 ++++++++++++++
>   .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
>   .../arm/mediatek/mediatek,infracfg.yaml       | 79 +++++++++++++++++++
>   .../arm/mediatek/mediatek,topckgen.txt        | 35 --------
>   .../arm/mediatek/mediatek,topckgen.yaml       | 60 ++++++++++++++
>   6 files changed, 199 insertions(+), 112 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
> 
