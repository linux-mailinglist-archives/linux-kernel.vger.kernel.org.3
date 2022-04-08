Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB82D4F9EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiDHVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiDHVOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:14:54 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776B1890F9;
        Fri,  8 Apr 2022 14:12:50 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 12so10067672oix.12;
        Fri, 08 Apr 2022 14:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cjOKT/l/I7puNpJps2GV6T4FNhY4VGWN16LgAuVbA0=;
        b=xK1pFf9ZfIzggXw6YEfpO5xkDi0DMWksU9t175rhqsimgStCoFPy8+wYH/6fymaWPk
         0XGuek4nwJIzDyUOBjzzPzDKKpx1yC4oRps2ZN/o0cQ1YSsUj/duoq5E45USgxOZoeg0
         px0W+mkX1LPnr+HlJ6ZUdOwk0nQ0gdHdnY+RAgYOKiYmY2uddXJu1D2lPC899oK6hqV+
         JihNSFTt1vEzwiXMTgbFI8/BT8fUK9Wx99FtEy60rx6QgibTrbrxo/kyieMC6hQ5B5nF
         lg40+BtK5oj2GtIvH14V7z3MsvzPquK8CddeEy4jmHmbKPv5DKPLg7rRr8GQMbcVHTrt
         8bzw==
X-Gm-Message-State: AOAM53138SmGvzmscGAKAvDjiatjs6fKfUto8tJkarrRjg3VQrmmXaRX
        wBgEthnicHH5HzhX6RhpCQ==
X-Google-Smtp-Source: ABdhPJwuZpiu6oFVfiyBaoPj5phaB+jwgmKb/ABlCw7JcE07CaEpgnV19koyepflqcBJVOGVupSrDw==
X-Received: by 2002:aca:4bd4:0:b0:2ef:7212:641f with SMTP id y203-20020aca4bd4000000b002ef7212641fmr794023oia.274.1649452369380;
        Fri, 08 Apr 2022 14:12:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l12-20020a056808020c00b002da28c240dfsm8997235oie.16.2022.04.08.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:12:49 -0700 (PDT)
Received: (nullmailer pid 4075414 invoked by uid 1000);
        Fri, 08 Apr 2022 21:12:48 -0000
Date:   Fri, 8 Apr 2022 16:12:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 11/14] dt-bindings: reset: socfpga: Convert to yaml
Message-ID: <YlClUCuYMj/jWrYh@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-11-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-11-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:35 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Altera SOCFPGA reset manager to
> YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> ---
>  .../bindings/reset/altr,rst-mgr.yaml          | 47 +++++++++++++++++++
>  .../bindings/reset/socfpga-reset.txt          | 16 -------
>  2 files changed, 47 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/altr,rst-mgr.yaml
>  delete mode 100644 Documentation/devicetree/bindings/reset/socfpga-reset.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
