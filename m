Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393104CE099
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiCDXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDXLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:11:15 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4625A27B8D1;
        Fri,  4 Mar 2022 15:10:27 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id a6so9360478oid.9;
        Fri, 04 Mar 2022 15:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nbp3CKVQIcxHEuP/e7OG3RMLG/oUR9xNYLZDthinbNQ=;
        b=RsiQVxFfl7WdYRqOIDhnA6+RFEe7DtCpEsnOLXaSBV/oDFkbrkQNSX9yApGpsbYNOk
         T6Ly1DZLR3D23QmEAkenZr8Nwon1BB3ZhPTU3qaiRmAU7tGqip2drmKDi2vI/YqYKPE8
         D8Zu+N5r56XwxcaFV/mooSmjuI4dRDU0tv8AU7YErPYM75HGi326bLNBlfo/GfOLpn/U
         e30rxgDwba4gbg1UbPPOJ7yC0nCUFLGabSQzVszFHiZRli/52qv7JPCtb3XXkbqieBHK
         jNQbGTDrrUhrvgKgV8uEkz/WsBlLZQj/QHYdwH9bkxC40/0RQuLqxVSwZz1iTETLnDYK
         ZgDQ==
X-Gm-Message-State: AOAM530t9f/pZiUyukDC6fHu5QZbH4JofxagA63jXeEPh9vGoTvamo+V
        g1aoGL/j4/8WFq3g/Edy3J9GAHlIHg==
X-Google-Smtp-Source: ABdhPJwjMiYZe7cZZuhCSr8Iua8jmpyFpnZyHA8jf+ETUHpBIA2Gusw3x5uJKpY+FBB/x9zSLnP85g==
X-Received: by 2002:a05:6808:1691:b0:2d7:9354:3ec4 with SMTP id bb17-20020a056808169100b002d793543ec4mr503845oib.62.1646435426601;
        Fri, 04 Mar 2022 15:10:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w36-20020a05687033a400b000d75f1d9b82sm2980440oae.47.2022.03.04.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:10:25 -0800 (PST)
Received: (nullmailer pid 634157 invoked by uid 1000);
        Fri, 04 Mar 2022 23:10:24 -0000
Date:   Fri, 4 Mar 2022 17:10:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: usb: mtk-xhci: Allow wakeup
 interrupt-names to be optional
Message-ID: <YiKcYCV4HacnVO5z@robh.at.kernel.org>
References: <20220225225854.81038-1-nfraprado@collabora.com>
 <20220225225854.81038-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225225854.81038-3-nfraprado@collabora.com>
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

On Fri, 25 Feb 2022 17:58:53 -0500, Nícolas F. R. A. Prado wrote:
> Add missing 'minItems: 1' to the interrupt-names property to allow the
> second interrupt-names, 'wakeup', to be optional.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
