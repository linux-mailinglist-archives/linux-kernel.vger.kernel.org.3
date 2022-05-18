Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3552C41D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbiERUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiERUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:08:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A223F393;
        Wed, 18 May 2022 13:08:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so3089973pgq.10;
        Wed, 18 May 2022 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c5iCYsm+oHhVyd3Ag75OkVnJmbs7lr5beKmjHFAJz5g=;
        b=k6zVqRqBcDFa8GFrhI5/kz+ge1DrR9m/SjS30GOJGpWXEYnDrFERoEvtuWoLYweLo7
         0xeLr98+o+sNI6Oj34J52GQopUUBwr/KYE9GWkQaesgOOFtVD+az2vF//S0yzH5RptNU
         xiCoe6rMjUfrSk8HdFyscCs+OVzjIWh0izK4oCDDzHUzxR1GHrHh4TJd2RTLfm9QFrDC
         +3EFDaLpVwCRaXAWnpMBuDSmAC2Wwd+FMzN4RmLTrPr/WYl6Oybv7QBGg25WbR3mi4dv
         +brvr5sDtHcUKf6Vg3WrTEEAEdO4Vkyrl7YRGbW0yIFP+x8KHmtthbd27hUyeAX+DxOU
         p0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c5iCYsm+oHhVyd3Ag75OkVnJmbs7lr5beKmjHFAJz5g=;
        b=NTVvfbeLU86OJkHnp4aGkEOsVwsZ/jWS2vUfBL+WiD317ncsiihI0cyjJScXoBTn2d
         Ykb2hVFEIbjwaMyFaU1jrBCoI9ph+joSG/hWmIifkwOz8H2bEo3yITgekU6wGL8AamGP
         EeJkSvxHZJr2fnU5uyFhc031yDyd0IU1d6eF4bCj/LUA45bhUG3+i7EVbqDlFCt92VEr
         nw3rnzbg0H/yrMe3nnVFfETZeTeJ8YuV1OzQtfS05vFKCU31W1QGeTlPFcvw3SSC+6bI
         tRgRt6qDycS6aGxRyVhLV1xyLU2CbwfCzB++trbrpZ3PGUsL1oZyeqpxhFoU70CiPwLE
         OHoQ==
X-Gm-Message-State: AOAM5307VfArxwMUn8XylH4QfVnc1jTrgTao/v5Wy/G7Frb2oxABpe6y
        On9n/6hRIwqWpNW4RuRrRHo=
X-Google-Smtp-Source: ABdhPJxtdI5lShe5YixuNlHYLeWKmURN3dZZlMIXKJwq3QZcEikY6vTFV/6MGZf7SmNwg2C4qsAmcg==
X-Received: by 2002:a63:2a02:0:b0:3aa:c641:cd86 with SMTP id q2-20020a632a02000000b003aac641cd86mr917002pgq.614.1652904487839;
        Wed, 18 May 2022 13:08:07 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id q19-20020a056a00085300b0050dc76281c9sm2397657pfk.163.2022.05.18.13.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 13:08:07 -0700 (PDT)
Message-ID: <dfb1fcf4-c569-5a01-59ae-fbaefdd9a800@gmail.com>
Date:   Wed, 18 May 2022 13:08:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/5] dt-bindings: arm64: add BCM63158 soc to binding
 document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        tomer.yacoby@broadcom.com, samyon.furman@broadcom.com,
        philippe.reynes@softathome.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220514232800.24653-1-william.zhang@broadcom.com>
 <20220514232800.24653-2-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220514232800.24653-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2022 4:27 PM, William Zhang wrote:
> Add BCM63158 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, 
thanks!
-- 
Florian
