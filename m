Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C899C507705
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356158AbiDSSGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiDSSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:06:20 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3B3B563;
        Tue, 19 Apr 2022 11:03:36 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso6245973otk.10;
        Tue, 19 Apr 2022 11:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+fNw0PdoYt1qVDrXfAqD4nqRFo5VR7IdVY54D5NHpZo=;
        b=dFSVA8zmeMfCC/FSi1QwiYycOHaqFmraiGxuvCGalAuU/GsdTOgSa61t9gKiq+Fe4m
         tU6nzERYuZZYAQ0Elsc28O6+f+G3TCvk2PA9revjUNNDSTsf7b9Zly+m9lGsRj0+qPBy
         hsYbyYhh2NivQl19/LFQerhOB3O4/qJ6mG+dJXJEXab1FyGI91CpSLuKJc86MfLXz3Xn
         EroPjD5IEOtLx2ZLtkDH2ryKUCKqeaZbCdgX1J2FlMEV1ab7F7AWnK7+75XZVdEuXR1p
         /rRTkIBfI18cimJSIZpvXVOY7PvSVcA4psst0K0HPjquAjneq7PuviRKGDHkSlJZIoh6
         1tpQ==
X-Gm-Message-State: AOAM532HjZ8Jfm5yZ8MCP5tO4kQMw7DfblxMMs5K9hMOVQszlYrDeJhr
        bLA7gngx99f1ubtmotJhUQ==
X-Google-Smtp-Source: ABdhPJwr48CoteiF8SovNQNRmbbE5UQFE9gdzDGqJdoxS7RFOi8geAlZwzQ6frsbqBiaM84T7OxxqA==
X-Received: by 2002:a9d:5604:0:b0:5ac:ef3d:38f5 with SMTP id e4-20020a9d5604000000b005acef3d38f5mr6304412oti.271.1650391416048;
        Tue, 19 Apr 2022 11:03:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u19-20020a056830249300b00605544f973bsm1125510ots.45.2022.04.19.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:03:35 -0700 (PDT)
Received: (nullmailer pid 3065892 invoked by uid 1000);
        Tue, 19 Apr 2022 18:03:34 -0000
Date:   Tue, 19 Apr 2022 13:03:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        erkin.bozoglu@xeront.com, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: Re: [PATCH v2 11/14] dt-bindings: pinctrl: add binding for Ralink
 MT7620 pinctrl
Message-ID: <Yl75dvpponIvTeVW@robh.at.kernel.org>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
 <20220414173916.5552-12-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414173916.5552-12-arinc.unal@arinc9.com>
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

On Thu, 14 Apr 2022 20:39:13 +0300, Arınç ÜNAL wrote:
> Add binding for the Ralink MT7620 pin controller for MT7620, MT7628 and
> MT7688 SoCs.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,mt7620-pinctrl.yaml        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
