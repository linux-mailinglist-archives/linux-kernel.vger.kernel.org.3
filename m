Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847E4C8F33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiCAPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiCAPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:36:14 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF889A9976;
        Tue,  1 Mar 2022 07:35:31 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id l21-20020a056830239500b005afd2a7eaa2so9647230ots.9;
        Tue, 01 Mar 2022 07:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9+B3rwm2FRmUHYugNPrh2s7Ox5TZPPsbWIJUn8Olyk=;
        b=a5fPN0fAsBgPO+S42i5Xm1b4SQyc3Q5h3+rd99YedJtGoUWxsBgO6lOHLu2CVimrtx
         J8tiEI1XD0Ma3NUq9fxMbNIfVdvyqHhfK8liuzNXD39h7z8XmEAcjnOtxtiFHz4Wb6t7
         khH29n2TkJLOjbYVI5VNuqZr8Ee22e0H907elXjkS4WJ9TOqUsWN+SxVQxQtWS59Kutd
         l3S5MB/EsF8myQxReaxO1O9CES9x/taI0FmD+GjpQhM5cFOnmYyZ8n0FhhdQiCi3E20/
         WwKeeDtOWzdWN7jhcyUaVL8Fu6bAz+EfdLHPRnh65sxiVW4uHEybupyp3lgyR9NVnVln
         huZg==
X-Gm-Message-State: AOAM533GDnE/wlN4Bqer1Fi3/CheKeUfo7V5ONBJ5SEFJauO00daJHyQ
        C4EEQ/YJ5/yzdCuyUAp5fA==
X-Google-Smtp-Source: ABdhPJzIu/fU31pUN2P41QKbMEvoWDJQcVzYI8t7f9ROGjwBDYoLMhHNIvqlVXC1duTP29Vytk+2Lw==
X-Received: by 2002:a05:6830:1687:b0:5ad:4b8f:a3bf with SMTP id k7-20020a056830168700b005ad4b8fa3bfmr12511602otr.365.1646148931167;
        Tue, 01 Mar 2022 07:35:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a69-20020a4a4c48000000b0031bec1608fbsm6359117oob.17.2022.03.01.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:35:30 -0800 (PST)
Received: (nullmailer pid 1289289 invoked by uid 1000);
        Tue, 01 Mar 2022 15:35:29 -0000
Date:   Tue, 1 Mar 2022 09:35:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document Renesas
 RZ/V2L OSTM
Message-ID: <Yh49QXQ2phIoIFJp@robh.at.kernel.org>
References: <20220227224845.27348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227224845.27348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Sun, 27 Feb 2022 22:48:44 +0000, Lad Prabhakar wrote:
> Document the General Timer Module(a.k.a OSTM) found on the RZ/V2L SoC.
> OSTM module is identical to one found RZ/G2L SoC. No driver changes are
> required as generic compatible string "renesas,ostm" will be used as a
> fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSI changes have been posted as part of series [0]
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-8-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
