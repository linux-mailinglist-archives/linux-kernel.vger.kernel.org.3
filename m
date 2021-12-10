Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F36470C11
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbhLJUwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:52:42 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38516 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbhLJUwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:52:38 -0500
Received: by mail-ot1-f43.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso10846585ota.5;
        Fri, 10 Dec 2021 12:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=puFA4eQqim3sFvZtexrPchZBArfnLEeEGlaxtAJnReM=;
        b=PEVwqF7tqoj0joTkaHti21El9AIeWNxnX5x1JS+KGiykq9T8pQwL2LOKYXaahpq1rR
         v3vIrf4lI93Kt5bJ0qsuBfElHR28dGjys1RqSpnTCWWt4rYVylKFBsTfKcw7EUxqJmaF
         2cLcBZ6hjh+QQNGP0cWdtRNmAhHWVU7+lEAdSz/mqJd/gM6MOVs8qloGPMJ9lybWFW3x
         qr7TVv6IayiItTseDAUrvpS0CS/leuxWfI2NA190l4gYOv1loeEgqItVLPe+V2Kie0F2
         bHtQZHMY8gfp65eeDg+OfQ0DbuoMQ+gSnd6TCAR2JlfSVhMUnU/4Wdab8x80CVOER5wf
         wHFg==
X-Gm-Message-State: AOAM531g1TIoi3AGF9eRnV5ouizZCMnJAZtvjOXTAV5TCbdENB/G9Ahm
        GCLiTQfWnWfeSZdc1SNbPnNHhZoHSg==
X-Google-Smtp-Source: ABdhPJwU9xvxrUIfv4q6eTQnaPVNwHghxeb380MKPta2Ovrtj3WQjxz5ZKMD22aNAYdmmt6ifllxyw==
X-Received: by 2002:a9d:4509:: with SMTP id w9mr12825000ote.214.1639169342502;
        Fri, 10 Dec 2021 12:49:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n189sm941951oif.33.2021.12.10.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:49:01 -0800 (PST)
Received: (nullmailer pid 1871200 invoked by uid 1000);
        Fri, 10 Dec 2021 20:49:01 -0000
Date:   Fri, 10 Dec 2021 14:49:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, john@phrozen.org
Subject: Re: [PATCH v6 06/14] dt-bindings: Add en7523-scu device tree binding
 documentation
Message-ID: <YbO9PUJmAAdflhko@robh.at.kernel.org>
References: <20211203113331.20510-1-nbd@nbd.name>
 <20211203113331.20510-7-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203113331.20510-7-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 12:33:23 +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Adds device tree binding documentation for clocks in the EN7523 SOC.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../bindings/clock/airoha,en7523-scu.yaml     | 58 +++++++++++++++++++
>  include/dt-bindings/clock/en7523-clk.h        | 17 ++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
>  create mode 100644 include/dt-bindings/clock/en7523-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
