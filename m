Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B23563C2B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiGAWHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGAWHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:07:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663DE5A467;
        Fri,  1 Jul 2022 15:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C400B83200;
        Fri,  1 Jul 2022 22:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2608C341C8;
        Fri,  1 Jul 2022 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656713220;
        bh=vV0xSMuo4/omWk7j+wJWIgoUBObYOKdf2kAkWaDvdbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cx+eRAr9ZIMidBsJJjrNupJUmfqbEF8vVNJhkMLERbBhCOt2iVEgOe4wF4BtMCUAD
         gJBuX1FlAzcsOHqPljyVLSxb682L3U94XCyt2eBhaesUUELGulphr1tAuuxIpc4pFO
         0dMyFi1CQF/f09hk2jtyNJ7B56+Wx7FlXilrLGuioq0LhhOiXbXhBijXGSaOEakAyf
         ELNEYAf2eeALrSWmNUfq6GUUbg8jnzZvL6kLt3WHX3YRT7GDcVflYZea5Xvne3Jocw
         aApt6P2LG/ygiZAMbIxmj+QLaJ7ppBJ2YYlMld7DKgQ2L75YI7OSPeRbO3ZE+I/QsX
         4jHI7du1eYxcQ==
Received: by mail-vs1-f51.google.com with SMTP id j1so3502399vsj.12;
        Fri, 01 Jul 2022 15:07:00 -0700 (PDT)
X-Gm-Message-State: AJIora/Ly4gcFe1WPyuw5ysqsUfYF+/7Ko7ptGwr/KhtqSuAc3f1K3m3
        EO6XJw2Nrm9enqW8a64j1lNfaA+ZrCZaHcMifg==
X-Google-Smtp-Source: AGRyM1tY5ODSnMUrL1n6s0Fz7+UY7toiRD/dHxqXQNiOLgYLr4K2bKCoXQ2RFnKWRR7WH6idb6/meMUzWZf7DWM2ZAs=
X-Received: by 2002:a67:e407:0:b0:354:3d39:e0e7 with SMTP id
 d7-20020a67e407000000b003543d39e0e7mr12328267vsf.0.1656713219743; Fri, 01 Jul
 2022 15:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220514220116.1008254-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220514220116.1008254-1-bhupesh.sharma@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Jul 2022 16:06:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com>
Message-ID: <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "Gross, Andy" <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 4:01 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:
>
> Rob pointed some remaining issues in the sdhci-msm yaml
> bindings (via [1]).
>
> Fix the same by first using the 'mmc-controller.yaml' as
> 'ref' and thereafter also fix the issues reported by
> 'make dtbs_check' check.
>
> [1]. https://lore.kernel.org/linux-arm-msm/YnLmNCwNfoqZln12@robh.at.kernel.org/
>
> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> -> This patch uses the dts changes sent (here: https://lore.kernel.org/linux-arm-msm/20220514215424.1007718-1-bhupesh.sharma@linaro.org/), for fixing the dtbs_check errors.
> -> This patch is rebased on 'linux-next/master'
>
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 52 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 8 deletions(-)

There's another issue with this applied:

Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb:
mmc@8804000: Unevaluated properties are not allowed
('operating-points-v2' was unexpected)

Should just need a 'operating-points-v2: true' line.

This won't show up until a fix for 'unevaluatedProperties' handling is
applied. But first I need all the issues fixed.

Rob
