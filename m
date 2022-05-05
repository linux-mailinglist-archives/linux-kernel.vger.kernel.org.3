Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDB51CBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386233AbiEEWRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386227AbiEEWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:17:06 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359D5EBDB;
        Thu,  5 May 2022 15:13:25 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id c22-20020a4ad216000000b0035f13ae7646so950522oos.9;
        Thu, 05 May 2022 15:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dw6mDqUtW1IcBDmIT9Uj1tyD3+Ete1lc8k+iE+64oyU=;
        b=si/qP2bNxsW7CuFIICiTijnPBFHgruCvS9ac30PKsEiU03n4+2T9B6lJq0+gEDD8PP
         i3tloOq3zpD7WW5/H70KrtIl+eEwDB7VrbAadWdCCAiOnQHf1eCGPZtx+Vhr+3hkOeht
         warniryIRRQlEtZPBJxTsQnMNyjVbYv+V1BwVP1+rDc9Q4/aDt0SlKsFMk3EZUeg9LHm
         h247QrC5/bj82ZHUtYi7rgbRLtpWqz+yYzZa2Jl3yx3f9c+RRr56xpu2Vc572uB+GbTg
         NTLsy/hsXPGMKiJ1ICZszOW2++1TjMMwVHT4uLZe5nZA1TQN7FyrZdfbzFTRpZ2VBRA/
         oZLQ==
X-Gm-Message-State: AOAM532jvTQtma3sse+YpKKOPLf/nU/ux64i0LbVLvoddP/2ODY1GUK+
        Evcu7/FbjDAxWXM+xIQCPU5WYPpN0A==
X-Google-Smtp-Source: ABdhPJxOc5FVD8sT0nwIy21thI5XYRxSYUZPQaP+QealOffMPjtb78oG9toMKYoC2Im9NqI1BQy6Bw==
X-Received: by 2002:a4a:621e:0:b0:35e:950e:6be8 with SMTP id x30-20020a4a621e000000b0035e950e6be8mr101204ooc.41.1651788805243;
        Thu, 05 May 2022 15:13:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fp13-20020a056870658d00b000edf5a12baasm927193oab.46.2022.05.05.15.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:13:24 -0700 (PDT)
Received: (nullmailer pid 288773 invoked by uid 1000);
        Thu, 05 May 2022 22:13:24 -0000
Date:   Thu, 5 May 2022 17:13:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-unisoc@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND,v2] dt-bindings: timer: Convert rda,8810pl-timer
 to YAML
Message-ID: <YnRMBKKn02Ut+Z/G@robh.at.kernel.org>
References: <20220504175502.GA2573@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504175502.GA2573@standask-GA-A55M-S2HP>
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

On Wed, 04 May 2022 19:55:02 +0200, Stanislav Jakubek wrote:
> Convert RDA Micro Timer bindings to DT schema format.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes in v2:
>   - Collect Krzysztof's and Manivannan's R-b's
> 
> It's been a month since the original v2, 2 months since v1,
> so I figured it's about time for a resend.
> 
>  .../bindings/timer/rda,8810pl-timer.txt       | 20 --------
>  .../bindings/timer/rda,8810pl-timer.yaml      | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 48 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
> 

Applied, thanks!
