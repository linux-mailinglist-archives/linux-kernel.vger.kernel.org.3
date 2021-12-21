Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9317847C7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhLUTyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:54:25 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:33600 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhLUTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:54:24 -0500
Received: by mail-qv1-f53.google.com with SMTP id kk22so334444qvb.0;
        Tue, 21 Dec 2021 11:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nSW4ewwMqVSFYkJQpvmFULZH3ZN7gne0K+41KDgKY9k=;
        b=YxrZuiV8XFz7MILksgbJgr+6p5o0lRsaBkdFzYC1Uo2ECQltWfZ9KJi5+X5RnP9ODB
         sw1vBKF3oYb1On5TTUZh1ZUpkpktLO9MJW1nW04m3btD+1AIQeN+vRR3gV1vAVBWnstU
         1x4DM3MIUQ/dm8mM6Nml/2JsCl71XTgmLNsQW5+u8N/CMwOtG/4HLTQVI33ABZh/lVP7
         Q8xrexGQ7C8TJe5Ba+KHiiU59bESfC9vqe7ilb0LcmOac0d4QQi5/7HmMMDL9OWprVb5
         ZN6z+NqL4hyu+tevRHex4LEPv4cGGTf3ZRRGlPsp2d2OZNUKJIi5iV6mE8ZGdradtWlu
         D4SQ==
X-Gm-Message-State: AOAM5333fvPaaumwUVRwNa+SMzo2OCR5U6umw7NY+wyTVyRkq2+jL8ys
        SSlGD7oUTV5SDXPeB+/l7A==
X-Google-Smtp-Source: ABdhPJxpq+KJvE8wfFe8hvEiAUqBx2YVWSNDJM28axDmgjijRZRNL9M86MZXMt8Ck9WtW+SysMxzOA==
X-Received: by 2002:a05:6214:27e6:: with SMTP id jt6mr4116419qvb.7.1640116463292;
        Tue, 21 Dec 2021 11:54:23 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id k1sm13538434qkh.53.2021.12.21.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:54:22 -0800 (PST)
Received: (nullmailer pid 1643746 invoked by uid 1000);
        Tue, 21 Dec 2021 19:54:21 -0000
Date:   Tue, 21 Dec 2021 15:54:21 -0400
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: ux500: Document missing compatibles
Message-ID: <YcIw7QH2UtJVkWiF@robh.at.kernel.org>
References: <20211218144927.GA6388@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218144927.GA6388@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 15:49:27 +0100, Stanislav Jakubek wrote:
> These compatibles are used in Ux500 device trees, but were not documented so
> far. Add them to the schema to document them.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/arm/ux500.yaml        | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Applied, thanks!
