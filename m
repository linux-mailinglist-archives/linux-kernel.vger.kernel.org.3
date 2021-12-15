Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A773F47638D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhLOUkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:40:46 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:39682 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhLOUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:45 -0500
Received: by mail-oo1-f42.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso6271395ooa.6;
        Wed, 15 Dec 2021 12:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCm31AopJqJh3IGAGVf/dCMDar4WQOTuKl/qvZkribo=;
        b=nQUmzxps9q0yOZEvAWHhZ1XAPFmYbT5E+EuqW8XkaH8mUaVzsabPKzfsZRV2iS9jGW
         VUQOdUP92kNIuY0ntzZygMXKEzWEgxx4WUi9kv7GXOqC/79IOMLbnR6CuISgEXbWCS+H
         65gTSxwV543QCfEtgxtfSaPCaEgSKH9Gaad9FNSOJREOHr4u3P7dlLv/QEIn946osvzC
         r1WrgrRYASGjk+CC/J5FwL5udXRRK0wBSJXa7n9Ya7fi7LMGUiTlHYsEPUbZtqyTB+BQ
         ewEy7+TddGfsgRRwH6b69LkApr4L4+FtA4a3B8bkOBjXIlg2o7T3rKrcfN5zwqSmCfvG
         QFwQ==
X-Gm-Message-State: AOAM532d8eSNMh9W3t0Lc1o7ZuQHo7UZtMDKdKwik610WN6Ke4ZvQef4
        SAjWriYWowpob7xSh6i0HQ==
X-Google-Smtp-Source: ABdhPJwkO6XUr282lpbyRQWgyGURMsV/N5cuswo4uKTuUZTRW3m+/Apo0eeSYdMnHWOq88WSqW/wmw==
X-Received: by 2002:a4a:3110:: with SMTP id k16mr8722917ooa.64.1639600844654;
        Wed, 15 Dec 2021 12:40:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b22sm527081oib.41.2021.12.15.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:44 -0800 (PST)
Received: (nullmailer pid 1801237 invoked by uid 1000);
        Wed, 15 Dec 2021 20:40:43 -0000
Date:   Wed, 15 Dec 2021 14:40:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 mux-states property
Message-ID: <YbpSy0+x/SnTYUzb@robh.at.kernel.org>
References: <20211214142908.27940-1-a-govindraju@ti.com>
 <20211214142908.27940-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214142908.27940-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:59:07PM +0530, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceivers,
> muxes might need to be set. This can be implemented using mux-states
> property. Therefore, document the same in the respective bindings.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 6107880e5246..7b9216e43b58 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -37,6 +37,15 @@ properties:
>        max bit rate supported in bps
>      minimum: 1
>  
> +  mux-states:
> +    description:
> +      mux controller node to route the signals from controller to
> +      transceiver. Two arguments can be present depending on the
> +      mux chip. If one argument is used then it represents the state
> +      to be set on the mux-chip. If there are two arguments then the
> +      first argument is the control line and the second argument is
> +      its corresponding state to be set, on the mux-chip.
> +

You are still describing how the mux-states works. What the cells 
contain and how many are opaque to this binding. Here you need to 
describe how many muxes you have and what they are controlling as that 
is what is specific to this binding. If there is only one, this boils 
down to 'maxItems: 1'. It's just like reg, interrupts, clocks, etc.

>  required:
>    - compatible
>    - '#phy-cells'
> @@ -53,4 +62,5 @@ examples:
>        max-bitrate = <5000000>;
>        standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
>        enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
> +      mux-states = <&mux0 1>;
>      };
> -- 
> 2.17.1
> 
> 
