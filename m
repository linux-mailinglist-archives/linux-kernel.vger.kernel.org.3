Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47E56504F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiGDJFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiGDJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:04:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBFB86C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:04:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x3so14692851lfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n4B9YLkKJASUbF6SDeFOUfEsE0vnt4+YdnmVDhP06z4=;
        b=PYvq706wWC49R4jolMknaPmpRLaoYvxAwS/yrvpFklnZZejweFemyL+imVd3ZQHAkf
         2/oXHaA9SGkarCtUTpJuT3rbr6E8/ZVClvuR1xBNSKo+a8wG5DTug1kwbGjWuOCBcI70
         dWGUwdFSDfUGxCvJG/zPrfbQm+BbCyObhS6xtSNndCwmGipu6Cfuvu+r8eMks7OKGo0b
         2YzZ/37v4uOxttWU2JFcYvY4M9Qr68hL1wTP8MZfoSjc1J2+2NJTNQry+5XTQR6atCko
         dT/Z9yNTRRG/tHVo63yXJDe5gp8/LH7Off+y7xl7ruy7e2ZiSNNwjEwSUYfXcOFTMnzE
         rrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4B9YLkKJASUbF6SDeFOUfEsE0vnt4+YdnmVDhP06z4=;
        b=vVtagFwyIQsdGaPm/iLS4W7N0XDuCPqCNyqfR6+gBzO9ck4ppIcy/LAzx7v1m4Rpb8
         hYHCVbYDhkkUD2nQJ4QpEf9DSgo0c3W+iC1F5m3v10HgszCAq1rFgnTQqnMOrOONX08s
         x8ROtmAQB0r7iRRl/zpJdaGP9X1D5kJzd/TBDnRotD4dILI/E761PtSo2wOhWw1OokkJ
         76PTUnIQ+/5naSh3zqhdwlTkoS2+7VvidrToq/mQd55X9swwFhOwlYYrSwyICAwjQztd
         1f6ee/38lQcNxQcfgCRpKfJ1yrLFsuJFoCgaGWcU07JR1c0MvEwuDFhMsX+bT772t8xI
         x2bA==
X-Gm-Message-State: AJIora9mJTh/isAQ6PPwjf2UXDSCnIwzspGnwY/Z06VU1axS0o08F6HA
        6NCcO2xreEIlHAy6pL4/9P8tCw==
X-Google-Smtp-Source: AGRyM1sLHkpEL/e3FbHHjgOt2aInxHNlxFrHeEIa0L1/Bz4GYdHDD1jIwPyFeJeq+08viN1qBJk27g==
X-Received: by 2002:a05:6512:acb:b0:481:cce:3c22 with SMTP id n11-20020a0565120acb00b004810cce3c22mr17601128lfu.45.1656925495041;
        Mon, 04 Jul 2022 02:04:55 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b0047863382e3dsm5024155lfq.215.2022.07.04.02.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:04:54 -0700 (PDT)
Message-ID: <4513594b-ece6-a4c2-82ba-d334f5c4234b@linaro.org>
Date:   Mon, 4 Jul 2022 11:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 02/13] dt-bindings: power: supply: Add Mediatek MT6370
 Charger
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220704053901.728-1-peterwu.pub@gmail.com>
 <20220704053901.728-3-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704053901.728-3-peterwu.pub@gmail.com>
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

On 04/07/2022 07:38, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add Mediatek MT6370 Charger binding documentation.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
