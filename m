Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3D5638BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiGARoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGARox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:44:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB515A17;
        Fri,  1 Jul 2022 10:44:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d2so5357975ejy.1;
        Fri, 01 Jul 2022 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=2w2/BpthXqOHTkCsAaU0UBZebQgMrwCMp2rLplxRxgE=;
        b=Rx8I1j/jXL3YcmiEv56BHfgMxMTRlOdfVIYYEnZmBb0FNznCz+VEBtA1dE4KBGLx9d
         j3i1HbaVR6jUi6BtfPbCfh49QFeNvarrY4xJjD+7IRa8EAqHaoOa6wgVJmMAcPGjvt8V
         +mJgJJ5EhAd2vlrFLXiTA8/Fiy4o+KE7CRtdXM5sPIlZ9BV2rK+FV1EB5kzLuweBm7xQ
         ck0Akgz+Lw4+1Ed2Kdhrq2hM+QyeWwLu0OJwEm0aJwhy0GIwebfQWv8uI0QE+Lf2Ph/g
         bS7cHhsb4a0C7FsMRhdc+rMh3FNhBGbrSv6prflLRiwiaUvZI6oW+xeBsMios6Zo0GqJ
         mMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=2w2/BpthXqOHTkCsAaU0UBZebQgMrwCMp2rLplxRxgE=;
        b=YWRKe0cyu6Gz2sxC+NwfNBjAB2xCd1sizt9rHFoHntXHS7R8Z5bRsy8jcZBannSWH3
         UKIxxvaJJWsS1AqY5BEjADn9aC8d26ro6ijsv5/Al9jtJGE+Jwy0+G5TCx6jFsS+YZA0
         D58DAeyj6fotcFLtihMx+YwRqC/CY5VLD5zPjD5A0q4fhsa8Ye7UpfumR5O4+iUrTJN8
         QF2UktP85j1s9b966e8R/A4Yo2aZOOpjDpPpAzW9QQvGa3KZV9/kYYsoUKb9Kflzcfnh
         YCF4cyVPeKJ7LFAVoRscZTaHLe1yNbt3zs/jSSQYhn0S4vJxpZGr8ssOIGXjBEj0fl3Z
         rIXA==
X-Gm-Message-State: AJIora/mRVX2kl9QvW8ElT4AUC9DQ99pNnh65Zw9U8pPs1AQ4A/SDekr
        tsSqvCMfXiHZuRSCfAC2uf8=
X-Google-Smtp-Source: AGRyM1vY2qQU6x5AEoRfVHsbQLbVaw0kMakjWaMhipgGZ4HVZJKqUD4I3Y7652u2i2UpsDSCmJ0anw==
X-Received: by 2002:a17:907:608b:b0:725:f45:39be with SMTP id ht11-20020a170907608b00b007250f4539bemr15963305ejc.669.1656697490382;
        Fri, 01 Jul 2022 10:44:50 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906174600b00715705dd23asm10712725eje.89.2022.07.01.10.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:44:50 -0700 (PDT)
Message-ID: <62bf3292.1c69fb81.f66df.44ed@mx.google.com>
X-Google-Original-Message-ID: <Yr8vncVpgOcziTu0@Ansuel-xps.>
Date:   Fri, 1 Jul 2022 19:32:13 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver
 Documentation to yaml
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
 <20220629121441.6552-4-ansuelsmth@gmail.com>
 <20220701173238.GA1175908-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701173238.GA1175908-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:32:38AM -0600, Rob Herring wrote:
> On Wed, Jun 29, 2022 at 02:14:39PM +0200, Christian Marangi wrote:
> > Rework kpss-gcc driver Documentation to yaml Documentation.
> 
> It's not 'driver Documentation'. It's a DT binding for h/w.
> 
> Lot's of things are YAML. I prefer 'DT schema'
> 
> The subjects are bit long and get cut off as well. For the subject, 
> something like:
> 
> dt-bindings: arm: msm: Convert kpss-gcc to DT schema
> 
> And similar for the other patch.
>

It was pointed out that since this have additional change than simple
conversion, using "Convert" can be confusing.
Is Rework or Refactor a better naming for this single patch?

> > The current kpss-gcc Documentation have major problems and can't be
> > converted directly. Introduce various changes to the original
> > Documentation.
> > 
> > Add #clock-cells additional binding as this clock outputs a static clk
> > named acpu_l2_aux with supported compatible.
> > Only some compatible require and outputs a clock, for the others, set
> > only the reg as a required binding to correctly export the kpss-gcc
> > registers. As the reg is shared also add the required syscon compatible.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
> >  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
> >  2 files changed, 90 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml

-- 
	Ansuel
