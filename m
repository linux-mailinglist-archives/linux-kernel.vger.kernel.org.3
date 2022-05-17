Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3A52A4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348822AbiEQOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbiEQOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:22:00 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787D3F31D;
        Tue, 17 May 2022 07:21:59 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f165bc447fso14480609fac.6;
        Tue, 17 May 2022 07:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGLw+fL3COQe9QIwj4OBRKj6JpcSM3QF4138gdMPdzE=;
        b=ikGRGoc57+J5TFqxGeRAc3a3/+3tYUbcKiQhULmih7tH/uCKjgsDon8+DiSFPNGrXV
         b7f3CGaEdR3aqAbVjHaz7FJZ/4jQl5pOKbwJHk2nQIL/8AEr7fxMNDeLsGs9F8fr5N+Y
         cN2wQIGJ5DZqE/1FsraHvoZCxqv0ctDBYSRaxFukUWCrIWSNqD4emYhuiRAfayDp++QE
         dWnf8mrLPr+CB1nNMs0KgNonvlzqL21e0qRu+ta+vijsKFLJZd3act4F4odYyMpg0aOL
         PI5u68M708bbF1fBoTDinZ1GlCZiRzm/gwjntwy1UEzqcB5Ifc1wrh8bwNz82uMkWtNu
         srbg==
X-Gm-Message-State: AOAM530d5oEvsXbeFqI9Uh8YCF4HofKbA5zaVi8htaE4/3lMb/B+Z0P7
        WPP/JJBpbZyLHbL6cwgx8g==
X-Google-Smtp-Source: ABdhPJwkjZzrQtJW7pqXDLoSxK823lU3utXJvXWlEqV/zzdcAfsMM+H1ayUSQfIafy9OyB4u8Xqdjg==
X-Received: by 2002:a05:6870:798a:b0:ee:35da:33da with SMTP id he10-20020a056870798a00b000ee35da33damr18416708oab.83.1652797318530;
        Tue, 17 May 2022 07:21:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p8-20020aca4208000000b00325cda1ffa2sm5118019oia.33.2022.05.17.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:21:57 -0700 (PDT)
Received: (nullmailer pid 959507 invoked by uid 1000);
        Tue, 17 May 2022 14:21:56 -0000
Date:   Tue, 17 May 2022 09:21:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        quic_rjendra@quicinc.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, quic_lsrao@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: soc: qcom: Update devicetree binding
 document for rpmh-rsc
Message-ID: <20220517142156.GA959450-robh@kernel.org>
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
 <1652275016-13423-2-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652275016-13423-2-git-send-email-quic_mkshah@quicinc.com>
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

On Wed, 11 May 2022 18:46:51 +0530, Maulik Shah wrote:
> The change documents power-domains property for RSC device.
> This optional property points to corresponding PM domain node.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
