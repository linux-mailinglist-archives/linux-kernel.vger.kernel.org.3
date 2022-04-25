Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7574C50E846
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbiDYSdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiDYSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:32:58 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60BB127A62;
        Mon, 25 Apr 2022 11:29:53 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso11386423otr.1;
        Mon, 25 Apr 2022 11:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lriM4Eb1mfVCkwHcOZJ5oVsOk4UnCnlaleMOkqNDBxQ=;
        b=OZxw98gdTKIZ71i1mW4yw8ph/ReUjWi44/d8t8ODZK2ZJphJ2a1vyoWAhZH7FNc/rg
         cB1OuMDG4a5G8gHjEbQptxH2i4w2jKJuL/D2A0Cm4K6W4GX1jVRTnT4+1iRjwIXQ7hZV
         wSE+5xlfypUlJiiLYvRyOJ5w+GUMcyRqijwYi3svCOwMg/XrreDKf7DvM22o56Ri1gMd
         NewAo3imzHUA6+mR93JZPxjy4g9OfQXXD//Hrlvm6G/HCetYUnoQSe204TdDyl7QAF9/
         /kjesQdVDv7GYSlh97aC3FHENowaGD6Lb1Get2PwuqpggSTEXint/neSxjbOh1TNN8J4
         ub5g==
X-Gm-Message-State: AOAM531Q7Opx0duT1tTFQj3JHFMnCp0fS+EvudUxYeoPD9nVbGV+qI5c
        FXMkO3uSxsevB8a5t+AWzu8sNRnt5w==
X-Google-Smtp-Source: ABdhPJxaO5dknFoF5dhxM9G+fEp86vhh8+PlM24r/ci3c8PfSMNP72mpASKiXDywUKFMXt8zqwF0cA==
X-Received: by 2002:a05:6830:242a:b0:605:783c:78c5 with SMTP id k10-20020a056830242a00b00605783c78c5mr6971033ots.172.1650911392658;
        Mon, 25 Apr 2022 11:29:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x16-20020a056808145000b00323371f6935sm4065264oiv.15.2022.04.25.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:29:52 -0700 (PDT)
Received: (nullmailer pid 13707 invoked by uid 1000);
        Mon, 25 Apr 2022 18:29:51 -0000
Date:   Mon, 25 Apr 2022 13:29:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
Subject: Re: [PATCH v3 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog
 compatible
Message-ID: <YmbonypWxzZJbjQ1@robh.at.kernel.org>
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-2-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425134204.149042-2-sebastianene@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:42:05PM +0000, Sebastian Ene wrote:
> The stall detection mechanism allows to configure the expiration
> duration and the internal counter clock frequency measured in Hz.
> Add these properties in the schema.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../devicetree/bindings/misc/vm-wdt.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/vm-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/vm-wdt.yaml b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
> new file mode 100644
> index 000000000000..cb7665a0c5af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/vm-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VM watchdog
> +
> +description: |
> +  This binding describes a CPU stall detector mechanism for virtual cpus.
> +
> +maintainers:
> +  - Sebastian Ene <sebastianene@google.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qemu,vm-watchdog
> +  clock:

'clocks' is already a defined property and 'clock' is too close. It's 
also ambiguous what it is. 'clock-frequency' instead perhaps.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The watchdog internal clock measure in Hz used to decrement the
> +      watchdog counter register on each tick.
> +      Defaults to 10 if unset.
> +  timeout-sec:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The watchdog expiration timeout measured in seconds.
> +      Defaults to 8 if unset.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    watchdog {
> +      compatible = "qemu,vm-watchdog";
> +      clock = <10>;
> +      timeout-sec = <8>;

How does one access this 'hardware'?

Why does this need to be in DT?

We have DT because h/w designers are incapable of making h/w 
discoverable. Why repeat that problem with s/w interfaces?

Rob
