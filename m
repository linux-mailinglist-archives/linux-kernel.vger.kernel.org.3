Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688F6480088
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbhL0Pqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbhL0Pm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:42:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087BC07E5DD;
        Mon, 27 Dec 2021 07:41:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A89BB80E5A;
        Mon, 27 Dec 2021 15:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E48CC36AEB;
        Mon, 27 Dec 2021 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640619684;
        bh=15mMjnAJtOvIMn6zPv/4Je924uGKzCsmt8+HS5gmN20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LU9WtGSi1RIaQ3Obqt23VhFJ/0uEDZLpUimW9OQoURgljdEIsWaGKqA55rq1pA96R
         J2q6sx1+Fk8taeNIGu2eg/z1SesNapn24DXTxrG2Wei9JQFiS6CbIBApFpeDs6S3Dv
         bRMLEC25DPJJd/MBLB2A8XyaNZF1pYBbWooLjXsAHhQhC5J54np/S8XXGPphifRrTk
         TXiIHJNXRN6M5cEJctVbcx7SnjVl12kjKZh3cDa6FehJeHX/NrL7RBDCUihFwwOeRc
         uADk1sPmFRbri6Mm9lk2qrlBriq82xQVWsxqhYDRK7rSrX+cXPW7oKoYM9kErixfnF
         +6F0CcTtCoFBQ==
Received: by mail-ed1-f47.google.com with SMTP id o6so63116909edc.4;
        Mon, 27 Dec 2021 07:41:24 -0800 (PST)
X-Gm-Message-State: AOAM533xQN9dZ6gAqity0zX4M83RpnuMgB7oSq403naUNGLfZTCw9rzz
        /ywGqELjxJ/15jfbgZIDVo8AXnoGj1lofwFFtg==
X-Google-Smtp-Source: ABdhPJxrg1e+Qn2QFV1JLvASB+GljzG6LFYYW5RjZebxYJd8e7aHGbkaKlnnbY17b7L0jTd6OFpJGLZEMhYGgJDjHQA=
X-Received: by 2002:a17:906:eb04:: with SMTP id mb4mr13908147ejb.27.1640619682657;
 Mon, 27 Dec 2021 07:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20211221125117.6545-1-sumitg@nvidia.com> <20211221125117.6545-4-sumitg@nvidia.com>
 <YcNv7xm19sFTlfjW@robh.at.kernel.org> <226fd57c-2631-ec7a-fc48-d6547d557681@nvidia.com>
In-Reply-To: <226fd57c-2631-ec7a-fc48-d6547d557681@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Dec 2021 11:41:10 -0400
X-Gmail-Original-Message-ID: <CAL_Jsq+=hGG-cMwvM0sKFW=Rwa56=fqS379jL4ZjSyDKOia-RA@mail.gmail.com>
Message-ID: <CAL_Jsq+=hGG-cMwvM0sKFW=Rwa56=fqS379jL4ZjSyDKOia-RA@mail.gmail.com>
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, kbuild-all@lists.01.org,
        bbasu@nvidia.com, vsethi@nvidia.com, jsequeira@nvidia.com,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 4:24 AM Sumit Gupta <sumitg@nvidia.com> wrote:
> > On Tue, Dec 21, 2021 at 06:21:11PM +0530, Sumit Gupta wrote:
> >> Add device-tree binding documentation to represent the axi2apb bridges
> >> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
> >> slaves are reported as slave error because APB bas single bit to report
> >> error. So, CBB driver needs to further check error status registers of
> >> all the axi2apb bridges to find error type.
> >>
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >>   .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
> >>   1 file changed, 40 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> >> new file mode 100644
> >> index 000000000000..788a13f8aa93
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> >> @@ -0,0 +1,40 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: NVIDIA Tegra194 AXI2APB bridge
> >> +
> >> +maintainers:
> >> +  - Sumit Gupta <sumitg@nvidia.com>
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    pattern: "^axi2apb@([0-9a-f]+)$"
> >> +
> >> +  compatible:
> >> +    enum:
> >> +      - nvidia,tegra194-axi2apb
> >> +
> >> +  reg:
> >> +    maxItems: 6
> >> +    description: Physical base address and length of registers for all bridges
> >> +
> >> +additionalProperties: false
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +
> >> +examples:
> >> +  - |
> >> +    axi2apb: axi2apb@2390000 {
> >
> > As axi2apb appears to be a bus, then all the child nodes (APB devices)
> > should be under this node.
>
> axi2apb is a bridge which coverts an AXI to APB interface and not a bus.

A bus and bridge node are pretty much one and the same in DT
representation. A PCI host bridge has a PCI bus beneath it for
example.

Rob
