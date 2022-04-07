Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB074F852D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbiDGQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiDGQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:51:12 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D0B61;
        Thu,  7 Apr 2022 09:49:11 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so822518otr.2;
        Thu, 07 Apr 2022 09:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9Hs+gnhjn+YVFkRSWJCDbSOkGyWB/bGPp9Wsa3Ssvo=;
        b=y3G9GyvZ3A8QzOl2MdfqS5ZAZhmvOrJDwsA9CTfoGhVXxTmkvVLebqgc7ybRtX4Cnp
         xX2GknR4v0G8VM5NKkWaSMKBFpVg0Wvm7yqA70uWKLsM/RTU4B2eIzhREMwhPiFv3Lcd
         x12wJoTOAoSDMtQqxPjsyHM0X0H/fMuvqAxRfeohDfVJ64jkkEa1MurY2iFiaUaCgAx+
         N91Saq9REQ7CtH1diaOsa7iYJu3NWnHtxc4M08dQqWwDRSBt722GqwUlAQJ0xkNfa9uh
         aG3Qzq4YldSfIlwcnt5/AOzpCGgAuFWoy7ZYaWITXlknKMC9BKwULZKKoy2UoKNVPQk5
         ffXg==
X-Gm-Message-State: AOAM532L0tDe5a0sa1eibe/JqHj/lsd4eF/6VvDMiODDJe7hvfUf/rxW
        rX1HC5ywU45t5nNV/nM4ig==
X-Google-Smtp-Source: ABdhPJwtMm69VAvbQPAQ41G9xgsuOi4yyFdqa/5hxgMvXOSvRMkU3dG5e/0MEKC0tS0NXw25Es2XZw==
X-Received: by 2002:a9d:20e2:0:b0:5c9:2edb:af8e with SMTP id x89-20020a9d20e2000000b005c92edbaf8emr5228736ota.325.1649350150961;
        Thu, 07 Apr 2022 09:49:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q11-20020a05683033cb00b005e686fd52d6sm4950701ott.17.2022.04.07.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:49:10 -0700 (PDT)
Received: (nullmailer pid 1386536 invoked by uid 1000);
        Thu, 07 Apr 2022 16:49:09 -0000
Date:   Thu, 7 Apr 2022 11:49:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Yk8WBXBH53rtZsBF@robh.at.kernel.org>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
 <20220331125818.3776912-4-fabiobaltieri@chromium.org>
 <Yk20uTE/Vdm2c6jI@robh.at.kernel.org>
 <Yk73f9yyxy5LBC+V@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk73f9yyxy5LBC+V@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:38:55PM +0000, Fabio Baltieri wrote:
> Hi Rob,
> 
> On Wed, Apr 06, 2022 at 10:41:45AM -0500, Rob Herring wrote:
> > On Thu, Mar 31, 2022 at 12:58:17PM +0000, Fabio Baltieri wrote:
> > > Update google,cros-ec-pwm node documentation to mention the
> > > google,use_pwm_type property.
> > > 
> > > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > > ---
> > >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > > index 4cfbffd8414a..9c895c990ed8 100644
> > > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > > @@ -19,6 +19,12 @@ description: |
> > >  properties:
> > >    compatible:
> > >      const: google,cros-ec-pwm
> > > +
> > > +  google,use-pwm-type:
> > > +    description:
> > > +      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
> > > +    type: boolean
> > 
> > Either do a new compatible string if the cell interpretation is mutually 
> > exclusive (channel number vs. type) or split the number space for the 
> > 1st cell between type and channel number. IOW, set a bit (31?) to 
> > signify the number is a type, not a channel.
> 
> Split the number space was my first (tentative) implementation as well,
> but it turns out that the PWM subsystem really wants channels to be
> zero-based[1], so I don't think flags or bitmasks are really an option.

Fix the PWM subsystem then...

> New compatible sounds good though, I'll rework a v3 with that change.
> 
> Thanks!
> Fabio
> 
> [1] https://elixir.bootlin.com/linux/v5.17/source/drivers/pwm/core.c#L423
> 
> -- 
> Fabio Baltieri
