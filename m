Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C3473760
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbhLMWUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:20:44 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:45893 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbhLMWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:20:42 -0500
Received: by mail-oo1-f53.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so4525604oog.12;
        Mon, 13 Dec 2021 14:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ew+Sn87n5dgrSQQlksxlUR5i6NQ5of8Xi1jdPcN3mw4=;
        b=rtErV75PsBS3XtTsUGSHa4yyupaOzDCbwUFfJx2mXE0Rb3AlAaOISpUB024UTLSHCF
         11ccBn4IFJQmM0AUV9GScnnEdBVOEgMciMoP+CAxPp9/UwSzXs5R7lL/eVnpaQKjaJsB
         6B9vjTzqWP0O6FQ0YhqFC0zMqmLmGICgT7aYGaOHdjp+dH4EyKxLItSJgylvnC9n4X/Z
         H5LBmU1oPV8/jeN4BysFewdTR3Wh5RSojOKh1YWHI+VEGsKIdyRx6Uxtz6XmuIXxgAYB
         fDDmjLVekPjpQTjKLNFsqc4znrUiudzfVsvS7+hFUF452S1rJGgihUd8HeBmqT7gIQyd
         FrHA==
X-Gm-Message-State: AOAM531SuejOLETkiWfZvJr29XE9lQzacL/jKTakgLulajsjz+XeTxMu
        G7DRZqGbe5UjQK+0kG0wuq/J00aM+Q==
X-Google-Smtp-Source: ABdhPJwqC3QI27RleQJCYcKMotxp9+X06R8vkDhazTd0yXRngflxKQGj8cSjF82QmUDQELfukNh5mg==
X-Received: by 2002:a4a:85cf:: with SMTP id u15mr842353ooh.45.1639434041735;
        Mon, 13 Dec 2021 14:20:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm3079014oiw.22.2021.12.13.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:20:41 -0800 (PST)
Received: (nullmailer pid 1681708 invoked by uid 1000);
        Mon, 13 Dec 2021 22:20:40 -0000
Date:   Mon, 13 Dec 2021 16:20:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, git@xilinx.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: usb: dwc3-xilinx: Convert USB DWC3
 bindings
Message-ID: <YbfHODV4JnyTl6/m@robh.at.kernel.org>
References: <1638808021-26921-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638808021-26921-1-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 21:57:01 +0530, Manish Narani wrote:
> Convert USB DWC3 bindings to DT schema format using json-schema.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
> Changes in v2:
> 	- Updated the schema with missing phy and phy-names properties
> 	- Updated the interrupt-names property to resolve dtbs_check warnings
> ---
>  .../devicetree/bindings/usb/dwc3-xilinx.txt        |  56 ---------
>  .../devicetree/bindings/usb/dwc3-xilinx.yaml       | 131 +++++++++++++++++++++
>  2 files changed, 131 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
