Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33947C5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhLUSIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:08:07 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:41628 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhLUSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:08:06 -0500
Received: by mail-qv1-f50.google.com with SMTP id h5so11454594qvh.8;
        Tue, 21 Dec 2021 10:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/i2gtBAAwHl7UFTwSIBiXP8Kkr2RiBpIIjjr4u1x3M=;
        b=XhPJ2dt+T1RVSnCLNAtftmaW8pO1JxEdbfoTldSH7Q45hQxZEsiELmDfRa57WzPvZU
         NOdWLu38b6YxQZ9ADcZMh689bWUAR8ZzIa8MGgyodqKWmheW1YIpCrANOfRgh+mdGNWj
         i/PQvAXpwuQIbG/h+jk1t5ViFnG1mdG+YL4sUSNvwTJkOmWYGKxPnQzMsL0FbLN7PUDZ
         gTayiNPkUxgH5TR2kOXYsfcxLm3xLRonUg+D/iMWIj7L5qRrb1P1PbIEFKa8MX97qXVf
         4O/5kQqzYETE7/5NVSZAOzvYr7ZDS7poQrkZBxO48l5VzBdaVVVwEm4qRVUve4GBI9DO
         MrGw==
X-Gm-Message-State: AOAM533gsYIwzme8Qays7bVgr00dMIb/UtnY+EroalEKewP+V9Tm+L0B
        A5zbysWN+Tn3ciiHUZetTQ==
X-Google-Smtp-Source: ABdhPJz/cCa8QYHLjZshamwBASEQa7AbH05I44tBFMXQ7N4Fkp5JLuoxxopZU0l2vkq1gl9wGpRuXA==
X-Received: by 2002:a05:6214:622:: with SMTP id a2mr3506810qvx.42.1640110085509;
        Tue, 21 Dec 2021 10:08:05 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id u9sm17846766qta.17.2021.12.21.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:08:05 -0800 (PST)
Received: (nullmailer pid 1512242 invoked by uid 1000);
        Tue, 21 Dec 2021 18:08:02 -0000
Date:   Tue, 21 Dec 2021 14:08:02 -0400
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     livelwh@outlook.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        romain.perier@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: mstar: Add compatible for 100ask
 DongShanPiOne
Message-ID: <YcIYAvOZsu9WYipC@robh.at.kernel.org>
References: <20211217093510.3674590-1-daniel@0x0f.com>
 <20211217093510.3674590-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217093510.3674590-3-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:35:09 +0900, Daniel Palmer wrote:
> The DongShanPiOne is a SigmaStar SSD202D based module.
> Add a compatible for it to the list of infinity2m boards.
> 
> Link: http://linux-chenxing.org/infinity2/dongshanpione/
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/arm/mstar/mstar.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
