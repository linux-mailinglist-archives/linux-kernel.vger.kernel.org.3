Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7355997D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347079AbiHSIjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiHSIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:39:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3955280F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:38:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u9so5212554lfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JQ2N9eV/mruP1qSMZgYRsi1GRzzDw7XMn///n243wCM=;
        b=mXAeU1hnmu3RDZSvggxiZhPX9UyTK/m37afbgYDla183ruesKl1GGn/gWLCXUsbI65
         GA04DLL3rNxArt6xOf/hns+nR61Q0WDBAFYkBNhYWxmUAx03GwYrXBZmpO/tE7tHuDLy
         kSfna3qILRt9iqFECk4uBpxHqAiHaRl2YMSNVXXLgW1iPs3aQQkLCRwajTTrfOt9AY2v
         BIakiJ8bFYJNzZwWaEC+qvbEjK+Fi9b+oSOIwQdyusLsPAyYm/rQ9LP7M04EoZYhaZzP
         EOZK3uaysjRR4+v9/x5VF9C+v8/z2lOZ4PqbXwn6F3mdIeMCMmIFL7L2iA/WtDQoZ+mn
         rOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JQ2N9eV/mruP1qSMZgYRsi1GRzzDw7XMn///n243wCM=;
        b=LAPy89uIF9UnqTpSOnDaPQUyCDSP++NXOyI0wlKmNkBARcfJVxRNg+qXUgvl8bicxJ
         RcTljsGbyiBsWiYo7aCYaREe4hGgK+VL/8kQ38VLjm7mNd7M7rFMTAyzR/XN6XmSpyNh
         wOIwh9ZZoXRoB3maek/ScWh4Khvs/CfUrmf5kNZcJAoRitAMzEVCvKyGYv6BPW+6Ak5f
         YEWO6ww5mVuFcisBlKTLIW1vkglG9rjfbWY1PQj8cQl0LS4hCYulp9OPvmzsDBH15rcp
         c/TFuQRDhbIdMTkgoqADyue5NgAh9EeICtg7zEuQdKOmW+wteC7g2Ehf7xcHP30S5ICI
         hAZw==
X-Gm-Message-State: ACgBeo1CN57OIBlXhy9819Ss3CEA5BurilexqzIeZnuVTvpOfsIUp+tT
        HJtmG5Gw+XgCf6NXBTIFyLWKwg==
X-Google-Smtp-Source: AA6agR7XQLtf5C8sDKTMGWsCcCyQhHRZUaAHZw4i/jxd+22w5TqObnWVtjD5Kyad6FnvFg8m/lRPuw==
X-Received: by 2002:a05:6512:1594:b0:48d:25f2:a6d5 with SMTP id bp20-20020a056512159400b0048d25f2a6d5mr2405503lfb.238.1660898311725;
        Fri, 19 Aug 2022 01:38:31 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id z19-20020a2eb533000000b00261ba714b01sm294624ljm.77.2022.08.19.01.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:38:31 -0700 (PDT)
Message-ID: <ae1c301a-60e4-5112-6681-8896a7479207@linaro.org>
Date:   Fri, 19 Aug 2022 11:38:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add active-low
 property
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220818172528.23062-1-pali@kernel.org>
 <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
 <20220819065620.wvmy3kigvvbwo4bo@pali> <20220819080814.GA6653@duo.ucw.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819080814.GA6653@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 11:08, Pavel Machek wrote:
> Hi!
> 
>>> Although the question is - where is the user of it?
>>
>> I was planning to send updated powerpc DTS files with these
>> register-bit-led definitions after accepting dt bindings.
> 
> We need device tree people to ack them, first. But a note saying "this
> is for Turris Omnia router" would be welcome.

In general the process is one of:
1. Send DT bindings with driver and DTS changes,
2. Send DT bindings with driver in one patchset, DTS in second but you
mention the dependency.

You should not wait with DTS till bindings got accepted. Why? Because
for example we do not want bindings for stuff which never is going to be
upstreamed (with several exceptions, e.g. for other systems). Also
because we want to be able to compare bindings with your DTS
implementing them, so we are sure you described everything (especially
that you said running one command to install dtchema and second command
to make the check is not possible in your system).

Without DTS here how can anyone be sure your DTS actually follows the
bindings?

Best regards,
Krzysztof
