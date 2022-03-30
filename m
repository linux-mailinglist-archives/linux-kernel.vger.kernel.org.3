Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E54EC70A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbiC3Ouf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347179AbiC3Oud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:50:33 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFEA28789F;
        Wed, 30 Mar 2022 07:48:46 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-dee0378ce7so11912453fac.4;
        Wed, 30 Mar 2022 07:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=skMSCIAgLPl78nzvZXYE2JT7zIrztjobvz7dNziQYsE=;
        b=YOLKtBaxxUSDjvtn8tEoN4QvogVSwfN4xVEiBqCaxzmZNE+eBzWJpPkgZVliBB79XY
         xAvqy+3UJx0kvJlVUh5wjTVVHWuNjJmkEZfufEq+Lgen6UE1Yta1o/JVozzA278Pb4Ha
         ZpWwX5boiLEiZM11qF70OJXN/vFiM/sFigtI29BAjyfOhdwUHdMiT4uLq7oRQ/SU8n9z
         hLg/PUA2eIgx0p9zkhjUc71q1bRH418A49HBES0c4MVVq0u7EkAlzyPlW2Vnl7YCvb9S
         fxigA5WRlKIm42AFOa3Zy0iVwUO2whKg0ifZ6CijM3MB7PQITIxphqAtrddKcedftlSi
         xENw==
X-Gm-Message-State: AOAM532FqYma72fGHAnA4X6VGf0YzNLnFqY0vc4jwGhULIZgAFLEvacb
        s2cy5wWANFonS6BPV2FtYg==
X-Google-Smtp-Source: ABdhPJxHdqfLBB2pgsxMf+I94z/WzW9slneVMU6+szkaMjJonYmkhtJIm3/o7LP/h/LoYE1YrqgzLw==
X-Received: by 2002:a05:6870:ec92:b0:dd:b5b5:75d5 with SMTP id eo18-20020a056870ec9200b000ddb5b575d5mr2330636oab.61.1648651725568;
        Wed, 30 Mar 2022 07:48:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t11-20020a4ae40b000000b0031cc933b418sm10019954oov.40.2022.03.30.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:48:45 -0700 (PDT)
Received: (nullmailer pid 3029818 invoked by uid 1000);
        Wed, 30 Mar 2022 14:48:44 -0000
Date:   Wed, 30 Mar 2022 09:48:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        smangipudi@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 04/11] dt-bindings: Add HTE bindings
Message-ID: <YkRtzJjHQvmYNlK8@robh.at.kernel.org>
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-5-dipenp@nvidia.com>
 <YkOVgRBtXX0k9zr1@robh.at.kernel.org>
 <3b0f3430-bc1c-26df-c93f-517ba395d9e3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0f3430-bc1c-26df-c93f-517ba395d9e3@nvidia.com>
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

On Tue, Mar 29, 2022 at 05:19:10PM -0700, Dipen Patel wrote:
> Hi,
> 
> On 3/29/22 4:25 PM, Rob Herring wrote:
> > On Mon, Mar 28, 2022 at 10:45:14PM -0700, Dipen Patel wrote:
> >> Introduces HTE devicetree binding details for the HTE subsystem. It
> >> includes examples for the consumers, binding details for the providers
> >> and specific binding details for the Tegra194 based HTE providers.
> >>
> >> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >> Changes in v2:
> >> - Replace hte with hardware-timestamp for property names
> >> - Renamed file
> >> - Removed example from the common dt binding file.
> >>
> >> Changes in v3:
> >> - Addressed grammatical errors.
> >> - Removed double plural from the respective properties.
> >> - Added dual license.
> >> - Prefixed "nvidia" in nvidia specific properties.
> >>
> >> Changes in v4:
> >> - Corrected make dt_binding_check error.
> >>
> >> Changes in v5:
> >> - Addressed review comments.
> >>
> >>  .../hte/hardware-timestamps-common.yaml       | 29 +++++++
> >>  .../devicetree/bindings/hte/hte-consumer.yaml | 43 ++++++++++
> >>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
> >>  3 files changed, 154 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> >> new file mode 100644
> >> index 000000000000..e8a69ceccd56
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
> >> @@ -0,0 +1,29 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fhardware-timestamps-common.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589163420%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=oyeG06oNMukYew%2Bkji%2FlXsDyGwIIrIvwxLHKxaiFBto%3D&amp;reserved=0
> >> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589163420%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=JOY3MmZlMo6Mopr5dwjUky%2BaQX4b0QSiDt8zo3mSu1k%3D&amp;reserved=0
> >> +
> >> +title: Hardware timestamp providers
> >> +
> >> +maintainers:
> >> +  - Dipen Patel <dipenp@nvidia.com>
> >> +
> >> +description:
> >> +  Some devices/SoCs have hardware time stamping engines which can use hardware
> >> +  means to timestamp entity in realtime. The entity could be anything from
> >> +  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present
> >> +  itself as a provider with the bindings described in this document.
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    pattern: "^hardware-timestamp(@.*|-[0-9a-f])?$"
> >> +
> >> +  "#hardware-timestamp-cells":
> >> +    description:
> >> +      Number of cells in a HTE specifier.
> >> +
> >> +required:
> >> +  - "#hardware-timestamp-cells"
> >> +
> >> +additionalProperties: true
> >> diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> >> new file mode 100644
> >> index 000000000000..be69f63aa8c3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
> >> @@ -0,0 +1,43 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fhte%2Fhte-consumer.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589319655%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0f1FFB1IotZESaxDlXX5mo9YyMN25BlFAyq%2FOQJtVoE%3D&amp;reserved=0
> >> +$schema: https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Cdipenp%40nvidia.com%7C5793b3be05fd48a97ad108da11db79a7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637841931589319655%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=B%2FvVGGwp9JghUpT33cGk0EZHDRlaOAzCbtv93Z%2Fa9YY%3D&amp;reserved=0
> >> +
> >> +title: HTE Consumer Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - Dipen Patel <dipenp@nvidia.com>
> >> +
> >> +select: true
> >> +
> >> +description:
> >> +  HTE properties should be named "hardware-timestamps". The exact meaning of
> >> +  each hardware-timestamps property must be documented in the device tree
> > The meaning of the cells needs to be documented. You are documenting the 
> > meaning of 'hardware-timestamps' here.
> 
> This is for the consumer side, meaning of the cells will be documented in the provider
> 
> binding document.

Right cells are opaque to the consumer. What bothered me is 
hardware-timestamps already has an 'exact meaning'. You need to me more 
exact as to what should be documented. We don't want what 
'hardware-timestamps' is described again. What needs to be documented is 
how many entries, what each entry is (for the consumer), and the order.


> >> +  binding for each device. An optional property "hardware-timestamp-names" may
> >> +  contain a list of strings to label each of the HTE devices listed in the
> >> +  "hardware-timestamps" property.
> >> +
> >> +properties:
> >> +  hardware-timestamps:
> > I'm wondering if we should just drop 'hardware'. What other kind of 
> > timestamps are we going to have in DT? software-timestamps? No.
> 
> I believe this makes it explicit and leaves no room for second guess. If
> 
> only timestamps, ambiguity then will be which timestamp it is i.e. through hardware
> 
> engine, pps, ptp and so on...

Those aren't hardware timestamps, too? If those needed a similar 
binding, couldn't they use this binding? PTP at least is sometimes an 
separate, external chip IIRC.

Rob
