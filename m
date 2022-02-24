Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30EB4C3341
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiBXRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBXRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:10:44 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970B208318;
        Thu, 24 Feb 2022 09:10:14 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 12so3490788oix.12;
        Thu, 24 Feb 2022 09:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgEt++oBYASgr9TfRFFi+SD8GpomMen+OR/8J8QIuRk=;
        b=aEtgsn3D2hw4ubfcvUO1S7T3MDR8VuyIdtRpCou6fY3Dz5IUx2ID51fZzT2EnZcZGx
         zDcQi20F10WvUxTk6375EulMzoQYPk52i+AwGnauA7Lvznh/9udfqS02BDWzMiLoFuoO
         NbEwBbgEh+SR07YBBmGales/f4A5p4nhMntfjbhhSuHSEYzPQh+P7Ug/Lpm49D4myMbE
         53wVwmXmFmCs7RQq6s2RIHlJNe8Jq122j+hLLnDrYAP9W3+I99JoI+I0I5/17Og3TQtN
         a4mwqoq+jShtXDbur/Fr/OhpepOopw+04JhaKaPCTCZJgddMDRQxkwyrANuUlo55Ko4C
         o7HA==
X-Gm-Message-State: AOAM532l5MZ8oN76lWCo6g+SFsk9NFROr/hYckN6bappMiQKTxQ+1WkL
        elOKL3c0vm4dqLSEW1lMMg==
X-Google-Smtp-Source: ABdhPJyRCb0IydycIC22RD0Zq8josaATMxmz1k/6Q12W3pmTQheLOuZTOB6+D1STwrh453Q5f2LV5w==
X-Received: by 2002:a05:6870:670e:b0:ce:c0c9:65e with SMTP id gb14-20020a056870670e00b000cec0c9065emr6854697oab.176.1645722614234;
        Thu, 24 Feb 2022 09:10:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870e1c300b000d0f502781esm65345oab.22.2022.02.24.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:10:12 -0800 (PST)
Received: (nullmailer pid 3252581 invoked by uid 1000);
        Thu, 24 Feb 2022 17:10:11 -0000
Date:   Thu, 24 Feb 2022 11:10:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file
 and binding document
Message-ID: <Yhe7876iV+P+z5JM@robh.at.kernel.org>
References: <20220216032124.28067-1-guodong.liu@mediatek.com>
 <20220216032124.28067-2-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216032124.28067-2-guodong.liu@mediatek.com>
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

On Wed, 16 Feb 2022 11:21:22 +0800, Guodong Liu wrote:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8186.yaml      |  297 +++++
>  include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174 +++++++++++++++++
>  2 files changed, 1471 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
