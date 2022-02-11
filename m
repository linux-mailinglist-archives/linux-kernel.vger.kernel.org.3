Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4492A4B2709
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350005AbiBKNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:25:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiBKNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:25:57 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71880BBF;
        Fri, 11 Feb 2022 05:25:56 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id s18so11273773ioa.12;
        Fri, 11 Feb 2022 05:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnixB23kidaMApi1YvDjLpG7fjZRCymMdg8bS8AXKfw=;
        b=T53allqTrloEkEwZUqrbPBXUUyPfb6t0CfmsBXBqx2y4pt1fczrgrJnMQvGB7J0/21
         ZWpBz1GQ/APx6Qb+dGCygftNfg5FDNHOQ2Y1wbP9rxsK3Bf9YQZQfNYC5cw6z/pvU4p8
         Up7lzW+YR5BT0HP+CdCCve8CF9RqoDHblY3EfJnLj/PaFB9iSNHQEhDrv+62H4qodj9p
         jgiI8q3XUy98Ik3xGmnvK2bvVrm2e5+bdETA45z3WArrdmXmZ4YGkJJDqTWEZhptWuRA
         10DTok89+CwhA3gnsB3HdjG65H2FwJbU1VZYoLlehP2pvjJ/+IYDhFF+0alCc16ub9VU
         jnbQ==
X-Gm-Message-State: AOAM533c8yFAB1HHbUzW6GRLeQHvwVmt9X8w8m96hAo/l5DcVm2LDJU9
        upKWnK++ZIhEocTVhtdMoA==
X-Google-Smtp-Source: ABdhPJwwHe0liHEXZ9LxT79ZvOj4LxW11MvHj7tkxAamyam2S41mClF0v6uYPFPiLnWf5Wduma2+Tw==
X-Received: by 2002:a5d:89c9:: with SMTP id a9mr857109iot.124.1644585955662;
        Fri, 11 Feb 2022 05:25:55 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.139.71])
        by smtp.gmail.com with ESMTPSA id ay35sm13534693iob.3.2022.02.11.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:25:54 -0800 (PST)
Received: (nullmailer pid 252738 invoked by uid 1000);
        Fri, 11 Feb 2022 13:25:51 -0000
Date:   Fri, 11 Feb 2022 07:25:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Levin Du <djw@t-chip.com.cn>, Peter Geis <pgwipeout@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alex Bee <knaerzche@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: rockchip: Add Pine64 PineNote board
Message-ID: <YgZj3xeLvO1vA5+f@robh.at.kernel.org>
References: <20220130053803.43660-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130053803.43660-1-samuel@sholland.org>
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

On Sat, 29 Jan 2022 23:38:01 -0600, Samuel Holland wrote:
> The PineNote is a tablet from Pine64 based on the RK3566 SoC. There are
> two existing variants of the board. v1.1 was contained in some early
> samples, and v1.2 was sold as the "PineNote Developer Edition".
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
