Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902C848D0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiAMDSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiAMDRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:17:55 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B12C06173F;
        Wed, 12 Jan 2022 19:17:55 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b127so5824800qkd.0;
        Wed, 12 Jan 2022 19:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiBmD87n7smzQMQDeZHB6mm8SdQHhbXrtoGI/254RyQ=;
        b=LAWyJiaGMbnBlzy67ihXukao4c1KRhHhCn7RfEdKQmEB40gT9JXyb6m157EiuvGVOE
         /PxN/hDiidM+VCLuf096XyBuxV5fBMNQuE67JFw2JIHMchRo1nAfLGU5Sib4chnHUsTM
         UdPsB8Z6kyZU001GWuXDhnmxNFTos+4aw59Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiBmD87n7smzQMQDeZHB6mm8SdQHhbXrtoGI/254RyQ=;
        b=rJ5WVWdB/pkRE23bHxbwrYeNkZ8F+0DfNVpMHOV47u25noGHHwbgmUZduH/+5nUJ6c
         uBmkXdsm26b3mnDUxGLEFE+jRBUlI/Buz9xGQ8HpFTav1IpM9b765zBR4vUaK2vb1VyI
         f0ZwJp7t2prKjhoeQ2QQCSlZ2+vgLc3cSy4NyEaxTGysY5z8biHcs7URvo7Muj22VkBC
         /yqY+RDgBMVfMGlkLUdZu+Yd9pL7KmGKMRKSi2WGhzHgj9DZfYCBHLoXrR6bXscO62/j
         1BrMO81uic9hUV2DbdmdS9CjAOqdfcQa7KAcy6YyiXz4N8pKPCaugXiIT/nVa8KLJ7es
         y8Vg==
X-Gm-Message-State: AOAM531I2oH29PegoIIY0/jHfNIJibavaf6IRPjNu1lXoaXsGPAKzauv
        DRewcM9D3EdwhxrRaqt8hfvn3zuKgrCgHSPVCWU=
X-Google-Smtp-Source: ABdhPJwZHZYgvotm7oygzzdLm6RLj5EtzqmsCy8jzni/Q69ijc8yVKgxipA6k47FweFIb1bMy8Eht1BD/2/myLO/Jsg=
X-Received: by 2002:a37:94c2:: with SMTP id w185mr1904124qkd.666.1642043874271;
 Wed, 12 Jan 2022 19:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20220112230247.982212-1-iwona.winiarska@intel.com> <20220112230247.982212-2-iwona.winiarska@intel.com>
In-Reply-To: <20220112230247.982212-2-iwona.winiarska@intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Jan 2022 03:17:42 +0000
Message-ID: <CACPK8Xfi33mr38_sdxF_Hi8Pw7VHzxH0zJd09gQz0voJm2xDBA@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] dt-bindings: Add generic bindings for PECI
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 23:03, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add device tree bindings for the PECI controller.
>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../bindings/peci/peci-controller.yaml        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/peci/peci-controller.yaml b/Documentation/devicetree/bindings/peci/peci-controller.yaml
> new file mode 100644
> index 000000000000..bbc3d3f3a929
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-controller.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/peci/peci-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Device Tree Bindings for PECI
> +
> +maintainers:
> +  - Iwona Winiarska <iwona.winiarska@intel.com>
> +
> +description:
> +  PECI (Platform Environment Control Interface) is an interface that provides a
> +  communication channel from Intel processors and chipset components to external
> +  monitoring or control devices.
> +
> +properties:
> +  $nodename:
> +    pattern: "^peci-controller(@.*)?$"
> +
> +  cmd-timeout-ms:
> +    description:
> +      Command timeout in units of ms.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    peci-controller@1e78b000 {
> +      reg = <0x1e78b000 0x100>;
> +      cmd-timeout-ms = <500>;
> +    };
> +...
> --
> 2.31.1
>
