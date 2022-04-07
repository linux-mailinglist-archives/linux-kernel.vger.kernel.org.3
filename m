Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB324F7EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbiDGMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiDGMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:06:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC57C31DE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:04:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so6108512edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TUagL1wODEikqUkLow3v0XH4BykbzucN8xEfLth78H4=;
        b=nnqmHk9r0F5jBw+maKTb6Sufj2aR12l7WrSCYLy+X52Zpl4xvhm3vApI8BfPZ/FSca
         HwzngoAMEytBgAXx1PNW+b2tl/TAti6xietSCob3HMt5mlOCiubX6i0Ggn4mfdljUpps
         vNPg1+Y/lvjLyBJkgf3IEKYOp8t7Hm7W1yCXMrJ+77edH7nDm23GGZz6eKW9LeWK/P0D
         zrTb8WSUD9w/KXU7BR0oL/kdGJksFN6WXoMWdRCT9V4DeGEWHZiGfSyTnraS9eQsxGm8
         eG83cMtly6GLGHunfjX/WRKVpeXQL0tuWbMK3qcGDVQZkfB3qmjO0N48MHzDLDytvW5w
         LYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUagL1wODEikqUkLow3v0XH4BykbzucN8xEfLth78H4=;
        b=KOcF7tcrEavL9l+OklZT79XCOKdkJmmCX+5G29OSRTaq2JPXfdVsnEGnxAj0w7Wbtc
         R1jKxVOVGWVYK5nwQn9edshAxzatc2A8Xl9vaZ91ZML56uUXFGLzzZBuPVFO43svG3n2
         80DsCMi/NI2YMGSN2ToIibl6icI8GyJQoyhhYYZ103CiGw04LrGxwqqqBjPLNKxT/dbh
         WUWX3agxg+hLoD+e5xiDjQnxr4zAYq3T5PAPAastMj2tJhsa7H+0aoMa8ot24Hj40axo
         e17gxTqqw7zJYVBjAJzco4PdO/ELjBvozVCs1TmeOgcTG/TjR+KqCPlSqdHkwtlz5YDu
         /ENQ==
X-Gm-Message-State: AOAM531Sfj0LE8A5zhRZTDSJDlDIwXAPsFzFo7xotcaWvI7qiElywRuA
        U/c2h31fcudEHxCx78+G2escwg==
X-Google-Smtp-Source: ABdhPJxdmNVJ/HA/fsikeQAjG7ODJWyGCaxh4P4WauvZgQ4v3hxlwTN/dO22tLf5iCaB6uKilwN9NQ==
X-Received: by 2002:aa7:d1d0:0:b0:41c:c19e:a0d6 with SMTP id g16-20020aa7d1d0000000b0041cc19ea0d6mr13790784edp.179.1649333065649;
        Thu, 07 Apr 2022 05:04:25 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f2-20020a170906390200b006e7f5fedbe7sm4073522eje.3.2022.04.07.05.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:04:25 -0700 (PDT)
Message-ID: <65a57655-2311-0f9d-8667-851755aaec1f@linaro.org>
Date:   Thu, 7 Apr 2022 14:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        tudor.ambarus@microchip.com
References: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
 <20220407112345.148316-1-michael@walle.cc> <Yk7LjrvqSLbzPYkw@sirena.org.uk>
 <561bbc1cf43c3795eee67e10537ba365@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <561bbc1cf43c3795eee67e10537ba365@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 13:41, Michael Walle wrote:
> Am 2022-04-07 13:31, schrieb Mark Brown:
>> On Thu, Apr 07, 2022 at 01:23:45PM +0200, Michael Walle wrote:
>>> The subject should also be prefixed with "dt-bindings: ".
>>
>> I tend to complain about people doing that.
> 
> After all it is mentioned to use that prefix in
> Documentation/devicetree/bindings/submitting-patches.rst. I try to
> remember when submitting SPI related bindings.

From my point of view, the dt-bindings prefix is still expected, just
after "spi:" (and other Marks' subsystems), because that's I am
filtering the bindings.

Your submissions had the prefix in wrong place, this one patch does not
have it all. :(

Best regards,
Krzysztof
