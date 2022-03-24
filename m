Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119034E68D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352728AbiCXSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiCXSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:48:46 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9364163D;
        Thu, 24 Mar 2022 11:47:13 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id b19so7867581wrh.11;
        Thu, 24 Mar 2022 11:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KDJpjxd6iOA3qWDHcyReo9R0utRfpUnP8h7B7fwBi2g=;
        b=3XuGON3DxzT6DBDjZK75nsDGsCeX+ECY+sdXsjA94aWIb2A+DGlQNnTf0Ye8i4Vjbr
         0WF8mpGMqDFqxtdaB1la30Ca6KCbWzDMn9F9IKksddiQzvUdU22azYJm+IlClJbLAJbf
         2/ZS5wRFgvCHAHPmb/AeXLyQ2J53Pbo7PcMOckCYfOg7MsOaRJMuZsJVuUkv6rudRX2q
         WIuddjng85TaS2/tKgne6WPLFqvgcYPTySW8oQi9zNExo43XKQ9b8K1Sw/pRDh0T08v7
         vr2NRDsRW1gcmvjN8QJBi3Hu/N5LqrxzMPyYqWc4WVitCzPyvWXGQS9rxaHUNqkFYGDE
         3K3Q==
X-Gm-Message-State: AOAM532eC/jr8/cSXbGvh6EBusMvLl5i9y43CrvQvCC+w3UM+wj0YLVC
        /2de2OOog0ybO/JBNEk7dJlMUinNlsAG8A==
X-Google-Smtp-Source: ABdhPJyosxIuUQaMs6KYbGUBTrKWWFzdvtClypQ8lyIFfEwbQZ22wFQ5SU62O0nK9gFjmopcNxDwPA==
X-Received: by 2002:a5d:424d:0:b0:204:7fc:d6c6 with SMTP id s13-20020a5d424d000000b0020407fcd6c6mr5601658wrr.291.1648147632374;
        Thu, 24 Mar 2022 11:47:12 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id bj26-20020a0560001e1a00b0020597757ebcsm2186322wrb.7.2022.03.24.11.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:47:11 -0700 (PDT)
Message-ID: <fdf37f73-6b7a-a96d-6a42-35d870c96f35@kernel.org>
Date:   Thu, 24 Mar 2022 19:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: bcm: bcm2835-vchiq: Add support
 for bcm2711
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220324172647.167617-2-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 18:26, Adrien Thierry wrote:
> Add a new compatible string for BCM2711. This is the chip used on the
> Raspberry Pi 4.
> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
> Changes since v1:
> - Removed duplicate compatible string for bcm2711
> 
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> index e04439b3355b..9cb957facae0 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> @@ -27,6 +27,11 @@ properties:
>                - brcm,bcm2836-vchiq
>            - const: brcm,bcm2835-vchiq
>  
> +      - description: BCM2711 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm2711-vchiq

This oneOf here - just to add description which is copy-paste of
compatible - does not make sense. It should be just enum with
compatibles. At least for 2711 and 2835 (and put them in alphabetical
order).


Best regards,
Krzysztof
