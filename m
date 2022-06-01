Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C353AFEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiFAVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiFAVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:31:42 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BEB1B6FEE;
        Wed,  1 Jun 2022 14:31:40 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f2cbceefb8so4396592fac.11;
        Wed, 01 Jun 2022 14:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEbVkK2s1dx1I733B0KjgcXb+wOYev+2UVEaoJXI8eM=;
        b=m/NIyF83h/mGZ0z8tueOeoS8o64Mdtosbamfbua8lRFll+RuOMiewctJ6uDTWsbzqA
         uZ4rDDxJyxHcbR6TweQtkzNyOsyT30QZnPGxPYRlzCiwh7sxygfeK4/lnC+LfIB8uie+
         +3jjO56osucNAFLIa6w+N46VkRHhUO3iH28OFzUkf3YYRh3q0CVzJD98+EWbiphe7VaG
         Wl7H470qtQ1oIXnChc46gqpwctMPO6IsJPCxYEuoJ4g5MJqB7Z4vUiA7uBrsN94As+7/
         IhmZoYrG3R+sjBOY/zWdQvGz1Yk0hlvKJ+PEqkfFopvE9RdWYPHOPh9fxnbQAZILAMDC
         gOHQ==
X-Gm-Message-State: AOAM532RVaiLYWzrwHJjOWp0BPaQrPfRuVmiZAn/RYfOQ6Rt5dx8cL9W
        SjXD34DTNvVKBXAIpCGw1w==
X-Google-Smtp-Source: ABdhPJwGMf8v2YTPcJ/X9dmPhH+sCdV5KMAkFhLog+ZqoQtoHIigpK8SF/AVRx09qZ0e/AgHrPL/3w==
X-Received: by 2002:a05:6870:6491:b0:f3:4ec4:8cfe with SMTP id cz17-20020a056870649100b000f34ec48cfemr943133oab.66.1654119099994;
        Wed, 01 Jun 2022 14:31:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w17-20020a4ae4d1000000b0035eb4e5a6b1sm1423674oov.7.2022.06.01.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:31:39 -0700 (PDT)
Received: (nullmailer pid 495183 invoked by uid 1000);
        Wed, 01 Jun 2022 21:31:39 -0000
Date:   Wed, 1 Jun 2022 16:31:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v1] dt-bindings: clock: qcom: Relicense to GPL2 + BSD
Message-ID: <20220601213139.GA478939-robh@kernel.org>
References: <20220520124447.31289-1-robert.foss@linaro.org>
 <YofgAd/nAejaATli@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofgAd/nAejaATli@gerhold.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:37:53PM +0200, Stephan Gerhold wrote:
> On Fri, May 20, 2022 at 02:44:47PM +0200, Robert Foss wrote:
> > Qualcomm has given permission for all the dt-bindings to be dual
> > licensed. All of the Linaro authored bindings are easy to change, in
> > terms of the permissions & copyrights, so they've been bundled in this
> > commit.
> > 
> > Additionally clean up the syntax of some of the copyright statements.
> > 
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> > 
> > There are more Qcom bindings that should have the license updated
> > to GPL2+BSD, but since they haven't been authored or copyrighted
> > by Linaro, I think I'll have to hunt down the authors individually.
> > 
> >  include/dt-bindings/clock/qcom,gcc-msm8998.h          | 2 +-
> >  include/dt-bindings/clock/qcom,rpmcc.h                | 2 +-
> >  include/dt-bindings/clock/qcom,rpmh.h                 | 6 ++++--
> > 
> 
> At least these 3 have contributors outside Qualcomm and Linaro.
> Doesn't this mean you would still need to contact all of them
> and see if they are fine with relicensing their contribution?

Yes. Though I think you could draw the line at some number of lines. 
This is what I use to get # of lines by email:

git blame -e include/dt-bindings/clock/qcom,rpmcc.h | sed -e 's/.*<\(.*\)>.*/\1/' | sort | uniq -c | sort -n

> I don't want to make this more complicated than necessary, but it's
> probably better to be careful when it comes to licensing stuff...
> 
> (Although personally I think it feels a bit weird to discuss copyright
>  for a bunch of "numbered names"...)

Indeed.

Rob
