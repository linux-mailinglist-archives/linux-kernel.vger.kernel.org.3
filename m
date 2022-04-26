Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364050EDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiDZA6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiDZA63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:58:29 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503D11C17;
        Mon, 25 Apr 2022 17:55:23 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id m11so8292506oib.11;
        Mon, 25 Apr 2022 17:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aa14jKg1EBvAUQaSK50DEJUfnrJhBtd3b/4HS3dD0yA=;
        b=WKFrCoNk74P4MdqmGcwtpQZSkuYaVp/ScDjT2+0E+v93uMcQVjDAocfE2YhYbPZPjY
         9hgfHbAEfEGO23iRTgjyFlzosR8+N0OCnnOjt/TVo5n20HHSx1aCSbJhgNlITiNAKe5U
         zIYoFSNz3wRxllCn0xeEB9HU06jodTjqDG6ZR21EJmqeKJ4vbu859NOZW4gCCB3PTY5M
         yoY5I0xAygEf7RTR9U1HC6SiwuZ4JFe7O1qp0Ph9E4UXu/l5TDYguVtvKtjpr6zbGCl0
         bk02XHeSbBhkO7atw/3r9zN9AUp+6raqSz1IgYwLDft4W4VMtqHa2BA3oszRlC8YlxJb
         K6hA==
X-Gm-Message-State: AOAM531NjTFrYgLKaoCMzgmjlledUnhFueJQ7HB7sMi5sZ+sfWXv7xgz
        /doYjFRBsYZ7nEHW8JjNyQ==
X-Google-Smtp-Source: ABdhPJzCEDuN/45uLcrN3SNTFLMqH442El+5OlEkAz0JcvBRd/hcw/J/vYnNhkiEeo/e+B046yRqSA==
X-Received: by 2002:a05:6808:170b:b0:2fa:729a:a42e with SMTP id bc11-20020a056808170b00b002fa729aa42emr13915543oib.0.1650934523215;
        Mon, 25 Apr 2022 17:55:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d644f000000b005ce0a146bfcsm4348105otl.59.2022.04.25.17.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:55:22 -0700 (PDT)
Received: (nullmailer pid 657948 invoked by uid 1000);
        Tue, 26 Apr 2022 00:55:21 -0000
Date:   Mon, 25 Apr 2022 19:55:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ryan Lee <ryan.lee.analog@gmail.com>
Cc:     perex@perex.cz, arnd@arndb.de, drhodes@opensource.cirrus.com,
        cy_huang@richtek.com, alsa-devel@alsa-project.org,
        krzk+dt@kernel.org, lgirdwood@gmail.com,
        srinivas.kandagatla@linaro.org, lukas.bulwahn@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        ryans.lee@analog.com, devicetree@vger.kernel.org,
        ckeepax@opensource.cirrus.com, hdegoede@redhat.com, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, stephan@gerhold.net,
        pbrobinson@gmail.com, tanureal@opensource.cirrus.com,
        broonie@kernel.org
Subject: Re: [PATCH V3 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Message-ID: <YmdC+XaH2ZQhSNOW@robh.at.kernel.org>
References: <20220425173715.1827706-1-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425173715.1827706-1-ryan.lee.analog@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 10:37:15 -0700, Ryan Lee wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> This patch adds dt-bindings information for Analog Devices MAX98396
> and MAX98397 Smart Amplifier.
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---
>   Changes from v1:
>     Fixed yamllint/dtschema/dtc warnings and errors
>   Changes from v2:
>     No change
> 
>  .../bindings/sound/adi,max98396.yaml          | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,max98396.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
