Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5D59C5AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiHVSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiHVSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:03:58 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D02CC82;
        Mon, 22 Aug 2022 11:03:58 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id p187so5835615oia.9;
        Mon, 22 Aug 2022 11:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=esNtcNx3BW0ZYDyHJtcCsZAGZC+vRBsZkbC1+V6YdwA=;
        b=TFjqIKk5GQjCmIwT98BjnxzTsJa2jL2miPnyMvgOZRiDk2Dw/tUwvn7MyDxY0DOoX8
         E3LV34Db7jotsincJl31rTfsWJSdeTNBI8/0M32o3h3CacTnc8BsOfWTSWPguxJ6Y2kM
         HiEDUuU/ma3Dqlgu2L2lLKlhwwmxOZxNeet1b5O8n5WFBt22UvcBm38IPXTLlRNvH+R3
         KrQd2tB8SR6cDf4+cg1f6z2PW8ARmezgVfV+eEcAfjCEFGCnlG3eeLIk30Bnznc3GXyT
         dKiWLd7gNn85Tjoy9VNvLT/7FaHaFSA10vfREt+yHGyts0TADSexb8acPa8m0lD+xhov
         aSvw==
X-Gm-Message-State: ACgBeo3t+nhBBRLbKDwbdterKT3eRJIDwfui3SxijovMCD7FR/2lymba
        vEzHxeNAJvO5bF5AT7eA5Q==
X-Google-Smtp-Source: AA6agR60bjoaWedKbnY/NS+tnW/H2Gz998DSgaZ40yNsNvcB/kC7hRFGHbUXBQym/1J5IOcu17Q8VQ==
X-Received: by 2002:a05:6808:308e:b0:343:4b22:1a1e with SMTP id bl14-20020a056808308e00b003434b221a1emr9769893oib.102.1661191437571;
        Mon, 22 Aug 2022 11:03:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j4-20020a9d7384000000b0063711d42df5sm1656299otk.30.2022.08.22.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:03:57 -0700 (PDT)
Received: (nullmailer pid 74561 invoked by uid 1000);
        Mon, 22 Aug 2022 18:03:55 -0000
Date:   Mon, 22 Aug 2022 13:03:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johnson Wang <johnson.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Peng Fan <peng.fan@nxp.com>,
        linux-mediatek@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: interconnect: restrict opp-table to
 objects
Message-ID: <20220822180355.GA74500-robh@kernel.org>
References: <20220818061653.9524-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818061653.9524-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 18 Aug 2022 09:16:53 +0300, Krzysztof Kozlowski wrote:
> Simple 'opp-table:true' accepts a boolean property as opp-table, so
> restrict it to object to properly enforce real OPP table nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct typo in msg.
> ---
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml        | 3 ++-
>  .../devicetree/bindings/interconnect/mediatek,cci.yaml         | 3 ++-
>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 

Applied, thanks!
