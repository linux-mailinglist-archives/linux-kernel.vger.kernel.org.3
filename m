Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8E4F8701
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiDGSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiDGSTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:19:05 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BE398;
        Thu,  7 Apr 2022 11:17:05 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id b17-20020a0568301df100b005ce0456a9efso4456607otj.9;
        Thu, 07 Apr 2022 11:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3SMplr3NIxarZcsC3NyJ/Iwr/dnvkZ+4jSSz/1c1XSw=;
        b=gfuAA+MZXBTn/Hb98acz+OCm3dxZuX5U544tDo8i2z1xS5Z7yASJ+Fc9U19VlzY2V+
         HDXvmAsleiv55RE+Lip7p9qzgbUBMBNTw34eDzyT4gREWX6hcng6bwuDcLSTJn7IugfN
         /65F9XBVOyEHwiXRSg3QQkovOmLFbnYfzNWWp62iH305qCo0T1bOFnx5//OTqKlCgthY
         JYwMiRe7AkzBUA+HcIZGDfpqDFR60hlFIhYNbxmC3PaTuEtvaYs3oonAiGRRpoC3TVEG
         k6QlhBNr0/jBPH+3k/czFK/cgopyV4i8pO0Mi+qUgJVGYwOlT7lIMuqU2AkqtbOkj3F3
         Qn1w==
X-Gm-Message-State: AOAM531w57KIYAbQvaf+3DedXyutkdi0gVo3h8UGeNONt3eVTLbD8kgb
        69tKwCrHbc5lyal1YiKPaS60HItxTQ==
X-Google-Smtp-Source: ABdhPJyHc92fEYOo1RjpNxcvbckJZUIjQ0BYjgcTRqSjC0wHSSqbmSAtBRvdDD4KQpHA3zuefjbC/w==
X-Received: by 2002:a05:6830:1ad9:b0:5cd:df9e:271a with SMTP id r25-20020a0568301ad900b005cddf9e271amr5356472otc.142.1649355424284;
        Thu, 07 Apr 2022 11:17:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870514900b000e27a6822ecsm449733oak.55.2022.04.07.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:17:03 -0700 (PDT)
Received: (nullmailer pid 1725965 invoked by uid 1000);
        Thu, 07 Apr 2022 18:17:03 -0000
Date:   Thu, 7 Apr 2022 13:17:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Peshkin <joel.peshkin@broadcom.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot, env: add Broadcom's variant
 binding
Message-ID: <Yk8qnxqXK7WZvXrS@robh.at.kernel.org>
References: <20220406152515.31316-1-zajec5@gmail.com>
 <CAN3=V2vOVLc95ZYBUDo8J7ast4UQMnZm4uYmX63LpcJdZWnmNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN3=V2vOVLc95ZYBUDo8J7ast4UQMnZm4uYmX63LpcJdZWnmNQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:55:14AM -0700, Joel Peshkin wrote:
> Hi Rafal,
> 
>    The first 32b value is a magic number (endian swapped mnemonic of "uEnv"
> short for "u-boot environment").   Finding that magic number of a 4K
> boundary followed by a length and then a u-boot environment with a valid
> CRC permits a scan of the flash partition to locate the environment without
> knowing a-priori where it is.

So it doesn't need to be described in DT? But how does one identify 
whether to scan the flash or not. You wouldn't want to do that one every 
platform. IOW, it's a sufficient discovery mechanism for a custom build, 
but not generic OS.

Rob
