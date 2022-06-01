Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10553AEF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiFAVSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiFAVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:18:05 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F16AA65;
        Wed,  1 Jun 2022 14:18:04 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f2a4c51c45so4373356fac.9;
        Wed, 01 Jun 2022 14:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB6dT/XCvf3C+B5FfUFc5pk+O7AJqhAY3bJMVvBLmO0=;
        b=aivA3m5Yvlpyl+pUHy+dBjTYLnfd7E+Dt70VezxgPXuUF9IxWRpNZVLhAQfQa0/Fjq
         27m/F6gcRt7nU+7qfLiWK5AEkAS9VxFSBCCSwz8dg0iRJeUbwoEGGS5lgGHl+eCT0yAO
         V5yvFUYAcIkPm0pJMPBx8Sa/IyIlEoDQXHb4VkkiowtaKQB/UQ/47KopEmQ41HhgU8x+
         aW/rDHzmOnTNn9bgAkEYPnFHgr1sWHLUFi7Xwbccu/eYrTio86CDK92UJ+e7i1r7rIKx
         OeKBqKcalUdcBfk6ZPcZ+xwM6DnsF5d0kQ6kMODvekRi1BKapTqt3eOh4ZZRZlV6PgUK
         IiyA==
X-Gm-Message-State: AOAM532KZedaMs9LsgoPuf54wfOhRv5D1CEYPvD/xwo5qftGasxQ3ij0
        HrNIVpsXFmlLzwHbPpv9FQ==
X-Google-Smtp-Source: ABdhPJyK7+g+68SDuh+gdaVuR1iTT6Wt141GPzQP3A1z+JoOYLQVSfSPqgb5fY0eBo6C+3xfL+BLrQ==
X-Received: by 2002:a05:6870:8888:b0:e9:a3eb:a52d with SMTP id m8-20020a056870888800b000e9a3eba52dmr904142oam.181.1654118283911;
        Wed, 01 Jun 2022 14:18:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o27-20020a9d411b000000b0060b469fa02dsm1344521ote.20.2022.06.01.14.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:18:03 -0700 (PDT)
Received: (nullmailer pid 472063 invoked by uid 1000);
        Wed, 01 Jun 2022 21:18:02 -0000
Date:   Wed, 1 Jun 2022 16:18:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
Message-ID: <20220601211802.GA472030-robh@kernel.org>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220519190112.6344-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519190112.6344-3-ansuelsmth@gmail.com>
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

On Thu, 19 May 2022 21:01:12 +0200, Ansuel Smith wrote:
> Document new qcom,boot-pages binding used to apply special
> read/write configuration to boot pages.
> 
> QCOM apply a special configuration where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
