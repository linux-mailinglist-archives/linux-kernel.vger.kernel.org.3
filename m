Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A439553B3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiFBGhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiFBGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:37:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE25021F98C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:37:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd25so4994408edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P+SVKsijP6JkUgNOco2XQmqekWV6FYkMFTb8nxQO5ww=;
        b=m8c+W7QgyV419RzrHTmnU1lGVvxFj1lycM/jla3m2HZRFzackfP82Ocf0pcBBhq+nc
         gw9FxoQoK4g83ngSbEQQ2dSjZD9nBv50f3M1Cq2aB5EiTclnSK9QiiggPVOwrOMacXwq
         IfqcWeNqsfL8UZMkux6dbflF9hQSJ4d3TzSOvQuRTH9IELyTcxmUTd6Z8lXcwgQhK9r5
         EAsHXEJSJDgqKmaYa2k6fBEj+8/+d+mEWdo4dtl3c4/4SknIcB5pKxqJ+uUxKty45m7m
         Ujy4U1b/ghF1wXJkHTvanrg/Qqb4BjMJyuRoLR02xnluLPoeToDgj2iOChQ1/XSyusXD
         MBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P+SVKsijP6JkUgNOco2XQmqekWV6FYkMFTb8nxQO5ww=;
        b=dBjJyawNqyplhUK3ZG7egaWmr/g41HVhJi7TW9yUqK/dH1dvhuWk6B6Oaam6ZR9Nh+
         EYBK40G9Ovkk92DMtZub2Z0mWBlqFWMVyFcLDuSnVZ2gtUM5ZwW4qpWJVSMofa4sAurF
         jnQeGNoxO8fxgOEEeRqxdPNJc78O7a5pTOYnsBEgq/6ui7dpwDOut7ZixHE6M5TYUene
         pymTWjp+aOFdM8oUYyBdFA0tdaJXVSCLZb7k8CXasIGwCKy0gXtUOQRLgpQSOliohwKG
         QLBHs1vov64c8Lr8qGWfvzVuPOsyIZ9SXbJykpt22eZpC+M4ixnHFvB2RdczwWhrzubd
         rKoQ==
X-Gm-Message-State: AOAM530dx4sOCkZF597GIDvtPToqXMH8VSZC/AUgkoN/eCYGZvsig5g1
        kEEfUfg0PZ89aUasKLXokw8zBw==
X-Google-Smtp-Source: ABdhPJzvPQWmTxwqNMXeu7trZCjNJkphaQbsMtBiWxqHxuG0WA17vaqx3Y07SBGsaskn4cdpMdEDKw==
X-Received: by 2002:aa7:cb4a:0:b0:42d:d232:34d7 with SMTP id w10-20020aa7cb4a000000b0042dd23234d7mr3679077edt.201.1654151865385;
        Wed, 01 Jun 2022 23:37:45 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906b09900b006f52dbc192bsm1432623ejy.37.2022.06.01.23.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 23:37:44 -0700 (PDT)
Message-ID: <b1b87be5-a048-b713-c9f2-84b948aa6718@linaro.org>
Date:   Thu, 2 Jun 2022 08:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
 <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
 <20220601105846.7hriawg3stxb657f@proprietary-killer>
 <630b0d13-6778-2508-6a34-9daa0358047d@linaro.org>
 <20220601110616.xmxih663kxgupszv@proprietary-killer>
 <a2a98c6d-2ff7-89f6-0711-c8f8b99e85c2@linaro.org>
 <20220601182418.okoofgannw6vbcxo@proprietary-killer>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601182418.okoofgannw6vbcxo@proprietary-killer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 20:24, Marty E. Plummer wrote:

>>> Either or. Whatever makes the workload easier is what I'm looking for.
>>
>> Sorry, you need to be more specific. Apply is not a job for you, for the
>> patch submitter.
>>
>> Then you miss here important piece - which is the first patch. DTS goes
>> always via separate branch (or even tree) from driver changes. That's
>> why bindings are always separate first patches.
>>
> So, add a 4: arch/arm/boot/dts/soc.dtsi and 5: arch/arm/boot/dts/board.dts
> to the above list, or should those be the same patch as well?

For me does not matter, sub architecture maintainer might have preference.

Best regards,
Krzysztof
