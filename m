Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C128D4E30AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiCUTUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352620AbiCUTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:19:56 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72C1CB00;
        Mon, 21 Mar 2022 12:18:23 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id g5-20020a4ae885000000b003240bc9b2afso20385069ooe.10;
        Mon, 21 Mar 2022 12:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zQsaTPyUZRrtGSfO6Vj1TGY8oZRoTuE+VKGytgXpzzg=;
        b=ArfqrP/y9oMW41ohoQWgFyxLlp0YQJDQtYwixlje6FqdqSX7xsXFpyQ3Y8fFrzTq+8
         G992R8z93KzTzdc0geJd/2AzL2Rw2NXcuIMqdLTuueSxh6hwzR3UjzoJrTVQblIorKFQ
         tp4wqYToVKGqwr/4lDNBT8jbWRcmgM+ymcP8YnGOH8560o1s99diInjoYdhHoNuxqA5z
         C0FVGJlkxBocvHjdZbcl9N61imorABWqC08fhAQeebc7KqFdI7EUViCShQYW+jvIqzHg
         wy0zolfds/z+emDcW89nJytL9Ked5Tj3dnixXCcNJLgM6Qpnq4lE8mAy2DrwnS2XQ2VO
         CHHg==
X-Gm-Message-State: AOAM532TsoJGio3TXYkpYJBuj+YuYFn5exyKxYwAPTPvXDYM5p5sheFB
        tTneqD8M69rG8v585laoNQ==
X-Google-Smtp-Source: ABdhPJzHrejqYtTO7cVO+lZa5TGwJfswtpENqFTFNjyk0JeJ7ytAcURFYCvK/4bCrBstINdyYiBs7Q==
X-Received: by 2002:a05:6870:d207:b0:de:1872:fe43 with SMTP id g7-20020a056870d20700b000de1872fe43mr271409oac.242.1647890303057;
        Mon, 21 Mar 2022 12:18:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 15-20020aca110f000000b002da58c4ec52sm7835920oir.6.2022.03.21.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 12:18:21 -0700 (PDT)
Received: (nullmailer pid 394706 invoked by uid 1000);
        Mon, 21 Mar 2022 19:18:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20220321153855.12082-19-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com> <20220321153855.12082-19-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Mon, 21 Mar 2022 14:18:20 -0500
Message-Id: <1647890300.369438.394705.nullmailer@robh.at.kernel.org>
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

On Mon, 21 Mar 2022 16:38:55 +0100, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> clock add the required '#clock-cells' binding while converting it.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1607841


clock-controller@2011000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960']
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

