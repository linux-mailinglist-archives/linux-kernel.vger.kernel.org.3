Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F494AA420
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377978AbiBDXQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:16:38 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:46732 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiBDXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:16:37 -0500
Received: by mail-oo1-f42.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so6348715ooo.13;
        Fri, 04 Feb 2022 15:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Noz2S1R2/8Z3d7zvAFyG3K4LlMUyG1rJ009mn97U+i8=;
        b=U05wWCY5WPUOGS0CkU4Fx0A3Euxd+woI3w6jcCw+JucYg+V2FIaakpO5NSY7r5O/mj
         F18QsiDMu4v9dYIViCZGRjAmtATBPMye+lQVeNI/pbj/VxjmFAK5nL1SBAeRHSrPpBEY
         PsCi2tqRuzVlCmZM6ckH/bz+cEqdYcYuRaj3XVdHZOojJWCgwir58mbHYh2+1W8NBoVp
         zZcwFsAwSDDGdyK0RYgMTxsX1hvRT2D9dbiAbVvYQlO5TeM/ldP/SkSMEJCm/we8EDYM
         x9m6Zhw5ghBhks8xGz5Xs3GTg7gfBrgbjuGS5l2BG5Lo84urvnyuEymba8+OeUrDYjhY
         DwoA==
X-Gm-Message-State: AOAM533YECWI3dYAzaezWTe1gkPeh6MOuqDeoailAy81EP+7cooFMorO
        Q3d0DXg0MrTExbe62uH/8g==
X-Google-Smtp-Source: ABdhPJwHobYCqQ9RVCiAPVCUiGgX7dW2gc1hUD+YsotlyWKPy4uONG+pwbHb8zZ+M6FyRw/WrPeW6w==
X-Received: by 2002:a05:6870:87c1:: with SMTP id s1mr328429oam.347.1644016597248;
        Fri, 04 Feb 2022 15:16:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj8sm1520290oib.20.2022.02.04.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:16:36 -0800 (PST)
Received: (nullmailer pid 3365859 invoked by uid 1000);
        Fri, 04 Feb 2022 23:16:35 -0000
Date:   Fri, 4 Feb 2022 17:16:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        aford@beaconembedded.com, NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, cphealy@gmail.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH V4 09/11] dt-bindings: media: nxp, imx8mq-vpu: Add
 support for G1 on imx8mm
Message-ID: <Yf2z0wF2KJKmQ4IS@robh.at.kernel.org>
References: <20220125171129.472775-1-aford173@gmail.com>
 <20220125171129.472775-10-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125171129.472775-10-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 11:11:26 -0600, Adam Ford wrote:
> The i.MX8M mini appears to have a similar G1 decoder but the
> post-processing isn't present, so different compatible flag is required.
> Since all the other parameters are the same with imx8mq, just add
> the new compatible flag to nxp,imx8mq-vpu.yaml.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 

Acked-by: Rob Herring <robh@kernel.org>
