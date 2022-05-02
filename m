Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C6517558
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386465AbiEBRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386459AbiEBRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:08:00 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477D26E4;
        Mon,  2 May 2022 10:04:30 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-e93bbb54f9so14818811fac.12;
        Mon, 02 May 2022 10:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZqvkkRDCdorFRZtCcuZ+8QHBB5xU6cFlN1q+kyC+GU=;
        b=beWatmc7g13JjCqJs1mDyuJ991P9RFpWQshurtXVWzj+tMb6oYsQKQtsH+95eHMQu6
         IxyIiKF4wNBN74zbbLF4DYCsdG4hy3G9KPW5jpIVcsPbdTGUU8OU/rSzvTpi5zSzkHAR
         hqds55q7zOX3yV1ve1vvCxcsnD6JmSRcjjlDmCI+Bn5KHGac33R38kMrZkPFXs48FSs9
         loWW1aBFswxKefVjOM4OQHnafKmEKhd8khqd+pk2kqo0XSul4hv5Qi25G3IbpuMWovmV
         UgGZCCgK43VUQJR6h08jqCURPqXaEQHBV00zDfFiDhEHFtAQstIca1ZH4drN0vcxPlyi
         fZSg==
X-Gm-Message-State: AOAM531RRQaL2qoA0vlgukOzVPCerTbmBnmerrcXFbAHu6sDDw+zr7bF
        Gt7UrWgCwT4ObXWV7RepxlVtOgUITw==
X-Google-Smtp-Source: ABdhPJw4D0yfe3Fz0McLxXba8QUskqPgAj+qjdP3d+lHF74ObtMt4NNeJRgeQ9fSvANifBABZ4ZBiA==
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id u1-20020a056870420100b000e647c4e104mr32155oac.257.1651511069314;
        Mon, 02 May 2022 10:04:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m4-20020a056870194400b000e686d13883sm6038754oak.29.2022.05.02.10.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:04:28 -0700 (PDT)
Received: (nullmailer pid 1339087 invoked by uid 1000);
        Mon, 02 May 2022 17:04:27 -0000
Date:   Mon, 2 May 2022 12:04:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, agross@kernel.org, bhupesh.sharma@linaro.org,
        adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the SDX65
 compatible
Message-ID: <YnAPGwCHA66V6+NW@robh.at.kernel.org>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
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

On Mon, 02 May 2022 14:07:42 +0530, Rohit Agarwal wrote:
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
