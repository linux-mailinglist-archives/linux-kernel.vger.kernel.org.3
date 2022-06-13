Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22754A153
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiFMV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiFMV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:27:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E2F1C100;
        Mon, 13 Jun 2022 14:18:08 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b142so5032370qkg.2;
        Mon, 13 Jun 2022 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O/5UX5Mk+dXZyLsI61qHLtFZfA+oRgShYdgS9qh+0KY=;
        b=bq+BZvn9NAYrL6o/8IEk69EzQ759NN6pPn0GcdbyT/U+ZAOIdHxjN10Xqi4wyRES4P
         81qFlyUQx2RfJtiu4K4XYUAU8zspZvGkeywU/HqGDKhlRyosRxbhhCOUqx7TFjwyoiAf
         LvvVxytxAtR3IeRVIaF3h6+ZiD7ZGDr1GifwdOhQFcbF68681ehaaXfCmMqlPbOTFGve
         T5c+EcemztZ6Zeqq8N+uh5K+mGdAITCTCVbJlLg5ag3FAbwHlHKzGUhdvpj5ENVOkq0o
         ESYfHrSYZlqRm+A2P4tf9X1xzNnUwr+rF4LayhdrLbZ4G80eXjYAtgcdNJfJP9Obe5LY
         xwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O/5UX5Mk+dXZyLsI61qHLtFZfA+oRgShYdgS9qh+0KY=;
        b=XvKQxN8CZAUuVKLN1gJLowAMgx+nrCZK6CcddQCOA18AyW61Y5ZOj7juH+HeyaCi/g
         5JRWmDIizzOUFHW41/TjlsyBIayLue0AxOlilFpE4Zonc7J6H9u0KZsIZnB4snb3+t1M
         idZJB3koHJTuStPrHh79BLMCs7/EbrYtDyzg6eFNCWDzMU+ITuzOQK32oz/xq089BRhV
         MDIjo9iSf+cI25o3WHQ5i+LPXXDidCw9TTgdZ9cj9Yli/ViZ/Thy3LOh3NrMsPmm5ojd
         oH7cfkJ9f8imn6FGNR3kMQXp9Ep3/VtsLrM8b0i2Bwzf9XUrzQGjv8ehNcAzmyoKw8Zn
         hoyw==
X-Gm-Message-State: AOAM5327+gn+PU0cvU59DX9jpSjC2v8ApwFn0K2fgsq6TvJk8RTlDIMY
        sQ4diR45LjOW8ajE29mgVlI=
X-Google-Smtp-Source: ABdhPJyopfILhkCEnMlw/+uoj4P644qCBNhEu5A7BpV+/ncZMc3u7zAqS/nkFyvzrAPU0+6gaW1I4Q==
X-Received: by 2002:a37:b481:0:b0:6a7:6248:1332 with SMTP id d123-20020a37b481000000b006a762481332mr1678927qkf.622.1655155087362;
        Mon, 13 Jun 2022 14:18:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id br30-20020a05620a461e00b006a726b03ad1sm7671223qkb.52.2022.06.13.14.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 14:18:06 -0700 (PDT)
Message-ID: <9f60a2d5-d3dd-5732-4c2a-4e249e702a72@gmail.com>
Date:   Mon, 13 Jun 2022 14:18:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] arm: bcmbca: Add BCM63146 SoC support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220608180100.31749-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220608180100.31749-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 11:00, William Zhang wrote:
> This change adds the basic support for Broadcom's ARM64 based
> Broadband SoC BCM63146. The initial support includes a bare-bone DTS
> for dual core ARM A53 with a ARM PL011 uart. Linux kernel image can be
> build with the ARM64 defconfig

Series applied, thanks William!
-- 
Florian
