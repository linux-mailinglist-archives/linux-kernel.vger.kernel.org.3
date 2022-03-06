Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC24CEB89
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 13:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiCFMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 07:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiCFMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 07:25:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E028D6BDCA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 04:24:59 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B63233F1C5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646569497;
        bh=ebLethXkP/SPKAvNmeAiw9LSso9GlAEBRLvcMgBoFxs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Dz90mDYEAulSEt8DRVD4m0p3Dv5Dml3lL2FAgGq/GZXj7LQ6rHDazcigtvRKIe/pr
         ix2wB7T5I+nER2LE2PO3LCOdNmlZ1qwJI4viyj8KbZCa3c0RlJeoh45Jtn5hXvq2q+
         LE8+rZdsZuvj1INK+Lu27PLQSso3cmqkAqf4+Ess/MRv7cBUQJnSyqYXL4ruqV0wP8
         WGjT0iudZ6Y51r9gpZUMaT7Dg1As/TcLDX3nnNyFcj4daLScX5iSwoxj+Cejp/hd2Z
         t/BM7byaoDv4JahyOQd++xbuWBVX95BcfYRfIxS4sFufNW0G1rIdYMvSIBhjCfyV6s
         KYlLzUaaHRXig==
Received: by mail-ed1-f72.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so443678edq.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 04:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ebLethXkP/SPKAvNmeAiw9LSso9GlAEBRLvcMgBoFxs=;
        b=pHnhk6jc33r3NcfY8Z9Q2+CF4YSAzemZAu3S1+Tcpf/103Dsimupgx+XTNLfZZtWEs
         F6qgmTEtKzShLlNtawmyVQuQSJBA0ghZKTmo6LczGgJQnzFZV/kmb1a+7oLAGeZ1HcUe
         KgEpPGPsIR+RDXlFiRWg2/ovL2pD27LMIzm9KBfWgnbp6I+0HKbgZdEtQJmSUYTnNBWe
         w5Z+W56stcy7yGBbi2E+uw3wyKi0mDYCiZC3JDVlxkseEseC1OfRZ8+3nI3zCyjLZ4z7
         t410iRFDmz8mCHpyAcBuLPKFJgRUWtMgaYawCt4oqfV+SoPA/uh4SGMIU9wGGvuuSZYE
         ms6g==
X-Gm-Message-State: AOAM531M2wa+DtZbbyraWB3FNn1Ko3ALfM8sQ+LgLqRaSNcFhNidC2f9
        Ko5F5abZzDfC2N3fWA4sYMVJT59HSngJZ9Q2eoiSKpR5Cm1H4HDpqKnFCdLBWoWZ5BhA0Bw7YEK
        kzVk1U/DsONCwnq8Xdpp0hhsOWHGdwf7RzRsbCbtzlQ==
X-Received: by 2002:a05:6402:16d6:b0:415:ed41:8606 with SMTP id r22-20020a05640216d600b00415ed418606mr6771748edx.12.1646569497396;
        Sun, 06 Mar 2022 04:24:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGdkRJrJd5r49weJN8iJ+8MPgRizzkUtShktIIdhfalsq93LL/I1ZmB0Oe3EKICul07WDm9w==
X-Received: by 2002:a05:6402:16d6:b0:415:ed41:8606 with SMTP id r22-20020a05640216d600b00415ed418606mr6771736edx.12.1646569497186;
        Sun, 06 Mar 2022 04:24:57 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bq23-20020a170906d0d700b006db0372d3a2sm1506242ejb.20.2022.03.06.04.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 04:24:56 -0800 (PST)
Message-ID: <135e9f87-7c39-e2c0-1735-dd814514a61d@canonical.com>
Date:   Sun, 6 Mar 2022 13:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: Add apple,efuses
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220306121816.70537-1-sven@svenpeter.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220306121816.70537-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2022 13:18, Sven Peter wrote:
> Apple SoCs come with eFuses used to store factory-programmed data
> such as calibration settings for the PCIe and Type-C PHY.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>   - fixed indentation issue pointed out by Krzysztof Kozlowski
> 
>  .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
