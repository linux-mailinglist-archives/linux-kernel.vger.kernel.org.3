Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E65810A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiGZJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiGZJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:59:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3C31200
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:59:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p10so14380044lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ywEnupIYPlj6Qgbc2SratI+CjTje6F8RjFicZ1VllkA=;
        b=sIk739jdGKOmB5iIVI8mTzj09ojlO01IW1pIKeiEmFLnYbhaTUbgM0YKgEGK4/vfA/
         JK7g0CAv52xfGBSpiCP+ulE+qRDXvcdtVHa69XTXdfsUgJq9NEWwEhCy/Y7UnFX1gtqQ
         9ttNzZ/UAi+2/0zLC1z4jLcHJBtFc5n36sDgnldgL8/UBKLavnf8IAQw/dQV5utUttgK
         Kx1KlKrK2SvYhkrlQGm0XCH07mLZv4N47bxzKfUnB0+JgpzJypn5Aaggk/pdAiAme1od
         BWDBrEgkprbYzdgRB24L+dxyxCIyvwPX+U2SjMR/ARK4UihSENHI+MU1DIkdZ9tDFySU
         HkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ywEnupIYPlj6Qgbc2SratI+CjTje6F8RjFicZ1VllkA=;
        b=kIbQqnZSWxsS5wzHvZ8lu8RmhfsZztzs+NUfbb6bp67YFRvyfA+i+URbQx+r6lXDq2
         l4RQPfFIUo8cM7cwmYM7wC99pk3WRwKrfv6Oy5RTpxbr1BmTaaUHbaEgf0DfIu1As9nG
         CL2VzcMewlFR11gkRhgg+uLw+6VQ7RLwHg242Oipfj7Yz8oUfzWpMcUDJkb/nfGBd1WT
         wvm2WfW9SGTm2bFAXUZr/NrVvZMzPM81dxoWsQuxp8tHgnV3AGJl3yQ3PUWF0aWN6uB5
         0Tfi+Os5E+MMJlTYypZpLLMuWvL6GG6LNbLrbHLTsYeDrfhttpdadOn6kA7eWTUNke+x
         83ug==
X-Gm-Message-State: AJIora/PFXu6jpVDznn7bHfugmLyl1NJFlwHJhZH0ZYnvozMNCRakrx+
        jVgKNmoH+rk2ke6it41sC4YC2Q==
X-Google-Smtp-Source: AGRyM1ul9iytSGDUCOYI73b/R1Pu7MMp5Dzp1NZ+scbQx6TNlPsqTC2uIHAzh/jZ2UPn8Mc/TD/a7g==
X-Received: by 2002:a05:6512:12c7:b0:48a:a637:b4d8 with SMTP id p7-20020a05651212c700b0048aa637b4d8mr612855lfg.46.1658829571079;
        Tue, 26 Jul 2022 02:59:31 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u24-20020ac248b8000000b0048a1a70d14dsm3115604lfg.94.2022.07.26.02.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:59:30 -0700 (PDT)
Message-ID: <ada44af6-2a5e-0b1c-8c46-3dbaae9b1a94@linaro.org>
Date:   Tue, 26 Jul 2022 11:59:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/3] Add Richtek RT5120 PMIC support
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
 <CADiBU39x98iyO_OB2sYdAUGUOW9pV4dt+mEdfquhuJVm1HDRHA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU39x98iyO_OB2sYdAUGUOW9pV4dt+mEdfquhuJVm1HDRHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 05:45, ChiYuan Huang wrote:
> cy_huang <u0084500@gmail.com> 於 2022年7月14日 週四 下午2:42寫道：
>>
>> From: ChiYuan Huang <cy_huang@richtek.com>
>>
>> This patch series is to add Richtek RT5120 PMIC support.
>> In RT5120, it integrates four channels of buck converter, one channel of LDO,
>> and one external enable channel to control the external power source.
> ping ......

Whom are you pinging? Everyone in To list?

Best regards,
Krzysztof
