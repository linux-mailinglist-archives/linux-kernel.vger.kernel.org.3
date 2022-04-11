Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4397B4FB890
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbiDKJzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbiDKJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:53:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285CD3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:51:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l7so24262589ejn.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iDorRWYF+QQ7tsQ5XJAfMUGysPHXxZuhvqA5athArg4=;
        b=cQUcIjYqumxFXKIfax6Ac8EtD9FDWOfGxzbGQVqSOljpl775nxUIiMeTO8Xp/bJT9n
         grUwLrpbFGnfB1LswBBPbgAuAlSZZalLgirSgNC8Wz6z12NgXyEI3u6lTpl0XoFngnt/
         Ao6Zj5AdYIwiBtHhcUNWFdV9E4rRwnuejnHx5RXMcwpeECvQXlRzL1ap2ZaPbC3Q/ZLT
         hdMmrdhF+tPKedGTSo7exitV750T6YVuHFDM17lKLxHO+en6cinkI9rZy4HAMe897N6x
         sna7mzw2litogiKbmAHMl5lVfdwFnBZNTh6ussREe/jgl2E34XnhViJgLcbRVEQDVcPN
         HoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iDorRWYF+QQ7tsQ5XJAfMUGysPHXxZuhvqA5athArg4=;
        b=YgzjiMuCdIcrisgxaIsyJcc3pdeETRQr04EbALFjNd9qfQQoLP07H1Ay49dBwh6All
         uilxmiClgtutILd4uEkQeIiD1LG7m1dpVry4tKqLTOUnEOhFkTmv7jsTDezeQLh0QSMD
         0qgunqJRJS0bOHytCZbIvGwp/1C/1XQb36artmc9yhhq/RVVZrxvjag1QdSkyc75M10I
         rxrmqww9obtcYoDb8O4Hk/azrk6UrM3xYTo0Q7FFSgs0xwIpg2ET051k54eWS+tdebxd
         4oiTI8zFo6l60A/bBf706OQdoPnIdEfComjhWcEmTn8F0/zRhq8/7eaTGbsdzmiJN7RW
         99oA==
X-Gm-Message-State: AOAM5311dmrRJiC82Z5rNodfcVJ5/6KaGH+JRpkr0iu9oGxfw4fVZXTw
        XygMGNIUyhIyiZDfiJdX1LOv1Eca2m6BReEQ
X-Google-Smtp-Source: ABdhPJyKyVJsgYT5B0W9dpIJ6npkZo/eH4l4L0qruFZU6wbmitvhLWcwAuqSBf+SfmmtGbdwMwfbWg==
X-Received: by 2002:a17:906:7314:b0:6df:839f:af7 with SMTP id di20-20020a170906731400b006df839f0af7mr29069881ejc.65.1649670667205;
        Mon, 11 Apr 2022 02:51:07 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a056402238c00b0041ce094cf47sm9469078eda.60.2022.04.11.02.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:51:06 -0700 (PDT)
Message-ID: <b4d721f5-7eb6-480b-84ea-8fcea7516fde@linaro.org>
Date:   Mon, 11 Apr 2022 11:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH] dt-bindings: power: renesas,rcar-sysc: drop
 useless consumer example
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220407193542.17230-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdWXLiTKDpXydKQh-fmyHOHb8WpCe9oetNrs2GGNGZqRCg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWXLiTKDpXydKQh-fmyHOHb8WpCe9oetNrs2GGNGZqRCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 11:14, Geert Uytterhoeven wrote:
>>
>> -description:
>> +description: |
>>    The R-Car (RZ/G) System Controller provides power management for the CPU
>>    cores and various coprocessors.
>> +  The power domain IDs for consumers are defined in header files::
>> +  include.dt-bindings/power/r8*-sysc.h
> 
> include/dt-bindings/power/r8*-sysc.h?
> 
> Or does the period have a special meaning here?

Uh, sorry for this. A typo. Thanks for the report. I will send a fix.


Best regards,
Krzysztof
