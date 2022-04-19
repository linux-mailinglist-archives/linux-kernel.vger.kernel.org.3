Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE29507704
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356168AbiDSSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356162AbiDSSGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:06:44 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7123BA50;
        Tue, 19 Apr 2022 11:04:01 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so18350187fac.4;
        Tue, 19 Apr 2022 11:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NOXUqKUrGDpPDUtG5OL18QzDLbgUxzLKVA6XuNw2RqI=;
        b=cYyQmlittCLw60IRqnu66Ecd5GRUVc9GGL0bkTk7ZEbOdXB4Atnp+eboJa7NpJ5onx
         1EvHnB+potKQf2o+JZiXRmUsD6/XDJ+3HplTJXIaerDvoxeSsmSR4MBB9S2RxQ2KSyXr
         U0TCW1FHhaoLp/+QI8sFHtEPMgzpwahMuAz2gqOwFgIhmef3I08yVxGL6HEoVKRP6iaq
         vrdONmN/oQjiYRV5CtnuZJR7hs1CaZnfE6dhvruWWdHIDvAR6SZr4v5uR/jhMa/763bA
         KNQwearHWU8yvSdv4IaybGN5+95oX01cRu5sa255kl5tz6D335lF9ZiLMmeNOuTsqQJW
         vKlQ==
X-Gm-Message-State: AOAM530YiKVJvwjs58oP1PU7YeuSxMj3p8f8LFbXFjgyykvUu0yx3tbx
        GA0SL1JLk3PJGKtft2GHBersJosnTQ==
X-Google-Smtp-Source: ABdhPJzLmxpu1Q/hE9musjIy34xDdXvVmAtbeQJiNSpfNMl8WSm6Djc8nnG+Q8CdI3cBT7tnqRBq/Q==
X-Received: by 2002:a05:6870:315:b0:e6:15d1:11a8 with SMTP id m21-20020a056870031500b000e615d111a8mr2715103oaf.289.1650391441300;
        Tue, 19 Apr 2022 11:04:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o185-20020acabec2000000b002ecf1218c53sm5366818oif.15.2022.04.19.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:04:00 -0700 (PDT)
Received: (nullmailer pid 3066699 invoked by uid 1000);
        Tue, 19 Apr 2022 18:04:00 -0000
Date:   Tue, 19 Apr 2022 13:03:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        erkin.bozoglu@xeront.com, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 12/14] dt-bindings: pinctrl: add binding for Ralink
 MT7621 pinctrl
Message-ID: <Yl75jw4OiTOK39Zo@robh.at.kernel.org>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
 <20220414173916.5552-13-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414173916.5552-13-arinc.unal@arinc9.com>
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

On Thu, 14 Apr 2022 20:39:14 +0300, Arınç ÜNAL wrote:
> Add binding for the Ralink MT7621 pin controller for MT7621 SoC.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,mt7621-pinctrl.yaml        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
