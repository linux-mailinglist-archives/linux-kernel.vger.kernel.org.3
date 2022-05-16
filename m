Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733415293D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349730AbiEPWtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiEPWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:49:36 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4C41988;
        Mon, 16 May 2022 15:49:34 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l16so20440376oil.6;
        Mon, 16 May 2022 15:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mdM5qvrQm7rJky1mnAZGhGxpOiNhvwd5dv3eu9sS6CM=;
        b=lWDjoaQUg03fGSGIVGclk9jrP8TsDroFYllOtC+LSaciHtcqDj4cxlufkYYY7/PzB0
         rPyr9pAkKunFkefFAwJnW4vjIreGD39J3VZPk/vnUD1LluW4vydbbQ6xaG5BLJIxO6BA
         aOGoH74cnbhwS8PgBm1ST69nerxe5zmnikRJ8dBECiFR7AuVCZ9N5tTJy9h5yrQLi10z
         xI5zYlW2ceIpO48NiHQ6ae+UW6Yt7zPgnvYQiwRCS+X+uXlXB68hduBCnHIrWnCjSsCG
         MorZ9iB3SEhjkPyHzXK0Xb2HWDLPT+NktFj910/1Fyc4wLH79+dfxKWp7Wq7fMNi1lkh
         s8KA==
X-Gm-Message-State: AOAM5322z3fuLb8iHqe+VWXhlRDolHxQoFmDREj6tZgFvKm7R715Sm58
        n2Gr2WdeZlnqUW5S8s9hEg==
X-Google-Smtp-Source: ABdhPJyCOm7HmYlOFO+xSDlzkoN0MiRoCx+anoUxdsRLlaxja49bMCTzfTXikwJn30vz5uh4WMnJzw==
X-Received: by 2002:a05:6808:d49:b0:328:ed5c:f8da with SMTP id w9-20020a0568080d4900b00328ed5cf8damr5207399oik.64.1652741373805;
        Mon, 16 May 2022 15:49:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j9-20020aca3c09000000b00326bab99fe5sm4305839oia.40.2022.05.16.15.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:49:33 -0700 (PDT)
Received: (nullmailer pid 3462273 invoked by uid 1000);
        Mon, 16 May 2022 22:49:32 -0000
Date:   Mon, 16 May 2022 17:49:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Message-ID: <20220516224932.GA3452552-robh@kernel.org>
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504075153.185208-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504075153.185208-3-marcan@marcan.st>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:51:51PM +0900, Hector Martin wrote:
> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
> The hardware has an independent controller per CPU cluster, but we
> represent them as a single cpufreq node since there can only be one
> systemwide cpufreq device (and since in the future, interactions with
> memory controller performance states will also involve cooperation
> between multiple frequency domains).
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/cpufreq/apple,soc-cpufreq.yaml   | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
> new file mode 100644
> index 000000000000..f398c1bd5de5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/apple,soc-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC cpufreq device
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
> +  the cluster management register block. This binding uses the standard
> +  operating-points-v2 table to define the CPU performance states, with the
> +  opp-level property specifying the hardware p-state index for that level.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-soc-cpufreq
> +          - apple,t6000-soc-cpufreq
> +      - const: apple,soc-cpufreq
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 6
> +    description: One register region per CPU cluster DVFS controller
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: cluster0
> +      - const: cluster1
> +      - const: cluster2
> +      - const: cluster3
> +      - const: cluster4
> +      - const: cluster5
> +
> +  '#freq-domain-cells':
> +    const: 1

Copied QCom it seems. Use 'performance-domains' which is the common 
binding.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - '#freq-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // This example shows a single CPU per domain and 2 domains,
> +    // with two p-states per domain.
> +    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
> +    cpus {
> +      #address-cells = <2>;
> +      #size-cells = <0>;
> +
> +      cpu@0 {
> +        compatible = "apple,icestorm";
> +        device_type = "cpu";
> +        reg = <0x0 0x0>;
> +        operating-points-v2 = <&ecluster_opp>;
> +        apple,freq-domain = <&cpufreq_hw 0>;
> +      };
> +
> +      cpu@10100 {
> +        compatible = "apple,firestorm";
> +        device_type = "cpu";
> +        reg = <0x0 0x10100>;
> +        operating-points-v2 = <&pcluster_opp>;
> +        apple,freq-domain = <&cpufreq_hw 1>;
> +      };
> +    };
> +
> +    ecluster_opp: opp-table-0 {
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp01 {
> +        opp-hz = /bits/ 64 <600000000>;
> +        opp-level = <1>;
> +        clock-latency-ns = <7500>;
> +      };
> +      opp02 {
> +        opp-hz = /bits/ 64 <972000000>;
> +        opp-level = <2>;
> +        clock-latency-ns = <22000>;
> +      };
> +    };
> +
> +    pcluster_opp: opp-table-1 {
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp01 {
> +        opp-hz = /bits/ 64 <600000000>;
> +        opp-level = <1>;
> +        clock-latency-ns = <8000>;
> +      };
> +      opp02 {
> +        opp-hz = /bits/ 64 <828000000>;
> +        opp-level = <2>;
> +        clock-latency-ns = <19000>;
> +      };
> +    };
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      cpufreq_hw: cpufreq@210e20000 {
> +        compatible = "apple,t8103-soc-cpufreq", "apple,soc-cpufreq";
> +        reg = <0x2 0x10e20000 0 0x1000>,
> +              <0x2 0x11e20000 0 0x1000>;
> +        reg-names = "cluster0", "cluster1";
> +        #freq-domain-cells = <1>;
> +      };
> +    };
> -- 
> 2.35.1
> 
> 
