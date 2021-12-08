Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E946D954
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhLHRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:16:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37296 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbhLHRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:16:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B9ABB821DD;
        Wed,  8 Dec 2021 17:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C2C341CB;
        Wed,  8 Dec 2021 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638983563;
        bh=zhdTco9B3K5IxIwHw6A2gZIWwdDrOmWoM619vHsVPbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D34iRWFF4ZbSrO1o9LzQdk1LDaNo2rH0qGEIH0/CfW+Qt2a05g9Le0JwPD3HfWF5r
         dLkdzloFYmxfwNQx7Zn/XdqbtII446Gkq6LwfJB4wwJ1ZaiKt3uz28NboiBPCmL+GI
         N7lq1Twwqs0HIdrIwdG6oQjxGwLZ49yfcq7eEn6mtivR/RIE4RvCb5je/b/9DyN6n1
         7jqEYpOjWl5X9qGFfWvFSEUtYL1QkmjxRYkhwLwaNpfjX4j2n1YE4Wmn+so05Jm6nh
         fpRFKECEkjsiDmF4oswrdDAunDzdIsMgLo21hIoYpNDp85Vemlv9j9I8hpfIYpfS26
         KxGro/Q5j79xg==
Received: by mail-qk1-f182.google.com with SMTP id m186so2583042qkb.4;
        Wed, 08 Dec 2021 09:12:43 -0800 (PST)
X-Gm-Message-State: AOAM530EyBgyvH9FSfMVjmEGklJzE7RHHmtQMzJHdz4NB6iuwpeiewLf
        h0jetQnL66brRX2ARt3kw/4/jfLukDbjcgEhzA==
X-Google-Smtp-Source: ABdhPJwgXgCZdCStNiwnLys/txVKe75J7k1CJgdfEbXzVI3f5tNc/PQyTDEroGkBaRkZazLU4sbMamnj2qk2snFWAoY=
X-Received: by 2002:a05:620a:2414:: with SMTP id d20mr8049147qkn.323.1638983562951;
 Wed, 08 Dec 2021 09:12:42 -0800 (PST)
MIME-Version: 1.0
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
 <1638262465-10790-4-git-send-email-harsha.harsha@xilinx.com>
 <Ya/SYqbVTPRdch5x@robh.at.kernel.org> <PH0PR02MB7271C9F92C667D80AB0A5CA8DE6F9@PH0PR02MB7271.namprd02.prod.outlook.com>
In-Reply-To: <PH0PR02MB7271C9F92C667D80AB0A5CA8DE6F9@PH0PR02MB7271.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Dec 2021 11:12:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+FWdOBB6YxUkK1rqGe-WiW6MAcKuQd=CXA4+7fRcF4xQ@mail.gmail.com>
Message-ID: <CAL_Jsq+FWdOBB6YxUkK1rqGe-WiW6MAcKuQd=CXA4+7fRcF4xQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
To:     Harsha Harsha <harshah@xilinx.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 10:17 PM Harsha Harsha <harshah@xilinx.com> wrote:
>
> Hi Rob,
>
> Thanks for your review.
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, December 8, 2021 3:00 AM
> > To: Harsha Harsha <harshah@xilinx.com>
> > Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Michal
> > Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; Sarat Chand Savitala
> > <saratcha@xilinx.com>; Harsh Jain <harshj@xilinx.com>
> > Subject: Re: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
> >
> > On Tue, Nov 30, 2021 at 02:24:22PM +0530, Harsha wrote:
> > > This patch adds documentation to describe Xilinx ZynqMP SHA3 driver
> > > bindings.
> > >
> > > Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> > > ---
> > >  .../bindings/crypto/xlnx,zynqmp-sha3.yaml          | 30 ++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> > b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> > > new file mode 100644
> > > index 0000000..45a8022
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> > > @@ -0,0 +1,30 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/crypto/xlnx,zynqmp-sha3.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xilinx ZynqMP SHA3 Hardware Accelerator Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Harsha Harsha<harsha.harsha@xilinx.com>
> >
> > space               ^
>
> Accepted. Will remove space in next version of patch series.
>
> >
> > > +
> > > +description: |
> >
> > Don't need '|' if no formatting to preserve.
>
> Accepted. Will remove | in next version of patch series.
>
> >
> > > +  The ZynqMP SHA3 hardened cryptographic accelerator is used to
> > > +  calculate the SHA3 hash for the given user data.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: xlnx,zynqmp-sha3-384
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    xlnx_sha3_384: sha3-384 {
> >
> > crypto {
> >
> > > +      compatible = "xlnx,zynqmp-sha3-384";
> >
> > You need some way to access this h/w.
>
> Accepted. Will add required details similar to https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/tree/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml

Why do you need a node for each crypto algorithm? Can't your firmware
tell you what algorithms it supports? Worst case, try each possible
one and see what fails or not. None of this needs to be in DT.

Rob
