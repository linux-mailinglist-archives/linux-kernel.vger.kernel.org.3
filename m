Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA85398EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiEaVmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiEaVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:42:13 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7321B;
        Tue, 31 May 2022 14:42:11 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id r65so146844oia.9;
        Tue, 31 May 2022 14:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gIiu7V/rqZjztwT4OL+Dpls+E/6GMUhDy54RLlpLRXw=;
        b=n933F+pKKpCoH4Yim+P8CGDGGMuN77qF3aynbgrEPQyS0YylGY5X7ICdRHZ1GvRS9o
         ch7/dwu7LGPLYMpkWUFZkFhGKNmj/ENu2PSM1mzl14tNduKAHKCG4kyxDeL4NzFzGpkG
         dnuSYwexzL8mgD6hcsIeBIc41Ov6n8kUNiNU6inX/iaYrRu5p2GHE9zvgvmAQNwOZ8lB
         72dJfDU+63ZtXNl3p9r8YUv+tMG8hOEdIzYaro+mXJUXj26URosX4lIAGat33ifxzeBK
         oSNWKIeG6Et+XRmobNPT9FlT7Uh+N5CWAfMzYdNq/Aa8wle14R6IVDH7RQs3y7ooGdtb
         6nrw==
X-Gm-Message-State: AOAM532M1mFLiHw+b/m+jkt7ocD9rRTkXzSc9AwOKVKmsQ44mTTywmhN
        LIztbbFH+cI7xtSqL0RrGa/XNUZf2Q==
X-Google-Smtp-Source: ABdhPJwgzILUoCZf2uNlhPDheGiyHAk0mxDs8Dn5NTyCeNx0G/Qn4/OaCZRbbk6wucaexjpCSDkyxQ==
X-Received: by 2002:a05:6808:211c:b0:32b:6ebc:4f5a with SMTP id r28-20020a056808211c00b0032b6ebc4f5amr13006766oiw.230.1654033330586;
        Tue, 31 May 2022 14:42:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f14-20020a056871070e00b000f342d078fasm3078658oap.52.2022.05.31.14.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 14:42:10 -0700 (PDT)
Received: (nullmailer pid 2383926 invoked by uid 1000);
        Tue, 31 May 2022 21:42:09 -0000
Date:   Tue, 31 May 2022 16:42:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] dt-bindings: timestamp: Correct id path
Message-ID: <20220531214209.GA2350029-robh@kernel.org>
References: <20220523172515.5941-1-dipenp@nvidia.com>
 <CAL_JsqJSF=7FOW4oNydRtDYY8L9Y43E4FsBkUzM+U5ZRjYdt7A@mail.gmail.com>
 <86b11457-2f1a-6b17-fab0-a13d932af993@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86b11457-2f1a-6b17-fab0-a13d932af993@nvidia.com>
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

On Tue, May 31, 2022 at 10:35:55AM -0700, Dipen Patel wrote:
> Hi Rob,
> 
> What is the failing signature and command? I tried below commands on 31st May

Well, you fixed it in your patch. I'd hope you'd know.

> 
> linux-next and I can not see any failure.

You confirm your fix is there?

> 
> make O=./output/ DT_CHECKER_FLAGS=-m dt_binding_check
>   DTC     Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>   DTC     Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
>   DTC     Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
>   CHECK   Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>   CHECK   Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb
>   CHECK   Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb

Had you already run dt_binding_check?

> 
> make O=./output/ dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dts
>   DTEX    Documentation/devicetree/bindings/timestamp/hte-consumer.example.dts
>   DTEX    Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   DTC     Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>   DTC     Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
>   CHECK   Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.example.dtb
>   CHECK   Documentation/devicetree/bindings/timestamp/hte-consumer.example.dtb
>   DTC     Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.example.dtb

I don't see 'SCHEMA' target here. It should have run since LINT and 
CHKDT did.

Do a 'rm output/Documentation/devicetree/bindings/processed-schema.json' 
first.

Rob

> 
> 
> make O=./output dtbs_check
> 
> 
> Best Regards,
> 
> Dipen Patel
> 
> On 5/31/22 6:33 AM, Rob Herring wrote:
> > On Mon, May 23, 2022 at 12:25 PM Dipen Patel <dipenp@nvidia.com> wrote:
> >> During the repository renaming from hte to timestamp, $id path was not
> >> updated accordingly. This patch corrects $id path.
> >>
> >> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
> >> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >> ---
> >>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
> >>  Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
> >>  .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> > Ping. Still failing in linux-next.
> >
> >> diff --git a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
> >> index 4c25ba248a72..fd6a7b51f571 100644
> >> --- a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
> >> +++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
> >> @@ -1,7 +1,7 @@
> >>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>  %YAML 1.2
> >>  ---
> >> -$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
> >> +$id: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#
> >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >>  title: Hardware timestamp providers
> >> diff --git a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
> >> index 68d764ac040a..6456515c3d26 100644
> >> --- a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
> >> +++ b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
> >> @@ -1,7 +1,7 @@
> >>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>  %YAML 1.2
> >>  ---
> >> -$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
> >> +$id: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
> >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >>  title: HTE Consumer Device Tree Bindings
> >> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> >> index 69e8402d95e5..c31e207d1652 100644
> >> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> >> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> >> @@ -1,7 +1,7 @@
> >>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>  %YAML 1.2
> >>  ---
> >> -$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
> >> +$id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
> >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >>  title: Tegra194 on chip generic hardware timestamping engine (HTE)
> >>
> >> base-commit: cc63e8e92cb872081f249ea16e6c460642f3e4fb
> >> --
> >> 2.17.1
> >>
