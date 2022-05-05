Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24251C616
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382687AbiEERc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiEERc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:32:27 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FFC5D18B;
        Thu,  5 May 2022 10:28:47 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-ee1e7362caso773178fac.10;
        Thu, 05 May 2022 10:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NzMllqiCFMSk++1Pf8cggGcUFRMwRPHIUtf9ChBPQE4=;
        b=aIDQUSFZ039bcML3vr6G2BuSSiGiUk9++guspOC3moQdRtAJ4WRa3tp7Oyo0agWngp
         LhiG01JT5D4Hkhm75imAJ61SicALihuZnZNNjMSOJahn+lNS3mUklSgLCLQt3wFDfA1G
         DdYBqvzXgtE/7dQw0DcHzEz1apcXDieGj3q1SWNbhfGw4MAZWCLMnUazJUypTNyUNS75
         ykq5pIPlqVFj3xoohjEYczS2EwTt+EegpROajeb/cG00k5frwARvNXVNyvOTsH+cyaC0
         UsCfyIEkttZWmneB3NQHGGLquIPJ73gn2RZUtWLIx4VfjZRoLUuU1gj5wHkYH3QkW4WQ
         eXGw==
X-Gm-Message-State: AOAM533Axvg1S5eAGjrTvl/rOCT2EUqJfjfOD6ac8mOlHmdqVUOTXHSc
        xK1ih34bHo3ANqclOxvY3g==
X-Google-Smtp-Source: ABdhPJzbXUwqoOg2gQXT0rMHnNjixszBCvLaQ9ZH5Ha6xdImgOnprzJQzhB5X/rjzTxXqavjGonlkA==
X-Received: by 2002:a05:6870:4788:b0:ee:3a:8ab3 with SMTP id c8-20020a056870478800b000ee003a8ab3mr2604860oaq.231.1651771726859;
        Thu, 05 May 2022 10:28:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a15c4000000b0035eb4e5a6b0sm1034639oon.6.2022.05.05.10.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:28:46 -0700 (PDT)
Received: (nullmailer pid 4076881 invoked by uid 1000);
        Thu, 05 May 2022 17:28:45 -0000
Date:   Thu, 5 May 2022 12:28:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     judyhsiao@chromium.org, broonie@kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, alsa-devel@alsa-project.org, tiwai@suse.com,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@quicinc.com, srinivas.kandagatla@linaro.org,
        devicetree@vger.kernel.org, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, agross@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        linux-gpio@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: sc7280: Add compatible
 string for adsp based platforms
Message-ID: <YnQJTY21QnETY0z+@robh.at.kernel.org>
References: <1651672580-18952-1-git-send-email-quic_srivasam@quicinc.com>
 <1651672580-18952-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651672580-18952-2-git-send-email-quic_srivasam@quicinc.com>
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

On Wed, 04 May 2022 19:26:19 +0530, Srinivasa Rao Mandadapu wrote:
> Add compatible string to support adsp enabled sc7280 platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
