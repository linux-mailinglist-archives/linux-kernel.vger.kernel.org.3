Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7414D52BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343807AbiCJUCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbiCJUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:02:01 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2206F18E3F6;
        Thu, 10 Mar 2022 12:01:00 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id x193so7160794oix.0;
        Thu, 10 Mar 2022 12:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uLQUYwbI142mPK+bpbXClLmkKDnYrWpju591cR/ZRE0=;
        b=YThDcneBRiXtDGHpPylmHanyhmHmn0kGC4k9goSXCqm0fWaebodVl1C5wnKEsw09qj
         RXQTX5vrT69rxIZam0/2iZKZqhGYnUOmAmBk1No2b9u8dULM1MFm8HsXvDlXcmfE8rqG
         XZtmzzUEWTw1IbiydssW52ipFXH0g/w0k2MyBQ0EcnhvhcaHtAQ9M77SrTcoZr1eFOae
         C/xc4zo54gtlQtPaYOzNouT/e1rvsXj0f7McD1Vkoj7mf7xrAc8BhPaLuDStqp3cFXr1
         y5DXqqiQDTyEAp3e4yCxB/vFCwGFfpSB5VMWLUMS8lo5Kf4w0jxk+VLY+EAwiqLeSrkM
         tEWQ==
X-Gm-Message-State: AOAM530ufbUJKqhvQM44MLv23oi3/v0Zi+9G3Req+1u1HH1QmnSRmcBp
        o7Gdpt8ujfOSw5YWClM4bw==
X-Google-Smtp-Source: ABdhPJxgtl62Rn5MfIz5PDMuxe0atN8+OKDMV0hDYPugU0yN5r01kQ03Mbod8t+beWBP1M7itVn4vg==
X-Received: by 2002:a54:438a:0:b0:2d9:a01a:4be2 with SMTP id u10-20020a54438a000000b002d9a01a4be2mr4360203oiv.265.1646942459469;
        Thu, 10 Mar 2022 12:00:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm2643375oak.12.2022.03.10.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:00:58 -0800 (PST)
Received: (nullmailer pid 1965958 invoked by uid 1000);
        Thu, 10 Mar 2022 20:00:57 -0000
Date:   Thu, 10 Mar 2022 14:00:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Levin Du <djw@t-chip.com.cn>, Peter Geis <pgwipeout@gmail.com>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Tianling Shen <cnsztl@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: rockchip: add radxa rock3 model a
Message-ID: <YipY+W2HVPNyA15W@robh.at.kernel.org>
References: <20220304161130.34977-1-michael.riesch@wolfvision.net>
 <20220304161130.34977-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161130.34977-2-michael.riesch@wolfvision.net>
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

On Fri, 04 Mar 2022 17:11:28 +0100, Michael Riesch wrote:
> Add entry for the Radxa ROCK3 Model A board (with the Rockchip
> RK3568 SoC).
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
