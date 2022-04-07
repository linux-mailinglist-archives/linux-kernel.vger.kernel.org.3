Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3654F81F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbiDGOlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344139AbiDGOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:41:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352611B2156
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:38:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so2256810wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+HrqUl2stcAnQOvkV/cLC8sh1bdsuE9uaYRM3SC8TAI=;
        b=QC/NBWbz8s242GqiqGVCxZjqkf65n2BOMSMdySwx5OMCnmpmfgmy2Gl0mqkViPk58A
         B0hFl228YREAAGFp1bTWTBF48v9/vcamAwhlivD7F9RoAWhkxTVUUszkElVwniFp+KSW
         153YOYtKLxloRx116E1JbzBPjjKXbUaIisB8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+HrqUl2stcAnQOvkV/cLC8sh1bdsuE9uaYRM3SC8TAI=;
        b=pPMLT6wOPZWlTBe/cU2DenZLe+xblAR60lt+6vrF+BmRfguMV12LoKt9wslznlbPrR
         HUQhONLHaFLoDM7U1J64BELR6XCLEGHMsK49E8elk/N5drjLLiLOwNkIii7H07N2HgcD
         Y76HWd3mzfXWPTfjjlKF/ntMJzLwN1k8b7bqnoEOv2zQDVT/ruf8/MRT8gr3y2thmVYX
         RJ3ynboQEUMPhVFxF7Davk95QUv4Qdq6b/4f3LY8gm2PfccUt1ZzS38szFVzNqryujGj
         YsTfgmI7xqHgkt+pioY5o2xBywkTzSWTg4SG646zfKR4GOr/Q2OSYf2BO48BjGkv0mFR
         g68Q==
X-Gm-Message-State: AOAM533NBu2whfGyppcqfb/O5cGOX1iuG/LeYD1mhcwLo33qXuefEltE
        oF5yPJfNpA3wItiDwlKv6DLU7A==
X-Google-Smtp-Source: ABdhPJxSm1o4AJPWmwSiOwXUcoOrfrDDoE6QavOVO+5QTW+urJsTAfmBJCV6RwoUxCRXXNUmmjXF1A==
X-Received: by 2002:a1c:f605:0:b0:37b:b5de:89a0 with SMTP id w5-20020a1cf605000000b0037bb5de89a0mr12345916wmc.88.1649342337820;
        Thu, 07 Apr 2022 07:38:57 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm7983010wmb.3.2022.04.07.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:38:57 -0700 (PDT)
Date:   Thu, 7 Apr 2022 14:38:55 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Yk73f9yyxy5LBC+V@google.com>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
 <20220331125818.3776912-4-fabiobaltieri@chromium.org>
 <Yk20uTE/Vdm2c6jI@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk20uTE/Vdm2c6jI@robh.at.kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Apr 06, 2022 at 10:41:45AM -0500, Rob Herring wrote:
> On Thu, Mar 31, 2022 at 12:58:17PM +0000, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,use_pwm_type property.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > index 4cfbffd8414a..9c895c990ed8 100644
> > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > @@ -19,6 +19,12 @@ description: |
> >  properties:
> >    compatible:
> >      const: google,cros-ec-pwm
> > +
> > +  google,use-pwm-type:
> > +    description:
> > +      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
> > +    type: boolean
> 
> Either do a new compatible string if the cell interpretation is mutually 
> exclusive (channel number vs. type) or split the number space for the 
> 1st cell between type and channel number. IOW, set a bit (31?) to 
> signify the number is a type, not a channel.

Split the number space was my first (tentative) implementation as well,
but it turns out that the PWM subsystem really wants channels to be
zero-based[1], so I don't think flags or bitmasks are really an option.

New compatible sounds good though, I'll rework a v3 with that change.

Thanks!
Fabio

[1] https://elixir.bootlin.com/linux/v5.17/source/drivers/pwm/core.c#L423

-- 
Fabio Baltieri
