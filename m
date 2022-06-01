Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069653A909
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355226AbiFAORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356216AbiFAOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:16:11 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2FC3D08;
        Wed,  1 Jun 2022 07:04:31 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id s188so2782635oie.4;
        Wed, 01 Jun 2022 07:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+gSZQW06c2J9Vc4RXJEh/UwV2q2eY7fbWj2w4Xp+OA=;
        b=3pkvJD9bhrEI9E+M3kLHM7NbiPH2JDV0fgSDIkZ/38XeQJA/KTjYU1SZmZTK7CX3NS
         vOT4fEwFgVNBPOoAQP62V8HGZPErp26zL2l79/QbHgrpWGT86hGBflL1qk1rxkWU8D+D
         S7tWPo+pcEYJ8AZFGhOsUnZspVqpe6Rpvj09XTpm0nj7qUt8UrsS2qL6LDURouu440Kh
         aNEyvmEKbj1oFXiD37e9ODGp+WmV9x497QAh3AbX9UgNyptaUc1Awp/bjM9n1+/Dw5A4
         lE7EHRRDSXUxM14rUjylLbr43dC4jmtqEMMD3S3pY85BnifI1+WnzrxkPhxorBijRbXe
         Wp/w==
X-Gm-Message-State: AOAM530wgMX15kUxw6TIhcafKItyfPRrKYyqJ617qiQ5fKfrr8nMchdX
        N80ldmplE6iMdz+8o3ptOA==
X-Google-Smtp-Source: ABdhPJzeZmIg6Eaxk/FFSJ7MRleaTDeX9X05UQX/nUSrA/9ETpZVpo1P14wSbRMgFSBe8n1csBuYlQ==
X-Received: by 2002:a05:6808:b04:b0:32b:8fc2:46e4 with SMTP id s4-20020a0568080b0400b0032b8fc246e4mr3165oij.54.1654092270390;
        Wed, 01 Jun 2022 07:04:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g9-20020a4a7549000000b0035eb4e5a6d3sm938894oof.41.2022.06.01.07.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:04:30 -0700 (PDT)
Received: (nullmailer pid 3915391 invoked by uid 1000);
        Wed, 01 Jun 2022 14:04:29 -0000
Date:   Wed, 1 Jun 2022 09:04:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hu Ziji <huziji@marvell.com>, Al Cooper <alcooperx@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Fix unevaluatedProperties warnings in
 examples
Message-ID: <20220601140429.GA3909718-robh@kernel.org>
References: <20220526014204.2873107-1-robh@kernel.org>
 <CAPDyKFoh5FyRDxr22XnkOd76MG4YjkvqL039=+qHGZKwfdFquw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoh5FyRDxr22XnkOd76MG4YjkvqL039=+qHGZKwfdFquw@mail.gmail.com>
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

On Wed, Jun 01, 2022 at 02:46:21PM +0200, Ulf Hansson wrote:
> On Thu, 26 May 2022 at 03:42, Rob Herring <robh@kernel.org> wrote:
> >
> > The 'unevaluatedProperties' schema checks is not fully working and doesn't
> > catch some cases where there's a $ref to another schema. A fix is pending,
> > but results in new warnings in examples. Fix the warnings by removing
> > spurious properties or adding a missing property to the schema.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Queued for v5.20 on the devel branch, thanks!

Can you take for 5.19 instead so I can enable this in dtschema sooner 
rather than later?

Rob
