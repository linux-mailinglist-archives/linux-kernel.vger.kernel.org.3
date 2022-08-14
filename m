Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250FA5926B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiHNVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHNVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:43:23 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18813DF4;
        Sun, 14 Aug 2022 14:43:23 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id a4so4412695qto.10;
        Sun, 14 Aug 2022 14:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gsvKZizMBPBqAoYqxHhYeaAnDMKudFEih3zhgTZgEKI=;
        b=QhV/tLebLrXELeRtJk6PCltkFEKa6K07qK8yZbka4QXRJj9VZDmb34hImhkmIp/M80
         rnFzVvf+HclPajPvrB64XlGDTW8GyZSsX+GQa4BAJ0y+JA+veWyCfFXSD7yuhpRV9KsP
         MsNA9QaGfgmLUyWQCQLaWP381LVXTzNera3NFlXjS5P0rlgX6COC5/mGvFseQk5xH78Z
         6mqZ2h50mwGGsESzNGQNJ/Litfy0W8ImHGTiYrQJxtvqERCVm9UaKM1HNJVj/GMILCBA
         E1gROphUIaXRjs/ibApmMENac0651zjY+lEFSOTrMfKvkYnfjkCcvhsz8orZRMwNRpeU
         Ra6Q==
X-Gm-Message-State: ACgBeo3GfN7XONtoRZgJOH/f3Aj639ksnZQE0p/Vlz0GusdulFl48o1X
        3pkRDJbSsOWxsKYaRWl4HQ==
X-Google-Smtp-Source: AA6agR5vGKyXZeFoPtut0Cl2IDwYQJK1DsTfiQVEtUhzO4dX1YgRj3J4ywYCM2tynjSjhUKjQvEW2w==
X-Received: by 2002:a05:622a:1707:b0:343:645e:333d with SMTP id h7-20020a05622a170700b00343645e333dmr11792887qtk.497.1660513402051;
        Sun, 14 Aug 2022 14:43:22 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac9f:26d8:4b95:fcf4:6a60:b904])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b003430589dd34sm6962150qtx.57.2022.08.14.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 14:43:21 -0700 (PDT)
Received: (nullmailer pid 738164 invoked by uid 1000);
        Sun, 14 Aug 2022 21:26:29 -0000
Date:   Sun, 14 Aug 2022 15:26:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: amlogic: add bindings for Jethub
 D1p (j110)
Message-ID: <20220814212629.GA738114-robh@kernel.org>
References: <20220811103113.3097868-1-adeep@lexina.in>
 <20220811103113.3097868-3-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811103113.3097868-3-adeep@lexina.in>
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

On Thu, 11 Aug 2022 13:31:13 +0300, Vyacheslav Bocharov wrote:
> JetHome JetHub D1p is a home automation controller, modification
>  of JetHub D1 based on Amlogic A113X
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
