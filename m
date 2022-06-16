Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1CE54E641
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377396AbiFPPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiFPPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:41:54 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604237BDC;
        Thu, 16 Jun 2022 08:41:54 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id b138so1847950iof.13;
        Thu, 16 Jun 2022 08:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+Of7pAImRcJq99CbMv/G3hY7m2gLQV0aaUFDPDS9K0=;
        b=gR+VxdYtmBvcBdDIUCz8HkF49vmn3j+bQRWEosgEtYPY2NIrEFXSkbuLpAfHNQJ3iV
         q0+0m8qZGfyg+kg3yCCkftTNPpx/ofYyQ5HckDoKoIH80JKjUmbB6bETmMz9rcr5GhWH
         r987EfwAoBrIqfLOStRPnB101r4Yh8Lss0PLj677c8t+YBp6j8GhL5d3yzsMN0J2UZ11
         /Z0+nkfl6OM2QhWc6TY+2NDIbtzdTuJZhtfoospqLhFLwPhAkVkpAwRBMsgJ4gTyPVeV
         8Bx2l/EztDuKlcEZZ3Rcu3lJSMrGKxH2M+wyLqxsv3tJPpCOzpE6kPQvvZohn6p0vxlZ
         d5zw==
X-Gm-Message-State: AJIora/0VrOIUz2d+ciF9zGpgSeHrA33iLicoGBSxB3MfIiZEi/Q1wfX
        dFOW4GINyJLQCKiJxMY9kxybh3+/Pg==
X-Google-Smtp-Source: AGRyM1tSOR64Ae/eujWzzeeM77A3ZzCWEqAAf7jb/wDwxahhn0VLduHwEjuUuXSJE6UZ5RBW7e3Ang==
X-Received: by 2002:a05:6638:13d1:b0:331:c916:d6cd with SMTP id i17-20020a05663813d100b00331c916d6cdmr3029714jaj.317.1655394113361;
        Thu, 16 Jun 2022 08:41:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c9-20020a029609000000b00331d411da60sm1011098jai.75.2022.06.16.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:41:53 -0700 (PDT)
Received: (nullmailer pid 3528499 invoked by uid 1000);
        Thu, 16 Jun 2022 15:41:51 -0000
Date:   Thu, 16 Jun 2022 09:41:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-mtd@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-partitions binding
Message-ID: <20220616154151.GA3528396-robh@kernel.org>
References: <20220616001835.24393-1-ansuelsmth@gmail.com>
 <20220616001835.24393-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616001835.24393-4-ansuelsmth@gmail.com>
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

On Thu, 16 Jun 2022 02:18:35 +0200, Christian Marangi wrote:
> Document new qcom,boot-partition binding used to apply special
> read/write layout to boot partitions.
> 
> QCOM apply a special layout where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
