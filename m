Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E404FF760
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiDMNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiDMNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:07:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA62FE55
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:05:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t11so3751672eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=jVWSCk1/VKYg1ru1BSawO7JWuW1g2f78k2SPtwtYxzM=;
        b=bts10QH0JSWBe2V7AJgHw4qjXFZBtENfGekc2KrKoKHjqXDPNCndGpMUkhHgy7XVQb
         6M1qc+lnhyPJEgz1Qnc2ZTJm0wlLubrCanfnfeEX27QoVrI6FN7dI4XHr0XyjacoTNsN
         2iKlDKGPv8EvkryymE4kMLpVBpExOZVmxxPtEY0yb/256n6wOAo9CLKiCEeeEMu5/ULn
         8BMQl1UOvigQmCc/nVoxfCENYirXfc82zd3670fi3UrL5ZvVxjUsftojb7J17ua536Zz
         ph5lFj0wO3wWs+zqldyY1nRSDhfDosJEMGXg9yFwfatulSHTuw7Ip5pBoT/kSL/JNnF3
         0LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jVWSCk1/VKYg1ru1BSawO7JWuW1g2f78k2SPtwtYxzM=;
        b=H7OtePvGaUJ64Dy3ulHoOZyFB3l438qWpS9JnRK5X+TuIQZHynevnLsTe5FGkJin7I
         4iG5BySI02b36xYFK8Y/Z+5xW9FqOOU93UNP5GbYBq1j2X7yzlXcNbweAtF0NCptFKNm
         4dl9W4EUPmpjdfauI6jjq3au9Qi2IazR8jp9KYlkmBImIlJBGDWv70s+cDaXobSirijZ
         26gsQ5LAA5mVzhjoIUFyKS2KBq9XTBcUzqYPEdOdVDaY6M/r7D3tzwnf8JiYz8cUjtcD
         3xNfkYEjpB//+c4QeFyzMKulqrtnSCAwWA7W0u28lED1BOajWrTZLI+tQVEQeMyhPAOG
         Bazg==
X-Gm-Message-State: AOAM53154l5R4BJDSPrsBZarrKoHB7YXnJoB5xP+ddZ4JZjo+DkTNIIT
        6m3sacfAiiemmObEmB3fblwfgw==
X-Google-Smtp-Source: ABdhPJyEP1jE0PHtwq+VxHUU/UZtA71ai6ZPUrV4OW242fMygMItK8oEk0TeE5fT/Zqz+8H0r9NiRw==
X-Received: by 2002:a17:907:7fa9:b0:6e8:c0e1:5741 with SMTP id qk41-20020a1709077fa900b006e8c0e15741mr4380743ejc.159.1649855098959;
        Wed, 13 Apr 2022 06:04:58 -0700 (PDT)
Received: from [192.168.0.204] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm14062558ejc.42.2022.04.13.06.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:04:58 -0700 (PDT)
Message-ID: <e6e376a6-b604-4a36-bfed-641d905ebec6@linaro.org>
Date:   Wed, 13 Apr 2022 15:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
 <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
 <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
 <605268c7-9d0f-83d5-d7e6-850dabb380f0@kernel.org>
 <06852353-9ca1-6f61-7447-b5f1d64ead25@linaro.org>
 <4681b00e-7f89-d9c4-6361-b781ced72656@kernel.org>
 <897a05fd-a568-9d33-dc20-5de4e5d2188f@linaro.org>
In-Reply-To: <897a05fd-a568-9d33-dc20-5de4e5d2188f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 15:00, Krzysztof Kozlowski wrote:
> I understand that. You can still test 8-12 popular ones on a regular
> Ubuntu machine (there are like 10 or 12 cross compile toolchains now in
> standard Ubuntu repos).
> 
> Another way is to put your patches on Github and ask kbuild folks to
> test your trees. I think this was the repo (but double check):
> https://github.com/fengguang/lkp-tests

I think this is correct one:
https://github.com/intel/lkp-tests.git


Best regards,
Krzysztof
