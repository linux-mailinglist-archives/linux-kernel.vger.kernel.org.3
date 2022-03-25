Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411A4E6EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347888AbiCYHST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiCYHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:18:17 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDF6B91B9;
        Fri, 25 Mar 2022 00:16:44 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id qx21so13525401ejb.13;
        Fri, 25 Mar 2022 00:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=6YHRcsHOFCm3E4C9FykKyoJxe7PYRENyIsb3tXOaP5I=;
        b=ayXysRdNgGUnL2RI3V7Mbl4pv0PesNEzA9rGSNgzyXWwydpR3YKN9khOSOxCgRFeEq
         6uRx1Nc6syeF96SqujXWOCcCqIzcMKeiicyRF9gpwx3fmQYDXfwIq28ZjQ+h2EQgVUy2
         0IopsLHAkYMpReNe7T6HmeNEBjKqzEFagdGR7iAEsVurfd3bPeRsySjYiUu9eyXDy0Ak
         0FxKpnW7R1xUTkh+CVA47b93FswYByVVpjk0UBN4vvOX6FznXR/kYzMhdnu584ZpcVj8
         q7HwCcT0b4/LRCyi5HXYfLNeMBJarvZgO+tkYFc8sC4Pwmh5rsJnFdnLV1WCDs5lQKM5
         E6YQ==
X-Gm-Message-State: AOAM530uhEKG5G5FrXjPxBoBsU42iK92/OCc2dsN6NafRz6sCpVGTESx
        y6dZKpq0bN2HOynxUYBYBBE=
X-Google-Smtp-Source: ABdhPJzPzXLNwxYfju2wh9vwGi8cPlhGKuDBZCqBi7gSMRDLYWMBkqfgbdWQbnsDEtFpPc5+JuVk0A==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr9906155ejc.712.1648192602385;
        Fri, 25 Mar 2022 00:16:42 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id ga5-20020a1709070c0500b006de43e9605asm2015052ejc.181.2022.03.25.00.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 00:16:41 -0700 (PDT)
Message-ID: <2c6b873f-a971-e79a-6a32-f101bda46e93@kernel.org>
Date:   Fri, 25 Mar 2022 08:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: bcm: bcm2835-vchiq: Add support
 for bcm2711
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Thierry <athierry@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev
References: <20220324172647.167617-1-athierry@redhat.com>
 <20220324172647.167617-2-athierry@redhat.com>
 <fdf37f73-6b7a-a96d-6a42-35d870c96f35@kernel.org>
In-Reply-To: <fdf37f73-6b7a-a96d-6a42-35d870c96f35@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 19:47, Krzysztof Kozlowski wrote:
> On 24/03/2022 18:26, Adrien Thierry wrote:
>> Add a new compatible string for BCM2711. This is the chip used on the
>> Raspberry Pi 4.
>>
>> Signed-off-by: Adrien Thierry <athierry@redhat.com>
>> ---
>> Changes since v1:
>> - Removed duplicate compatible string for bcm2711
>>
>>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml      | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
>> index e04439b3355b..9cb957facae0 100644
>> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
>> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
>> @@ -27,6 +27,11 @@ properties:
>>                - brcm,bcm2836-vchiq
>>            - const: brcm,bcm2835-vchiq
>>  
>> +      - description: BCM2711 based boards
>> +        items:
>> +          - enum:
>> +              - brcm,bcm2711-vchiq
> 
> This oneOf here - just to add description which is copy-paste of
> compatible - does not make sense. It should be just enum with
> compatibles. At least for 2711 and 2835 (and put them in alphabetical
> order).

Actually, judging by your driver and DTS, it seems that this should be
list of items bcm2711 followed by bcm2836.


Best regards,
Krzysztof
