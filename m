Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3C5524F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbiFTUEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbiFTUEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:04:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF2B7C3;
        Mon, 20 Jun 2022 13:04:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j21so5824897lfe.1;
        Mon, 20 Jun 2022 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TpJe2xpme7GXSbx8BteS+b1+C5CW+OzG00NqoqCd678=;
        b=GSgF+cLqRXJKYf3yNnfmWqr54AVdQjLh6edCJujqgsd97Yjvqs+yQjD7Jss7v+++RO
         WKaj++N7QCuShBxlUPYrSALOOKBULdeMgxc0SJHf4THv6hvfIC2dW0a44SVE9NMkeMVI
         EWL7JiYMtx6ugjahBmlNNaxgkXDPMC1MPUkM4v7198x49O6R5rstD7SPtwITAQb83WEo
         YGPBmLgBESR5eVQIKB4t5Kt1h8H+C3vpRWBo4mgxfPYVbqgsFscseHB4frUSn7H1Asol
         XXZuy4kBz/Kf394dNHiZ8cBD9IlwrKu88hPNY+gpaZHSgW0bg0HnWhM7AVjpE5wWRcSy
         6VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TpJe2xpme7GXSbx8BteS+b1+C5CW+OzG00NqoqCd678=;
        b=G9Aw9TIv3WOmMTP1kBQb78B9cCKfRjccFiXcm5pLqONIWZQX0+zI+HhPLtGHc7Qvwq
         nsZ2Mgswo+V+PpseHtzEyw7hfn7h2fhShuHFUhTiuT8KDfoFhCVMSNchV/QKY1Aa/AMi
         rt9usWG7Qe1JSkA5Ady+dVxXUj7UQ1tfuzcsgmWxGTDoBOtp+YWsjailXuc0PWRmcgu6
         CPIXs3lFdgUhyk1Ott4KF0pua2SktBokjjsl3tDa/PMivON4+XxQvZUZbdSgdAkoKDEt
         sDlYPLeWTR2Ythe/xllfAlaBaWQpmCy+xESw0esZUrWXcN6QW/ffrZ+4+WpU8GOECFLq
         yruA==
X-Gm-Message-State: AJIora8GU7o/qBV157OxHyFIGnEjjN4Yr1WjPcBKRW+McAPe7My9hlmA
        X3XPouTbbJ9C30ROL0uy3sw=
X-Google-Smtp-Source: AGRyM1s9hC3AkuXJ3ZweWOOQOtexRt7GAioDH6EyzKPh6oV4TFpEWuIx0FeO/g4ACaXSg0VuNLv3WQ==
X-Received: by 2002:a05:6512:1050:b0:47d:c714:10ba with SMTP id c16-20020a056512105000b0047dc71410bamr14078604lfb.165.1655755488996;
        Mon, 20 Jun 2022 13:04:48 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a10-20020a19660a000000b0047e789b9700sm1867834lfc.118.2022.06.20.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:04:48 -0700 (PDT)
Date:   Mon, 20 Jun 2022 23:04:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220620200445.yew3vo3pnjhos7rs@mobilestation>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
 <20220620193044.ihxfn6kddif7j5la@mobilestation>
 <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:46:25PM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 21:30, Serge Semin wrote:
> > On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
> >> From: Brad Larson <blarson@amd.com>
> >>
> >> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> >>
> >> Signed-off-by: Brad Larson <blarson@amd.com>
> >> ---
> >>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> index e25d44c218f2..2a55b947cffc 100644
> >> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> @@ -73,6 +73,8 @@ properties:
> >>                - renesas,r9a06g032-spi # RZ/N1D
> >>                - renesas,r9a06g033-spi # RZ/N1S
> >>            - const: renesas,rzn1-spi   # RZ/N1
> > 
> >> +      - description: AMD Pensando Elba SoC SPI Controller
> >> +        const: amd,pensando-elba-spi
> > 
> > Not enough. The driver requires to have a phandle reference to the
> > Pensando System Controller. So the property like
> > "amd,pensando-elba-syscon" is also needed to be added to the DT schema
> > otherwise should the dt-schema tool correctly handle the
> > "unevaluatedProperties: false" setting (Rob says it isn't fully
> > supported at the moment), the dtbs_check procedure will fail on your
> > dts evaluation.
> 

> The property was here before, now removed, so I assume it was also
> removed from the driver and DTS. Isn't that the case?

Ah, the property has been indeed removed. The driver now searches for
the system controller by the next compatible string:
"amd,pensando-elba-syscon" using the
syscon_regmap_lookup_by_compatible() method. My mistake. Sorry for the
noise.

* Though personally I'd prefer to have a property with the phandle
reference in order to signify the connection between the system controller
and the SPI-controller. Otherwise the implicit DT bindings like having
the "amd,pensando-elba-syscon"-compatible syscon gets to be
hidden behind the DT scene. But seeing we have already got the Microsemi
platform with such semantic, I can't insist on fixing this.

-Sergey

> 
> Otherwise this is incomplete binding...
> 
> Best regards,
> Krzysztof
