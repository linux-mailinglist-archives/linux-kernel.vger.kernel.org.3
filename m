Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE5512C67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiD1HOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244923AbiD1HN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:13:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254507F21C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:10:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p4so4489222edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mfVDlT+SB+fUGtNozIrcoCBtFK15myE/xvi70Ns07Y0=;
        b=xaa7sh6dUpf/JxH5JjtFsQCnSBvLBGO59ZolFIGdMeRc1TeiA6r+f5f1yZ7Bnr2Nq/
         FjtSAulgYT8xeGzhF+fK240lXwT2M02KlfSJEwJvh/cUisAjPQ+0mVGoP5lC0LhGNTK3
         SC3u4sxieaHY5oA1CJLgbgCWSUr9B8s+Lrwu22OF+ShFdb2qQrOkPg3cGd0AD5DOW8ih
         lhr53NlIGKMPK1ebYPtovy2tJ0PfIDoGAekcR1cOLeZ8Vi6HyXb81JuBpMZEHE2uRKdZ
         EN1kUxq9ZSkxJIEkdpC816bw+O8L5srUyNB8pvvNmme61DuYZopGKaI1uBtZ6gHknl74
         uZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mfVDlT+SB+fUGtNozIrcoCBtFK15myE/xvi70Ns07Y0=;
        b=rdtbX9IR6CFlcMdFS8O9clkwJEYPp/kEU+vWAHOVyNbuzQpWNeRUAagOOpMlds2nJq
         ivsullkJWkVZVEPBQvm6SdgAH4OFbdQGHNMphzhfpre/XE1NGLr4gpFb05OEN/J9gJ27
         PyiBrr0u1rY/Sv6eEGMWR85kWFre6+6eCzWCihYSkUXekos6eqrGOTKrH+jfRDP/iB36
         yz/Tr0vM71XIXlWzKuwtR1NMDkYOKP+NXRMRuUmeP6ktH60lan+1ubKhhMPdChfLOEjo
         sdzKbid3ySS8LEU7VyRNB0bi6NQWN3AkiqONrRMncVheFXFVZ+WY3JmoN1ftx8pUCqeF
         s4gA==
X-Gm-Message-State: AOAM532/sT4xCJ/3Z8yJnrhlfSpPLoyeZOI7IRqZuKZFVOf9/ywc+eao
        AeXz/We0IVq8JBP+ebhzaac2Xw==
X-Google-Smtp-Source: ABdhPJx/RN+yCmworyXkMteDeoWpMxQQIF8ARhEImfpJoyrf4ovluw4eYFLw46bzELds12rwdt2Gmg==
X-Received: by 2002:aa7:d543:0:b0:416:13eb:6fec with SMTP id u3-20020aa7d543000000b0041613eb6fecmr35208100edr.348.1651129843703;
        Thu, 28 Apr 2022 00:10:43 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906770900b006d20acf7e2bsm7890526ejm.200.2022.04.28.00.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:10:43 -0700 (PDT)
Message-ID: <57812ced-4132-51ae-98c2-62c6de809841@linaro.org>
Date:   Thu, 28 Apr 2022 09:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/4] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427075338.1156449-1-michael@walle.cc>
 <20220427075338.1156449-4-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427075338.1156449-4-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 09:53, Michael Walle wrote:
> Convert the fsl,ls-extirq binding to the new YAML format.
> 
> In contrast to the original binding documentation, there are three
> compatibles which are used in their corresponding device trees which
> have a specific compatible and the (already documented) fallback
> compatible:
>  - "fsl,ls1046a-extirq", "fsl,ls1043a-extirq"
>  - "fsl,ls2080a-extirq", "fsl,ls1088a-extirq"
>  - "fsl,lx2160a-extirq", "fsl,ls1088a-extirq"
> 
> Depending on the number of the number of the external IRQs which is
> usually 12 except for the LS1021A where there are only 6, the
> interrupt-map-mask was reduced from 0xffffffff to 0xf and 0x7
> respectively and the number of interrupt-map entries have to
> match.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v2:
>  - drop $ref to interrupt-controller.yaml
>  - use a more strict interrupt-map-mask and make it conditional on SoC
> 
> changes since v1:
>  - new patch
> 
>  .../interrupt-controller/fsl,ls-extirq.txt    |  53 --------
>  .../interrupt-controller/fsl,ls-extirq.yaml   | 118 ++++++++++++++++++
>  2 files changed, 118 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
