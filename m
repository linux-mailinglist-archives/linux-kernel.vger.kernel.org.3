Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDC4735BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbhLMUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:19:52 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39653 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhLMUTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:19:51 -0500
Received: by mail-ot1-f43.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso18676944ots.6;
        Mon, 13 Dec 2021 12:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WN/EU3Tqk0e8ErBw3JtRSP5A6/xa+N6f3cKQLbPWvZw=;
        b=W/8pwFExiybSs+T6jhTzFaHfgUTAB8sq60MSrEh4CNdPh6C10XIWE0rs2rhLEyekri
         m0vZIJE6nMIjI2xIcb/brOmabwxv2eh93Ffmazc7gFFIFm0eKcvrLQsB1rQKrYGnRGAO
         4tvnEVR68U8Taxm6aeLgJy2TwdtpURt4VyK0pOl3Kv6QgP+haBs79YsTVHAz3G21YEqF
         kTVKCL9hZ2IiXKy7l+TBYsTkEmttXql0OGuJe4RygsxLTxtj3pWsdVKBe0vY4jNhpd/r
         5hzSkg2EqkahYoTHU5KRVaYOpESwA51des80HfdX6aRNUWj5W+7yOzF6M3L7hUFetOdn
         lvkg==
X-Gm-Message-State: AOAM531gHOuZHjDJg04+jLQWEA3OwuICkH+tiIPJTn14KAFfqrdKqReQ
        KiWQ9vKfzh10F8h+GSEdjA==
X-Google-Smtp-Source: ABdhPJy/Kdpt3vHE/n5DWLa5z2zo9tRnw/q4qgWuWRbWc1zYTxCxupDXrhT9Yyr+7fnGb3/2r4HHOg==
X-Received: by 2002:a9d:4543:: with SMTP id p3mr645542oti.99.1639426791186;
        Mon, 13 Dec 2021 12:19:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bi20sm3047537oib.29.2021.12.13.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:19:50 -0800 (PST)
Received: (nullmailer pid 1502975 invoked by uid 1000);
        Mon, 13 Dec 2021 20:19:49 -0000
Date:   Mon, 13 Dec 2021 14:19:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 mux-states property
Message-ID: <Ybeq5dNYjN4GOzdV@robh.at.kernel.org>
References: <20211202131002.12217-1-a-govindraju@ti.com>
 <20211202131002.12217-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202131002.12217-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 06:40:01PM +0530, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceivers,
> muxes might need to be set. This can be implemented using mux-states
> property. Therefore, document the same in the respective bindings.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 6107880e5246..5b2b08016635 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -37,6 +37,18 @@ properties:
>        max bit rate supported in bps
>      minimum: 1
>  
> +  mux-states:
> +    description:
> +      mux controller node to route the signals from controller to
> +      transceiver. Depending on the mux chip and the control lines
> +      in it, the first and second parameters can be used for
> +      representing control line and state. The number of arguments
> +      is to be used based on '#mux-state-cells' property in the
> +      mux-controller node. If '#mux-state-cells' is equal to
> +      one then, then the argument to be used would be the state.
> +      If it is set to two, then the first argument is the control
> +      line and the second argument would be its corresponding state.

No need to redefine how a common property works here. What you do need 
to define is how many entries and what they are for if more than 1. 

Rob
