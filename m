Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD74F7850
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiDGH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiDGH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:57:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723811434C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:55:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d7so5387051edn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uWgB1TPWrG17Im7IPZMnLsPtOW+zyWLCGeaLXICJLyk=;
        b=rqgldnAzVueo5sDBj0XN11SiGwiV3OIN4Fqm3AYvyt+IRI1LjUacj9rXLO6kHazqsA
         piNOEs1wHY1jdizJV0YvZ1PyOLysD3AO4RqQGiepnSmU4t+t437qRGzr2ZOgwDLNLzwM
         Bcchvq3w4saU30mpm1HLJgrlSttDgOUSWJ5ht7KvI5e5PntidMkdODobYOvN8PGt9w6M
         uJXZgtAhuDZ2REFBm5vzYlcMa5ihnyf2YfBudGwJoZktsFaZbJf5lFYGtA7MMsd3hEJD
         3lwM/icCIiOlpVQFF0IzFuzkQohsS1DnGDXYfJG6/zno0dI+PXrKPRcfHL/IMK24o4mD
         JpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uWgB1TPWrG17Im7IPZMnLsPtOW+zyWLCGeaLXICJLyk=;
        b=fAgRm/zb1Ip9oU9dZcEkqZEhuCbge/yC2PeLaG3T4bL6C8QcgjQnq8y/OFsV+iiFmE
         E+uoExl5iLa1ihilyCfmXFqYpaSIE7UjkKS1AivbVv09dlScwL7C5CnjGu7OAkEDu5Pc
         9Yfzvc1U469l58OKWK7GSnKovd0QBFwlSy6gCVDnXSxlmNFPOJ4RmXjajwVU3B8bHJje
         auxYKXj1ZDUqtYYP7Ncw6A7RBQuybLq9sMY8a0u2DfJZ1H3CYGM0MVp1yFv57MrAbf2B
         fDLzAQyqUPr/cxN7B2fr6LADPoPxEypNEMZzHS+5KsHa81qB7V9muwZNxrwVrd/eUvCJ
         A8ig==
X-Gm-Message-State: AOAM533luBV8wIoZQDW/ietTp0NYqJtcThUgpI/K6rGxGJjDh+uDUHTI
        9VIIwu1WEH64QJodXxOgkWZzdg==
X-Google-Smtp-Source: ABdhPJy/47fiNsQ6b10hGrkNQmi52hrmZo3QD/pTkUnCM3VFv1gV2ZTqhrM+rp2O/ww0tg4Cs0KmKg==
X-Received: by 2002:a05:6402:268a:b0:419:e9cb:f62d with SMTP id w10-20020a056402268a00b00419e9cbf62dmr13051173edd.194.1649318123332;
        Thu, 07 Apr 2022 00:55:23 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id za11-20020a170906878b00b006e7f5d17d4dsm3994155ejb.140.2022.04.07.00.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:55:22 -0700 (PDT)
Message-ID: <e9e3a689-fafd-62e8-9e17-1f15445228cd@linaro.org>
Date:   Thu, 7 Apr 2022 09:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: soc: ti: wkup_m3_ipc: convert bindings to
 json-schema
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407032208.2249485-1-dfustini@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407032208.2249485-1-dfustini@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 05:22, Drew Fustini wrote:
> Convert the wkup_m3_ipc bindings documentation to json-schema.
> 

(...)

> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml
> new file mode 100644
> index 000000000000..04ed5ada1d28
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/ti/wkup_m3_ipc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wakeup M3 IPC device
> +
> +maintainers:
> +  - Dave Gerlach <d-gerlach@ti.com>
> +  - Drew Fustini <dfustini@baylibre.com>
> +
> +description: |+
> +

Remove unneeded line break.

> +  The TI AM33xx and AM43xx family of devices use a small Cortex M3 co-processor
> +  (commonly referred to as Wakeup M3 or CM3) to help with various low power tasks
> +  that cannot be controlled from the MPU, like suspend/resume and certain deep
> +  C-states for CPU Idle. Once the wkup_m3_ipc driver uses the wkup_m3_rproc driver
> +  to boot the wkup_m3, it handles communication with the CM3 using IPC registers
> +  present in the SoC's control module and a mailbox. The wkup_m3_ipc exposes an
> +  API to allow the SoC PM code to execute specific PM tasks.
> +
> +  Wkup M3 Device Node
> +  ====================
> +  A wkup_m3_ipc device node is used to represent the IPC registers within an
> +  SoC.
> +
> +properties:
> +

Remove unneeded line break.

> +  compatible:
> +    enum:
> +      - ti,am3352-wkup-m3-ipc # for AM33xx SoCs
> +      - ti,am4372-wkup-m3-ipc # for AM43xx SoCs
> +
> +  reg:
> +    description:
> +      Contains the IPC register address space to communicate with the
> +      Wakeup M3 processor

Just "The IPC register address space to communicate with the Wakeup M3
processor"

> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Contains the interrupt information for the wkup_m3 interrupt that
> +      signals the MPU

Just the "wkup_m3 interrupt that signals the MPU".

> +    maxItems: 1
> +
> +  ti,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the wkup_m3 rproc node so the IPC driver can boot it
> +
> +  mboxes:
> +    description:
> +      phandles used by IPC framework to get correct mbox
> +      channel for communication. Must point to appropriate
> +      mbox_wkupm3 child node.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,rproc
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        mailbox: mailbox {
> +            #mbox-cells = <1>;
> +        };

I propose to skip the mailbox node, it's trivial and obvious from
mailbox providers/consumers documentation.

Best regards,
Krzysztof
