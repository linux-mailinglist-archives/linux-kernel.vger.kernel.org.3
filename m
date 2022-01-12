Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0191148BCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348047AbiALByu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:54:50 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42980 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348041AbiALByt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:54:49 -0500
Received: by mail-oi1-f173.google.com with SMTP id y14so1516913oia.9;
        Tue, 11 Jan 2022 17:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFu4YXdx41UOd1vz7CJnROycNl0bjAuTCz/ym7j7eQw=;
        b=PGLxn+p4XCN2q9aIDcD5LmkfdPxxalF55DdnVmOLkL8MYsLPLItrwCsXz4l+g+Auef
         9F54WTcut/EkbrCNy+jKD0wlO085UE86fKLezUbc428/1X7NcrsO1o0yG3LLvw9P5k+9
         BRP9sbEK8qXd2DrJH6jRZO0lsQcl6RCOibDUEgj10zvfkupUZnORzSHNl7eHuq5X5ASU
         6/PV/aZQ/5yda1TuFH+vs+IDJc1t1CvheFlC2+E2KPdfADgTzM1KAMA81wUNsdQzGktW
         9Y8m6gnx7Huc2CbbvWviHO7TdKHcgG37ncxX4xzwNdnh7KPZ2yci/naPLTMM2QneC1Ti
         e45A==
X-Gm-Message-State: AOAM530JrBwKluGASMbIuXh2NRcUuvWeVDW6cO8a288uL3Sa7EGBRxSi
        usG0NzIOBHuSQeXOgJNThQ==
X-Google-Smtp-Source: ABdhPJzgCSk7w9DxNqhAYhWxkv43pujoIQ16tiGZjVM1hq+XIuSE6wC2gLvT4TgIg5bCndUVD3gFQw==
X-Received: by 2002:aca:c104:: with SMTP id r4mr3590467oif.93.1641952488564;
        Tue, 11 Jan 2022 17:54:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh36sm455059oib.19.2022.01.11.17.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:54:47 -0800 (PST)
Received: (nullmailer pid 3905050 invoked by uid 1000);
        Wed, 12 Jan 2022 01:54:46 -0000
Date:   Tue, 11 Jan 2022 19:54:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: display: meson-vpu: add third DPI
 output port
Message-ID: <Yd405jhJtNSiOgzm@robh.at.kernel.org>
References: <20220107145515.613009-1-narmstrong@baylibre.com>
 <20220107145515.613009-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107145515.613009-3-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 15:55:11 +0100, Neil Armstrong wrote:
> Add third port corresponding to the ENCL DPI encoder used to connect
> to DSI or LVDS transceivers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/amlogic,meson-vpu.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
