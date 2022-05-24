Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8B5320B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiEXCJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiEXCJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:09:34 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9B95A1C;
        Mon, 23 May 2022 19:09:33 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e5e433d66dso20674498fac.5;
        Mon, 23 May 2022 19:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SwWzs+3v6Gy2EsC5WlrpELvaSaVndcghBnKKNBB21YA=;
        b=ZiSaLFxub4JNqs9aV9CbhyO8d9/x/b1iP4mT+jDPiBu2qCQzLWKR27oO+8YR3Ph9T4
         74nRe01btvO4vHjbxAwvOUIE4rS8FWdCO5XVMM+aDDWrmjzXwdjZyLrIvYELYiFTeorI
         0WWdm6i9bxUNZuMTwrMFE78qcTvajQqwO4mdRiXXysTENKO/XCT45sX6d0pZ23Lig9Xl
         +4MpPidGciFhzZuJ8HvddU09iA5WUObuM75gZYib1jzi3AogaGUwjicNFMh7+rR90jSI
         vzuNOIMcoxVP8A95YJwUTHVhEabfXJQetmIX1lEKJ9jBCvKhzrNeQDAN7YhUpYjCbBVB
         sOwg==
X-Gm-Message-State: AOAM533EClQid/sxgG2VnCzkLmILESR2ySKgPsguyX8HRgy65se63Wl7
        vEo3wMK2jbW4N7eq8raKlQ==
X-Google-Smtp-Source: ABdhPJwGEWxVIGvVY6wkQCiesL/leU52wGExHdjpwEzJUvIygpCNEjCII4WbkMPmF0e6IOpPsHFTaQ==
X-Received: by 2002:a05:6870:9686:b0:f1:8905:3210 with SMTP id o6-20020a056870968600b000f189053210mr1175894oaq.61.1653358172736;
        Mon, 23 May 2022 19:09:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o192-20020a4a2cc9000000b0035eb4e5a6cfsm4825268ooo.37.2022.05.23.19.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:09:32 -0700 (PDT)
Received: (nullmailer pid 2611545 invoked by uid 1000);
        Tue, 24 May 2022 02:09:31 -0000
Date:   Mon, 23 May 2022 21:09:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: timestamp: Correct id path
Message-ID: <20220524020931.GA2611512-robh@kernel.org>
References: <20220523172515.5941-1-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523172515.5941-1-dipenp@nvidia.com>
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

On Mon, 23 May 2022 10:25:15 -0700, Dipen Patel wrote:
> During the repository renaming from hte to timestamp, $id path was not
> updated accordingly. This patch corrects $id path.
> 
> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>  Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
>  .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
