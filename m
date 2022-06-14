Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9454BC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358598AbiFNU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358411AbiFNU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:58:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EC4F9F6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:58:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1974395pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VhtgMIE5/Wg9DeNfIoD/7ofySaH7LKxXNeBi1f7nprg=;
        b=nd9cPW0Zt54xwKXnf3Iqq+3nbNSv9YnSZqD18K5ZuoLb8FxShWIrEG2PJLN12gxioC
         SvF0ZC7HvhioxdS7XgKyqhgphK0f03ZJgBJ/2/vqZ5LS1rCq7g9JvviehoIMBw7OQAuk
         Fp8Xy4w/Odlbk6L8hBSLbi1toPO4qyq1vH8niXdNJ0z2x9zPwimFl3qNMjizcBuyz7km
         Nrn1aQMFT3vL1JHRYf7s5Vz2FnCUCTswJG4hlYOOvlf05zTAJgU2W00aGEzIzGT/ZULf
         DgYK1Ic6IM5x2+R8rkG41yxT4rzGrjL79XZaleoWPXFK2McSlg+ftzEIAf2EUYcLciA8
         Y1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VhtgMIE5/Wg9DeNfIoD/7ofySaH7LKxXNeBi1f7nprg=;
        b=vLzth+D1oUBJxFK4+zc7ywT3iT+15sv0v4nw21UsJnP64zIROT214YqY1LXXCzmC3/
         lKksxYKBrANw3fZwpKwR6Bag9Jzqh0vqLnX6nsu2m8RVFl9cho+XUcdlSi/ROKHzcW0I
         yVVv9T5cm+2Xg5x5Caq6ou8oggZ/Tq/i3oEOPCAWFzbmWB6DTXdDN/k+tYq+QLDAl2I9
         TalHRHbUvnoWoSGmaQByvlbX/xt2B/EVIEsbfXF1U/PNg1arvNd/mGrTdMtyyVorBqiw
         dGj0TRHeYEW4mDylfXnnC1fO/Sk5o6gX6B4s3fqCg7D4gZNTz25il59vRxFxJouTJffw
         SrWA==
X-Gm-Message-State: AJIora/reEmHLT9LBiWdiGgw8+8C7yvpWMJrs1CWjGH3ro6ViXvZMqzq
        KyoouQYWMAoyd70wQoiWnu53lA==
X-Google-Smtp-Source: AGRyM1swttS5otb7Ake3x9Zuf+nymu832Shm/TyGc9J+pv3ZSyf2ABU3qHozSWtHj3WAswhxf3kIZg==
X-Received: by 2002:a17:902:f68b:b0:163:f358:d4ad with SMTP id l11-20020a170902f68b00b00163f358d4admr6103713plg.23.1655240317182;
        Tue, 14 Jun 2022 13:58:37 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id a15-20020a62d40f000000b0051f2b9f9b05sm8120090pfh.76.2022.06.14.13.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:58:36 -0700 (PDT)
Message-ID: <57d11a55-beba-c91b-e168-989417e3910d@linaro.org>
Date:   Tue, 14 Jun 2022 13:58:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613225338.393-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 15:53, Vadym Kochan wrote:
> From: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Describe the compatible properties for the Marvell Alleycat5/5X switches
> with integrated CPUs.
> 
> Alleycat5:
> * 98DX2538: 24x1G + 2x10G + 2x10G Stack
> * 98DX2535: 24x1G + 4x1G Stack
> * 98DX2532: 8x1G + 2x10G + 2x1G Stack
> * 98DX2531: 8x1G + 4x1G Stack
> * 98DX2528: 24x1G + 2x10G + 2x10G Stack
> * 98DX2525: 24x1G + 4x1G Stack
> * 98DX2522: 8x1G + 2x10G + 2x1G Stack
> * 98DX2521: 8x1G + 4x1G Stack
> * 98DX2518: 24x1G + 2x10G + 2x10G Stack
> * 98DX2515: 24x1G + 4x1G Stack
> * 98DX2512: 8x1G + 2x10G + 2x1G Stack
> * 98DX2511: 8x1G + 4x1G Stack
> 
> Alleycat5X:
> * 98DX3500: 24x1G + 6x25G
> * 98DX3501: 16x1G + 6x10G
> * 98DX3510: 48x1G + 6x25G
> * 98DX3520: 24x2.5G + 6x25G
> * 98DX3530: 48x2.5G + 6x25G
> * 98DX3540: 12x5G/6x10G + 6x25G
> * 98DX3550: 24x5G/12x10G + 6x25G
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> 
> Notes:
>     Changes in v9:
>     - Renamed $id with "ac5" prefix

I guess this was the reason to drop review? Anyway this is unexpected
change considering the name does not appear in compatibles.

>     Changes in v8:
>     - Add review from Krzysztof

Best regards,
Krzysztof
