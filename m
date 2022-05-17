Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35363529C29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiEQITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiEQISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:18:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C574048E45
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:18:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk15so9655892ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PMmKxe3WgBWgmW72+NDFsBAaWr7pVUMq7IT2EOFj9rg=;
        b=DXyvSIi7jXgAcG84j0dtTQNSoDlJIe40zgLupS5EpCO8insL1A3QKtDr3G4YtYNT0b
         DpWn3l9GGUDYHesxAFO73sqFKLaDNKK7YLJVzLAY2gm9j/Pn1W1/yJiSdDE+V6VfEawE
         7BvCwhDOBjFde5UyiZ36odZNjDdhjBsz3aadbnvIo0gAPHwVU7yPNYeTJTJahN5Cedpy
         jn9ZlDycZAV49AIAkpAbSKCBFgYK0W14EVxWZAW0RFl76wBEJBgH4xXOT/qDJt4yioHs
         hg5YQn9MV4XKqILR5+vGASilGUivZSB/j/My7a7ImeJAoINREVLPuN/Gsn8IxnhALlPp
         IsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PMmKxe3WgBWgmW72+NDFsBAaWr7pVUMq7IT2EOFj9rg=;
        b=NRjvzBfCLDq5YMIq51oUkvRVe+5Ow16Bw636euMLpaUl/Yz4aUeImSabO4LldveUzp
         puistWbQesB7Wx3U2152pCmlZOnK5SSr4O3CpkHVYUOOHF+1Bd5ajlFw7lLIdCPGqbyr
         RYiNsADuoKBTRAKw3GZImDbyIl6Cg27bYy6TPRxJPqp/Vpfe5HR45b2I/XZcrxVtlUUQ
         ZNpDgQheH+/3aY+hQXLItpTYPste2P5HFF09LqK8Efie82a7EBJC25+uJ7HdboxgtcNf
         YR6Opt9GPjHIqaAmPP9WbWPB8ounjWArUGoiGtmxrinQb48SR68g2nFbp5Zrz21XhtR+
         AKRA==
X-Gm-Message-State: AOAM532EKzKoGNT2NVFsGJjqsLFygX//Ezd9VKGZbU/h/nVxyJFGhAWD
        Ktq5PXbZMBbCrkBwqfUB4zOikrCSgOJWq3Sf
X-Google-Smtp-Source: ABdhPJzrBCibM9RMlaxwEZZmMm1yEb5wWtfOTQfHuB6kYMrz6tNnDZq7nVne/1DF18nq6iRbJULiXQ==
X-Received: by 2002:a17:907:1b14:b0:6ef:a5c8:afbd with SMTP id mp20-20020a1709071b1400b006efa5c8afbdmr19134421ejc.151.1652775520403;
        Tue, 17 May 2022 01:18:40 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e9-20020a056402104900b0042ac0e79bb6sm1345467edu.45.2022.05.17.01.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:18:40 -0700 (PDT)
Message-ID: <626d3f67-ae15-938d-ae87-e111b83435d0@linaro.org>
Date:   Tue, 17 May 2022 10:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt6795: Add fixed clocks for
 32kHz and 26MHz XOs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
 <20220513171617.504430-6-angelogioacchino.delregno@collabora.com>
 <03e99a02-1233-3882-e1e5-24ab1bbaf257@linaro.org>
 <0f303425-3b12-7573-b201-030d4d044db8@collabora.com>
 <d78e1936-a0ab-663d-1381-b537bfd7f07d@linaro.org>
 <32c97e47-47a8-d033-4948-3c73a4313703@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <32c97e47-47a8-d033-4948-3c73a4313703@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 10:14, AngeloGioacchino Del Regno wrote:

> Right. If external components are strictly necessary, physically, they're
> still external components and not inside of the SoC, and anything external
> *may* change depending on the (hardware) implementation.
> 
> Anyway - I was wondering if splitting this change in two commits would be
> better to let people understand what's going on... probably it would, as
> that would clearly show both the addition of the 32K/26M clocks and the
> subsequent removal of the other two: I would at this point do that, what
> do you think?

Could help.


Best regards,
Krzysztof
