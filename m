Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CBF59C8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiHVTcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiHVTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:30:41 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0F58DEA;
        Mon, 22 Aug 2022 12:25:14 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id j5so13391442oih.6;
        Mon, 22 Aug 2022 12:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YBa4Wpb/1K3mz75p1OPVR3AVlx1stGTKnEAnSXaWGEc=;
        b=oh3Gr+wltQLYWZ2DTpp6Pw/80Kl/hy0zj3+tZmEkfdNV3Y8TJH4L6J5gydzZXiWKGv
         Dzj3ARzn9X2h+VTF7YHD8IjjLs6fjKSjNuoXhuEeVSF1/yu1g/hFKM4uDXd4jlG3aNL1
         U1turCNCoF9re9KKYw59a2AM3xlm7hiOdxogcO1S6Pxg61+Cp6PNJir58nc99DG3YCAM
         vb7dVoXLxTz6PRSZWEdZIe++S71CVMJDMa2vRSsTcHesz04rrYnXAdWxnGvaa3uWfpFF
         VOCxBvI2nDKivsbI2myEl9Yibf/u6eMkdjOlEdX7xu5j0Pb8CyISmTs8FOZSmTCaQIve
         7FZQ==
X-Gm-Message-State: ACgBeo20fcZKJa1BJt0fmM+hhWC403rh2Nd9pJ8WJLfCpRQz99610DSA
        Y6+6gKoFGkdLjZAGvZHimg==
X-Google-Smtp-Source: AA6agR4yidOvnPilwMylDNgezwAjLFjDT0pd8MDJ4gX+NgTAQQYnJjX9woySWud8W/j1lDm5RISF1A==
X-Received: by 2002:a05:6808:1b0c:b0:345:2df:b297 with SMTP id bx12-20020a0568081b0c00b0034502dfb297mr12004875oib.236.1661196313793;
        Mon, 22 Aug 2022 12:25:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y12-20020a544d8c000000b00342d207e68bsm2691610oix.37.2022.08.22.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:25:12 -0700 (PDT)
Received: (nullmailer pid 308105 invoked by uid 1000);
        Mon, 22 Aug 2022 19:25:11 -0000
Date:   Mon, 22 Aug 2022 14:25:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, contact@paulk.fr, sre@kernel.org,
        lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, tony@atomide.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/10] dt-bindings: input: twl-pwrbutton: Add support for
 twl6030-pwrbutton
Message-ID: <20220822192511.GA308017-robh@kernel.org>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-5-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820071659.1215-5-bavishimithil@gmail.com>
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

On Sat, 20 Aug 2022 12:46:54 +0530, Mithil Bavishi wrote:
> Adds documentation for the compatible string for twl6030 powerbutton
> support.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
