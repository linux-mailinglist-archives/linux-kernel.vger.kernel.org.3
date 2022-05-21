Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D213352FD5E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355277AbiEUOhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiEUOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:37:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FB66FBB
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:37:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu29so18776340lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HghIPP/c/aNOhyZD5DNeCeHaqeDM1vYhEBVF/dCUtJg=;
        b=oOY/fR+Tg45kSSTWNzGLslHiFzBjURbO53hujaFIrpEgLFCAvIpJnp5BoQq5PIMRhf
         OY9GPgX/PKaap9Ln9tq2mXRabiwBKmP7DOIwg9+gzXwRnOXKp5U4/TMxoYWHWL3ELWHn
         h0qsL03lBRz3QqmfshuCJBDCKAKhKNz4dTasz6/b5XQzFZfzi1ArJAZotoprBzncCnmO
         z3gudk2yJUtNm6wd4gGj1FYYj6jST3WHm7PiFIcrdLC8D+DQKaYlGlCvCet478IksISc
         8AWSZLKpccr4teHCrqEW8S6Q0aIS2spAv3fm9lNetDuwoU+W64QSiC3aCqFzXAPGoN2A
         BVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HghIPP/c/aNOhyZD5DNeCeHaqeDM1vYhEBVF/dCUtJg=;
        b=emrMo8dRDy+pvByfDXYkIvAiXbSOfM4E/7vnJFsvJP+bd+xmt5l2pmB8l51IsmDNG6
         BbYtVb0g8TYOpddsqjC66itTXkK7qjMwJp7QwtIKKiE5qlwSzhTFTwxq27RdTGqaU6nq
         zwhPliowbL2n6HzaClxhF2VUJcUK4t9ExhULiFTPqtRA/Rt82JILe4jLi2X/1Gns1hIy
         zam8C5i6Ax+LiVD1v+BJklO96iywG3cSoUTH4DyGzs0lAo479tiI4QANGKzewW7h/YSU
         OhFlLUZs/Uxd7nxSB4AktP8+1J3L1XmPDK1tsoBGwS3Yt41GQdKH45QQBfsXSk9TvteI
         iphA==
X-Gm-Message-State: AOAM533089lrDiyZOdj27t6070xsGNVuVwDNn4Rr8D0INOT7TPH+euCB
        Ux/Kil6wb95s5Onmo0I2EuloRg==
X-Google-Smtp-Source: ABdhPJw+1Sc2rMKqGmba/fJgsYKnwtgpoYhIctxY2xn2jtIRw+LPGvUXaOxbXQ82y6OLLszeHRUBRQ==
X-Received: by 2002:ac2:4a6c:0:b0:478:51fd:f8ee with SMTP id q12-20020ac24a6c000000b0047851fdf8eemr5607074lfp.208.1653143852027;
        Sat, 21 May 2022 07:37:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d25-20020ac244d9000000b0047255d21165sm1079376lfm.148.2022.05.21.07.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:37:31 -0700 (PDT)
Message-ID: <27dbb8c4-834e-2c2a-431f-05558fe56561@linaro.org>
Date:   Sat, 21 May 2022 16:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] dt-bindings: usb: atmel: Add Microchip LAN9662
 compatible string
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220520152335.352537-1-herve.codina@bootlin.com>
 <20220520152335.352537-3-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520152335.352537-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 17:23, Herve Codina wrote:
> The USB device controller available in the Microchip LAN9662 SOC
> is the same IP as the one present in the SAMA5D3 SOC.
> 
> Add the LAN9662 compatible string and set the SAMA5D3 compatible
> string as a fallback for the LAN9662.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
