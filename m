Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDD4D6B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 01:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiCLAJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 19:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCLAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:09:57 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FF622635A;
        Fri, 11 Mar 2022 16:08:50 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so12373196oof.12;
        Fri, 11 Mar 2022 16:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+ZowuaGpChH9k7dXrO+pQwCk5UuyOxTNI7OLQVdPlw=;
        b=HnogdFWeuUfOHy4wp4FG9lhBQrDHhAlNHvBlkQntWIKWP1d7OR41oEThEUnuq8qCkq
         hoGNrxRs2reFTEynEoAuKk/7UauHhjtGIMGcbCeOWRiLYBGaeV5hroxfTc1qSksIY2QW
         zW3y3XOOOdB1t7Y3k/ExGUpcTq8Kif1rF7pyTJQXDeGtm2FJxi9MtV+Cxmr0xPcXEue2
         WuICvwAWWL9R50QjJi/2PrMJ+J5J0q/mDgq9s4iLMNb3ACgFWpiTNQih+i/FIWVVs57a
         qwuEoSSDzdiWNjjO6/G7WjG6hsEz7+w0toJmU7/X9hMVsyrppfeZmbKuavxkolCRKph7
         POaw==
X-Gm-Message-State: AOAM5334pxmx8Oh1VRp/TwDkmdzEp05zfzjjA6PKool13eCe5uDZ/lwy
        HzkJboHmd2r4t6aWei+voA==
X-Google-Smtp-Source: ABdhPJxKJfen2kigP0gnh/8VFptrw0maG5VWC2hBhKLIhJu+QNoF9eXdi5I/avYm4FAyN1IQGZsxTg==
X-Received: by 2002:a05:6871:890:b0:da:6895:1b41 with SMTP id r16-20020a056871089000b000da68951b41mr12065172oaq.74.1647043729574;
        Fri, 11 Mar 2022 16:08:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p21-20020a4a2f15000000b00320fca09b74sm4282072oop.1.2022.03.11.16.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:48 -0800 (PST)
Received: (nullmailer pid 445165 invoked by uid 1000);
        Sat, 12 Mar 2022 00:08:47 -0000
Date:   Fri, 11 Mar 2022 18:08:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add power-efuse binding
Message-ID: <YivkjyFhpW61VmJ2@robh.at.kernel.org>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-2-zev@bewilderbeest.net>
 <YitpuR+SlDiKh4eq@robh.at.kernel.org>
 <YivDpkajrJk3KfBM@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YivDpkajrJk3KfBM@hatter.bewilderbeest.net>
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

On Fri, Mar 11, 2022 at 01:48:22PM -0800, Zev Weiss wrote:
> On Fri, Mar 11, 2022 at 07:24:41AM PST, Rob Herring wrote:
> > On Mon, Mar 07, 2022 at 05:18:09PM -0800, Zev Weiss wrote:
> > > This can be used to describe a power output supplied by a regulator
> > > device that the system controls.
> > > 
> > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > ---
> > >  .../devicetree/bindings/misc/power-efuse.yaml | 49 +++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/misc/power-efuse.yaml b/Documentation/devicetree/bindings/misc/power-efuse.yaml
> > > new file mode 100644
> > > index 000000000000..5f8f0b21af0e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/power-efuse.yaml
> > > @@ -0,0 +1,49 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/misc/power-efuse.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Generic power efuse device
> > > +
> > > +maintainers:
> > > +  - Zev Weiss <zev@bewilderbeest.net>
> > > +
> > > +description: |
> > > +  This binding describes a physical power output supplied by a
> > > +  regulator providing efuse functionality (manual on/off control, and
> > > +  auto-shutoff if current, voltage, or thermal limits are exceeded).
> > > +
> > > +  These may be found on systems such as "smart" network PDUs, and
> > > +  typically supply power to devices entirely separate from the system
> > > +  described by the device-tree by way of an external connector such as
> > > +  an Open19 power cable:
> > > +
> > > +  https://www.open19.org/marketplace/coolpower-cable-assembly-8ru/
> > 
> > Not really a helpful link...
> > 
> > I still don't understand what the h/w looks like here. At least I now
> > understand we're talking a fuse on power rail, not efuses in an SoC
> > used as OTP bits or feature disables.
> > 
> 
> The systems this would actually be used for would be things like these:
>  - https://www.open19.org/marketplace/delta-16kw-power-shelf/
>  - https://www.open19.org/marketplace/inspur-open19-power-shelf-ob19200l1/

Those still don't help show me what the h/w looks like. High level 
schematics is what I'm looking for.


> The rightmost pictures on those pages show the four black connectors where
> the cable assembly linked in the patch plugs in, each of which provides the
> outputs from 12 such efuses, on 12 pairs of ground and +12VDC pins.  (There
> are also two more single outputs off to the side.)
> 
> It essentially just amounts to an external power output supplied by a
> regulator, with the regulator providing an on/off switch, overcurrent
> protection, etc.
> 
> And yes, the ambiguity of the "efuse" terminology is unfortunate (the
> "power-" prefix was an attempt to clarify it slightly).  That's the term
> used in the documentation for the hardware and hence is what I've called it
> here, but I'd be open to using a different name if that would help.
> 
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: power-efuse
> > > +
> > > +  vout-supply:
> > > +    description:
> > > +      phandle to the regulator providing power for the efuse
> > 
> > Vout is a supply to the efuse and not the rail being fused?
> 
> Yeah, that was a fairly muddled description -- it's really the latter.
> Perhaps:
> 
>   phandle to the regulator providing power for the output rail
>   controlled by the efuse
> 
> ?
> 
> > 
> > Sorry, I know nothing about how an efuse is implemented so you are going
> > to have to explain or draw it.
> > 
> > > +
> > > +  error-flags-cache-ttl-ms:
> > > +    description:
> > > +      The number of milliseconds the vout-supply regulator's error
> > > +      flags should be cached before re-fetching them.
> > 
> > How does one fetch/read? the error flags?
> > 
> 
> In the specific case I'm dealing with, via PMBus STATUS_* commands, though I
> was aiming to keep this more generic so it could potentially be used to
> describe non-PMBus arrangements (in the Linux case, via whatever mechanism
> the implementation of the regulator's .get_error_flags() function uses).

PMBus is I2C (subset). What device(s) is on the PMBus?

Here's what I've got for connections so far:

Vout(regulator)-->|efuse|-->12V

Host-->PMbus--->????

Rob
