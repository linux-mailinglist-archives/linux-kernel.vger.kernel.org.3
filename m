Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724415134C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346985AbiD1NUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346944AbiD1NUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:20:19 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8E5C85D;
        Thu, 28 Apr 2022 06:17:04 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id l203so5335608oif.0;
        Thu, 28 Apr 2022 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2KX0k1wrXX43D5TeLkqocszqE72U0xXm9eQIEdaCUbE=;
        b=TgY5XBw5uqMfXtjMf9sYoal5HTrNfcmvw4StcnpzzB0rDlRM45ZMcSDfPOKmgQTUjQ
         hPGz2xRhQn6EZt0Sp+F3f+bZHH5hburNjsjxkVLrLYejteID6EgeD08ceI9NzeoFmbQA
         skGVhl790JO4uD/JjOUx+t6ourfAKFAkT+efo2mC/Ohh3UToye5wqL9LqTbSti5NwFjy
         fGqjOmWAV2oMt63uQeByzICkDc1w05coNbBQoBTU2LsewXi8dIPNBjZs5Yd+behASMB8
         8UtjZW99RQcyyrLBj8/cK9EW8v7cD2z8N5WTxfDda43d0atYjjEvVkGIWQJ690+8/Qrd
         ZupQ==
X-Gm-Message-State: AOAM532fWHsXpUkXv9rmqVs1tdtdD/cxmzkv/ZUtAwI0mvVS38GL/FJC
        FWAFOp/yOVl8tte2V4D23g==
X-Google-Smtp-Source: ABdhPJz/d8BYWGUSJp+sBgndd/ngWTLW1+V3dbP8Dggh5IlPgtUXaU65s/zWtk3vrKBC101akso2uw==
X-Received: by 2002:a05:6808:2021:b0:322:ba69:53d2 with SMTP id q33-20020a056808202100b00322ba6953d2mr19985135oiw.22.1651151823956;
        Thu, 28 Apr 2022 06:17:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dt48-20020a0568705ab000b000e686d13875sm1825089oab.15.2022.04.28.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:17:03 -0700 (PDT)
Received: (nullmailer pid 2082134 invoked by uid 1000);
        Thu, 28 Apr 2022 13:17:02 -0000
Date:   Thu, 28 Apr 2022 08:17:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH 2/2] dt-bindings: mfd: Add bindings for the Mediatek
 MT6360
Message-ID: <YmqTzlrVL5KaVPuz@robh.at.kernel.org>
References: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
 <20220427080330.40136-3-gene.chen.richtek@gmail.com>
 <YmmQpg/Hh6qTNhj2@robh.at.kernel.org>
 <CAE+NS34SawC_pdTm=eDmp6zq1zLZgEaA+_s_xZOc4LuFHDV1iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS34SawC_pdTm=eDmp6zq1zLZgEaA+_s_xZOc4LuFHDV1iQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:30:38PM +0800, Gene Chen wrote:
> Rob Herring <robh@kernel.org> 於 2022年4月28日 週四 上午2:51寫道：
> >
> > On Wed, Apr 27, 2022 at 04:03:30PM +0800, Gene Chen wrote:
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Add bindings for the Mediatek MT6360
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  .../devicetree/bindings/mfd/mt6360.yaml       | 258 ++++++++++++++++++
> > >  1 file changed, 258 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml
> >
> > As I mentioned, I applied your previous version. Please send a patch on
> > top of it adding the child nodes.
> >
> > Rob
> 
> Hi Rob,
> 
>     I try to sync latest code and can't find the mt6360 led fixed patch.
>     Could you please tell me how to get and apply previous version?
>     And should I add a tags in commit message to tell which previous
> commit I based on?

The led fix is in my dt/linus branch and today's linux next.

The mfd patch is in my dt/next branch.

Rob
