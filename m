Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52652DECC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiESUxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiESUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:53:27 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0610FC6;
        Thu, 19 May 2022 13:53:24 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id v9so3223642oie.5;
        Thu, 19 May 2022 13:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vr35W3paoABM6vUlppihSXBGzo4C7D5+LkOldPnsJ+s=;
        b=KPqTRh30NiU17Q0Qp+Pc6KAoSKk+wgli+lZe/3wgNucePaGmXc3040IRQtpAYEoMXz
         EOypjUg34WjUi+RTetmFCoc8tBPhjKiXscP7DSCDGpNwV1p3sCZm6/s9/Uz4atWfKcvB
         84adZjoWqD08cxwLWCI5WNPoey+WmUAaoJ6TjV9mMXT8fglQ89tbjMLCHKBg9tr+SIHz
         lddzihsODD5Bb2Gq/ofuc+Kmlet33thFDzHYyK7n2SodG9iLCSdEn84e8PyHcaaiqgra
         g2m/UJuif9bXhTKmWtQStJuFRumSmqs0AjGMRgf5FUISFgaoZ7CYAFK5qqA0tzNChPhn
         9VNQ==
X-Gm-Message-State: AOAM530FVehJZ+7DEapJXT53V1oT8HCuFbMwNPUO64zlDulj72e5HeyQ
        zBv4MyHrIYk1e9EVZST1Ag==
X-Google-Smtp-Source: ABdhPJxZNVXs1r0C+wqkhBUfdG8DMxjc8+Bd0W1pj4yhH2bjTCZlQtoNSW+klCTJMiua+T7y8sJhaA==
X-Received: by 2002:aca:6c5:0:b0:325:5bce:bbc1 with SMTP id 188-20020aca06c5000000b003255bcebbc1mr3824631oig.221.1652993603425;
        Thu, 19 May 2022 13:53:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dt10-20020a0568705a8a00b000e686d1387csm170976oab.22.2022.05.19.13.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:53:22 -0700 (PDT)
Received: (nullmailer pid 2171348 invoked by uid 1000);
        Thu, 19 May 2022 20:53:21 -0000
Date:   Thu, 19 May 2022 15:53:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Hung <joe_hung@ilitek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: ilitek_ts_i2c:
 Absorb ili2xxx bindings
Message-ID: <20220519205321.GA2170924-robh@kernel.org>
References: <0c5f06c9d262c1720b40d068b6eefe58ca406601.1638539806.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5f06c9d262c1720b40d068b6eefe58ca406601.1638539806.git.geert+renesas@glider.be>
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

On Fri, 03 Dec 2021 14:58:26 +0100, Geert Uytterhoeven wrote:
> While Linux uses a different driver, the Ilitek
> ILI210x/ILI2117/ILI2120/ILI251x touchscreen controller Device Tree
> binding documentation is very similar.
> 
>   - Drop the fixed reg value, as some controllers use a different
>     address,
>   - Make reset-gpios optional, as it is not always wired.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  .../bindings/input/ilitek,ili2xxx.txt         | 27 -------------------
>  .../input/touchscreen/ilitek_ts_i2c.yaml      |  7 +++--
>  2 files changed, 5 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2xxx.txt
> 

Applied, thanks!
