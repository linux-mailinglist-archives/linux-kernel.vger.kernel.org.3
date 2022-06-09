Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF49545584
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbiFIUYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:24:40 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D11C0CA2;
        Thu,  9 Jun 2022 13:24:40 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id p128so3871320iof.1;
        Thu, 09 Jun 2022 13:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXFr+AGOM+7XdmBTM49rg6ip3rbHfpbk63C2J+FEopY=;
        b=OMY0OxD6eyLDVE/C/i8wkEVlyBzMJO1UOKatVK2As5y+lWDJKks5AnDEAekih2SaC0
         7HhtXsBd497tMPnl7ggETOuZ2uVb2bIWYMT94wcxzYy8tOybriDbYrLBt8wgZWpkkIRe
         TJCJ5xr9sAxnP626rDZVHOsL6W90L4+YqPD48ygVAAUMWBkVOPoRxcAZOzIDCICNUEfr
         zQyM6/CVIkYcUF0R+AMJsAuAVylT7CaaYdPKg5fD8Lxg0HDFW0Czfnwm/XPSnFAUnVrV
         HBicLQB2uWStpPZ7hyklbeMwF9wf2Z/E4kTq1Fj15nVlcV6eRaQ5aZ0uqk4WrYRpuFaG
         hDwQ==
X-Gm-Message-State: AOAM531zw8jh07rKW8zUDQCCptlPcqwB9rSguPtHf9Awdo08tTHNVNpm
        d/4/j8MqQgEwsIEwBcXcWlbIwr5RrA==
X-Google-Smtp-Source: ABdhPJxq/rQJljnv1MaCNKFPZNueJys2d4PzmSQjoOyDCSFWpcBaNO9rTPljW4vKGraz1b43ikqmTg==
X-Received: by 2002:a05:6638:370d:b0:32e:db90:f2e2 with SMTP id k13-20020a056638370d00b0032edb90f2e2mr21514924jav.84.1654806279265;
        Thu, 09 Jun 2022 13:24:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y38-20020a029529000000b0032e583132e4sm9933595jah.123.2022.06.09.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:24:38 -0700 (PDT)
Received: (nullmailer pid 42587 invoked by uid 1000);
        Thu, 09 Jun 2022 20:24:35 -0000
Date:   Thu, 9 Jun 2022 14:24:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     quic_gurus@quicinc.com, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        sre@kernel.org, linux-iio@vger.kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        broonie@kernel.org, rafael@kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        gregkh@linuxfoundation.org, wens@csie.org, jic23@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/17] dt-bindings: gpio: Add AXP192 GPIO bindings
Message-ID: <20220609202435.GA42506-robh@kernel.org>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-7-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-7-aidanmacdonald.0x0@gmail.com>
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

On Tue, 07 Jun 2022 16:53:13 +0100, Aidan MacDonald wrote:
> The AXP192 PMIC is different enough from the PMICs supported by
> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> driver also supports interrupts and pinconf settings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
