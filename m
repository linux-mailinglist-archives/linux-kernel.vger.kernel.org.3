Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4E5ABA16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIBVcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIBVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:32:08 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE00F0776;
        Fri,  2 Sep 2022 14:32:07 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-12566bc8e52so4672416fac.12;
        Fri, 02 Sep 2022 14:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4QI4nEyjsiVuTahVuT4LVwrwcPM2qTDJilCYENPbJv8=;
        b=TpV+ZVihsErJn5UX/VdZqnav5eDihMYnlVb8aAgMwAsmStBCjzoGi4LAX6ixuhG9Ay
         PM2veihAuaZXLJeN/FsCxZVVJFblhlOgJFaivPXq/eB1ZWNYt3xTGp13vV4PyEVnVGdX
         BPJPYdhB2w/LI/QOd1P1wp1Mcamm2JWK1fVdpPE18iDpQqnE0KfuNP05QH4ISapsvE6q
         cPXqciBItaNvPspoqn+5ZqRoy3YlNpswt40iUsG+G2ahDCHAhfT3UfIEUVIJRLRkIcx/
         k1ftVWkjBlldeZuwfGW9URX4HnO71KqDm2mH5YgpQwYKK2VL3bB1Xz9XMhPUuHdeMOKS
         1MFA==
X-Gm-Message-State: ACgBeo1NSMajKWreoRy9J2/zR5UtNp0n0O5J4XSTENKU5aAjHubcs8P5
        bMBfyUg5eImU02kmWY8ocQ==
X-Google-Smtp-Source: AA6agR5GWmF9cXQRHgWyYJMq13ylv5lwehumlQvIzSsM+on4P9hTbKpE2WfQFxU/2FYHIFgr/a5Lvg==
X-Received: by 2002:aca:1c1a:0:b0:343:7dc2:7442 with SMTP id c26-20020aca1c1a000000b003437dc27442mr2592722oic.143.1662154327099;
        Fri, 02 Sep 2022 14:32:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r130-20020a4a3788000000b00448a3ecdc9dsm1083038oor.22.2022.09.02.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:32:06 -0700 (PDT)
Received: (nullmailer pid 450801 invoked by uid 1000);
        Fri, 02 Sep 2022 21:32:06 -0000
Date:   Fri, 2 Sep 2022 16:32:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH RFT v2 2/4] dt-bindings: soc: qcom: smd-rpm: add
 qcom,glink-channels
Message-ID: <20220902213206.GA450746-robh@kernel.org>
References: <20220901093303.134346-1-krzysztof.kozlowski@linaro.org>
 <20220901093401.134473-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901093401.134473-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 01 Sep 2022 12:33:59 +0300, Krzysztof Kozlowski wrote:
> The Qualcomm Resource Power Manager (RPM) over SMD bindings contain
> compatibles and description for RPM devices on two different
> communication channels: SMD and GLINK.  Except the difference in the
> parent node, they use different properties for describing name of
> channel qcom,smd-channels or qcom,glink-channels.  The first one is
> already present but second is missing:
> 
>   qcom/sm6125-sony-xperia-seine-pdx201.dtb: rpm-requests: 'qcom,glink-channels' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../bindings/soc/qcom/qcom,smd-rpm.yaml       | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
