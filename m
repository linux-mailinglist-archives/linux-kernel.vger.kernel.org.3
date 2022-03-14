Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE134D880E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiCNPaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiCNPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:30:02 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D38A19C06;
        Mon, 14 Mar 2022 08:28:52 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id d62so18604124iog.13;
        Mon, 14 Mar 2022 08:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6HtwX9B+I/cwGYS9sFs1EBK8BhKR73Z2a3cdC3BGMg=;
        b=J8s2g1ZOL0YHLuEbZGkVEEdRPjPN5FS3XcsDz8gGv7ueWRODUToo1wuG3VEmx6ZdRP
         mX/Ifsw51ixBewwwkMEHsMucP4XlUd+FWkuBZZNP0ipQapch6ggn35AeoN2p7QgzS46H
         agXVhunTk3NsmyiidoFhjoGBR4KMDKBsgNQaxyzgn6F3U1fzmfXYtU7pyYmIklVRrhyZ
         SRAmPPaPhc4vu8So4vLOXa2izc7drYa3cdgKfYU8v2tGJxcBrriTvmfwz9uqVquU+W+5
         IyVaxLDY6w66v/jn9R1cvaEG0a/wiKPraf0MTownKjyJVoyCnI44382OqPGdYbV3ObQ4
         0B6g==
X-Gm-Message-State: AOAM533zbipHEIexfQbW0taAdYkwSoEngqtLbqVum7a7olK3BK1SQ/ou
        GaGWpU8pwqf/V5cohUFMzQ==
X-Google-Smtp-Source: ABdhPJz8r2zMzOR+Daq/ViBSyP3Bs7uRlDXQ3MIRpNLW60TtgExiDCc4dWJQ0gmWm22TOePOpCoXdg==
X-Received: by 2002:a05:6638:12cb:b0:319:c047:6e57 with SMTP id v11-20020a05663812cb00b00319c0476e57mr18275449jas.215.1647271731576;
        Mon, 14 Mar 2022 08:28:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r9-20020a92cd89000000b002c655c48593sm9392229ilb.67.2022.03.14.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:28:50 -0700 (PDT)
Received: (nullmailer pid 84320 invoked by uid 1000);
        Mon, 14 Mar 2022 15:28:48 -0000
Date:   Mon, 14 Mar 2022 09:28:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        yc.hung@mediatek.com
Subject: Re: [PATCH 5/5] dt-bindings: mediatek: mt8195: add
 mt8195-mt6359-max98390-rt5682 document
Message-ID: <Yi9fMM26XHodzvc4@robh.at.kernel.org>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-6-trevor.wu@mediatek.com>
 <Yip5O3t0Ymyc2h+p@robh.at.kernel.org>
 <fc3c76ab274c12bea9be9e17823fcb4f80ddf764.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3c76ab274c12bea9be9e17823fcb4f80ddf764.camel@mediatek.com>
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

On Sat, Mar 12, 2022 at 10:20:21PM +0800, Trevor Wu wrote:
> On Thu, 2022-03-10 at 16:18 -0600, Rob Herring wrote:
> > On Tue, Mar 08, 2022 at 03:24:35PM +0800, Trevor Wu wrote:
> > > This patch adds document for mt8195 board with mt6359, max98390 and
> > > rt5682.
> > > 
> > > Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> > > ---
> > >  .../sound/mt8195-mt6359-max98390-rt5682.yaml  | 61
> > > +++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/mt8195-
> > > mt6359-max98390-rt5682.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-
> > > max98390-rt5682.yaml
> > > b/Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-
> > > rt5682.yaml
> > > new file mode 100644
> > > index 000000000000..7ec14d61b109
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-
> > > max98390-rt5682.yaml
> > > @@ -0,0 +1,61 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: 
> > > https://urldefense.com/v3/__http://devicetree.org/schemas/sound/mt8195-mt6359-max98390-rt5682.yaml*__;Iw!!CTRNKA9wMg0ARbw!zb7eaqdAQfuyPpP5m31L3Q5pdCulclJgnygkkMgYh2M6segUZedd-cYz51-5Q2XDCA$
> > >  
> > > +$schema: 
> > > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!zb7eaqdAQfuyPpP5m31L3Q5pdCulclJgnygkkMgYh2M6segUZedd-cYz5187C1ArQA$
> > >  
> > > +
> > > +title: Mediatek MT8195 with MT6359, MAX98390 and RT5682 ASoC sound
> > > card driver
> > > +
> > > +maintainers:
> > > +  - Trevor Wu <trevor.wu@mediatek.com>
> > > +
> > > +description:
> > > +  This binding describes the MT8195 sound card.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,mt8195_mt6359_max98390_rt5682
> > 
> > You have nodes for each of these components, why do we need new 
> > compatible string for each combination. You can figure out the 
> > combination by looking at each of those nodes.
> > 
> > Second, why does each combination need a new schema doc?
> > 
> > Rob
> 
> Hi Rob,
> 
> I'm not sure whether I can reuse the old schema doc because of the doc
> name and compatible string seems to be specifically for the codec
> combination.
> If I want to reuse the old schema doc, should I change the doc name or
> compatible string? Make the naming more general.

It's fine to either leave it named after the first compatible string or 
rename it if you want.

Rob
