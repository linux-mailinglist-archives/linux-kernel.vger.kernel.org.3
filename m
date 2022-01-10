Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112DC48A27F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiAJWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:12:00 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42895 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiAJWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:11:59 -0500
Received: by mail-oi1-f182.google.com with SMTP id w80so20537962oie.9;
        Mon, 10 Jan 2022 14:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hHMtIWBBwZWxgsgZfXbNkAmFjx7hrkdVDxn+6n+tto=;
        b=12+foDSNk5g8fMJCgkalntfxvP360AXkY1C6xLvA4E6Cjl67BGZFtlNccs7m2/DXfT
         Lur4bz7ZJj0fKjR4ddjJy+a8Pw90IhuYjreZ/ULY7/iECLbZws++anvRxFmBIWb0y8oV
         HWyCPcrnC1AtLHRVhgD0zGB56wGi3T/l19/HABkV8UfBq3lMqjxwpPx/YLD3oHw925DS
         mcpWMMTMmLnC7sQXRzqzHLHOsBR38gZKql4SehZegEGzYKI3jhVZZfv7nWOW/BF3v6VW
         Yvtr6LwQ+zZwHRFbkUV65w/RESdj5vFqlIeYOGga4RCXsvFgCLfYcBK5GC0X0FCBNE+n
         E2CQ==
X-Gm-Message-State: AOAM533HZRae6yz3ZraY7rzAftS332PxgMxGJ8mQRPBqSbfqm7CSWtLl
        PxCZDhdyiXDfqdI+qefwjw==
X-Google-Smtp-Source: ABdhPJyVX7S3KToqZ2CrBJImjI3SfpGSXg0UsFE0I7c/lBs5VkiJRG6C4CmBAB4FY8M3ceSkw2wqvg==
X-Received: by 2002:a54:4502:: with SMTP id l2mr1041442oil.167.1641852718580;
        Mon, 10 Jan 2022 14:11:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k25sm1356483oik.19.2022.01.10.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:11:58 -0800 (PST)
Received: (nullmailer pid 1614366 invoked by uid 1000);
        Mon, 10 Jan 2022 22:11:57 -0000
Date:   Mon, 10 Jan 2022 16:11:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: clk: mstar msc313 cpupll binding
 description
Message-ID: <YdyvLSbjrPPg80Pa@robh.at.kernel.org>
References: <20220102165730.50190-1-romain.perier@gmail.com>
 <20220102165730.50190-2-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102165730.50190-2-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 17:57:22 +0100, Romain Perier wrote:
> From: Daniel Palmer <daniel@0x0f.com>
> 
> Add a binding description for the MStar/SigmaStar CPU PLL block.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/clock/mstar,msc313-cpupll.yaml   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
