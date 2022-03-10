Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D34D5215
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbiCJSSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiCJSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:18:42 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306355AB;
        Thu, 10 Mar 2022 10:17:38 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso7697861oop.13;
        Thu, 10 Mar 2022 10:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZKB5rgatNU4unfMPUALwl/eCbetKzYXpdyZA9VU5SY=;
        b=k2KAnFDZXp4Wa7gI9kT/Fg1E3Zp1vuhokcq10fToNyx3TOEDyd4I2a9668o3/ucn7M
         JWaO23eESnuFA6Mx8EY/zE6ZZaCgeaWmarloloEOqyUm3kP8iB9TwucOBx83lnPhX7Au
         kebm2iWugVK4TYY/gsjxSzWPJPa6e2XT+548kcz3uMk7YiiT7rX8Rfz7U59FSafjt6i1
         TDFuQfQ2FE+IXCDlzx/nlS1L88Xux0hCsUUWagn24CP3AMSiACOrnxnfBrBtDVpasaTU
         Pj/H5eq8tpBzsIg9uxEuxq/9RK37EpLkwDHB1Jyo8ZQmhUrT5xdDj9hPr8CPMNB0dMTJ
         A+pg==
X-Gm-Message-State: AOAM530Z2MZz83ZKqY+tIsv1elZWn/jY1AdpuLm7xztct+/fJbYdKNzP
        TR6+VIlGTwml8dvDhA6z6w==
X-Google-Smtp-Source: ABdhPJy+kSQTHi+CuiP48iwuEt3adEwVucDFsMoEwtJisvJGTapRTmSo1y4xd40p5Wla/Pah3MdH6w==
X-Received: by 2002:a05:6870:340c:b0:da:b3f:2b7f with SMTP id g12-20020a056870340c00b000da0b3f2b7fmr9438791oah.286.1646936257866;
        Thu, 10 Mar 2022 10:17:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b15-20020a05687061cf00b000d17a5f0ee6sm2640359oah.11.2022.03.10.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:17:36 -0800 (PST)
Received: (nullmailer pid 1800189 invoked by uid 1000);
        Thu, 10 Mar 2022 18:17:35 -0000
Date:   Thu, 10 Mar 2022 12:17:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
Message-ID: <YipAv3DDdCj6sVvP@robh.at.kernel.org>
References: <20220308211543.3081-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308211543.3081-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Tue, 08 Mar 2022 21:15:43 +0000, Lad Prabhakar wrote:
> The Renesas RZ/V2L SoC (a.k.a R9A07G054) has a Bifrost Mali-G31 GPU,
> add a compatible string for it.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!
