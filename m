Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192984EA3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiC1Xnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiC1Xnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:43:32 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B51E674EC;
        Mon, 28 Mar 2022 16:41:51 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-df088cb155so3628577fac.1;
        Mon, 28 Mar 2022 16:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=om1jfT7LQJ2WzF+mEa728pkjUE9UGG3QEmScj7yu6ek=;
        b=ULDliSoczKuAQnYGovbDRJFRvh982dCuyS/4kB0IgpIVf4zVrUbXkg07K34BE94+Ro
         jk5C9zt/2BHNwCn2JP+wVT9K/VIVBYU0Sj59lKwy2KIvN0XgqhnJviQLa/UO66/Qcvuk
         ZPGeRP3KxoJXFQ8d2IpOs7mYdJujptBx1LNNNS5prhpf275jDJ3oyawSPTGdYADjyjd6
         yMtsh2fLhxDnFmeESPcVSL1drCLpHOD2YjRwEwCCk5LJCQT3Qw5Ef18dnBNneyFICXXV
         WvWh8aTLDVnY6NwYIGL8A31RcBXO4yC5PqW2uogl4ZUxlQ3+/tKERznueEISm+45HWNy
         0iGA==
X-Gm-Message-State: AOAM531LiK0ma1wguja+l2CCMojJ4amq2LjGOGybisvU8LDoAQpF808R
        LrCDX5R7Zlq7Nwnay1ajeA==
X-Google-Smtp-Source: ABdhPJxxw28YeT3ErL7L4AzgYSaPY2Q0JhMy6FMrwttt9IujI4sYXM+BzjBftKWTI/9cca7otPVZOg==
X-Received: by 2002:a05:6870:1085:b0:d2:7d2c:f5c0 with SMTP id 5-20020a056870108500b000d27d2cf5c0mr809650oaq.42.1648510910682;
        Mon, 28 Mar 2022 16:41:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm6741639oab.35.2022.03.28.16.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:41:50 -0700 (PDT)
Received: (nullmailer pid 3267936 invoked by uid 1000);
        Mon, 28 Mar 2022 23:41:49 -0000
Date:   Mon, 28 Mar 2022 18:41:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, rohitkr@codeaurora.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        broonie@kernel.org, dianders@chromium.org, swboyd@chromium.org,
        judyhsiao@chromium.org, agross@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/3] ASoC: qcom: dt-bindings: Update bindings for clocks
 in lpass digital codes
Message-ID: <YkJHvXziueHY1iwz@robh.at.kernel.org>
References: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
 <1647852981-27895-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647852981-27895-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 14:26:19 +0530, Srinivasa Rao Mandadapu wrote:
> Update dt-bindings for clocks as per ADSP bypass solutions, in which macro
> dcodec GDSCs are enabled using power domains in lpass digital codec drivers.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 17 +++++++++++------
>  .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 17 +++++++++++------
>  .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 11 +++++++----
>  3 files changed, 29 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
