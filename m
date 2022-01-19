Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F750493BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355032AbiASOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:05:35 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36445 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350177AbiASOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:05:33 -0500
Received: by mail-ot1-f42.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso3234801otl.3;
        Wed, 19 Jan 2022 06:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bA4lXk3bs4g992PO5jXPShXJCU4RdXIJFPt9TWuZvi8=;
        b=Lo6knvrEtX/KFxyzA+UatqyecN5QpsDx2jKbnR1JQMxQ3bcNJo2x7FK73GNXu5GXKJ
         yYKgWYLv3Bat1xQyACduvR5yesnyxdLIJfPRBbevYtjGJsI8kYT/DOOYXjL4eHBBbO+R
         PLniaDtYQ3EnG1myqvhtQ9umRFjZiBTV9NmLO55lvCDwusqs/bUeElRp1FFgrQfTDGdY
         8TLqyog2EgnFi0R7fgBlahwrkhILuvZfoneSBbGHBwdr49kCMrv9LuLonkP8wmVhid9G
         LrC4t4Vfu7eWUshQDt5zg/W0OFja7Agx6wEVdsLyyXhbsHORSnKbbu/FijTfSa3Q8HTv
         jOHg==
X-Gm-Message-State: AOAM533yzZCwRxbFMdylPqi/P2zCj4YKcGZvxEJierkhhM8qc7yIHZyq
        DfAcTMxlnUx7ejQu/JXr8w==
X-Google-Smtp-Source: ABdhPJz+nPpKZ1wx/9MZBe3c2PWe70YAUIasbvLv9Mx8j0isWcefeBYdwrdxEdCzSxpX+Pr8JGIYZw==
X-Received: by 2002:a9d:e88:: with SMTP id 8mr6044843otj.276.1642601132546;
        Wed, 19 Jan 2022 06:05:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm10018818oig.28.2022.01.19.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:05:31 -0800 (PST)
Received: (nullmailer pid 3480173 invoked by uid 1000);
        Wed, 19 Jan 2022 14:05:27 -0000
Date:   Wed, 19 Jan 2022 08:05:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     aisheng.dong@nxp.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        Mr.Bossman075@gmail.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, adrian.hunter@intel.com,
        abel.vesa@nxp.com, linux-serial@vger.kernel.org,
        shawnguo@kernel.org, olof@lixom.net,
        giulio.benetti@benettiengineering.com, linux-gpio@vger.kernel.org,
        linux-clk@vger.kernel.org, linus.walleij@linaro.org,
        festevam@gmail.com, sboyd@kernel.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, stefan@agner.ch, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, soc@kernel.org, jirislaby@kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v8 2/7] ARM: dts: imxrt1050-pinfunc: Add pinctrl binding
 header
Message-ID: <YegapycPxDdgTlXQ@robh.at.kernel.org>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-3-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111215415.2075257-3-Mr.Bossman075@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 16:54:10 -0500, Jesse Taube wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> Add binding header for i.MXRT1050 pinctrl device tree.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Jesse: move pinfunc from dt-bindings to dts folder]
> ---
> V1->V2:
> * Move pinfunc from dt-binding to dts
> * Change subject and description
> * Change licence to "GPL-2.0+ OR MIT"
> V2->V3:
> * Change License comment style
> V3->V4:
> * Nothing done
> V4->V5:
> * Nothing done
> V5->V6:
> * Nothing done
> V6->V7:
> * Nothing done
> V7->V8:
> * Nothing done
> ---
>  arch/arm/boot/dts/imxrt1050-pinfunc.h | 993 ++++++++++++++++++++++++++
>  1 file changed, 993 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imxrt1050-pinfunc.h
> 

Acked-by: Rob Herring <robh@kernel.org>
