Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668454E9D80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiC1R3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC1R3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:29:38 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420963530;
        Mon, 28 Mar 2022 10:27:58 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id w127so16313027oig.10;
        Mon, 28 Mar 2022 10:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pKj0Gjvro8HTxjGPukTbqzqx9n4h/OXOk7/nuTgNznk=;
        b=YxIOSdrFnwgp+NrOe7QEDFoqev1ufwNP9BTLhsX3oibQuaQOqLqgj53JajQVKqFqOx
         MUYaCT3KtVRoObXy/h3Ylz8atNVohwRVeQQbSsoRY0iVU7+yU1NqagMDCboCqk2Th1Pt
         B67oG8pFt9Zm7Jhss/jy8d3Z83QjRaooCfbg7edg77Wy5qxui9y89KCwMGAfOCUrZoMv
         g7jVz59f177F2neSzIvgRMefH7dQVcJEBINAsSefCjWJ0A2ME4XiEDINUoATTDtRA3Ti
         k7J4FqNOkG18xbaLAkwsRh5S+D9djYjh0/cfj+JZYL/6pG5Wu4//hsKbOyrfX//Y1dD8
         uGJQ==
X-Gm-Message-State: AOAM533aczP/unKlcx7wfwM9RIDPa1o5YVEzvntqJYgrxXkWxQCDd3tD
        CmyTxgSrviO9HKDKuWcV7A==
X-Google-Smtp-Source: ABdhPJy9zkdxb+G0m7ZY98qArUKWYEXV2InDfgYRh2KbJ2ffNuMS4F51mQaf1i8pp3e5obxjJ3g9Ng==
X-Received: by 2002:a05:6808:308c:b0:2f7:5d2e:1a5e with SMTP id bl12-20020a056808308c00b002f75d2e1a5emr102483oib.209.1648488477125;
        Mon, 28 Mar 2022 10:27:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x65-20020a9d20c7000000b005cdaeec68d5sm7389911ota.37.2022.03.28.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:27:56 -0700 (PDT)
Received: (nullmailer pid 2611453 invoked by uid 1000);
        Mon, 28 Mar 2022 17:27:55 -0000
Date:   Mon, 28 Mar 2022 12:27:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     krzk+dt@kernel.org, mturquette@baylibre.com,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, sboyd@kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: convert
 rockchip,rk3288-cru.txt to YAML
Message-ID: <YkHwG5SaXchzeJ7o@robh.at.kernel.org>
References: <20220326120942.24008-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326120942.24008-1-jbx6244@gmail.com>
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

On Sat, 26 Mar 2022 13:09:41 +0100, Johan Jonker wrote:
> Current dts files with RK3288 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3288-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3288-cru.txt    | 67 ---------------
>  .../bindings/clock/rockchip,rk3288-cru.yaml   | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
