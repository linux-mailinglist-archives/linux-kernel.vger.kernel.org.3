Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EF5500AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383652AbiFQXWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiFQXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:22:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BAAAE4C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:22:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q140so5219831pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BZYFg5kiVhld2lAiBUaa0ABgAdKIA/3yLwoH/l48Ndg=;
        b=NM+CS8TeBLIzD73k6jDvxl8r2exFRyI0AzyUwqtQyY5Wrvn1EyVhBCPZvU3RVlLVCL
         GSing4OzXKnQ03Bpr5gjk50qCE3f2yqUooD5szbeBVu0eLmDF1PODhmYzFtORs85GH00
         2ni+66TgRxjJd/AnMFXdWrh/ILBHI4HYllfWPoeYqWfwajWT691jOqAHyKRM7lE3TgHz
         ca8Q+PUepWAkNOEIe1e72DrJXCjDSwHktQAXPLeIgHIJYVFU9zO5bhMQSmrS9NZLTkhm
         5wABOSDPoI7BqC3TRTPgqGgWT5WAqMySxDuiy+CRpQLVSWb22679Fr0mMy14D9t1pj1y
         U5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BZYFg5kiVhld2lAiBUaa0ABgAdKIA/3yLwoH/l48Ndg=;
        b=H3xaYGTTLIhciAsxR9s/79dP/m5mBc7FYiKsv7ByYioXS/4cMc0CjdIvyhNM3+eeWo
         uVtrenn5GT5gnjyMou9sgkEyZPh2qTt5f4Yblam6/3bJrKoQEMbRtayd5Gd1htH9Hdrx
         nH3neerKkDUpZ09Huek8TzYx1ztP35LN/Jh56Tt4x5MTwGQoOg08mVHvgynJBnrYTlgk
         Olq/6fzj1FZi94URVvx1gpVnpQFE7Wkp3UkeDeocN14JpBiPyWiHzdSWkoc76P5xBGgJ
         DF/nVoDY56L8L8YmZP4OVhNGawBfu8i0VWNx4jSZw+oNHwU/TMQxJX988muT/pqQRTam
         sG0Q==
X-Gm-Message-State: AJIora88/4RKwEkGpQijhvZlzPJauW6UZQY9mpjhe2NeOd+fjeqEcj+4
        XqWLfXMBp1gIVNqBdKjZZBmthQ==
X-Google-Smtp-Source: AGRyM1u2gXb8MDp4KfFCqq5UNmC/0QyElHJ+3n22NkWBoduGn8VHO24rY5m3NjNte2yGRFcMtMnZ1w==
X-Received: by 2002:a63:6bca:0:b0:408:897c:3fb8 with SMTP id g193-20020a636bca000000b00408897c3fb8mr10798602pgc.576.1655508161648;
        Fri, 17 Jun 2022 16:22:41 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902760800b0016223b5d228sm4042218pll.288.2022.06.17.16.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 16:22:41 -0700 (PDT)
Message-ID: <834af774-ecdd-1929-86eb-6a814c5d774c@linaro.org>
Date:   Fri, 17 Jun 2022 16:22:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt7622-rfb1: remove wrong gpio-keys
 property
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617232124.7022-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617232124.7022-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 16:21, Krzysztof Kozlowski wrote:
> gpio-keys (regular, not polling) does not use "poll-interval" property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v3:
> 1. Correct commit msg (Matthias)
> ---

Eh, jetlag hurts the brain. This should be [PATCH v4] in the subject.


Best regards,
Krzysztof
