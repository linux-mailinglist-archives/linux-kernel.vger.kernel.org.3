Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D33747D593
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbhLVRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:05:05 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:45772 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLVRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:05:04 -0500
Received: by mail-qk1-f176.google.com with SMTP id e16so2896727qkl.12;
        Wed, 22 Dec 2021 09:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxOVJeyqCmU32AckrBEOQE83g3mh3op0AFwv29sitWs=;
        b=3BHVsJ8zMwq+Src7x8KreH6dEYqSZECDPLdaq8OST7X3HZoDv81e6Ww21MQ9qVneGW
         5r2jbpsUIBfX1mU3x01mf4qJCCz6y5hp9ecL4uGDJpORATj8gv3snRD/67Mb3G65tEAh
         lScxHkWRKF5sEBgyL0pyBXhD3Bx8UWC4MJNoj+WNQjQHlH/0nJbbEYnr8IgM5wWXhu+y
         wRWTXc/2FcGA1Ur1zf+EU4FGotiPTS1h2zdwoq7kI9eAGAzv4zRtWkXbs2533qvxGQpD
         dyAMnV3rEnXuLv2FWGp1DilUoK6WA4DMtHNhrYBXRLpPvHzVMLk1RJbdbFjYDqvXlMgU
         a02g==
X-Gm-Message-State: AOAM531GsiWKQdVIeGV/jn92OlbW+2GYTU6aj74KYwsnrhEy463YXBci
        a54OrWSvmVA/uep2l+0/9Q==
X-Google-Smtp-Source: ABdhPJxMux/N/jFQjJbXPnewnuN/+3feac9FUFYputqL8H7h84Mijz6P7oWUrrTR/jWQRhCD0nYB/A==
X-Received: by 2002:a05:620a:284d:: with SMTP id h13mr2599682qkp.612.1640192703354;
        Wed, 22 Dec 2021 09:05:03 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id k8sm2225916qko.130.2021.12.22.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:05:02 -0800 (PST)
Received: (nullmailer pid 2326372 invoked by uid 1000);
        Wed, 22 Dec 2021 17:05:00 -0000
Date:   Wed, 22 Dec 2021 13:05:00 -0400
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     mturquette@baylibre.com, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux@armlinux.org.uk, devicetree@vger.kernel.org, maz@kernel.org,
        wells.lu@sunplus.com, tglx@linutronix.de, robh+dt@kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        arnd@arndb.de, p.zabel@pengutronix.de
Subject: Re: [PATCH v7 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Message-ID: <YcNavOi/OtCZV1M1@robh.at.kernel.org>
References: <cover.1640154492.git.qinjian@cqplus1.com>
 <504303c7cf92af8368dcda0cdde3b9c15a833418.1640154492.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504303c7cf92af8368dcda0cdde3b9c15a833418.1640154492.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 15:06:01 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Add clocks & clock-names.
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  52 ++++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
