Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55DF595A71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiHPLnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiHPLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:42:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64EBB004
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:12:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o2so14472740lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3voalfDQmBkJPM0iEJsy/pKGiIZwChjwOwKTgiPpcq4=;
        b=u1jHFXVQelHvAsNbis29DRi8FSq7YOKJir1/5EgPIni7IHBviuSNWkvqKcxU6mb40R
         BlTCsCYh1K7sEgITXhZRYuYCN5pe2icqTkOWfoMuklIV/+8Gz8Km9Ua5GakzZb5C6vYE
         c/gtolt2fQpzqg7RzUa7JJJZHGFZesC1epB+YBppY3+iXA3X9R/+A+b/Cs8fSx7Zfgj9
         HkhIRc/RtFysjq/jswJbCKcPVLXfYAkP/TdFb/zRc/nvYNbE7Tr0tyCAg9dK61Mg2I+X
         kYaLufS6xx2BrN+tOj97sb3WT5EVJ4DulT3EMA5N8rYLWheSzQTjpo0MJU1zCmaGZXGZ
         808w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3voalfDQmBkJPM0iEJsy/pKGiIZwChjwOwKTgiPpcq4=;
        b=dftDZMEYbbXamMfROid3znd/MFNcViCNL/oqL6uMOyVq417/9WKUk0o9dAG7I/uqwx
         VWEm9MJoUzuc4ux/gix/ziHkVW38DYbeK3W/4bIjQvHMw1vZSDlOZSxspCIwet+rM5z3
         6AhGHQH/8cbgxyjZwdZwmyzY+w3TTet8RVaRdCh0ExGcK8L+5209/vHnQevqd/tIA0F7
         xbEFPeVU9c1OOf/FF3TAAgJGLomttmepFg+mursdQ7ftX8Al8z9nzzrGMlnFH11xep+E
         1M8fTPr5CRrJ2QIUWzhdYc/gMv83vBj2sXWtLqpIPIQPIcKK0eSwgB/8ywSeaYGi92d/
         l/rg==
X-Gm-Message-State: ACgBeo1RGnI3BIzg8fyuGFXKtPkTOhV363jemD1Ucl7Z0Vx+vU3yRNAt
        1o2qbgt6biF/93pd810FUyV32g==
X-Google-Smtp-Source: AA6agR5s6mmYOckWupogUoGlmi0i4i7rbgUk9CW8zTxihnx3AOW7S9ITLQhn/Y/uWTfocKkgvLXxHg==
X-Received: by 2002:ac2:50d7:0:b0:492:8830:4819 with SMTP id h23-20020ac250d7000000b0049288304819mr3641459lfm.36.1660648347906;
        Tue, 16 Aug 2022 04:12:27 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512025000b0048b18d65998sm1358896lfo.38.2022.08.16.04.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 04:12:26 -0700 (PDT)
Message-ID: <14753794-245a-7b27-3bd9-46b80666b7af@linaro.org>
Date:   Tue, 16 Aug 2022 14:12:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220815050815.22340-1-samuel@sholland.org>
 <5593349.DvuYhMxLoT@jernej-laptop> <3881930.ZaRXLXkqSa@diego>
 <2249129.ElGaqSPkdT@jernej-laptop>
 <b5401052-e803-9788-64d6-82b2737533ce@linaro.org>
 <20220816120050.07dc2416@donnerap.cambridge.arm.com>
 <29072f12-b9a3-9815-ad52-5c4f6b1634b3@linaro.org>
In-Reply-To: <29072f12-b9a3-9815-ad52-5c4f6b1634b3@linaro.org>
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

On 16/08/2022 14:11, Krzysztof Kozlowski wrote:
>>
>> I think one reason might be that this is so central to the whole SoC
>> operation, that it's already referenced multiple times in the base .dtsi.
>> And having a yet unresolved reference in the .dtsi looks dodgy.
>>
>> NVidia seems to omit a base oscillator (maybe it's implicit in their
>> binding design), Marvell doesn't use a fixed-clock (but still puts their
>> base clock in armada-37xx.dtsi).
>>
>> Exynos and Renesas put a *stub* fixed-clock in the .dtsi, and set the
>> frequency in the board .dts files. Would this be a compromise?
> 
> This is exactly what I said before. The clock frequency is a property of
> the board. Feel free to keep the rest of the clock in the SoC DTSI to
> reduce duplication, but at minimum the clock should go to the board.


s/minimum the clock should go to the board/minimum the clock frequency
should go to the board./



Best regards,
Krzysztof
