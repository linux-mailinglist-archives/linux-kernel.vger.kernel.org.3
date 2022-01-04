Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF03F484861
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiADTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:13:59 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35429 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiADTN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:13:58 -0500
Received: by mail-ot1-f47.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so48472320otg.2;
        Tue, 04 Jan 2022 11:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RfgW8UBbfWWVsW3q0k4cJsLxXXBEQJ054F3007q+F/g=;
        b=hTQnDeRoiFJoldrrpkClLRQLekyKbzpJGSAAtO4QXfLtWnBp32B/TpYNnKZIEkJe+p
         L7JMt9hTbVWSXPDe3xw4LjxjruPGUKDXEKEK0tCYLopOugSCLZ4Jx0ZTn3/RRSNTk5Lp
         Hc+uxMkPjHXfr8hgG7yL6LtLbBaJKWgBt8hTUy4uZacFBUfd+VuETZKeDrK906pUoLmH
         aVt45WDU3OboKSSNNojFz+FzyOFP1AV9dDE0ZFRSx6fwLwJNAyevxLaD5X7YiMxHAMbE
         OsujWR9gkYE7D9pivbAN/Ggbyhm1iMr6U9MUBTyWTM11xba9K55AGRJ4BW330eO9BO+G
         nuEw==
X-Gm-Message-State: AOAM533y0GgHSJy3PiTRvHUqHhIu3bFWkwgTpyl4Vq8CI4poQK799u9X
        7kdlMK8RFvLcP/TZwmvr807c63RGyQ==
X-Google-Smtp-Source: ABdhPJy0YURjDPnlQssIPcPPZ6un2d2Pvm8SjIs8TPbLRcOHisGKBjtaw5XPO4+4DhqoF3meduYgug==
X-Received: by 2002:a05:6830:244c:: with SMTP id x12mr32642971otr.197.1641323637795;
        Tue, 04 Jan 2022 11:13:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r23sm9387520oiw.20.2022.01.04.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:13:57 -0800 (PST)
Received: (nullmailer pid 1240061 invoked by uid 1000);
        Tue, 04 Jan 2022 19:13:56 -0000
Date:   Tue, 4 Jan 2022 13:13:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: memory: Document Tegra210 EMC table
Message-ID: <YdScdFvwLfAlp9Gf@robh.at.kernel.org>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217165919.2700920-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 17:59:15 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add device tree bindings for the Tegra210 EMC table that is passed via a
> reserved-memory device tree node.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../nvidia,tegra210-emc-table.yaml            | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
> 

This one appears to stand on its own, so applied, thanks!
