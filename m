Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D555B2F7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiFZQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiFZQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:47:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEFE026
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:47:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z19so9939033edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hoftpvw15r4xLbRsERYjJkiajYv1XuOe4uhEcNHqoG0=;
        b=VkwAckcR6E6DlGj1MoZbY9ocbM2AR27Jf6bTbelhqn3Jgli15/4ChBhpanVoUfvyZy
         0yOCxZpqFBOpzH+h/NyF6LbZO+2yF4IeAzkPd9WFkfbBktBwr5ClvsKOmRYQ49mjoRbB
         mSFszxIXj0Xts0WEjbiheD6LKwBXpG0KFTDXOw3FW+as+4Mdf3NZ6JdmCCXP2x5DPWvA
         Zh3SNYg5UIeWLiokJ/6eP+WpWSxdXuM3LnnhYgP4A+YsKc4Z0Ry/ZsEO0RZwHmJCzX8I
         vtqq1zo+XTZyxFeZvqGjGmPajJQIi7qt71MdHX9OX1sGIuys5x/5hLzNsutYkCKmISTo
         pKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hoftpvw15r4xLbRsERYjJkiajYv1XuOe4uhEcNHqoG0=;
        b=TtxM8dL7duR28i0kW077bkCrBd5AqKwfVr6lXaTSiikNZJnPLU3ha4BjIsYr1rQDkp
         o6hdWbWK5FpDrQMFIblP3fkRY1MBG3xvBKLJPcjUQpNbiKk9q0UdLRKkI5hzdAmzRqQK
         2nqpsL6s+rDzzjVFJUztBZjUjTuNTy+e6d4AvsHDJjPqMOG5ZjOu29aaP350U+2tLxl1
         7zRkXYNCU4Gn+csOZPrmSdNgUwcWMjwFkR+wf0TQMstRcTw8Q7BUTHsyhxdCYEvHtRbS
         lDCMMHaq1E8lpM0bJLvxhQzk0xRxxM1L8SaSvbpY5LGpCY/zl8bBL83x2lzu01Vq8hHt
         8hAA==
X-Gm-Message-State: AJIora9srszvYK0pQRaeMnNXJNjcfj2BLSadAIoJujSARt60ShkvoCxU
        /cZNSTY1JGSTMDL12z7OlQ3JMQ==
X-Google-Smtp-Source: AGRyM1spjqQikKcr//dZIj337t3qRWtVqkWz20h8CsT4xdJMnBLaBLTFvYwyNlCukgPMZjSTmgXw6w==
X-Received: by 2002:aa7:db46:0:b0:435:676e:c138 with SMTP id n6-20020aa7db46000000b00435676ec138mr12056299edt.388.1656262035139;
        Sun, 26 Jun 2022 09:47:15 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b7-20020a50e787000000b0042ab4e20543sm6196814edn.48.2022.06.26.09.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:47:14 -0700 (PDT)
Message-ID: <4c3b66ac-2bc4-996d-445f-75afefe1fe22@linaro.org>
Date:   Sun, 26 Jun 2022 18:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document lg,judyln and
 lg,judyp devices
Content-Language: en-US
To:     Stefan Hansson <newbie13xd@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220626164536.16011-1-newbie13xd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220626164536.16011-1-newbie13xd@gmail.com>
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

On 26/06/2022 18:45, Stefan Hansson wrote:
> Add binding documentation for the LG G7 and LG V35 smartphones
> which are based on Snapdragon 845 (sdm845).
> 
> Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
> ---
> Changes since v3:
> 
>  - Fixed changelog location
> 
> Changes since v2:
> 
>  - Rebased on top of
> https://lore.kernel.org/all/20220521164550.91115-7-krzysztof.kozlowski@linaro.org/
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
