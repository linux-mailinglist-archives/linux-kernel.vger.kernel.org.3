Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89753470C81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbhLJV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:28:35 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46043 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhLJV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:28:33 -0500
Received: by mail-ot1-f41.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso10878251otf.12;
        Fri, 10 Dec 2021 13:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MM7Mqy4LVhqQo1WtAnEZHBAScofrOdZmMSPjQZ2muY=;
        b=bAIXQgEUZfBMhYHPkSr7Q+ptZx62u/N9xYlsNjmMTxN4aYBx5bJyStVMA9wp3YmJ3H
         y7+sZGVmw5DuhsCxvomRrFdncZvN/W5Uz1rwMU4UhNhyE51jPtU/tHIHPynIIJtOaeUq
         omsQ59dMc97gf4Mf00E4VeDQ5gejHU4EBo1sYjmUqyjkAFHzxq3kEghCxLMs55Vzn0ys
         3RO8PlBNSg0vMQSgGliy2ynLII1IMfzmbYMoSH7r9GgfpK1HsnhTHwLUq9cJpXRO4wUP
         3vzgsqZHEfqAaCfXrqK7rfhWevrK2zaNjBlVXaG2nHVaaloICaQmnOoz18nYiWAG9qM3
         BBNg==
X-Gm-Message-State: AOAM532DYrdeo92ahRVbizoPb1WBJ8ckYvDsO9uxzgu4tFiMN7ZxzkiD
        6AGcL+TC9hO9rN7po6RpLw==
X-Google-Smtp-Source: ABdhPJyTn5sR0JkqUstumnB93RnMCqtBd+uULYV15dK0CVTcCdcT8gfqCXalGgl6VqPsJd0DE5LuYQ==
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr13577934otp.10.1639171496337;
        Fri, 10 Dec 2021 13:24:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r25sm722169ote.73.2021.12.10.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:24:55 -0800 (PST)
Received: (nullmailer pid 1925851 invoked by uid 1000);
        Fri, 10 Dec 2021 21:24:54 -0000
Date:   Fri, 10 Dec 2021 15:24:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     olof@lixom.net, s.hauer@pengutronix.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, ulf.hansson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, stefan@agner.ch,
        linux-serial@vger.kernel.org, arnd@arndb.de,
        giulio.benetti@benettiengineering.com, gregkh@linuxfoundation.org,
        linux-mmc@vger.kernel.org, Mr.Bossman075@gmail.com,
        festevam@gmail.com, shawnguo@kernel.org, kernel@pengutronix.de,
        abel.vesa@nxp.com, linux@armlinux.org.uk, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, soc@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 05/13] dt-bindings: imx: Add clock binding for
 i.MXRT1050
Message-ID: <YbPFpt/EXjSBVBib@robh.at.kernel.org>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-6-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204061042.1248028-6-Mr.Bossman075@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Dec 2021 01:10:34 -0500, Jesse Taube wrote:
> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Add the clock binding doc for i.MXRT1050.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> [Giulio: added all clocks up to IMXRT1050_CLK_USBOH3]
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Jesse: added clocks from IMXRT1050_CLK_IPG_PDOF to
> IMXRT1050_CLK_DMA_MUX and moved IMXRT1050_CLK_END on]
> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Added GPT binding
> V3->V4:
> * Change License to MIT or GPL-2
> ---
>  include/dt-bindings/clock/imxrt1050-clock.h | 73 +++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
> 

Acked-by: Rob Herring <robh@kernel.org>
