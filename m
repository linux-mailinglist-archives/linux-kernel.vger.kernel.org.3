Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1846419A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbhK3WoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:23 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43568 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbhK3WmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:14 -0500
Received: by mail-ot1-f53.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so10894453otu.10;
        Tue, 30 Nov 2021 14:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyRB4uee9xxyNE6vb1Awa2gOArPOKZhUzeq1Pnr7VKM=;
        b=ijC3e4Os6Nub7fNNmdtk9zFuQ8UJ5QKzgHETJBO3SNolHQ+eITMhj+KzRVpq7Zssw6
         zwBBJEcVAYo323K2oDwxIG6FJGFk2hiESp3g/gnsAU6SRHMwyG51AO6KNNAj40NidZwZ
         cNCegg5cRGzfZs5T6btiZGNc1gSI0jtYDLtfqrNWjSFDKeK3ym9JGK5Kg9urUfW+wNBs
         ENej5zLrR6BeZ/oPpQumYe9WMJsUGUkwisKLC1pHFjKDt7/vTdf9s4xn7oPr+TxwF4Tq
         BUHfaGCQHN7uR1NOgR87qGgwNCG5KZzx8o1CrtwZMw2Jy0WEJNiVatvm52310G8R6Omb
         cXqQ==
X-Gm-Message-State: AOAM533Q8DRbTV+gg2YjWaslsSjGHEvfqMa1kSGuPFZwf8khfzv2qDXP
        YSZc+5zML+omODVfcT2SFQ==
X-Google-Smtp-Source: ABdhPJymcgYv040uIpH2kPpBlDazxLB3zUYP/C8iLtDvxNdCW/Fd/7DcJ5lMc1JHZAKRTP3mxLF9xQ==
X-Received: by 2002:a9d:6752:: with SMTP id w18mr2035458otm.13.1638311933762;
        Tue, 30 Nov 2021 14:38:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s26sm4205127oiw.19.2021.11.30.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:53 -0800 (PST)
Received: (nullmailer pid 3139818 invoked by uid 1000);
        Tue, 30 Nov 2021 22:38:52 -0000
Date:   Tue, 30 Nov 2021 16:38:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiantao Hu <xt.hu@cqplus1.com>
Cc:     wells.lu@sunplus.com, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, qinjian@cqplus1.com,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        wim@linux-watchdog.org
Subject: Re: [PATCH v2 2/2] dt-bindings: watchdog: Add Sunplus SP7021 WDT
 devicetree bindings documentation
Message-ID: <Yaan/GqjL31nGKiF@robh.at.kernel.org>
References: <20211112105952.216280-1-xt.hu@cqplus1.com>
 <20211124104149.361019-1-xt.hu@cqplus1.com>
 <20211124104149.361019-3-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124104149.361019-3-xt.hu@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 18:41:49 +0800, Xiantao Hu wrote:
> This adds the documentation for the devicetree bindings of the Sunplus
> SP7021 watchdog driver, found from SP7021 SoCs and newer.
> 
> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
> ---
>  .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
