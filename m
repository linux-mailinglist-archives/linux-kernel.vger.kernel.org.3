Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB651076E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352511AbiDZSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352469AbiDZSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:50:46 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C818BF57;
        Tue, 26 Apr 2022 11:47:38 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r8so21705962oib.5;
        Tue, 26 Apr 2022 11:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1uymfQiPxL3nM8OAUppQEvfmPuzquyZRpSRTKhxYVpY=;
        b=Jc/RE+XefSQzNhXSgVxjw1n8LtYZBfRr+jzRYSmBI+lV0+QN+ejID6PjyHRnI4VX3s
         HKisYKqDeom8cLb0wf9lH0OWaGXbOYVOV4umqys8jsz2JK/Odp99m3QqpDGWyK5GvVAp
         a+xLMNM3wi+QU63LVaoP9SzTqCFPy8+9ZyR0sUZgVjmmDvBlK+zVXkL9RWgTn/NM3gOC
         GT90riQrSd9/57MYBRd5H8sJyTzXDitvbGww2gHAD2KInXuKo5aMzQEhUVsvtMRK2Ss3
         BKdjQrJsfe2d2Ni5tHqDCTSTLKmzwGJSYzsY80KjKwnOUm26hIJbC+DWQ6P1wBO2fN70
         prPw==
X-Gm-Message-State: AOAM531IV3iBOHrqvpa5xTmNKRXFa25DN5v7a3oYLNXGYoi2CtBP2Oyd
        Q3tVrY1jvDo6eXf4a2ufjw==
X-Google-Smtp-Source: ABdhPJyM1lyE288UlIkDddumXd32y92F4WYqMeTFtZj6sy25wfIWqHkKXBOpvngFKm3dl2kOjf0I7A==
X-Received: by 2002:a05:6808:f02:b0:325:e78:3bbf with SMTP id m2-20020a0568080f0200b003250e783bbfmr7542341oiw.86.1650998858297;
        Tue, 26 Apr 2022 11:47:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h1-20020a056870d34100b000e686d1389dsm1113835oag.55.2022.04.26.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:47:37 -0700 (PDT)
Received: (nullmailer pid 2339368 invoked by uid 1000);
        Tue, 26 Apr 2022 18:47:37 -0000
Date:   Tue, 26 Apr 2022 13:47:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: mediatek: topckgen: Convert to
 DT schema
Message-ID: <Ymg+SUzI6FMFDE4J@robh.at.kernel.org>
References: <20220424084647.76577-1-y.oudjana@protonmail.com>
 <20220424084647.76577-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424084647.76577-2-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 12:46:45 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert topckgen bindings to DT schema format. MT2701, MT7623 and
> MT7629 device trees currently have the syscon compatible without
> it being mentioned in the old DT bindings file which introduces
> dtbs_check errors when converting to DT schema as-is, so
> mediatek,mt2701-topckgen and mediatek,mt7629-topckgen are placed
> in the last items list with the syscon compatible, and syscon is
> added to the mediatek,mt7623-topckgen list.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,topckgen.txt        | 35 -----------
>  .../bindings/clock/mediatek,topckgen.yaml     | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
> 

Applied, thanks!
