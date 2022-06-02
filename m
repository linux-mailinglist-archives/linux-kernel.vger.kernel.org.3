Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74453B959
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiFBNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiFBNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:04:37 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C34CD5A;
        Thu,  2 Jun 2022 06:04:36 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e656032735so6707071fac.0;
        Thu, 02 Jun 2022 06:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/VCST4F7lVnuhuAO5by30KXb22t8RLJk2t2EhCzbII=;
        b=ZUceIxsmbAC8DMNFnR9ElXv3ij93jLpZDyTJJQ9uad3UXM514LOVX5sYzgVR1jHenG
         tJDrvhp5TX71x3wZsDzxnX0gyH3E2y+QWOcDMbc/ni1i+T6KyvdHnjfc4GDq1Y+ygo8p
         wn6ntRoAyiDM0gAS3JvoCBjujqGIw50ftYRrhbVebtNKzf+DRMEZhaF+T0Ean0HqEX/T
         fzTlJ4v7rlSe8zo43kosk0JT6mMOZ+8kfi40ESjrKXzKaX7VSeKQAVsOOwWjjdzIULC2
         YWc5LNYcNGLKwXH97uzvXcPB5pKrj1dZ0wmDjj3FhVIDedFb26+WB4o3sTQjGfy6pwaJ
         fGtw==
X-Gm-Message-State: AOAM530Jcd02tbz8iUtbRJf/d8ux5FlY3vMH2q3Y/C/Xa7b9zcE/Hd97
        lGTKAIOaHPzFspkDxF+GZw==
X-Google-Smtp-Source: ABdhPJx2W0m4zHCJcbUYiCbmMZxD45G9xBPM0mXVqwnzD0WfnB5hrx5/44F6vFlg4XgGrsVmFtgK3A==
X-Received: by 2002:a05:6870:ea8b:b0:f1:f46f:515e with SMTP id s11-20020a056870ea8b00b000f1f46f515emr2655714oap.192.1654175076098;
        Thu, 02 Jun 2022 06:04:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 1-20020aca0701000000b00328e70cae5csm2325309oih.43.2022.06.02.06.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:04:35 -0700 (PDT)
Received: (nullmailer pid 2106394 invoked by uid 1000);
        Thu, 02 Jun 2022 13:04:35 -0000
Date:   Thu, 2 Jun 2022 08:04:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 1/4] dt-bindings: usb: mtk-xhci: add support 'resets'
 property
Message-ID: <20220602130435.GA2106339-robh@kernel.org>
References: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
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

On Mon, 23 May 2022 17:04:46 +0800, Chunfeng Yun wrote:
> Add 'resets' property to support IP reset usually by top pericfg.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
