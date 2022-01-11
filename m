Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B576048BB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbiAKWyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:54:54 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33370 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAKWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:54:52 -0500
Received: by mail-ot1-f53.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso576003otf.0;
        Tue, 11 Jan 2022 14:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaRuwn3z2vZgd7d6uXNPEElduZNqC7atPxnY1MWXEY8=;
        b=7r7XjMUBrodiwOkpClbbe/puSFPdfgM+IB86Jykvjq4hl7k3mlzkbU0Z+m4vMcVes2
         FunTwWGkPgyf6cdVBWUMDxGlEhSs7zMKnVvq9zff+5V6++/TPs2hJ34Jdb7JPfd1yuTS
         b1dLbRPxibf4iZmzroXFLPhmobhK77+z4hlJXJiUVyTzkZKcqqlC9/blHF+f+MSZqYZT
         ScuJxDRay0CPioKuFVGdhF43aZx8RuR0eZbXXH1PYeQfxtzeAhqPQeuHs5l++09V+ICH
         yQFoHK5heQhNpMQugm5MI20Ba8QvTVUk8GG+iJdTcHGjdunsUof7vDW3C9IbRYed9suC
         jOxQ==
X-Gm-Message-State: AOAM531KtZoOrqiv88XI6Hxoy65nKv63JuTA9ED5s5RwYWeMGDbztpM6
        9wamq6Un097YEFYeNFhgLQ==
X-Google-Smtp-Source: ABdhPJwvYN7rY4HXMQOQTwTBQsr1FwLLwpj6T6v32VokHKGrciARnmlF3v+Wt525mMAIkpcHWb5nnQ==
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr4780844otq.215.1641941691939;
        Tue, 11 Jan 2022 14:54:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h1sm2187481oog.26.2022.01.11.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:54:51 -0800 (PST)
Received: (nullmailer pid 3659851 invoked by uid 1000);
        Tue, 11 Jan 2022 22:54:50 -0000
Date:   Tue, 11 Jan 2022 16:54:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, Benoit Masson <yahoo@perenite.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
Message-ID: <Yd4KulrOCjS4PdWG@robh.at.kernel.org>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
 <20220103163956.6581-3-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103163956.6581-3-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 16:39:49 +0000, Christian Hewitt wrote:
> Add board bindings for the Amediatech X96-AIR STB which ships with
> model variants distiguished by Ethernet configuration: models using
> an external Gigabit PHY have a -gbit suffix, while models using an
> internal 10/100 PHY have no suffix.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
