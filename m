Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B44C8F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiCAPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiCAPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:39:05 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330DC3F889;
        Tue,  1 Mar 2022 07:38:24 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so22965838ooi.7;
        Tue, 01 Mar 2022 07:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IgFdAQ+7rpP01kxtGmU2BZRc0yJm0gPUU3cLLc8Jk3I=;
        b=J7PeG/lQ3o2cNCZf6zJh2Nj3BiJRvcUFaJOcqfEZnyloqc/pCfPv3u19Uk+JmO6vND
         BIuViC2kaz8pNSL6blPPjp4T6P9CRfgxxbMPqZTwNX+kiUg4R+clDN+8LgFxc1EsDMdz
         oCDhD1OKxLukW8AuhEJ1INpDh1P/xBb/YJ7XlpBhsZy5l7vYP6HAsMPwYN60fbqcdobw
         g0rLAv++iLEwdRVcppfcY8HfYJOCYKuDcSp79jXc+/JuUmpMZpd3PuMsAVj4MSUsRZEI
         X5xWxp/PH6xBjuG6KKwfdKFN3lHFG7rJTYkVk/g891qPGGICoT/O/xa9fRVdFMTRkwTF
         asTQ==
X-Gm-Message-State: AOAM531uXBpNfdA20TLMz3ZSCgyRmMlxZuxlULYCxQCmu+PKnDZdxwzM
        v4qC4PHUR1YDmudxfPSBjQ==
X-Google-Smtp-Source: ABdhPJxnILQc7GonthpI4taLLpmtwW7NoXOejQ9ut/CquT/SyVavj3WgIPY3n6l9AQJxHWqwjh4Qzg==
X-Received: by 2002:a05:6870:4392:b0:d7:844:3d99 with SMTP id r18-20020a056870439200b000d708443d99mr8431062oah.56.1646149103443;
        Tue, 01 Mar 2022 07:38:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x10-20020a4a2a4a000000b0031bf0818df1sm6273831oox.4.2022.03.01.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:38:22 -0800 (PST)
Received: (nullmailer pid 1294204 invoked by uid 1000);
        Tue, 01 Mar 2022 15:38:21 -0000
Date:   Tue, 1 Mar 2022 09:38:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
Message-ID: <Yh497cZIqQFrc/Mi@robh.at.kernel.org>
References: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227231531.32279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Sun, 27 Feb 2022 23:15:31 +0000, Lad Prabhakar wrote:
> Document RZ/V2L (R9A07G054) SoC bindings. USBHS block is identical to one
> found on RZ/A2 SoC. No driver changes are required as generic compatible
> string "renesas,rza2-usbhs" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSi changes have been posted as part of series [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> cover/20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!
