Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E355B0ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIGVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIGVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:03:47 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B242B0B33;
        Wed,  7 Sep 2022 14:03:46 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1274ec87ad5so24234518fac.0;
        Wed, 07 Sep 2022 14:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EZ9HUgSqvyNc/+TpiOeV2TgoBH0eafNx+Qz6byNR00Q=;
        b=35jjD1WFGu+gCeWPAM1XqBtVh5vYSEnATB4m0v1v84/YzLKAXWfL0watyDEnstClUo
         3XkabWLWDl9fCnGzRfX8X+xGWgSfP0QC6w7H1gV4UL4j0EoaxwpZ/RKtWHmpPNASIiE8
         pvClJzjUSx4P3yElt5Ylkxm8wchXSCt0iKa0uicPHl1Vxn93EGGwn8GzlQ9IzTOLakKr
         R+/t9/jUD7teUn820pgpus2FfQASnHIT+lHWGblsYFJXztR8dVkmMgvbiMDFQMSP4SX6
         n5XwWhofUXws7fuecCdj0nSx45efiyCoJhXsGpaQF6wmu+z3JosBs9Mu8BNSPWNrZc+2
         BfOg==
X-Gm-Message-State: ACgBeo0zCrPJN6K1d02d0Nx+jN6YoJ3uoh6w/zpR5shXIRShsH3yZ6ij
        xoKhXW0xOBFgPn8o2lz2FTeOGv35gQ==
X-Google-Smtp-Source: AA6agR4rooqn7kfNEBlElGIRJEZFX1hZK2LfGqQwHU4505TZ2naJ3R3GcWRUN3L1te1UQPxaHUaY3Q==
X-Received: by 2002:a05:6870:45a1:b0:10b:8ee3:b3bd with SMTP id y33-20020a05687045a100b0010b8ee3b3bdmr172442oao.9.1662584625672;
        Wed, 07 Sep 2022 14:03:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n189-20020aca59c6000000b003430d6696e8sm6912227oib.8.2022.09.07.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:03:45 -0700 (PDT)
Received: (nullmailer pid 342051 invoked by uid 1000);
        Wed, 07 Sep 2022 21:03:42 -0000
Date:   Wed, 7 Sep 2022 16:03:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp-usb: add missing
 power-domains property
Message-ID: <20220907210342.GA342002-robh@kernel.org>
References: <20220902080705.12050-1-johan+linaro@kernel.org>
 <20220902080705.12050-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902080705.12050-2-johan+linaro@kernel.org>
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

On Fri, 02 Sep 2022 10:07:04 +0200, Johan Hovold wrote:
> At least the "sc8280xp-qmp-usb3-uni-phy" binding requires a power domain
> to be specified.
> 
> Fixes: aa27597e594c ("dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-usb-phy.yaml   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
