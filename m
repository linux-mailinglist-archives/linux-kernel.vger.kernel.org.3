Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E394C8F39
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiCAPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiCAPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:38:45 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A19C36B75;
        Tue,  1 Mar 2022 07:38:04 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so22861520oos.9;
        Tue, 01 Mar 2022 07:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mznNVqLOkKc7jorutIorqi0Jkhb6WsMaeJLanpGX0PM=;
        b=e6M2jFW+ATgExEXheBoA62lq3Sh0N+hUQUuGyxtjn2lj6Y8nBitmPy3wI4Avzi/7HW
         g/kwRtDL0h5l7uQnDDEaAhnVY/XuarBSNwItStKNlIeXUVD6DR3x1EBcK2oUUDTnzctc
         AF5y45s7IOBR+STUBbKRzK784icFem4dR+IPfO2482yWpFWtHWWSYLDCWHylzF1/YTSL
         /3LcCDFYfsfdlKxPpSuwPWd+Hn0TpLc4aD16c3kvFQHMiQnHhP4rt2W7EPhhp923p6WG
         CrDVA9QOZZ5Y6CTbawqwCVekDWFrf51MDsi5RRBPFAbAl0yI6+KOXd7y7C0yukLInh1a
         7iMw==
X-Gm-Message-State: AOAM533Dl3TzQLyMG88T/qOPJMUgKgjun0WdtphcibRcPurPjrBHm4ZC
        kVvBmKpndWZn/EGOB/BauifVj57Qyg==
X-Google-Smtp-Source: ABdhPJzNhYmzhwMze9iU/BfX63oYRqq9s1uKuprJwpxF4rvWDoXxC7Om5n2sGlXYapXk/D46UE0qmA==
X-Received: by 2002:a4a:6556:0:b0:319:3805:bc55 with SMTP id z22-20020a4a6556000000b003193805bc55mr12239007oog.16.1646149083436;
        Tue, 01 Mar 2022 07:38:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl26-20020a056808309a00b002d4f48e3799sm8474921oib.12.2022.03.01.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:38:02 -0800 (PST)
Received: (nullmailer pid 1293507 invoked by uid 1000);
        Tue, 01 Mar 2022 15:38:01 -0000
Date:   Tue, 1 Mar 2022 09:38:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document
 RZ/V2L USBPHY Control bindings
Message-ID: <Yh492RZf2eXfCfTa@robh.at.kernel.org>
References: <20220227230302.30388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227230302.30388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Sun, 27 Feb 2022 23:03:01 +0000, Lad Prabhakar wrote:
> Add device tree binding document for RZ/V2L USBPHY Control Device.
> RZ/V2L USBPHY Control Device is identical to one found on the RZ/G2L SoC.
> No driver changes are required as generic compatible string
> "renesas,rzg2l-usbphy-ctrl" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSi changes have been posted as part of series [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> cover/20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
