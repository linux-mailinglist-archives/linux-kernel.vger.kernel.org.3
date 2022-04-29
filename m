Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E45156F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiD2VfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiD2VfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:35:18 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02359CEE24;
        Fri, 29 Apr 2022 14:31:59 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id r8so9849932oib.5;
        Fri, 29 Apr 2022 14:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipYeQfWFLcPKZ7mKRzp5aFzO9fJGsAJq6rg91kdXPzA=;
        b=xlKrTCaUsbxgnOF6DptXQmqOp4N/svT47lFFGdgjszc/2ZrIvVpvtpQRXAcuuymZxQ
         cFwxe9JQFq9QpqOwVUQeeR6K9brRjjX0iMLD5G/89zjMDxIzYxsyakPE+QU7sutMbKzY
         EFUbHqcfbQIrE3BUAHL6MWSH+poZYmwfevu8KVekQaycBz3ic7/dg4T7DG2XH8heCiyi
         Qttvfbhb5p3C+FSCVeEf9eskW8n4lvs3xY1/HJF9U6ggXYy+XU9vc5RE/dH5PTKgruZc
         MeccxcoW/elegprdZVxIllhSedHmfzHrX/lPSsqMlictVfimHqZiJkcA0foPUc6R0CdK
         w0Ug==
X-Gm-Message-State: AOAM5306Wu8sa4IUMnOv3Cw+OeN0M4vdi3aNBj8fdvFfNPQze2DscCKR
        Lf6Jl9OrbmaKytik97hlFasPxA3Wiw==
X-Google-Smtp-Source: ABdhPJya/0Vf9slHqEQZMdiq4bLMSDj4AKWTrwZobUGM5btcbpe/2eQzGgdRlYsVWAAKTcIpHtNWWQ==
X-Received: by 2002:a05:6808:219f:b0:322:9505:396d with SMTP id be31-20020a056808219f00b003229505396dmr2494199oib.141.1651267918288;
        Fri, 29 Apr 2022 14:31:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q8-20020a0568080ec800b00325cda1ffa3sm150320oiv.34.2022.04.29.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:31:57 -0700 (PDT)
Received: (nullmailer pid 2917268 invoked by uid 1000);
        Fri, 29 Apr 2022 21:31:57 -0000
Date:   Fri, 29 Apr 2022 16:31:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Message-ID: <YmxZTf7w40xv/Jvs@robh.at.kernel.org>
References: <20220429121739.28584-1-ansuelsmth@gmail.com>
 <20220429121739.28584-4-ansuelsmth@gmail.com>
 <1651247596.124069.2344494.nullmailer@robh.at.kernel.org>
 <626c0b64.1c69fb81.1b1e9.4fe6@mx.google.com>
 <5127b3b5-ad27-fd06-42b7-fdf96d0a10ea@linaro.org>
 <626c4ee8.1c69fb81.74b06.15c4@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626c4ee8.1c69fb81.74b06.15c4@mx.google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:45:09PM +0200, Ansuel Smith wrote:
> On Fri, Apr 29, 2022 at 10:43:21PM +0200, Krzysztof Kozlowski wrote:
> > On 29/04/2022 17:57, Ansuel Smith wrote:
> > > On Fri, Apr 29, 2022 at 10:53:16AM -0500, Rob Herring wrote:
> > >> On Fri, 29 Apr 2022 14:17:39 +0200, Ansuel Smith wrote:
> > >>> Convert kpss-gcc driver Documentation to yaml.
> > >>>
> > >>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > >>> ---
> > >>>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 -------------
> > >>>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 +++++++++++++++++++
> > >>>  2 files changed, 63 insertions(+), 44 deletions(-)
> > >>>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> > >>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > >>>
> > >>
> > >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >>
> > >> yamllint warnings/errors:
> > >>
> > >> dtschema/dtc warnings/errors:
> > >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'
> > > 
> > 
> > The patches were previously sent (even as v6) and somehow the history,
> > changelog and references disappeared...
> > 
> 
> Mhh with split how this should be handled? Putting the relevant changes
> in the cover letter?
> 
> > > Erm how to fix this? I can't do a 1:1 conversion if the source was
> > > wrong and also have no bot warning.
> > > Or I should just push an additional patch to fix this error after the
> > > conversion?
> > 
> > Didn't we agree that original bindings were not in good shape? Yet the
> > questions raised with your v6 remain actually not answered, till the bot
> > complains.
> > 
> > Please do not send the bindings which do not pass dt_binding_check.
> > 
> > Best regards,
> > Krzysztof
> 
> In v6 the last mail were with the idea of sending separate series with
> minimal changes and it was mention that it was a good idea to send only
> conversion and then send the changes with the conversion series.
> 
> Finally got the message. I should NEVER send patch with warning from
> dt_binding_check.

It's like sending code changes that don't compile...

But I wouldn't say NEVER. If you have a warning that you think is wrong 
or don't know how to fix, then send it and say that in the patch.

Rob
