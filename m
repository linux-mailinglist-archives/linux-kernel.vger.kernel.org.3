Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859BF4EB2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiC2R1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiC2R1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:27:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7EF18EEBB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:26:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so36542747ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=16O1OMAfhlCbCfBLXhj0uiBE7+Ph4Xzv5BL186nDdEE=;
        b=Iz0gFt6SkMM/Tc1oKY+iWeHB+ZZzVCBhie9aFJTmGMcAo9i/HuFW8csLVXQUFouF7i
         sODn1lkzn7fEu9q/GWTsROihZlk1uPShwi0QMfkhbopw6GToZht6UVCbVifHRhRZJ7NB
         pslFxBjNnSP7HSaOmFfJGSTrQfUU+bs3n4vS+S7HDqxOlIwthiEQnI3UKTF319vYLHmo
         weXVxF9pkizeGsEBh71hKzQz20MJ/aHwGGypCtIjcE018sPWX4agTh5FLy0ed2PZmEPn
         U6ngoOrUZBCJPLjvHna3xjRPh0QQZfMUzSS6HSLs4yBE+Ej6pMMiZiDebkc0cr/N41+7
         COsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=16O1OMAfhlCbCfBLXhj0uiBE7+Ph4Xzv5BL186nDdEE=;
        b=c2uHpH3SYQ0d0yCdxW4Hq27K/MWF4NIom6KARVCk36L4/82X/v3nKAD9XqFQ330FU0
         q+ZC0v4UbYLjzx7CgP997ePYJfby+S2EE/Fe4jLtIsGUjtoh/RDmuS7W5MWp4osvt3rH
         6FFkgm1h41Et6vh8XyOBU0cdyv/Wz6XTvAaklHYHLyBe/VsFRJTIvV+aSVOv2R9zNN+m
         ul3NFwUQY9HpeEuCaQUkFKgJlyJEt3y01UZmyL4IUGGboaMOCH9MqssAfqeQ8GiGqgAF
         3wQtvT71iDGKQz9n41gY6I6kRZyKIHHVmk11rkB3MyQtb/Xhspf9tL2nwCz4jd+9iQA+
         Y4Ng==
X-Gm-Message-State: AOAM530/osvrJqf5nGg+5Fca6NPW0QokycoDwdEEynfSyrfGYTOd/tEh
        VGlLOAlqu+trr9SO+Ikf//tYHQ==
X-Google-Smtp-Source: ABdhPJwO9YuESjI9rToeZW+DG0b2tF5pOXo1HOsOCjNQL+mrVjMKAMiXxYXUoYj7xy0+X+N5MP2kCQ==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr35881835ejc.712.1648574759076;
        Tue, 29 Mar 2022 10:25:59 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm8772042edx.58.2022.03.29.10.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:25:58 -0700 (PDT)
Message-ID: <403f831c-6a19-8ede-9dfe-6b033d1292b4@linaro.org>
Date:   Tue, 29 Mar 2022 19:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: convert rockchip,
 rk3368-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329172120.30328-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329172120.30328-1-jbx6244@gmail.com>
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

On 29/03/2022 19:21, Johan Jonker wrote:
> Current dts files with RK3368 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3368-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:

I see you are on a conversion spree. :) Thanks for the work. Please
shorten the subject as I proposed for 3328. Also this "Changed" and
"notifications" are confusing. There are no notifications here.

This could be something like:
Changes against original bindings:
 - Add clocks and clock-names because the device has at least one input
clocks.

Best regards,
Krzysztof
