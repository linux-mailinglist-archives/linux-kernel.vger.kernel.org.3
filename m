Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1107057CE02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiGUOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGUOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:44:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD08689A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:44:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m9so2077320ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FMWEsxHpInJ1xz9Gs6AtvSkVM4GO31cBlC1zLGqoQzg=;
        b=tjJLv/UGjfvQJpvCQ33RuE6X0s3x88e32Phfvp0hTB5CvyJTNfViQdQMJZjgJr95RJ
         M1DhIFGCYV8S4RKnxt5Jv7SvnIEZJmZNYgPrSJSYnvCJtipTTNkSCqIzV3Bp/GXFc7bN
         2bh1G4BvwlmBGppJk+Lew6rYmlR/nktEiX7S2AFfFdkM75T2xdwesadxT4Z2oXPm/XNh
         asX65DPb616tMln9yU1TlNSpJ/csUBQleESxdeop7PVjkzFmMBtFgEVnXCWm+EL2C13n
         TotNrFrbcYM19moIdyMenDbbNlC4VVh+lw07G+x/SN4yUze6MpNfqae1wt4ccQ4/KUOU
         WgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FMWEsxHpInJ1xz9Gs6AtvSkVM4GO31cBlC1zLGqoQzg=;
        b=TIzV/E9MPcMPSQI3z/8w8Q/BgnTdpHTrwE10HAlx5q04Y6jYzUVEN0hKxvn/EsXZxQ
         hKU0YOsDMnppY1VKITV9A31Jw0CAOgSxWQ+etz1xj9QjUpannk+KsuizeGN4yy1VnwYv
         60H7pedy+dHasggq3RRu3W/2Z87GnPBIXWYkAfdMyCEov6/gCStae11ue+aNqRDMljUI
         vh09vVL4T1GhxaFMdUSj2OU69PLXoUO6yeMsCgI6xjVs2D7ljZ0KJHqfGIdq4OAq3F6C
         skmVXRbBBoiH9a2TF4DP/rVYM4Gf7kjVejWEQbA3nHrBvRXUVncJMVZRZm1MWgKWEBzy
         yyWA==
X-Gm-Message-State: AJIora/DjTT7mLSkcuNhKqXgYUzUQwEup7EOHkCwhiyLs1MMQu+55572
        SoIHbCdZ1EAtsdP8Z2agVZpomw==
X-Google-Smtp-Source: AGRyM1syJRz5lw19BNkewuiPYEzwKNI6nibJa7ejYlb/nifC90WR3tPIgHeEmuSlf60Y8XpXN5pc5A==
X-Received: by 2002:a2e:bd89:0:b0:25a:86c8:93ca with SMTP id o9-20020a2ebd89000000b0025a86c893camr18419288ljq.419.1658414682866;
        Thu, 21 Jul 2022 07:44:42 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id i8-20020ac25228000000b0047fa02cd96csm479673lfl.162.2022.07.21.07.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:44:42 -0700 (PDT)
Message-ID: <35639a59-4a3d-5aa7-946c-22fbd2f25e89@linaro.org>
Date:   Thu, 21 Jul 2022 16:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: add pinctrl definition for
 mt8188
Content-Language: en-US
To:     "hui.liu" <hui.liu@mediatek.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     johnson.wang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220718113813.23787-1-hui.liu@mediatek.com>
 <20220718113813.23787-2-hui.liu@mediatek.com>
 <b28dcbe5-d15f-1c4f-9b3d-650d5c39de6b@linaro.org>
 <08a7209fe198839093b3ef729fc97c1a950e1fbc.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <08a7209fe198839093b3ef729fc97c1a950e1fbc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 15:46, hui.liu wrote:
>>> +
>>> +          bias-disable: true
>>> +
>>> +          output-high: true
>>> +
>>> +          output-low: true
>>> +
>>> +          input-enable: true
>>> +
>>> +          input-disable: true
>>> +
>>> +          input-schmitt-enable: true
>>> +
>>> +          input-schmitt-disable: true
>>> +
>>> +        required:
>>> +          - pinmux
>>> +
>>> +allOf:
>>> +  - $ref: "pinctrl.yaml#"
>>
>> No need for quotes, especially that you use different here " than in
>> other places '.

You quoted my entire email, where is the question?


Best regards,
Krzysztof
