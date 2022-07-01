Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D327E563BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiGAVhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGAVhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:37:07 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197D5C94E;
        Fri,  1 Jul 2022 14:37:05 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id h20so2151982ilj.13;
        Fri, 01 Jul 2022 14:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J86v2cLDP22dhdMQY1gkogeTSb0Yh6JFnGz+u5RmAN4=;
        b=n7EBcob2aoNHxC3VdPMo1ya4BTxVa2InRSrwDJr5w049qokmz0zxnfDLxuHFZws8jm
         A5ScfalNpF+UP1plY/q37I0bzHDx73uikxv1F5dlGwoPEhjH7t9wYitbioLlFXW87S3q
         4RTQzDHDBM/BweJzZCFhh2AmQ2fEyDn5syFUMETKUSi7BKgu4+qun5L9MLo/LlZTZzZl
         MrT2+MzRW48jskGRyv9amINACQYWIp9nFT32LaE+3xpg0o16amIqIm2ZYanWkBqa5NBz
         w3qa9QqpWULIwdcftW2HRlLzKchu1IhpPCuj+BCAMRb91VowQAR70xHfAlFxJM4MGFaN
         JSAQ==
X-Gm-Message-State: AJIora9dVxF842sfFyDyKgt4SJ0PXP1ND7j+1/sF+U8iyD5XG95UNJtZ
        j0lffUs3KOHfJ8vPtaLs+w==
X-Google-Smtp-Source: AGRyM1sYR91twYxQYAQPVbEe2Fqnz0wIkKnwr9gOaTJIX2q5xD/4kgmop65ap+DhwWDj1Bc3j/yEmw==
X-Received: by 2002:a05:6e02:1c85:b0:2da:956b:6bc with SMTP id w5-20020a056e021c8500b002da956b06bcmr9686339ill.36.1656711424773;
        Fri, 01 Jul 2022 14:37:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x5-20020a026f05000000b0033eb2f2ccfasm100716jab.43.2022.07.01.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 14:37:04 -0700 (PDT)
Received: (nullmailer pid 1599831 invoked by uid 1000);
        Fri, 01 Jul 2022 21:37:02 -0000
Date:   Fri, 1 Jul 2022 15:37:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: mtk-xhci: Make all clocks
 required
Message-ID: <20220701213702.GA1591697-robh@kernel.org>
References: <20220623193702.817996-1-nfraprado@collabora.com>
 <20220623193702.817996-3-nfraprado@collabora.com>
 <93c6b7201533325cf7758637dd194a372f3c00c6.camel@mediatek.com>
 <20220629185546.z6rn7xp3ejpmaupi@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629185546.z6rn7xp3ejpmaupi@notapiano>
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

On Wed, Jun 29, 2022 at 02:55:46PM -0400, Nícolas F. R. A. Prado wrote:
> On Tue, Jun 28, 2022 at 08:57:45AM +0800, Chunfeng Yun wrote:
> > Hi Nícolas,
> > 
> > On Thu, 2022-06-23 at 15:37 -0400, Nícolas F. R. A. Prado wrote:
> > > All of the clocks listed in the binding are always wired to the XHCI
> > > controller hardware blocks on all SoCs. The reason some clocks were
> > > made
> > > optional in the binding was to account for the fact that depending on
> > > the SoC, some of the clocks might be fixed (ie not controlled by
> > > software).
> > > 
> > > Given that the devicetree should represent the hardware, make all
> > > clocks
> > > required in the binding. Subsequent patches will make the DTS changes
> > > to
> > > specify fixed-clocks for the clocks that aren't controllable.
> > > 
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > 
> > > ---
> > > 
> > > Changes in v2:
> > > - Undid clock list changes that allowed middle clocks to be missing
> > > from
> > >   v1 and made all clocks required instead
> > > - Rewrote commit message and title
> > > 
> > >  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 +
> > > ---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > xhci.yaml
> > > index 63cbc2b62d18..1444d18ef9bc 100644
> > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > @@ -67,7 +67,6 @@ properties:
> > >      maxItems: 1
> > >  
> > >    clocks:
> > > -    minItems: 1
> > >      items:
> > >        - description: Controller clock used by normal mode
> > >        - description: Reference clock used by low power mode etc
> > > @@ -76,9 +75,8 @@ properties:
> > >        - description: controller clock
> > >  
> > >    clock-names:
> > > -    minItems: 1
> > >      items:
> > > -      - const: sys_ck  # required, the following ones are optional
> > > +      - const: sys_ck
> > >        - const: ref_ck
> > >        - const: mcu_ck
> > >        - const: dma_ck
> > 
> > This patch causes more check warning, I prefer to leave dt-bindings
> > unchanged, but just fix mt8195's dts warning instead, thanks a lot
> 
> Hi Chunfeng,
> 
> the warnings reported by Rob's bot only happen if patches 3 and 4 aren't applied
> to adapt the devicetrees. They are ABI breaking changes, but I understood this
> as the desired solution from the discussion we had with Krzysztof on v1 [1].

The warnings have nothing to do with patches 3 and 4 as those are for 
dts files. It's examples in bindings that are the problem.

Rob
