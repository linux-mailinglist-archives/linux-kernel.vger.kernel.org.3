Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363451C281
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380624AbiEEO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380650AbiEEO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:28:55 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36254BCA;
        Thu,  5 May 2022 07:25:14 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id l16so4480059oil.6;
        Thu, 05 May 2022 07:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGBOPc3N9qF/C4mARfPp8CmuxJczywQ4J4cT073/c6E=;
        b=LZd5m8NC3oKzEH95JQhjqiSQk8DDSzVtjcUzyQog/mCYQV6L9Xvpz1rXSQF7m2uVKl
         /vZA77pyVeZhfcliJygz9DPy1pPi1dZf89r+9gLWelWbIn2+ouMAGSJ/EYP8eLB1EfhC
         s+0edXcOgtIWK2Q5hw5vx9oSacO4SFyJXsVsxyf32aIncBGw5UDw2dgWkQvThbtIEH0k
         GqKnWoeRuydjfezmHXKBIF5hZsb9X1f2twXHyGgu/YQaUsM89lwj04JD8XBMdzzuu97x
         EZL2UC/fvIyAu8H6fp7NyLn7VR7Rl5Fp3wUcq7DIIvOFugVQ8LJRKpEdsgYpT+1+E63h
         sHfA==
X-Gm-Message-State: AOAM533tmaq01Lglypjd4ukS8mLGQPtP8aa+JE33UoPXhyVpf7cr5ONQ
        452+sfT9CG5YwKzGbDJL9w==
X-Google-Smtp-Source: ABdhPJzwjLod3NVGLJDzAyv5wuRrPg6RCXoSMnpnBe0GnShykiuEYPnvw17HlvMTk49r/Pol/G1lSg==
X-Received: by 2002:a05:6808:30a7:b0:322:f55c:1338 with SMTP id bl39-20020a05680830a700b00322f55c1338mr2493900oib.161.1651760713161;
        Thu, 05 May 2022 07:25:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 15-20020a54418f000000b00325cda1ff8dsm691529oiy.12.2022.05.05.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:25:12 -0700 (PDT)
Received: (nullmailer pid 3830401 invoked by uid 1000);
        Thu, 05 May 2022 14:25:11 -0000
Date:   Thu, 5 May 2022 09:25:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH 04/13] dt-bindings: usb: qcom,dwc3: fix clock matching
Message-ID: <YnPeR88iAFyudMm5@robh.at.kernel.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
 <20220504131923.214367-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504131923.214367-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 May 2022 15:19:14 +0200, Krzysztof Kozlowski wrote:
> The bindings defined strict clocks but several variants do not use them
> in such order.  Split the clocks and clock-names per variants to match
> current DTS usage.  In few cases this might not be complete match, due
> to incomplete DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 222 ++++++++++++++++--
>  1 file changed, 200 insertions(+), 22 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
