Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56651C264
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380599AbiEEO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380124AbiEEO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:26:37 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52A2898A;
        Thu,  5 May 2022 07:22:57 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-edf9ddb312so3406838fac.8;
        Thu, 05 May 2022 07:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MYZ1J6FolI4230hKGE/4CLcUiPhVjInNSMzDjUnG2gg=;
        b=JffR8KR7lhAjuEk+zR7mgxVE2OMKCTC3xTPwuLpbKHMFZ8MzcWLY8KvgHHhpxWQTrR
         rFSUlW/oV0+9cB0C9GcPha7+slNgkLYSF/3KJ/x1GNp1aR7RpZcOnerwKzD2NITTSzdJ
         zblDxLpmMcx9vsD0VkcdMW363wBY+cFsPxyujaUQ+YlSqKvbaXVMUGf3IOq7ZcotZYlR
         N08+oOvtz4dvNqNhT6UX7Tc5M5+CROH/paxsXx7G/TfIItQoCMU3nANFPz71AtIHlfb0
         VeC9Tb7Lx29/qZrkMWJwfXyzbpdZNyKBK9n7o0JddJR608VU5y6yMT0AeQRIkwsNY0K3
         kpMg==
X-Gm-Message-State: AOAM5330rGZ4L3KprjkdEAZFICCl0ywoaR0s+v7sE1zK4rH4E5EZirRR
        hxe26mjz69MUcjdafvllig==
X-Google-Smtp-Source: ABdhPJwGr8T5ltzNlq2hul6Yx7sRNv30V35Ouw3uymLa76juOWSteruivvJJLaWMZuN36v/Vy/DfBw==
X-Received: by 2002:a05:6870:4624:b0:ed:977b:7842 with SMTP id z36-20020a056870462400b000ed977b7842mr2375196oao.89.1651760576568;
        Thu, 05 May 2022 07:22:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a9d6184000000b0060603221250sm644698otk.32.2022.05.05.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:22:56 -0700 (PDT)
Received: (nullmailer pid 3826717 invoked by uid 1000);
        Thu, 05 May 2022 14:22:55 -0000
Date:   Thu, 5 May 2022 09:22:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 02/13] dt-bindings: soc: qcom: qcom,smd-rpm: add
 power-controller
Message-ID: <YnPdv4wzYw5CTukU@robh.at.kernel.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
 <20220504131923.214367-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504131923.214367-3-krzysztof.kozlowski@linaro.org>
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

On Wed, 04 May 2022 15:19:12 +0200, Krzysztof Kozlowski wrote:
> Document power-controller child of Qualcomm RPM over SMD to fix
> dtbs_check warnings like:
> 
>   msm8916-huawei-g7.dtb: rpm-requests: 'power-controller' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
