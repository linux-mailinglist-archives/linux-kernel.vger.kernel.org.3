Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3425050EA03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiDYUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiDYUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:22:55 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AF93134E;
        Mon, 25 Apr 2022 13:19:50 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-e68392d626so12217167fac.4;
        Mon, 25 Apr 2022 13:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kb7RkZkzN7pO9fdYKUo6aPtGYRwxfkKCzPaeaORxLpk=;
        b=XLPLce5KnibgbN3ZBsZSSPMnbfuN94nx6YHAUkPBR1PtO3QZHDmDfaXIcjFXSM5Lig
         tP51DAO0eBB5+I1LsvCgW6BNsV4JVuZWah/mOmPcJs2rmp2SyBPnv6wXdnRb0CS4BmSc
         4Q6sFQPyG2RPNYGAf4CwLXAP9DrsUyoCQBu51Z1egVDl8+lrR11OlQuXAWd1dGzBheoJ
         BoLMHiqPAnYFQHl+MAan/R/gMAE4jtVWlGmNQpT1T/B8p6Tv7K2qz5MlQFgC/2xxhcJb
         +GayN+cGCIO4EkCZEmrPWJGDq+OoVK/gSfaXo0lbHRc2OTPVsG6/hJxk6lwrPDsjUYfo
         THQg==
X-Gm-Message-State: AOAM531L901h/FoOFajSZwau2SUgLcKx+0CjOlhGSk5EymB4sbefm5Zq
        dshbzc1xtogZpIQrbm07mg==
X-Google-Smtp-Source: ABdhPJx8n9hkDxZc5mmzCkxbN1Mw9BRtrAau3Q42HyGotZK4S28umh8sQ9zbBXdupkVK/HIeGaTh8A==
X-Received: by 2002:a05:6870:b023:b0:db:78e:7197 with SMTP id y35-20020a056870b02300b000db078e7197mr11956037oae.36.1650917989831;
        Mon, 25 Apr 2022 13:19:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y20-20020a056830071400b0060578d19d8esm4168775ots.19.2022.04.25.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:19:49 -0700 (PDT)
Received: (nullmailer pid 201453 invoked by uid 1000);
        Mon, 25 Apr 2022 20:19:48 -0000
Date:   Mon, 25 Apr 2022 15:19:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: gnss: Rewrite Mediatek bindings in YAML
Message-ID: <YmcCZGKkt5tCn1Ld@robh.at.kernel.org>
References: <20220425132947.1311171-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425132947.1311171-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 15:29:47 +0200, Linus Walleij wrote:
> This rewrites the Mediatek GNSS bindings in YAML.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Add the missed gnss-fix-gpios.
> - Move allOf to right before the properties.
> - Keep the description on timepulse-gpios because it documents
>   which pins are used on this chip.
> ChangeLog v1->v2:
> - New patch since Krzysztof pointed out there is really just
>   one more binding to convert, so why not.
> ---
>  .../devicetree/bindings/gnss/mediatek.txt     | 35 -----------
>  .../devicetree/bindings/gnss/mediatek.yaml    | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.yaml
> 

Applied, thanks!
