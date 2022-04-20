Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480015091FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382466AbiDTVTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382459AbiDTVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:19:29 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD843AFF;
        Wed, 20 Apr 2022 14:16:41 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e2442907a1so3352596fac.8;
        Wed, 20 Apr 2022 14:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Th0dX12lMZvuR5tp3w0qZKCRz9BSomG0+8iVjF7Mv6I=;
        b=eX0QqQW88hx8G7QCneDX3tSDfbba4bDnHm4r3NuLshiBISt+QJJFmME46HogJOayMN
         /DjW98J2IQkQJj8CLV08BwA6Z7iof/Su33m4kmx2Mc0C+MQnHah/lomP8vb5O67XMEBw
         HwYLz9hL8X2g9/zSEIVh5egWAXGdxXmGPpwHXJgr8Q21xjqGC6v9I6msBWW/dhnW3JqE
         QGHS2gw6DB8GvxGBTeUhutnbY9/hTCyBHSVFkLywWA/x97qRR4ylta1/+Lf9OZpszkVd
         QYlMRPc7ObP82HSYyWO8BnK6qQegaGKRAlPKxizYDEQJX3EjAJAndiKj+CCjDIptzuCY
         XgaQ==
X-Gm-Message-State: AOAM5333TUuLb4HJdKJA4v2NC5/Cxdngz1xU0I2WWuR5gIMCQqQOV/UD
        1pXPi75WnK0svWI/Bt1mJA==
X-Google-Smtp-Source: ABdhPJyZQZnIeSTcR5QuXFH20WVVwckci/cxd1Nup7ns0hvWRZjAm9QuV170gcMZwvBniomX13r5Jw==
X-Received: by 2002:a05:6870:b39c:b0:d1:4a9f:35f9 with SMTP id w28-20020a056870b39c00b000d14a9f35f9mr2310887oap.119.1650489400567;
        Wed, 20 Apr 2022 14:16:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y23-20020a056808061700b00322e73cd18bsm953770oih.16.2022.04.20.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:16:40 -0700 (PDT)
Received: (nullmailer pid 1863106 invoked by uid 1000);
        Wed, 20 Apr 2022 21:16:39 -0000
Date:   Wed, 20 Apr 2022 16:16:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     sebastian.hesselbarth@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, andrew@lunn.ch,
        linux-mmc@vger.kernel.org, gregory.clement@bootlin.com,
        krzk+dt@kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: mmc: convert orion-sdio to JSON schema
Message-ID: <YmB4N1w/dgioauMA@robh.at.kernel.org>
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
 <20220414230603.567049-4-chris.packham@alliedtelesis.co.nz>
 <1650033161.788328.251788.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650033161.788328.251788.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 09:32:41AM -0500, Rob Herring wrote:
> On Fri, 15 Apr 2022 11:06:02 +1200, Chris Packham wrote:
> > Convert the orion-sdio binding to JSON schema.
> > 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >  .../bindings/mmc/marvell,orion-sdio.yaml      | 43 +++++++++++++++++++
> >  .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
> >  2 files changed, 43 insertions(+), 16 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> mvsdio@90000: $nodename:0: 'mvsdio@90000' does not match '^mmc(@.*)?$'

Looks like all these will be fixed with patch 1, so nothing to do here.

Rob
