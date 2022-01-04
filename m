Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FA2484A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiADWHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:07:55 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41830 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:07:54 -0500
Received: by mail-ot1-f45.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so8069686otl.8;
        Tue, 04 Jan 2022 14:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WpuTEnMsfacvD0VOURlK31DWnAVBUgJmXM4X3B1dfVw=;
        b=ESwvf2GL6leO2H/LypLn3p0gDz/P02Hk73G++uSypsIoFurtZua5ihO1EXTdrus7hg
         pA4fzBHjbxeSCvBhlvPiMwFp4tY9t/gj9VEytF5c0IOPApRiFez/uAOGU3229v5QR12b
         ZRqiCNK2LOLkhzoe/5LWURach7XMY0JQR/0EcqKNqfsSNsSnC60rq5hL7pExnJb8rLF/
         FYzxJSXk5U2ZVqfvZtlbg3S86qrtDJH6LbtYiq/D6fXYVoDKY0+p7aji6Ml4uTQWhhWG
         5u/0LWDb1eoJRstnOgwKyw2+C/+Z53geqjjzBQrcHVyRqGU2alZ+a2nuoOy/iOXkGHFK
         8+CQ==
X-Gm-Message-State: AOAM53202FBVLsL9mAeM3LKIrTPr18QFT8xAH0BxowvZy90DafM589pe
        QF0GyRSqlKMqneBv7FgZEA==
X-Google-Smtp-Source: ABdhPJwcOkAgoVIzZ4/aXLTGe5sAZbXE/iR7xEi+gBzUL+p6caHDpCCjUdLlmlzY3dynP6W95IYHeg==
X-Received: by 2002:a05:6830:1d49:: with SMTP id p9mr37021965oth.108.1641334074202;
        Tue, 04 Jan 2022 14:07:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y14sm7531050otk.39.2022.01.04.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:07:53 -0800 (PST)
Received: (nullmailer pid 1526475 invoked by uid 1000);
        Tue, 04 Jan 2022 22:07:52 -0000
Date:   Tue, 4 Jan 2022 16:07:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: arm/npcm: Add binding for global
 control registers (GCR)
Message-ID: <YdTFOLEbcWs8tu1D@robh.at.kernel.org>
References: <20211224200935.93817-1-j.neuschaefer@gmx.net>
 <20211224200935.93817-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211224200935.93817-2-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 09:09:27PM +0100, Jonathan Neuschäfer wrote:
> A nuvoton,*-gcr node is present in nuvoton-common-npcm7xx.dtsi and will
> be added to nuvoton-wpcm450.dtsi. It is necessary for the NPCM7xx and
> WPCM450 pinctrl drivers, and may later be used to retrieve SoC model and
> version information.
> 
> This patch adds a binding to describe this node.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> ---
> v3:
> - Make a few changes suggested by Rob Herring
> - Change name of mux-controller node to appease the linter
> 
> v2:
> - https://lore.kernel.org/lkml/20211207210823.1975632-2-j.neuschaefer@gmx.net/
> - Rename node in example to syscon@800000
> - Add subnode to example
> 
> v1:
> - https://lore.kernel.org/lkml/20210602120329.2444672-2-j.neuschaefer@gmx.net/
> ---
>  .../bindings/arm/npcm/nuvoton,gcr.yaml        | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
