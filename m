Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5705689D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiGFNly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiGFNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:41:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7D25280;
        Wed,  6 Jul 2022 06:41:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dn9so21901062ejc.7;
        Wed, 06 Jul 2022 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUXwjjf1U46wfMLKCsYIvNuZoHapS30B+iSnE2vDi98=;
        b=kqEhS1C88SXdC/AEcQncgZRYYuNMXDwHSE1d6A0+/0U3Jnpr9RB681WXtj5XRfPLyI
         oZJfjdawxAsCgy39VQVcWRHRxyOheyrX63VBk48oHTYR/Yc42IUlh/ycpvkJEdlyODbD
         VOl0HCwYmf0EQ7O5VPF4sfDrBSQOHl4vdxEaOyRDYdr0gUCOAZeagErgo1notCjcaDz8
         ATRusZunAP5nXLUHcHtt/Qdl7L9E4W+2M1BDiqm+RuBDci0Xx+Ms25UNxJJHs8WRxWq6
         LOf3PrVOdVxPvlimzwDoNRPWuP1TzpYvtW2VKt81YImJOx8udWBYTp9KNvD1lAz3UTkj
         kLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUXwjjf1U46wfMLKCsYIvNuZoHapS30B+iSnE2vDi98=;
        b=uEy42nkL0cDeJdBpU+qMz/dVrCVZXrX4b1hwGK32bKOw8cCkzDMC4peaR6E2FNUsmv
         pCIwZaFc8sxpfwgzAXMDpxcuZPaLtytMk0uicYLX6+tk4jdFrHXO09N9QYSpt54WWi7y
         jmVxoCw/a00UnQPCm3lXRw6WGRUocdAMk30U2vpkvnTRHe0qU2yAXCSy4BEd8S+O7F2D
         jiw0gBaq+6KkBvHbTUzazysnGtOyb1Xqf/H1AFrkmHc4b9DYlg7UNbM+K3hnhZOczVPL
         1FL41Tdrx72dpiEM9jrSPJBMWFWBRy4vEFDEkfSF+2IXbKrigwmlg4vzleZijURD9vgY
         y/MQ==
X-Gm-Message-State: AJIora/AW3AoJhTay0g/tAAQZz0Vv9uPM3nxeDy+1psFkdmG+JGNgEdC
        G+x7YsdyMP0aF1bPZ6fcptw=
X-Google-Smtp-Source: AGRyM1tuxALukWE0mce/eNKJsKRDcupgzd8ysNgkN59i6gZp96Mp4o9eMZxUakP5WLi+zuQq5A+2RQ==
X-Received: by 2002:a17:907:b09:b0:72a:8f36:e781 with SMTP id h9-20020a1709070b0900b0072a8f36e781mr26706939ejl.362.1657114905170;
        Wed, 06 Jul 2022 06:41:45 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170907784a00b0072aa014e852sm6747660ejc.87.2022.07.06.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:41:44 -0700 (PDT)
Message-ID: <62c59118.1c69fb81.9c3f3.ac43@mx.google.com>
X-Google-Original-Message-ID: <YsWNM1m58uj8XfkV@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 15:25:07 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-5-ansuelsmth@gmail.com>
 <8a394fa3-92fb-d162-b4ee-df010a09aed0@somainline.org>
 <62c58a60.1c69fb81.25b26.e72a@mx.google.com>
 <36a68a0b-0c18-deb5-609c-2128aa3fc21f@somainline.org>
 <62c58fca.1c69fb81.76f6a.15f4@mx.google.com>
 <43572937-8505-ddf0-1fe0-99ddfe486c11@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43572937-8505-ddf0-1fe0-99ddfe486c11@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:37:36PM +0200, Konrad Dybcio wrote:
> 
> 
> On 6.07.2022 15:19, Christian Marangi wrote:
> > On Wed, Jul 06, 2022 at 03:31:55PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 6.07.2022 14:56, Christian Marangi wrote:
> >>> On Wed, Jul 06, 2022 at 03:03:32PM +0200, Konrad Dybcio wrote:
> >>>>
> >>>>
> >>>> On 5.07.2022 15:39, Christian Marangi wrote:
> >>>>> Mikrotik RB3011 have a special configuration where the regulators are
> >>>>> not the common smb208 controlled by RPM but they use a TPS563900
> >>>>> controlled via i2c. Disable the smb208 for this specific device.
> >>>> Ok, so that answers my question from the previous email.
> >>>> Please define the SMB208 regulators only in the DTs of
> >>>> boards that actually use it, as it is not a SoC component as
> >>>> far as I can tell.
> >>>>
> >>>> Konrad
> >>>
> >>> This was already discuessed,
> >> Yeah sorry, I didn't notice earlier and started reviewing patches
> >> that were already reviewed by others.
> >>
> > 
> > Np, thanks for the review.
> > 
> >>
> >> rb3011 is the exception, qcom for ipq8064
> >>> recommends to use smb208 but gives the option to implement it in their
> >>> own way. So again we have 28 device with smb208 and 1 device that use
> >>> its own special way...
> >>>
> >>> Wonder if a separate dtsi can be used for this if we really can't put
> >>> smb208 in ipq8064 dtsi?
> >> There's msm8916-pm8916.dtsi. You can follow.
> > 
> > Ok, will put the smb208 definition to a separate dtsi, something like
> > ipq8064-smb208.dtsi? or ipq8064-rpm-smb208.dtsi? Looks also cleaner that
> > way.
> You can create ipq8064-smb208.dtsi that will also contain every ipq8064-plus-smb208-specific
> configuration, such as regulator assignemnts to in-SoC components (like PHYs, SDHCIs etc.).

Just for reference there regulators are used only for cpu voltage, l2
cache and special ubi32 cores that are not supported currently, nothing
more.

>
> Konrad
> > 
> >>
> >> Konrad
> >>
> >> [...]
> > 

-- 
	Ansuel
