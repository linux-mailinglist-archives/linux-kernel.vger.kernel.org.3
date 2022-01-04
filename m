Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE704484896
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiADTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:31:29 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40644 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiADTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:31:28 -0500
Received: by mail-ot1-f49.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so48545359otj.7;
        Tue, 04 Jan 2022 11:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KTGs3+rdHyCKA35lj1ufu+1n2FGA4o6nnx82oWhTh/I=;
        b=nTHSPjgmL4ssC2V6e1g75ZS0d+aq/qpG1xrTo6fQrDWVG25QoofRerc95G0zs0FQpQ
         65SSjz4aP9Won+y4d2YUX6BSgTPdkGfSKSFqHCQNkhGZHvQN9aBpucffBzpYfAnVdC7T
         jHAeu1XeGJ7ZRMG/GN1xXwsoZLh31L4rZhVFFyvY+7CFs7rKFDLxN0c3rW9+zWWkScSv
         phxEGpKa9odXKgwwEhen0rjMt21THhBLxXCSxQlttZe3KFpaSV1UH8XxbxjSPLvtbNSL
         DbhozZm+EI73zhkh7emiJ/b3uCqXJlUF2z1FWGt5X5V9s+Iy7imCMHBRiJGkRfLRaIXD
         1r+g==
X-Gm-Message-State: AOAM532g3I+lJSeuHxz2PH8Y26jF6Sontngb5uuFFKsXNldVcwOOG+zw
        j3k+kQDB6iltQ244e7rdrw==
X-Google-Smtp-Source: ABdhPJwORFRXYaYQCIVPXzdG+4AMu81mGLj9/SF0d0fDR/VzwnoWuvyIkrkPOgTDTqn6KlHe7tk2Xg==
X-Received: by 2002:a05:6830:2b25:: with SMTP id l37mr37284224otv.298.1641324687296;
        Tue, 04 Jan 2022 11:31:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh12sm10034224oib.25.2022.01.04.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:31:26 -0800 (PST)
Received: (nullmailer pid 1269921 invoked by uid 1000);
        Tue, 04 Jan 2022 19:31:25 -0000
Date:   Tue, 4 Jan 2022 13:31:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add
 description for power-source property
Message-ID: <YdSgjf5TYtwjDJWj@robh.at.kernel.org>
References: <20211222145901.23661-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222145901.23661-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 14:59:01 +0000, Lad Prabhakar wrote:
> Add description for "power-source" property mentioning the values in enum
> are in millivolts.
> 
> Suggested-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
