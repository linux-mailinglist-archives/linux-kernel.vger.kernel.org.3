Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033C5807BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiGYWpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiGYWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:45:20 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD05FC3;
        Mon, 25 Jul 2022 15:44:34 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f2a4c51c45so16622304fac.9;
        Mon, 25 Jul 2022 15:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lLkHlGevvdceJH/z9Q2B9k1T4jkGrkPxzE4a49wxQs=;
        b=BIvUjMkmW5yqEn+A1+eEiniYVYhlF/XBX9e8MoVmT68w/DQtp6eMg6BqhOYBQHv8ZG
         BjdcCYL/ptA69IEvjaN7lqrjM2ClcjYDmHia40EIIJvIUveByeOczP3oVhVNa755COEy
         1eQ9aL5jrkeOqKqZlt3qOxATMKcteSsGmWd0zslLDuy0481Jtv1EeLyKIheoRjbj4tZa
         QK/Id5ocn0/2IIPIb9xxDlmfy9e/GoehPTJliEfoc0MjuVznsH5a1Oc7kpZBDw9cGPTb
         suBKFlzBvtqCsWja1IjInVFtseb7+WMbh8i9NUubVmEZYxkMAEvIesiHk92jKLehwcnv
         wHpQ==
X-Gm-Message-State: AJIora8LHj8Qdqxy22uGV8i8VSA9D9ycndf7noJp0tr3PXXMoseINgpX
        2EEqceNkuk7a4gonAWg/Ww==
X-Google-Smtp-Source: AGRyM1s+bJWxKUgB23p7xrO0B5oIPbMw4dLvQHY06IhlsMaYnDULkyq67k7ADy/FV4BlJQ4FLy7fug==
X-Received: by 2002:a05:6870:a90a:b0:10d:9e83:98a6 with SMTP id eq10-20020a056870a90a00b0010d9e8398a6mr10800351oab.228.1658789073924;
        Mon, 25 Jul 2022 15:44:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bp6-20020a056808238600b0032f662af5d5sm5445081oib.1.2022.07.25.15.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:44:33 -0700 (PDT)
Received: (nullmailer pid 2885354 invoked by uid 1000);
        Mon, 25 Jul 2022 22:44:30 -0000
Date:   Mon, 25 Jul 2022 16:44:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Runyang Chen <Runyang.Chen@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        nfraprado@collabora.com, Guenter Roeck <linux@roeck-us.net>,
        angelogioacchino.delregno@collabora.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Runyang Chen <runyang.chen@mediatek.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/3] dt-bindings: reset: mt8188: add toprgu
 reset-controller header file
Message-ID: <20220725224430.GA2885292-robh@kernel.org>
References: <20220722072316.582-1-Runyang.Chen@mediatek.com>
 <20220722072316.582-3-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722072316.582-3-Runyang.Chen@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:23:15 +0800, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add toprgu reset-controller header file for MT8188
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8188-resets.h | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt8188-resets.h
> 

Acked-by: Rob Herring <robh@kernel.org>
