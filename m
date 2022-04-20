Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F850817A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358801AbiDTGwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiDTGwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:52:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452814025
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:50:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l7so1537043ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+tvOwcHK/pMvEVLplx6yrJ6qPflwR4OLhSkd6EKCLRI=;
        b=ABab4LEiP42hY9yp+atAuEZipBVfsAjqtuxekTR3fyYxLj2YI8sVmtq72lPxbrYdFh
         qYZRhzptItVJ5QRJjLXt8AP+2Af94KpGv6oWML5uxYh3VcPzvduL9jlmM7bIK9kijXKK
         qBG85CFH7lrPzFZ9DSXZUQ2PlOrn0TObElxD/kLZv7u/iv965hXXC81CmDTmWtVaj40q
         Un2PbZS1alXWSTITFNdAMrWzLECVm8PcPuus8FAdtnS8mlRN6yvvZKiUX3uTvR/rg5aq
         +wlWIwdNivWJg1mBg8G7OeIc3+T81h5UOwYAy1J2A14LtouiZ1AI2szTphNG2tPFDVjk
         M6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+tvOwcHK/pMvEVLplx6yrJ6qPflwR4OLhSkd6EKCLRI=;
        b=HWsSF8qLDgjUxXtV26Ls+7VHfGBdzo32eRb6GnQFxOuzKi4sx2uYa2UZFaeqQR8nIx
         8kCBi7XaN1oW3RKms0tmc/2qDNZD1OH9PAb9l83abPL0yufpGVAtagzpco/pBMVFMtS3
         KXpt7REX0que0/ZpWSsEvsmixOdvXDYPWUxeCJXqKB6uR5fDzvB9olf4vAGZVrrjDIWU
         XdrRwG/QmEnU8xEtipD35S/ZhzTiaQBKfONYzjnqOLBYY7KbmsD/HFEbd+vsPHRFqqXQ
         pjvF1AWIZK3Oft6tXM+4lBWi4EiJZnTLWLkmzy1o9NiJYErNn8jGwqiYVB6WbEFSq+n3
         on3Q==
X-Gm-Message-State: AOAM530onjRKDmjFylY1qBTzFfwRQreNPG5Ur+8CAMGKYdILCX+Vek84
        pFfRNz3FyMp2F1bwUJiu5HCtvDMcL6ur2w==
X-Google-Smtp-Source: ABdhPJyyliRjehv6sbtfEh1xJToY/HkD/2LEVWUqQLsW+zcHi7QShLPq/HedquMqPHFjG/+my/ZNhg==
X-Received: by 2002:a17:906:4c93:b0:6f0:2de:f42d with SMTP id q19-20020a1709064c9300b006f002def42dmr1296745eju.648.1650437404769;
        Tue, 19 Apr 2022 23:50:04 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mp8-20020a1709071b0800b006efc915e1ccsm2144513ejc.118.2022.04.19.23.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 23:50:04 -0700 (PDT)
Message-ID: <958e076f-4567-3941-69cb-69d819de2470@linaro.org>
Date:   Wed, 20 Apr 2022 08:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: apmixedsys: Convert to DT
 schema
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220419180938.19397-1-y.oudjana@protonmail.com>
 <20220419180938.19397-3-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419180938.19397-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 20:09, Yassine Oudjana wrote:

Thank you for your patch. There is something to discuss/improve.

> +
> +title: MediaTek AP Mixedsys Controller
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description:
> +  The Mediatek apmixedsys controller provides PLLs to the system.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:

Same comments as patch 1 - no need for items here, just enum. Please
also put the new binding in clock subsystem.

Best regards,
Krzysztof
