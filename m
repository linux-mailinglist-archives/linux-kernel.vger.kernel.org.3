Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB4528D14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiEPSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbiEPS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:29:53 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FB3E5C2;
        Mon, 16 May 2022 11:29:52 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id y20-20020a056830071400b00606a2ebd91bso10620239ots.5;
        Mon, 16 May 2022 11:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaecUFiUxZibI7py873WPjMBAa6EmidW+to0s/EQuUk=;
        b=unpCVrGSImyUmImqgsAv/10vLd1wYBuAzASl7J21m1nWWnmEM3Roxttmcfl8kLHXsz
         9RPF5uydxH5I1BrYQXPzH+YiX6gHoEE6Sr3HIk3C88Hmt726YR4bmfF30tvIWiY21jZ1
         2H15kLOageQ+cqCEW5/WGiCFt6gOdCpDNJ/uesU784kT/xYNWfByTrjV1GohUYxbtrSs
         5P5qRDestTS8MGEeb1OQLcvQn3k5+ZzEtVdORx1xxpercq2mb34uPxGktMauljL9DNEM
         nK8uoLx9g90VCxldwVliXS6fWSBRsDnnAbdgEHmQ0o/NdN3mGHIgbf8OZRSC4MH+Y3pg
         /LtQ==
X-Gm-Message-State: AOAM530Wsq0RYxSE2C4VBac7+s5LVrvUl/5TVv0NirWRgEHblyOINjpG
        TLAas43h9wt953oDPd2cuw==
X-Google-Smtp-Source: ABdhPJwRtrohJ5GMQJDP1rcsA+kU6YqCTCII37RSfo3NP7KEsy6ZIP7CqE8AKoeBBac5Rd8hGkjG9g==
X-Received: by 2002:a9d:6552:0:b0:605:e866:1b58 with SMTP id q18-20020a9d6552000000b00605e8661b58mr6408042otl.224.1652725792031;
        Mon, 16 May 2022 11:29:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w63-20020a9d3645000000b006060322127fsm4161211otb.79.2022.05.16.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:29:51 -0700 (PDT)
Received: (nullmailer pid 3035804 invoked by uid 1000);
        Mon, 16 May 2022 18:29:50 -0000
Date:   Mon, 16 May 2022 13:29:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     p.zabel@pengutronix.de, sboyd@kernel.org, arnd@arndb.de,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        linux-clk@vger.kernel.org, tglx@linutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v15 01/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Message-ID: <20220516182950.GA3035747-robh@kernel.org>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <6107a68008f2d71d2c7868d4d94cb66c5b5fc134.1652329411.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6107a68008f2d71d2c7868d4d94cb66c5b5fc134.1652329411.git.qinjian@cqplus1.com>
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

On Thu, 12 May 2022 14:30:56 +0800, Qin Jian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Remove "Device Tree Bindings" from title
> Add board compatible "sunplus,sp7021-demo-v3"
> ---
>  .../bindings/arm/sunplus,sp7021.yaml          | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
