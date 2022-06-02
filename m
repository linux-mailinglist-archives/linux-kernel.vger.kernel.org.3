Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3F53BB23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiFBOqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiFBOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:46:49 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CB2187;
        Thu,  2 Jun 2022 07:46:47 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id k11so6742835oia.12;
        Thu, 02 Jun 2022 07:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OqbyLMTa5EEL6RxtyCIR/NHZfXvXp6qSuYlVj8gFdA=;
        b=uDibgpz8EwlPQvtjAG7dohqOJX9i4xiDSoaXjcYA9UEi5/cuYoj/aV4JPYflzKukTy
         i+JNjtlyXz/mfqPZd0cdC3KfsgeLAqIdDH68zbobgmhxXT2IK6AR0Xx+5akb3dejwEax
         xQhld6Q1b/aknXKEPKr5CI5tP8j7YL6Mn5wRlB/FF/6CLFjUVKIClrd+JUmutQFL8Esg
         p3qv+FqUmM9x/z1GG8kIdyqa8EuyXDwU1qFxTn6uDHhoDUd9AvepOz9XunExnGwnJiXH
         CcTCmWci/8khwcF+FgB3vSZr43C5C+67RRAk4YfXvMqZ7ar+Fr7cKR7o5w9juIR7SIR0
         8WAg==
X-Gm-Message-State: AOAM532ZhCMzaBv2YxcWpuzGP99GXBVBb8WjytdmpowTadxbFzI7zGTg
        HoDO1NZ2xj1Hyp3+af3Bzg==
X-Google-Smtp-Source: ABdhPJy6omKqs5U1K2FahbzcdCjnEXHb8La5WghrtetpNPL23YoGja2J0Zasvgq2RMqS0e/WWXxC6g==
X-Received: by 2002:a05:6808:20aa:b0:32b:a632:fb5e with SMTP id s42-20020a05680820aa00b0032ba632fb5emr2855961oiw.264.1654181206717;
        Thu, 02 Jun 2022 07:46:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y12-20020a544d8c000000b00325cda1ffbasm2338898oix.57.2022.06.02.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:46:46 -0700 (PDT)
Received: (nullmailer pid 2291389 invoked by uid 1000);
        Thu, 02 Jun 2022 14:46:45 -0000
Date:   Thu, 2 Jun 2022 09:46:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     devicetree@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>, linux-mmc@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lucas Stach <dev@lynxeye.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Stephen Boyd <swboyd@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [RESEND v12 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Message-ID: <20220602144645.GA2291328-robh@kernel.org>
References: <20220525015140.384-1-axe.yang@mediatek.com>
 <20220525015140.384-2-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525015140.384-2-axe.yang@mediatek.com>
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

On Wed, 25 May 2022 09:51:38 +0800, Axe Yang wrote:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
