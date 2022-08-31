Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB65A76B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiHaGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHaGeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:34:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9443CBD762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:34:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q7so18550394lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EfVD6vsRPLcHy1xJRg55OQq/u1sxBQsS9AWlrVtf3tc=;
        b=Bs1uRBA+EvIU7ELdOh4+/qok9OgyeolpHAwagQcVTgcKyJ1QN/l6+Tk4isx/L35jsN
         AklJ+0UT1wvSejSl+UCB1yDbaxuHQQxmZnGyIOkdd10rFk6GahXtXFJP1NF4GdLbBQBH
         GznmxegpYDrGcghUTJm0Shqk22ElKV/58fKVU5u74suMWHWsNHRq6FI4y/0sexoQ2+jr
         svDIKzpW6swbydVdJMYlKbIOmJOpFyHQZvXel6wgifLXUIXUn4iwC9V3Uo3ULzJKMsIZ
         Kbnu0+ADVka69040EKuD7r3/F6d6Yn/lUXs/TveovPEwV57qihC9ubvAE1ZrK4wfHDg7
         P8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EfVD6vsRPLcHy1xJRg55OQq/u1sxBQsS9AWlrVtf3tc=;
        b=wdCUGiYs6tcp8uG3PXn8g2rPmYNOsm5YQ0E7/yhEDHcd3i0Pse8HOaQS+gUixgaMjT
         BAO1eVzNRUZt44bNgaB/mhcsNL1q00+rm95QOQ2epnLfFd+Wt1+LsCtaKHHDwNCdK1gP
         MBGndRaKYQsutxgDmXNDhskySnZDHVsT7j/DK76+5p30PswrsEUDmlhuMkBOCTYVg4N9
         1N6yRv7hOVU3FsMoKuGDQVendltdxIkun7NHvnve0xj4QQuH0FfaomPXWZziNy3cuQmU
         mNlP+wkSKkE4mhdZbmoovdi0Je5rOgKXI2eHQ0AUn2V+oZrk3QIiE23Q9ce9gY0NOsrE
         5xvQ==
X-Gm-Message-State: ACgBeo0Oqog8zDqL3AptEY1HAT8cnT7cBEO5SloR/cRuywRFOSXbAq0O
        Zvzoc8pHKI945Ws/ZeY899/HDA==
X-Google-Smtp-Source: AA6agR5ucdj71CKZHjXO1DiOPxggS5pBYARYG+4o1jOXLc8VfrkwFqUDl/6C7BaYMIUYvwKqSQvxpw==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr8418177lfu.602.1661927648005;
        Tue, 30 Aug 2022 23:34:08 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id n6-20020a05651203e600b0049313f77755sm1176538lfq.213.2022.08.30.23.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:34:07 -0700 (PDT)
Message-ID: <44af0610-63b1-20d2-2c8c-23e84edb519c@linaro.org>
Date:   Wed, 31 Aug 2022 09:34:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/4] dt-bindings: memory: Describing LPDDR topology
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831013359.1807905-1-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831013359.1807905-1-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 04:33, Julius Werner wrote:
> This patch series implements a proposal previously discussed on the
> mailing list under the topic `[RFC] Correct memory layout reporting for
> "jedec,lpddr2" and related bindings`. It adds a new jedec,lpddr-channel
> binding which should be used to group nodes of the existing jedec,lpddr
> bindings to describe their relative topology on the system and the
> amount of chips wired in parallel on each channel, as well as their
> different ranks. This also adds bindings for LPDDR4 and LPDDR5 memory
> types and deduplicates some common schema elements between different
> LPDDR types.
> 
> Julius Werner (4):
>   dt-bindings: memory: Factor out common properties of LPDDR bindings
>   dt-bindings: memory: Add numeric LPDDR compatible string variant
>   dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
>   dt-bindings: memory: Add jedec,lpddrX-channel binding

Thanks for the patches. Where are the users of these bindings? Although
bindings do not have requirement of providing user (as kernel API has),
but this is quite a rework so I want to see that it is applicable. That
it matches real use case and need. I can do it only with real DTS in the
kernel.

Best regards,
Krzysztof
