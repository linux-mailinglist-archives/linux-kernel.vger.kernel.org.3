Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0A572EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiGMHO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiGMHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:14:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5A2B606;
        Wed, 13 Jul 2022 00:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC40B81CBD;
        Wed, 13 Jul 2022 07:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8FAC34114;
        Wed, 13 Jul 2022 07:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657696460;
        bh=7DHxolcsZ8sgDrhV/+4giGupHL5PwedaRGNt6h/lQrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TrGnwMcQuimxhM49Sr5I3innckUA300c+IeC5YSTnY4/W0abAnp5Fx/nBZWQ4suRe
         tAyCEz/RZXxzM1N4O7Qgadsj8EMjUFtWrqFDYrP4ZeI6YqOv5kP/SpSDUZ5M+sQRDo
         bLExpm8T0SzdfxMDMvhUEEBN+0w4c0Biolmfnz5CcqHAOJipZoR4ymYtHaXlGKsUah
         Rq0LPOyDX2YmnUuHIMyOs7JVUS1aFn9pxqfOUzQhkH60apbs8RBObkoCq+b6wO+RAw
         BG0egc7tasE/B/Ns7QIwCo1YNbee+T5kTJtYJQVceih+uh+X+btvB8fC6cAKX1ql4y
         XV1HllVZLrXMg==
Message-ID: <313e2dc6-e8cf-f6c9-20e2-d7c766b4ecee@kernel.org>
Date:   Wed, 13 Jul 2022 09:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] dt-bindings: mfd: Add bindings for Samsung SysMgr
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
 <20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:56, Dongjin Yang wrote:
> Add an devicetree binding for Samsung system manager.
> This driver is used for SoCs produced by Samsung Foundry to provide
> Samsung sysmgr API. The read/write request of sysmgr is delivered to
> Samsung secure monitor call.

Nope. Second patch with the same - you need to describe the hardware or
underlying firmware, not the driver. "This driver" is not acceptable for
bindings.

> 
> Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
> ---
>  .../devicetree/bindings/mfd/samsung,sys-mgr.yaml   | 42 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml b/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
> new file mode 100644
> index 000000000000..83b9d73a5420
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/samsung,sys-mgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung System Manager
> +
> +maintainers:
> +  - Jesper Nilsson <jesper.nilsson@axis.com>

How is this related to Axis platforms?

> +
> +description: |
> +  The file documents device tree bindings of Samsung system manager.

Useless description. Describe the hardw

> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,sys-mgr
> +      - samsung,sys-mgr-smccc

Sorry, this does not look like hardware. It could be description of
underlying firmware, but you would need to justify it. Look at Qualcomm
SCM for example. Or ARM SCMI, SCPI.


Best regards,
Krzysztof
