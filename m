Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3B4E33CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiCUXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiCUW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:58:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4B5362D06;
        Mon, 21 Mar 2022 15:36:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so396129wmb.4;
        Mon, 21 Mar 2022 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEY0X4OyCU3/iAzQa5k+IyEdis1PzP3qOVzQs+i3IrU=;
        b=LkwRWPCX/iULhA7/6CDwI/dQQG+8KKQEDgfZekVNHnJLVpuugYPcECcWvhcZh+pxGF
         RQtjateZgvCJXR1QmD6Z1shAJcueM3/8XtWPuZcZLkU4O2ndQgvnniTyMTc7tLuRQLE6
         lzIVOvGgLwJ529joD5QTMtSPhKevjJWSXAfrCBeFBIPPkW79CZiCHIvRnhkgEyr+bqkM
         kQPES1cRfkfYwj5VSe/jbfrJ4hxQrP49MR02uPWx6bIxr2mc/VLxCR/VhwCSCkTujdd8
         fGLOZkPRx58d58X3V0C49ZXm2M82PrMHaNHvrpuGRa49D0uQCiXIs+iaFq1k0CzIgPiG
         2yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEY0X4OyCU3/iAzQa5k+IyEdis1PzP3qOVzQs+i3IrU=;
        b=3xWeltTzY1mF1k4R8jUJ6KurG9vpf99540DiAe7W5suSSxgkCsybowEdbMOgiq3K1J
         jlD5E5QzLQencR0Nrf2QKQrIpa5rZM1d1G/I+/W9XSdhTHK3I7hRm0FWF7Nib29rJflg
         CfkO1a1NoTq3ZQYXrqvlo/8iuBkaUcQ8+1iUREfhm0rPJbo4OA7XgdKLxp7OpY83JxRO
         jI46usYbtormYu4GwOP4y+FuHlNoI2Vd4HAktbrRSkVtoJ52J7QY6pPwFX+cQZNgnauH
         Z8Iw3C0qdTS/5pebxM3vjM6fRP2zxZ91Gzg6adLMZEf6Hpsli/tCfVDqxQNCerQI1wLD
         ztUQ==
X-Gm-Message-State: AOAM531kYoyKHwfS37DK5iQR1c7JbfcOCFmszi3CmZMAtit2UdDQpGJF
        GW3zOyptSak5pa9kNiA67SHfWPuJO10=
X-Google-Smtp-Source: ABdhPJwOu5SgpIvDS+cc8Pa3YCZ3gEvW6NMK+B3R5zhf3SQ0JtRxwjwPpnCkLe2VulMXizTjOT7fHg==
X-Received: by 2002:a7b:c922:0:b0:383:e7e2:4a1a with SMTP id h2-20020a7bc922000000b00383e7e24a1amr1015908wml.51.1647900049727;
        Mon, 21 Mar 2022 15:00:49 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm8773157wrv.49.2022.03.21.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:00:49 -0700 (PDT)
Date:   Mon, 21 Mar 2022 22:31:29 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 15/18] dt-bindings: clock: Add L2 clocks to
 qcom,krait-cc Documentation
Message-ID: <YjjusXDsyhWMUeZb@Ansuel-xps.localdomain>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
 <20220321153855.12082-16-ansuelsmth@gmail.com>
 <YjjzQw4z6GCmlmp+@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjjzQw4z6GCmlmp+@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:50:59PM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 04:38:52PM +0100, Ansuel Smith wrote:
> > Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
> > and the hfpll_l2 clock to be provided. Add these missing clocks to the
> > Documentation. The driver keep support for both old and this new
> > implementation and should prevent any regression by this fixup.
> 
> Depends on what the old driver looks for.
>

The old driver used parent_names with the same name declared now in the
Documentation.

> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/clock/qcom,krait-cc.yaml     | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> > index e879bfbe67ac..f89b70ab01ae 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> > @@ -23,16 +23,20 @@ properties:
> >      items:
> >        - description: phandle to hfpll for CPU0 mux
> >        - description: phandle to hfpll for CPU1 mux
> > +      - description: phandle to hfpll for L2 mux
> >        - description: phandle to CPU0 aux clock
> >        - description: phandle to CPU1 aux clock
> > +      - description: phandle to L2 aux clock
> >        - description: phandle to QSB fixed clk
> 
> Clock indices should not change. New clocks go on the end of the list.
> 

Sad but will change if necessary.

> >  
> >    clock-names:
> >      items:
> >        - const: hfpll0
> >        - const: hfpll1
> > +      - const: hfpll_l2
> >        - const: acpu0_aux
> >        - const: acpu1_aux
> > +      - const: acpu_l2_aux
> >        - const: qsb
> >  
> >    '#clock-cells':
> > @@ -50,10 +54,10 @@ examples:
> >    - |
> >      clock-controller {
> >        compatible = "qcom,krait-cc-v1";
> > -      clocks = <&hfpll0>, <&hfpll1>,
> > -               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
> > -      clock-names = "hfpll0", "hfpll1",
> > -                    "acpu0_aux", "acpu1_aux", "qsb";
> > +      clocks = <&hfpll0>, <&hfpll1>, <&hfpll_l2>,
> > +               <&acpu0_aux>, <&acpu1_aux>, <&acpu_l2_aux>, <&qsb>;
> > +      clock-names = "hfpll0", "hfpll1", "hfpll_l2",
> > +                    "acpu0_aux", "acpu1_aux", "acpu_l2_aux", "qsb";
> >        #clock-cells = <1>;
> >      };
> >  ...
> > -- 
> > 2.34.1
> > 
> > 

-- 
	Ansuel
