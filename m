Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DD53A61C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbiFANsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiFANsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:48:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35048E52;
        Wed,  1 Jun 2022 06:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83B2DB81806;
        Wed,  1 Jun 2022 13:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3613C34119;
        Wed,  1 Jun 2022 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654091275;
        bh=dsNttoVsrUaz4VeEXZqi3jt67Xqr7AzNdL+66iFEbXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AE5kbjOZ3XvTKi8XT6Wx/oYq6mh2DeFssy7oTlwtU9SAN1He3CcuPsR7l0bNaFR8f
         sU70KER+zLhsJczUPIn/FacD1ICLmmi/MSLRRUdc/OBcyWXHi13yrEeXEOURdV2HED
         aWoutN94sWIxhEeVJtbyVebqW2t86vbhtoGaqHNcjk+r+LOKb7npMPZMcvnjLMVNo+
         M4uT/NYX9IgwuLPZG1NB05tbhWBY8sgkCdoyCtnnuBX7xoYqx70bIEWPIsJ2xrcDfl
         vS5Bg8gy1G8KFEObWtMJ8Hmyplz6CPTgEil9g2SwItGIezmJGJdvZ4eBeVPU99+B8C
         3lFtXiKQB/YZw==
Received: by mail-vs1-f50.google.com with SMTP id w10so1734889vsa.4;
        Wed, 01 Jun 2022 06:47:54 -0700 (PDT)
X-Gm-Message-State: AOAM531rKImxBFA3OH9ztkvJhh++l7lQhge4QoPqoaXd77n8tCfY2+S8
        wF83FLOeR19QNSkCZEggzT5ZVkA32hjpdZl17A==
X-Google-Smtp-Source: ABdhPJwJ0q4pFSykrkh0IL3W7dskb5bYekKeVt6j00WEFLRa6uA1CTAdkOit9N9tvdLDls5vlYk28BIqC+5Wfny4EJ0=
X-Received: by 2002:a05:6102:1041:b0:349:cfa3:c029 with SMTP id
 h1-20020a056102104100b00349cfa3c029mr3685902vsq.0.1654091273924; Wed, 01 Jun
 2022 06:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220529111515.182810-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220529111515.182810-1-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 1 Jun 2022 08:47:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcn+NDaPvRYBFbOZZ-x7fKPLenGBh5xdUPBU3usk9hnw@mail.gmail.com>
Message-ID: <CAL_JsqKcn+NDaPvRYBFbOZZ-x7fKPLenGBh5xdUPBU3usk9hnw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: document deprecated Atheros
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 6:15 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Two old boards use "atheros" prefix instead of already documented "qca".
> Document it as deprecated to fix warnings like:
>
>   at91-gatwick.dtb: atheros@0: 'atheros,board-id' does not match any of the regexes
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Can you resend this not dependent on 'dt-bindings: vendor-prefixes:
document several vendors for Aspeed BMC boards'.

Rob
