Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4255546F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352979AbiFVIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353546AbiFVIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:30:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F65010BB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:30:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so468720wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ms/HKnagjpWOkTSuqrlOB4okpfVHQ9DTgJbAyIUZ6V4=;
        b=K3zDe3mPlB00MLjcFS42DXpYKYf2TVGmfQ3L8zKJgwUqbSXfnDPEcFBgyHRdKgDFXF
         WsBAZWWYEX5jzyiDDm2DMpIeXWkjx2wXt1wdHGcP1VnWaUH6spt4wZgKC2TH4MKD3zEk
         P6R8ZEcEvYlrKyuRH8sTk5ZjWNmP1jJlFyASryr9LldFHKLV+LGX4VK5+Zpsz26/P0DP
         rQ+v6cEdI9WP0jooa+fkrx2UUO/Xc9m9qkXW85yLtRb7mcw2ENOkj3tRu+O49LGOOJd2
         4S9nLF6lqzajDSNtiTff1JmVj8JKk5UTIKhFstK7gzzcwlJxt/WoKitTHv0ZEUjn+o0r
         4Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ms/HKnagjpWOkTSuqrlOB4okpfVHQ9DTgJbAyIUZ6V4=;
        b=q+a8X1Lfv44owFunfhPSF4wyb6LVCZLrzA01L45i3XZroP9Tt4Qw7CLkuVGIXmpJPa
         uEhFmU7P4jnfQki30nbtJ6nJJW8SCp/VosJSK0LMiwZEzJXCmR/wyqVmlxLNdx0X8hF6
         C7haNlQ+PVAQJp1cw+L4JhetK+A1kktHpvvynwwPn9bd2D8HGNFiArCUzRibnEF4mfn1
         gtPGxHVTLPXo7shg3Rn7keYxs4Y/fh2cr4yNUV8QByirNFUI0zofV13zoyUH9XyHUJ77
         ZR5SyMHAL8k2CsfaMo5+2+fF1lzbRZGMWX+lX0SbEDAKLDpYOQ8GA3rdXixeo63gnFrj
         2MAg==
X-Gm-Message-State: AJIora9qABYN89gkweLeR2g8Mjdm82Twrno//HcHsYIhjSOp0ojycnyN
        9azNeopFCU98g8MCfb613NIFZw==
X-Google-Smtp-Source: AGRyM1tQ7QLdivgUmT4kY5FU+N9htHIPI5XIgL1dnBJAH1mNMWUvvNWGHru4x1XpllOOMXFcFsPe2Q==
X-Received: by 2002:a1c:44c5:0:b0:3a0:2ae2:5277 with SMTP id r188-20020a1c44c5000000b003a02ae25277mr1741579wma.30.1655886627887;
        Wed, 22 Jun 2022 01:30:27 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d620c000000b0021b866397a7sm12912224wru.1.2022.06.22.01.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:30:26 -0700 (PDT)
Message-ID: <0a35d997-7e7e-8847-7c87-edd33719f7a3@linaro.org>
Date:   Wed, 22 Jun 2022 10:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: adjust whitespace around '='
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220526204248.832139-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204248.832139-1-krzysztof.kozlowski@linaro.org>
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

On 26/05/2022 22:42, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Output compared with dtx_diff and fdtdump.

Any comments on these two patches? If there are no objections I'll take
them with rest of cleanups.


Best regards,
Krzysztof
