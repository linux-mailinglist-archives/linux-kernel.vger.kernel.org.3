Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303EB4D5F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347808AbiCKKXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347806AbiCKKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88C1BFDDB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:25 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5CAD3F1AB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646994143;
        bh=DAVriWfMGPTsL+sa6ojmwlvAcyFDQFDnBsePZn4gJvo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Cm+pKngf2fuWJMYP6j8t3CY4VWz4TWkC1R9cnQZc2o48Ij0ywLi0skdpIWe8VpEXv
         XrDKS4q+1c41MQHfzSJJ3Lo4m6QOjLuKYw8tiC5hUxukZV2+rJpuiW5ABWaA3IL8ot
         cZYg4viBJxxvww2nz3BWtqidIma7t2+KrX34ATVSl/J9/4cZ6wV4XIyI1snJK1Jk4F
         JfYN1jR+zJHM9fxwHut6aQKMpP3taYYsTvMRT7iDq7ae/t3KNnJ1SFTlhn6vHUFala
         ciTYAwQ47067MRoqBAJ6Ld1qzJGIi3L9Hyr7iiXPKDPNUtyVxa9Pk9kz7liCf5V5LB
         1zqk9zjx3VJXA==
Received: by mail-ed1-f69.google.com with SMTP id x5-20020a50ba85000000b004161d68ace6so4617004ede.15
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DAVriWfMGPTsL+sa6ojmwlvAcyFDQFDnBsePZn4gJvo=;
        b=PDB6Gqo24tt5bFhv9N1DhI6YheZ7sxJ75+XmqFnVSdeHrQjDsU9tshRlZIKRWpAS4K
         6OxS+RMK3i/swmF+ajvvtPhj/a9tZAxqlUxVqZ90HMDPOsriA3IJiEgVDFQ4mwtTehMY
         Kj+4QqEwz8kntt74epRxkWCkFajJyynYlc44Exo6eyVidDFASttgS/M6IAeJMKlnMfAT
         ROqvTGmi0XdJiKVoWYB6yI097urcqwIAi5WnLzqlwBnqwUkr2MfgYWYqZ+ML97KuFvVI
         eHzUcOMEAdMSmN3FvxdO1npf6BFWhpXtcbNDsc7ZQEnNoE9zQfeVkbmNwDGL+NilBzKT
         l40g==
X-Gm-Message-State: AOAM531XjKA/al93J7iLVNZabqOAemMtxVvkvRZAlaNPB1zLL9EsAm9a
        sxFN7oDkyPFjZnt7cFl58weZm1oyMAOg7cS9qDJlMKiHrNZigBuW8Fso1KpUcqkfP5eY/KA+OYo
        mqcfNTdpdTNFQWbnNTuQzJrN11Bqnv+njOPDlT73zWA==
X-Received: by 2002:a17:906:c114:b0:6d7:1065:a8b0 with SMTP id do20-20020a170906c11400b006d71065a8b0mr7821352ejc.181.1646994143556;
        Fri, 11 Mar 2022 02:22:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3HrnS+Vr6tGo6Ytf/3Yw1utrhk17vjWI3t9FZffF20NXSb6KlReOoQp/QOKavg1BVh9Mrtw==
X-Received: by 2002:a17:906:c114:b0:6d7:1065:a8b0 with SMTP id do20-20020a170906c11400b006d71065a8b0mr7821333ejc.181.1646994143309;
        Fri, 11 Mar 2022 02:22:23 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402254900b00416b0ec98b5sm1792227edb.45.2022.03.11.02.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:22:22 -0800 (PST)
Message-ID: <679cb1a3-28fb-7031-ecc7-5f60266bcf7c@canonical.com>
Date:   Fri, 11 Mar 2022 11:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 08/10] dt-bindings: arm: Add HPE GXP CPU Init
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-8-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310195229.109477-8-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 20:52, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> This adds support for the hpe,gxp-cpu-init binding.
> With the HPE GXP initialization it is necessary to have access to this
> register for it to boot.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../cpu-enable-method/hpe,gxp-cpu-init.yaml   | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml b/Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
> new file mode 100644
> index 000000000000..a17c3fcc5421
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Initialize GXP CPU

Please explain what's this. The bindings describe the hardware and I
cannot get what is this here about. Is it a CPU enable method (like in
cpus.yaml)? Is it some power management block?


Best regards,
Krzysztof
