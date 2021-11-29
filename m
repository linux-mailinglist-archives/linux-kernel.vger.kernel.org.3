Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0746247C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhK2WT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:19:59 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34772 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhK2WSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:18:04 -0500
Received: by mail-oi1-f176.google.com with SMTP id t19so37403059oij.1;
        Mon, 29 Nov 2021 14:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IffRfna52Ob5VpMAmyauxNNqvaWuTWKWn4wJYeGVpRA=;
        b=RQKXVssjlSJupvYmDnt1M/YcDcxj5H0M/uRjgdJURSI3YZntm6THX1vW1V3tWwx6Op
         qMkbZtJPfaNmQXKzGDjqUrXEoIlcp5hu6by7VoaMIPpD05ssSsB0YvNMnXlPEUvKiSoN
         amZfY5dMTro1eM0LWOKqFsFxLo0/JkUO0UjdTyCU1GNMZYvHwsswwg9/cWO9sCwRUwyH
         iepOdbv73+4qz48sHi1Ob/AYBywBoY7+C/ILpR3byZN8CHLpPsgJBeimY2Q9S0H7p9Lh
         Vct9h3n2i15kXVNn03j1G2mkMsao/4v+tHhYBtw8RR3/0R+vJxtqhPy5Z5LIj2SFi7Cf
         +WOA==
X-Gm-Message-State: AOAM5302rNjBnIfpF34UtMztQdjXDVTsuPe3WDI8UpR6mMHSwBQl8H7H
        ims0+UZiq0MeI70JWEqo5Q==
X-Google-Smtp-Source: ABdhPJyP57TJVroc8VqQIOgqc6U9QgHNXTv3668NJsD3IXEbfYDDvO+BAt1+Eq3Optk5l4XALnhxYw==
X-Received: by 2002:a05:6808:cf:: with SMTP id t15mr692955oic.43.1638224085630;
        Mon, 29 Nov 2021 14:14:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q12sm2813970otl.66.2021.11.29.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:14:44 -0800 (PST)
Received: (nullmailer pid 706746 invoked by uid 1000);
        Mon, 29 Nov 2021 22:14:43 -0000
Date:   Mon, 29 Nov 2021 16:14:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ping.bai@nxp.com, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: power: imx8ulp: add power domain header
 file
Message-ID: <YaVQ06/tLczxwKaK@robh.at.kernel.org>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
 <20211117032740.2518926-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117032740.2518926-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 11:27:38 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8ULP power domain header file
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/power/imx8ulp-power.h | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/power/imx8ulp-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
