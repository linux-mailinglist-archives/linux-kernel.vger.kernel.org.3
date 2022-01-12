Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8062E48BC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347729AbiALB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:28:09 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41789 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbiALB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:28:08 -0500
Received: by mail-ot1-f46.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso850775otj.8;
        Tue, 11 Jan 2022 17:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBfKQkR2L8qDoUKsf/7Yn6Ct6cSR0Xt75+chDiQTRgI=;
        b=Wkxye6GAtbH58gVdgK5LPT6FCyQQdqdQQFNH6948R/tR3kXEffOE9d8Pu38tlWCnf2
         +H6dRnSYYrXWFIhLpOk6A7EvF0hWjJror5dZ+jLO1uBO09n2psuoqyrD3usEh8M9/S3o
         qo3pOpkid05woL/oUZ5njmZRhDJRDS5e19Q2NfSLWEgCFtXeos2qoLwyQPX2Ct6yjXXV
         WP4AL6bBJbdEkYgnqRN+a4a/iTEEUUFpyVXtL5wQAAWcBjhnoWrMmxnwLB5foDa9n8bw
         gWq4hjeqe6964RDWZhfIQx4OqciA0TsLOQ0lPv2HGYw1MhF6CnvsMe1XFTzeBsT5gTQk
         WQKQ==
X-Gm-Message-State: AOAM531YboLTcVW9B1dHDABsjrOhVw/Qjm9cXqsNOwqg1lRlZMomFliF
        a9j1hxOmtmy7otvTQ5iuHo2XmOIhUg==
X-Google-Smtp-Source: ABdhPJzsDgBBXjQuiqaoPL/a/LZz+jn3IcBHOG9zON4EBu3FE4uxwCuLLOxCJdO65wl6bZoTuewA9Q==
X-Received: by 2002:a05:6830:1e9c:: with SMTP id n28mr5057237otr.321.1641950887973;
        Tue, 11 Jan 2022 17:28:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t23sm2368919otd.77.2022.01.11.17.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:28:07 -0800 (PST)
Received: (nullmailer pid 3865794 invoked by uid 1000);
        Wed, 12 Jan 2022 01:28:06 -0000
Date:   Tue, 11 Jan 2022 19:28:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Ryder Lee <ryder.lee@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: mt7986: Add reset-controller
 header file
Message-ID: <Yd4uplioThv8eJJE@robh.at.kernel.org>
References: <20220105100456.7126-1-sam.shih@mediatek.com>
 <20220105100456.7126-2-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105100456.7126-2-sam.shih@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jan 2022 18:04:55 +0800, Sam Shih wrote:
> Add infracfg, toprgu, and ethsys reset-controller header file
> for MT7986 platform.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  include/dt-bindings/reset/mt7986-resets.h | 55 +++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt7986-resets.h
> 

Acked-by: Rob Herring <robh@kernel.org>
