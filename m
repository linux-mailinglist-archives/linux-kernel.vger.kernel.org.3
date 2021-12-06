Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42946A8DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349899AbhLFU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:59:25 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:43810 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349883AbhLFU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:59:22 -0500
Received: by mail-oo1-f41.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso4740802oow.10;
        Mon, 06 Dec 2021 12:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1GkNznSBQtWJgrsWSFxmee9FbMbeGL/694Sq+ppQxoI=;
        b=XQ4jKkRuP9l2zXCS40ZOiyii0dqcZgUp51eHuuAGEtUZTPx9/aUJRxfQkuzUJNlrRl
         1wY0pdZBnTp/DkSfjVHzSFaWPp5LlFqsW0UErhebu85Sg8q1dhpmlQKIAfSufmY131VR
         7LN0v21SAj8G3PIIGK6lQC67C5F3YdAD3WZMaIBBA41zfKRvU76khEpKJVfnK0D34gxB
         Npk2jnIYGjX3lbQHauK1At6LIKvPlqP0MsAe20l8BYQtbqUso41lt3Wbuy6Chgw7vD+p
         Fxa9fwi4AXofq8POHO1+p3E5ojVXTXMn+kWoU61U10snugnUSpDPDffzGlUQTHD+h8OX
         Oxsg==
X-Gm-Message-State: AOAM532oqDIPPHE5BR0bofHaQk5BQg/l8J4kNsCJdYc8mALwshkRFimv
        Ms2VH09e8g7pK8aWaYxIaErWis1flw==
X-Google-Smtp-Source: ABdhPJxT0JSuhaYjX3+lvrmTAecuqd8/aKtxxaFKQafVBTtXok+6SKYkzYqml3xqz5LMZPyCSe8JIg==
X-Received: by 2002:a05:6820:30b:: with SMTP id l11mr23870353ooe.32.1638824153196;
        Mon, 06 Dec 2021 12:55:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm2299851ooq.36.2021.12.06.12.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:55:52 -0800 (PST)
Received: (nullmailer pid 2569154 invoked by uid 1000);
        Mon, 06 Dec 2021 20:55:51 -0000
Date:   Mon, 6 Dec 2021 14:55:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/2] dt-bindings: mux: Document mux-states property
Message-ID: <Ya5411zdtB3RJePO@robh.at.kernel.org>
References: <20211202124053.2835-1-a-govindraju@ti.com>
 <20211202124053.2835-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202124053.2835-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 18:10:52 +0530, Aswath Govindraju wrote:
> In some cases, it is required to provide the state to which the mux
> controller has to be set to, from the consumer device tree node. Document
> the property mux-states that can be used for adding this support.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Note:
> - on running dt_binding_check with "DT_CHECKER_FLAGS=-m" the following
>   error was seen,
> 
>  LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>   DTC     Documentation/devicetree/bindings/mux/mux-controller.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/mux/mux-controller.example.dt.yaml
> /home/gsaswath/presil/ks3-linux-integrated/linux/Documentation/devicetree/bindings/
> mux/mux-controller.example.dt.yaml: can-phy4: 'mux-states' does not match any of
> the regexes: 'pinctrl-[0-9]+'
> 	From schema: /home/gsaswath/presil/ks3-linux-integrated/linux/
> Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> 
> "mux-states" is a new property that is being added and the patch adding this
> property to TCAN104x can transceiver bindings will be sent as a follow up
> of this series.
> 
>  .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
>  .../devicetree/bindings/mux/mux-consumer.yaml | 21 +++++++++++++++
>  .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
>  3 files changed, 55 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
