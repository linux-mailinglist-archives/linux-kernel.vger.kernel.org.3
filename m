Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8882554DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiFVOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFVOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:48:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2338BE3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:48:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf9so14447452ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HH079LRyJTHmM+5gTDBKSJiZpHcFCkFjE8Gfy06llCc=;
        b=H9tP4SI9QupeqEThyhbGj6fshmasD8PmJFGVHL7k7YByj2aMUy03B5eYGHNd2eMY74
         XR6LRJmw/8PPwjk6xlbKZhXYFTke5A70dFaOHoRFyi0lz2OaJ7M18rhdJCLCZ0/wxbGk
         2nmdaSa2GBf+qpEuUSSz22bLq6H++ga00KwHWt6bSRuUt+Uza96Cg/wz38LJt466nUXu
         1WZtDG0wVI91nnt2oYicf3RRPGWW6/XnAQr/KP0pwHh9GHJjMdsk1dztKssfodFT/Mmk
         N+y7mt5XpoPQirdnyo6H5Wf8MZCeuhId3dHCXz6A3f2jGvvj4/MzDkYCRFZR8WXm30GN
         SPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HH079LRyJTHmM+5gTDBKSJiZpHcFCkFjE8Gfy06llCc=;
        b=O7zmG7yNqY4ohZpRvgI1o18vcJoN0BilmXuj+l+UotaPbNf8a4zMNxGsdVlITgeWuz
         jwoX8lChzHHDHGFsWd68r+8O+QYqFvtsFyK/76hd+VBaHLuc7oTC0RJh95Qt9UL9qndu
         zRIxBoILuW1OIKzY3mx34YnMwgfN9C66AYAbeHFJ0ia+VYQmh30296/UhMWKewpFk9Bo
         Bg7VyX9FyX44ZtNVi0hqYIF5Tulr3kXHejXbshivtB9nUUDPROVZPR0YNOHSYl3P6x0i
         EV6+VKU3ekCw5ttPkl5vTRnO7Z9edexSzQJzC6++dudJJyw9JPEUhm8gn5JJuNJk2CKi
         qq+A==
X-Gm-Message-State: AJIora+/F5rq1HDfw5cgwNClZQnrVyOcuhpxralJaNy2l/1ri9DzO94E
        g57TbTztGQI9UqnwFUJLFAoKUg==
X-Google-Smtp-Source: AGRyM1tTU8sGWhE5uoJlmgoqQlCvu0Bo0iKSowkNVd8F9534/qg8dpEzj0RucSD0a2PdldIeeIU+3g==
X-Received: by 2002:a17:907:a427:b0:71b:6f0b:8beb with SMTP id sg39-20020a170907a42700b0071b6f0b8bebmr3434300ejc.496.1655909323287;
        Wed, 22 Jun 2022 07:48:43 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gg19-20020a170906899300b00715705dd23asm9286292ejc.89.2022.06.22.07.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:48:42 -0700 (PDT)
Message-ID: <fbf2251a-8df7-7bb3-bfda-8359b6d151be@linaro.org>
Date:   Wed, 22 Jun 2022 16:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1655892104-10874-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 12:01, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek RT5120 PMIC devicetree document.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
