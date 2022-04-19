Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA775076FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356151AbiDSSFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346655AbiDSSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:05:04 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D8637B;
        Tue, 19 Apr 2022 11:02:21 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id z8so18974312oix.3;
        Tue, 19 Apr 2022 11:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2uhrxcL/WlGsDwYOE/ex3LEujw8S7I6uYFrm/mTX47Y=;
        b=CG+FCT6g+EZwPoEjKbLHrACaf80RcBSeEb2LrCJs3qbWQLtuRqU8bP35LbhStwZ0XK
         xs8kJwjiKUqa9EnKfpYWAhDjp7OG1FJfdI0/DJTuZ+9AFduB1WNxe+Mkg0tz8i4/zjDt
         AbQC+jK3lx+Jj959KYUAgbW99Ww5udF0djWlHxYjdbqWWehZkpaqW9slmGdTjUnvP648
         yzaFAK8XPyb8N6FlcL3JMkzGv3FvhgYPoqw5tCAjv/YT+ychr4fPED1YmPNL9vtro8cP
         7dmQYgkxwTv7pNn6nKCzbaA5QkxH0/+Oo084vQb7OhdBwSqR7VEfKWyH+kBgjC/R9qzZ
         1YEQ==
X-Gm-Message-State: AOAM533o7pme3OfeKlMl1GJF5Uoruu5BUIk7vKhuCRAmys6eGW/dBDQ+
        5j0Os38B0rOcm9Xa+E+xP/Ue3b6efg==
X-Google-Smtp-Source: ABdhPJyC+Ey/LhVwewvu2Dj6uL7e/Pw+ekpuC4DuhF5AskRoN9KlHzZy7DPkZte98+AH/aX0tN54yg==
X-Received: by 2002:a05:6808:13d3:b0:322:8cf5:3afb with SMTP id d19-20020a05680813d300b003228cf53afbmr4871293oiw.186.1650391340596;
        Tue, 19 Apr 2022 11:02:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0105000000b005fbe5093eb0sm5606044otu.54.2022.04.19.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:02:20 -0700 (PDT)
Received: (nullmailer pid 3063578 invoked by uid 1000);
        Tue, 19 Apr 2022 18:02:19 -0000
Date:   Tue, 19 Apr 2022 13:02:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        erkin.bozoglu@xeront.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 10/14] dt-bindings: pinctrl: rt2880: fix binding name,
 pin groups and functions
Message-ID: <Yl75K2iSlAY+9DQF@robh.at.kernel.org>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
 <20220414173916.5552-11-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414173916.5552-11-arinc.unal@arinc9.com>
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

On Thu, 14 Apr 2022 20:39:12 +0300, Arınç ÜNAL wrote:
> Deprecate the old property "ralink,rt2880-pinmux". Add the new property
> "ralink,rt2880-pinctrl". The old property name was inaccurate as the
> hardware block is called pinctrl across the Mediatek/Ralink architecture.
> 
> Current pin group and function bindings are for MT7621. Put bindings for
> RT2880 instead.
> 
> Add me as a maintainer.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  ...pinmux.yaml => ralink,rt2880-pinctrl.yaml} | 26 +++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>  rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,rt2880-pinctrl.yaml} (53%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
