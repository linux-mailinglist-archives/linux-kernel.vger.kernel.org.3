Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6814C36FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiBXUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBXUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:47:01 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B5279469;
        Thu, 24 Feb 2022 12:46:29 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id x193so4962304oix.0;
        Thu, 24 Feb 2022 12:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Js4DjQg4+/Js5ZDt0/DtZ6DBXYws/A9V85XipwiunGk=;
        b=xc9C1mollzDsys+P7dbHyQ7K/uwqYa73cCpFxP1yKWSlGxggSDwKRB2JA1rgSLE5QR
         Ccxm2BUUUkaHhWIz32DFxXN65VnvEJ7mCmmnzV/Ax7fGx3g6etpvjRzg0dRR8jxhHyv7
         4s3I5AN30U6b4D0bIfDktJWCFL17N6ePw/IZZI2tjbHtE87+Yk8mbJU7w0hTaymdU+3T
         ExTJ+lN1jbpkMvG4Pu7cnAQf2gvkkLyLqXYP/mj4HEMcOZLHHygmJD3vkrRcpI0WPk36
         Nr1NDmKsH32/qtoR97++BHq906vb2M7xA564ELlhqzztR7kZ/d/NgSB8SfaoywqL9mGi
         bryA==
X-Gm-Message-State: AOAM53287Shzi6mqjMjnnsgcnd88K8HDooSmxNHVEY1gJyoOGTNbgXCa
        Xw0IbMSiurAgdimOEUlrbg==
X-Google-Smtp-Source: ABdhPJxoxsHF7p455z10lgDwbJoBMEGDdTQlM9j3VSp6Aw6sFwosLejXmLbbVWJSen+7ni2GsJrq4A==
X-Received: by 2002:a05:6808:13cd:b0:2d3:a60a:1456 with SMTP id d13-20020a05680813cd00b002d3a60a1456mr2455365oiw.39.1645735589105;
        Thu, 24 Feb 2022 12:46:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm171240otk.81.2022.02.24.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:46:28 -0800 (PST)
Received: (nullmailer pid 3556414 invoked by uid 1000);
        Thu, 24 Feb 2022 20:46:27 -0000
Date:   Thu, 24 Feb 2022 14:46:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [v2 1/2] dt-bindings: power: Add MT8186 power domains
Message-ID: <Yhfuo0vpb+G1AoIM@robh.at.kernel.org>
References: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
 <20220215104917.5726-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215104917.5726-2-chun-jie.chen@mediatek.com>
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

On Tue, 15 Feb 2022 18:49:16 +0800, Chun-Jie Chen wrote:
> Add power domains dt-bindings for MT8186.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  1 +
>  include/dt-bindings/power/mt8186-power.h      | 32 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8186-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
