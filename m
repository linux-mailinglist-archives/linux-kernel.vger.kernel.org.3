Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE25620F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiF3RMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiF3RMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:12:41 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14AF3EF38;
        Thu, 30 Jun 2022 10:12:38 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id k7so12805108ils.8;
        Thu, 30 Jun 2022 10:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vH+eIeVMyqxiZo7+C2E8+WxMh8E5sNuGYMj0NCMiFYc=;
        b=FXB/YzLVXfbCiDRG6H68XfbKBuwwvfJfOe+cBXqFy1G4l97L6ntSzf3fKv1c+5iOG9
         6kUwiNWLJmYwsfmicPEgSAfSV6l8q/unSZmpS2PRhZiH9jj0GF5XX8RJ0HaAUy7fcZ2V
         n9w0vJLocSzd3HWMuzfxFF/I1FpnVDYnCO+icCUQok5DPzcge9Y4MddmqJN0uN/CCELY
         1YOsiCOcYwA2EwAVM6b0DiZJ9Exxgx9iQuBXQXfByrxIxac3PHYm67/yPfoTRNdF3xhR
         SWI7PW5y0XN7qL1Q2f4YkmEhrWdBQDugeqlLMtZUQmgztVymudY/55K/64CZU2dNxAU2
         0e4w==
X-Gm-Message-State: AJIora/yiiwvvm1ENrYEg7U9ABr9PoMOuPo7XN+051RwxSnqYbe97siE
        SMOtr+kuXtogYhAS4dg72LdR/Q3ahg==
X-Google-Smtp-Source: AGRyM1tYEmugjifHFHRwNw9YGWl6wPQoGw00b9hcZYt4UmmpCK8sUvJEvNDX1A4o85vt603e9O081A==
X-Received: by 2002:a05:6e02:16cc:b0:2da:b7b7:a7ab with SMTP id 12-20020a056e0216cc00b002dab7b7a7abmr6095559ilx.114.1656609157996;
        Thu, 30 Jun 2022 10:12:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m9-20020a02cdc9000000b00331fdc68ccesm8617042jap.140.2022.06.30.10.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:12:37 -0700 (PDT)
Received: (nullmailer pid 2919582 invoked by uid 1000);
        Thu, 30 Jun 2022 17:12:36 -0000
Date:   Thu, 30 Jun 2022 11:12:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: add AD4130
Message-ID: <20220630171236.GA2912452-robh@kernel.org>
References: <20220628144649.3957286-1-cosmin.tanislav@analog.com>
 <20220628144649.3957286-2-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628144649.3957286-2-cosmin.tanislav@analog.com>
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

On Tue, Jun 28, 2022 at 05:46:48PM +0300, Cosmin Tanislav wrote:
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 256 ++++++++++++++++++
>  1 file changed, 256 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml

The bot report can be ignored. It's all due to '-nanoamp' suffix 
landing.

Reviewed-by: Rob Herring <robh@kernel.org>
