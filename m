Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554954BC72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357206AbiFNVAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245736AbiFNVAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:00:53 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E0250076;
        Tue, 14 Jun 2022 14:00:53 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id i16so10717787ioa.6;
        Tue, 14 Jun 2022 14:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6wiAEAPY25hq39gjHNba18GOciZXRMGE+/vSibk2A0Y=;
        b=pzKp/jCj0hGhQhT1oPjAQR/DQOF4LYGMx/Z69dnZw4Aw4X8PMrT+BUVjMlOWfDgCii
         5EryCoSdyeC5dmAQ/PMmp+gr3UaAKLA1uxicimv9Ua5fY3XObX7yPQNkGTmp0+Z3qsJR
         mOqZBWWk/U82hMofQENt/cTqVNBdfRtGCc6w1Z6Cf744y6AoBu0GsgrmPemuJd2kDhcJ
         aKjO7Bq9ROMQfWRb91fSbKxc7Npd1MXRJaGKCyRYt8ogWmKHn8/aWk1tP7Gn2KPbZElK
         bGPWZQwrDNKcSWzmjbYDn0IJ3Xr0dlNmR9rlC+UzlT2vFaWiZb2DKFlNzO+ClgzDVG2N
         vYyw==
X-Gm-Message-State: AOAM532e2A48yNjE839oK4utBZK0MHtmVisDGe2uhGx178OiI6aAWqGf
        ILDtMy1xNYlMdbZGd4htoQ==
X-Google-Smtp-Source: ABdhPJzIytzKnEVgu1QnavMIZw8F2v0fC5i8fFAEMNNu8RKGv/X2WWcvM5eIkW4e+95ltwCWuCHhLA==
X-Received: by 2002:a05:6638:1342:b0:331:e382:b0af with SMTP id u2-20020a056638134200b00331e382b0afmr4132233jad.32.1655240452595;
        Tue, 14 Jun 2022 14:00:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u12-20020a92d1cc000000b002d77ea49cd7sm5954020ilg.28.2022.06.14.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:00:52 -0700 (PDT)
Received: (nullmailer pid 2556989 invoked by uid 1000);
        Tue, 14 Jun 2022 21:00:50 -0000
Date:   Tue, 14 Jun 2022 15:00:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Andy Gross <agross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 3/3] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-partitions binding
Message-ID: <20220614210050.GA2556790-robh@kernel.org>
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
 <20220609132344.17548-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609132344.17548-4-ansuelsmth@gmail.com>
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

On Thu, 09 Jun 2022 15:23:44 +0200, Ansuel Smith wrote:
> Document new qcom,boot-partition binding used to apply special
> read/write layout to boot partitions.
> 
> QCOM apply a special layout where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
