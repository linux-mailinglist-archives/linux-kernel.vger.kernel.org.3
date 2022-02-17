Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875C44BAD05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiBQXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:04:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBQXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:04:07 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452925D25A;
        Thu, 17 Feb 2022 15:03:47 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id m185so5538317iof.10;
        Thu, 17 Feb 2022 15:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a90pTChAYnDmwk/LBPu/23Ywkd3tKQPqdNOZmAKI93Q=;
        b=5EUB1SVH01JRlVXqQGSZ9XyPf14cTKXidjQhvcs2W7Eltaze4J2eBgLrwtgr5jxyj5
         hj2gRnZ6z9+Gx+MrNiajBCHsLCrGcuIhWxtLfyRrpdbpHu28TWMKfUt7jYJcYYrx1N2f
         QQgf0GUy9+Hnsbn2rNAY+nyulFxgfp4VxDtD9PJC/QT4+M47amUXpphHcJwOpmjPc9er
         RKucuY7mNz18lk/OqDjz9cxFLsFRrkV79Qbrahg0o3G04JmIi8nWKuc80uSudmfapREQ
         i846t9sjfcNk3ujSwlL5TybNiVzv7MLUVb54CCQufYUY7LkrY8W/zbChOzf7qT8dYJMb
         hERQ==
X-Gm-Message-State: AOAM530RMvae5GjT9FRHccFp6QBITn36lVR9zOIOv7HK1WTPW3fTiIW1
        kIP3fTsvGlFoV9KhMHqYyQ==
X-Google-Smtp-Source: ABdhPJwBNOHhOTwNdVsdNbEO922dnDGVriqBho+EVOye2+ET06i6szcEIK8HwmqntGDDgPD3BpC68A==
X-Received: by 2002:a05:6602:1652:b0:611:56a8:8aae with SMTP id y18-20020a056602165200b0061156a88aaemr3410597iow.101.1645139026697;
        Thu, 17 Feb 2022 15:03:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w15sm268284iou.44.2022.02.17.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:03:45 -0800 (PST)
Received: (nullmailer pid 3935833 invoked by uid 1000);
        Thu, 17 Feb 2022 23:03:43 -0000
Date:   Thu, 17 Feb 2022 17:03:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     tiwai@suse.com, rohitkr@codeaurora.org, broonie@kernel.org,
        alsa-devel@alsa-project.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        lgirdwood@gmail.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        quic_plai@quicinc.com, devicetree@vger.kernel.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, judyhsiao@chromium.org,
        linux-gpio@vger.kernel.org, perex@perex.cz, swboyd@chromium.org,
        agross@kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: pinctrl: qcom: Update lpass lpi file
 name to SoC specific
Message-ID: <Yg7UT5eZbmMF+SyN@robh.at.kernel.org>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644851994-22732-2-git-send-email-quic_srivasam@quicinc.com>
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

On Mon, 14 Feb 2022 20:49:48 +0530, Srinivasa Rao Mandadapu wrote:
> Change generic lpass lpi pincotrol bindings file to SoC specific file,
> to distinguish and accomadate other SoC specific dt bindings.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 133 ---------------------
>  .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 133 +++++++++++++++++++++
>  2 files changed, 133 insertions(+), 133 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

