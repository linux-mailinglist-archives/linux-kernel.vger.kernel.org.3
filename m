Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F65728D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiGLVyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGLVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:54:51 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB3357D7;
        Tue, 12 Jul 2022 14:54:50 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id y2so9198369ior.12;
        Tue, 12 Jul 2022 14:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B8tMYfNlFFBawjqFpMsqY7d8iDUBaf8mx9VTGzxGhHc=;
        b=yK1Giavcuhhv9YVyIjvsB8daiG1XIH1UuisJaH0T85tWgGTjYdquR+Y1wbauOmcWjx
         WBcRIhJQD2+jAbBIF+PdIPNAxkCKTIBb2iILIFv3n8ZfTXFgpZkPZwdaqw+xCVfqHOo4
         8hxVw0jSNGmtnUltmSEhh09H1kg22uR/gx5ZXulsxAMwSYiaGSNm3F/FO2vqj29AE7Zq
         KEWia26UliJ7YnUnAdIGgrRHbvqJfwICmTAQmnjB4xUPrUS57trVpnhyIra47n/noRaS
         NapFgtowmQlWDApGTAkPmAphn9EpmCwUPCbsjIhb1MraESbBFOnqQqoSx0Mf01sPPDVK
         q6Eg==
X-Gm-Message-State: AJIora+3BaaBOs3uJIAMJLcGkqINT9usBhYFzqxfp6rC9QpG80lbiZpx
        vHURCWRoGdXVQt6s7RBxuQ==
X-Google-Smtp-Source: AGRyM1sTNF5cLSCr9EpJMt7vLz/hHDgjnWfrGwvfvH2h5+b+7Aw8r7rfZ4sFTiG0HwWsgHtxjiwo5Q==
X-Received: by 2002:a05:6602:2a42:b0:678:84be:c9ec with SMTP id k2-20020a0566022a4200b0067884bec9ecmr180408iov.64.1657662889754;
        Tue, 12 Jul 2022 14:54:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a29-20020a02735d000000b00339ef592279sm4573163jae.127.2022.07.12.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:54:49 -0700 (PDT)
Received: (nullmailer pid 2428467 invoked by uid 1000);
        Tue, 12 Jul 2022 21:54:47 -0000
Date:   Tue, 12 Jul 2022 15:54:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     john@metanate.com, heiko@sntech.de, p.zabel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, didi.debian@cknow.org,
        herbert@gondor.apana.org.au, sboyd@kernel.org,
        mturquette@baylibre.com, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 25/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Message-ID: <20220712215447.GS1823936-robh@kernel.org>
References: <20220706090412.806101-1-clabbe@baylibre.com>
 <20220706090412.806101-26-clabbe@baylibre.com>
 <1657114144.957232.4099933.nullmailer@robh.at.kernel.org>
 <YsWcGDwPCX+/95i3@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsWcGDwPCX+/95i3@Red>
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

On Wed, Jul 06, 2022 at 04:28:40PM +0200, LABBE Corentin wrote:
> Le Wed, Jul 06, 2022 at 07:29:04AM -0600, Rob Herring a écrit :
> > On Wed, 06 Jul 2022 09:04:04 +0000, Corentin Labbe wrote:
> > > The latest addition to the rockchip crypto driver need to update the
> > > driver bindings.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > ---
> > >  .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
> > >  1 file changed, 77 insertions(+), 8 deletions(-)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:0:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
> > 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too long
> > 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too short
> > 	False schema does not allow 4
> > 	1 was expected
> > 	4 is greater than the maximum of 2
> > 	4 is greater than the maximum of 3
> 
> Hello
> 
> I upgraded to dt-schema 2022.07 and fail to reproduce all errors.

Did you clean your tree or just touch this file after upgrading? I'm 
guessing not. We don't detect dt-schema changes. 

Rob
