Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99647518D2E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbiECTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiECTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:32:20 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB682B184;
        Tue,  3 May 2022 12:28:47 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so18151778fac.7;
        Tue, 03 May 2022 12:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUf3XQMild+xicK8oDYdfUPAT4BtU1iyM+znB1rhmAo=;
        b=MBryVXrAXsdjUNdQ6xA7SdMvd4eaVB2GkHbejqnDkB5Dn9s5WjDw6nMT6/8D1oEGOS
         okac5DSUyLIfZxl0XG6M64OjHkcoyc5aJA/KEz5R9J1cUc2YFeq/2wIOosslvtW88+Rr
         RoHgk63NQHta5mN5kdnfsdnAh6Lwi7bfex+36E+SmB06ElCf8g7MfkbO6WsEeKOOUTMH
         97Po4dzqSj46ASoHvJOAMFpuMtU7AwRURGciZ2r4V6xmVD8bwqvdD92aJoBX5Ye2Du/v
         f+omj3mwd01IfAb1fC/Rh0Yuy9M7GUJrJmgtB2B9BQJiShBPXq/50sg7cVtD0/eZBnp1
         ifVg==
X-Gm-Message-State: AOAM532igmOBp9m1k/wDG8FLktTN72De5gc5CQsX73Sr+1WQhdRopRbw
        9WbQRIRomSxvSA2agrXTDmfGL6qIcg==
X-Google-Smtp-Source: ABdhPJz1PgQckTT7l4ZN5QqtbtQQNS7Kp0xqMln5B2vdoQhCctXdmOlFhg1JEubgmtL+D/uS7TmHWQ==
X-Received: by 2002:a05:6870:f6a8:b0:da:cf54:dc14 with SMTP id el40-20020a056870f6a800b000dacf54dc14mr2426092oab.43.1651606126977;
        Tue, 03 May 2022 12:28:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z15-20020a05683020cf00b006060322126esm4264763otq.62.2022.05.03.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:28:46 -0700 (PDT)
Received: (nullmailer pid 4087750 invoked by uid 1000);
        Tue, 03 May 2022 19:28:45 -0000
Date:   Tue, 3 May 2022 14:28:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, lee.jones@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH V4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YnGCbWTWmnMzusZY@robh.at.kernel.org>
References: <20220427100848.3525710-1-gengcixi@gmail.com>
 <20220427100848.3525710-3-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427100848.3525710-3-gengcixi@gmail.com>
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

On Wed, 27 Apr 2022 18:08:46 +0800, Cixi Geng wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
