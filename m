Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33514E52E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiCWNVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiCWNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:21:01 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AA1FCFB;
        Wed, 23 Mar 2022 06:19:31 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso1053390otp.4;
        Wed, 23 Mar 2022 06:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HyrrPHrvO3f1aaisugCkhzShyIOT6AwhUm27bUwnRnY=;
        b=edJGnoiidC2B8L1eSAB1pVDctAy16XehxgC2A548wjV2WGwCQGPXPAZO8O/CaCwcCv
         d3NDrKaz09eHAevVn3XNZD8nUb7Uw2yly6B5TccEF3aCWguruS6EXr4XU7hemWQMF17e
         OCwZAjXB150bvRcNyKzPi0AsEx4L7KFz9JgJyAVYSQK3aNGCo93Kzvg019qz39T5zng2
         PEVv2hbFYioa2ojf591KV/Y3u7urGkQyeta+T+7tSMnUxuQscVNlkBG9cMrKECma5vlV
         xbxzniopKcuQYRKCLZbdXXB6Ss4W/gzcVUVU+moM973jCiz+nsqdrL74JzRxgSCIKw3U
         M70g==
X-Gm-Message-State: AOAM530+cprwJecoliORx8d/67oGTuZJLBOZU+sS1lcB7Lpr9vzV1wPn
        GPpnHtsAw+BrubVRn4lFaxOB90nWng==
X-Google-Smtp-Source: ABdhPJzsDMm/cvfuLg7u1LLlbwsqx1fxh37nvGVMM7XfRdRCrSnJJGXTwTDOnKPPSTOyY7+8cpZLIg==
X-Received: by 2002:a05:6830:4106:b0:5c9:6651:9333 with SMTP id w6-20020a056830410600b005c966519333mr11914812ott.183.1648041569775;
        Wed, 23 Mar 2022 06:19:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm9972012otn.55.2022.03.23.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:19:28 -0700 (PDT)
Received: (nullmailer pid 3946551 invoked by uid 1000);
        Wed, 23 Mar 2022 13:19:27 -0000
Date:   Wed, 23 Mar 2022 08:19:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Message-ID: <YjseX1+AGkByxpg7@robh.at.kernel.org>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
 <1647913851.222685.941035.nullmailer@robh.at.kernel.org>
 <Yjr2nkIrQ356DMUI@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjr2nkIrQ356DMUI@Ansuel-xps.localdomain>
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

On Wed, Mar 23, 2022 at 11:29:50AM +0100, Ansuel Smith wrote:
> On Mon, Mar 21, 2022 at 08:50:51PM -0500, Rob Herring wrote:
> > On Tue, 22 Mar 2022 00:15:47 +0100, Ansuel Smith wrote:
> > > Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> > > clock add the required '#clock-cells' binding while converting it.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
> > >  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
> > >  2 files changed, 69 insertions(+), 44 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/1607962
> > 
> > 
> > clock-controller@2011000: '#clock-cells' is a required property
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> > 
> > clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960']
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> > 
> > clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> > 
> > clock-controller@2011000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml
> > 
> 
> Sorry for the very stupid question but it's something i'm searching for
> a bit now... I can't really find Documentation or a guide on how to
> check single yaml and dts instead of using the make command and check
> everything. Am I missing something or this is not supported?

make allmodconfig
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml

And now in next you can do just the filename or a pattern:

make dtbs_check DT_SCHEMA_FILES=qcom,kpss-gcc.yaml

Rob
