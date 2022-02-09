Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E374AE86B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbiBIEKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347208AbiBIDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:20 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF636C043189;
        Tue,  8 Feb 2022 19:33:39 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so645306oth.12;
        Tue, 08 Feb 2022 19:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLEDEM1kk6Dqn6C31Q6LU87xVga3iN9eqGvkHT+E1Ls=;
        b=UcB/5IMNiJetV5kQgNAdJyBjUwsselJvcimgQGVD1Ww3M/W9zhwLBGDiidobOEqdy3
         wgbIzpbfDNfKiLRDduInHnkjp9Hu+Bs1aG/E3klk7HhfPanLgFHtvGy6V17w6a3XMJV0
         ATLi/pFGHVtZ/Xd4qiAqcY6ZEIR9Jwx3cxcKUh4z/iMOazmcSdvGI5kd4Xcfd0ahZEzS
         Jz3sTGZco7D4mYHrnYGyvBFeLIUstcXaqxewzA13zt4B5rhPSwoL/mpVNSatjCADp7Dx
         1gyHJo1GASj1s3hgI0i+eq/OMKAQm4+1nEGXElGesuqaZ3nArx6E5BlAuwp+etCf9YdW
         9oYQ==
X-Gm-Message-State: AOAM531rSkK7GzIYDYIcMN9zoyLJkjKdwdflyEGeAXS8eSiuPvTMVmTw
        qwHcjTrK8s81sPuqOuuNBw==
X-Google-Smtp-Source: ABdhPJyW4Ob/qfgCUZJ4QykYSIImZSmVtSLXKXd2ittMD69qlMfv/2oWaR6d1oRd+3UEqE/t11nF/Q==
X-Received: by 2002:a9d:69d1:: with SMTP id v17mr176580oto.183.1644377618962;
        Tue, 08 Feb 2022 19:33:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q8sm6376052oiw.12.2022.02.08.19.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:33:38 -0800 (PST)
Received: (nullmailer pid 3588235 invoked by uid 1000);
        Wed, 09 Feb 2022 03:33:37 -0000
Date:   Tue, 8 Feb 2022 21:33:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-clk@vger.kernel.org, Fu Wei <tekkamanninja@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 4/7] dt-bindings: clock: Add starfive,jh7100-audclk
 bindings
Message-ID: <YgM2EeYzQ444f0DY@robh.at.kernel.org>
References: <20220126173953.1016706-1-kernel@esmil.dk>
 <20220126173953.1016706-5-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126173953.1016706-5-kernel@esmil.dk>
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

On Wed, 26 Jan 2022 18:39:50 +0100, Emil Renner Berthing wrote:
> Add bindings for the audio clocks on the StarFive JH7100 RISC-V SoC.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../clock/starfive,jh7100-audclk.yaml         | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
