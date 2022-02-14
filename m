Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89204B4F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiBNL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:58:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiBNL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:58:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF7CCA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:58:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w11so26418433wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZM9SFzuxH0/CdsKBidMXt+0l24yE5+NneRxyeWKMPLg=;
        b=P24Bb1HqNrlFgBNdXDf/r1ELN/m1gsdgBkBSmnd5IGGNq/V+Zy5yM938CnSCBiCQYL
         58cBm/S2n7iTvARQ3IiIuPU5mS4aBeoWBN/ZGZyBP5ppBp4Kq6tLU3GIJBARglRaZS/B
         o/PnZqJuqW3+obYZqYbHylDNGC0odWh46GOtBCV5NkDKM2Q0J7q1z/nnvgaQI2tAXeyj
         U5CDpYsP+datuJ8tAsY61EXFFtVho7cZGJiCfg7UR/Rdcr09PMkr6vgtpq4uqAq3S+vC
         cH0k86Ya2gcsQGCfr1LJaD77UlNcII7NW9Sde44e5NJpM8ke54JJs8/5S0RjoBI2bnSm
         oEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZM9SFzuxH0/CdsKBidMXt+0l24yE5+NneRxyeWKMPLg=;
        b=UVNeBW1QaRkpMhjJWphqf6A+eNo5khRyidghG7jqK4TX73pcK7JW0soLsdrZ78pZRT
         YkhgUO0961131Hv0QdJA8YKTkR7EvUQVRHsRSR9nbCO8Svz7iAtfCdcDe8flpsVQAeY+
         9l9epsI2HdbuUz7MvLSrax8ehljwhswht3oNLGlIaPfZCYVyjePpLZgXrb7vg/r/w4t8
         6cLTBm/VGvF+fSm3PIuFxP63sWwVin6iERsswdottQ3DSBh7M1EMASwCin9vPx0SL9F3
         5Tmh6XE4t1N4ZJOHCItQ3xEB07EjUAkA25aGID5CdCipGIHHKoj2Z7Tqcv5UUdQFBovr
         ArPw==
X-Gm-Message-State: AOAM530EjYzqldFhoIZO/0QvIBJy+glhYRa7rxdCBINUH5pPX68qlCcm
        eMkQYgKmqdrghLwSxEU4v55zmQ==
X-Google-Smtp-Source: ABdhPJwh6ry1RXzFjBT6+m9SZ9MEXoKqp7u6TNN6MVn8iZ8iemoFsVradCE/GW41sxuZ+v4GKnGA6w==
X-Received: by 2002:a05:6000:168c:: with SMTP id y12mr10783391wrd.265.1644839904542;
        Mon, 14 Feb 2022 03:58:24 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id x18sm29013956wrw.17.2022.02.14.03.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:58:23 -0800 (PST)
Message-ID: <c3c9c6e3-259f-0bf0-6c9f-b777beca2c39@linaro.org>
Date:   Mon, 14 Feb 2022 11:58:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/3] nvmem: add Layerscape SFP support
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220214115529.662948-1-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220214115529.662948-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2022 11:55, Michael Walle wrote:
> Add support for the Security Fuse Processor found on Layerscape
> SoCs.
> 
> changes since v1:
>   - added Rob's Rb
>   - cleaned up the include files
>   - changed the module license to only "GPL"
>   - fix indendation, split lines longer than 80c
> 
> Michael Walle (3):
>    dt-bindings: nvmem: add fsl,layerscape-sfp binding
>    nvmem: add driver for Layerscape SFP (Security Fuse Processor)

Applied 1/3 and 2/3.

dts patch has to go via respective arm soc maintainer tree.


--srini
>    arm64: dts: ls1028a: add efuse node
> 
>   .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 38 ++++++++
>   .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 11 +++
>   drivers/nvmem/Kconfig                         | 12 +++
>   drivers/nvmem/Makefile                        |  2 +
>   drivers/nvmem/layerscape-sfp.c                | 89 +++++++++++++++++++
>   5 files changed, 152 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>   create mode 100644 drivers/nvmem/layerscape-sfp.c
> 
