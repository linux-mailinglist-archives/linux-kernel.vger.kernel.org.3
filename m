Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837A248484B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiADTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:08:02 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39574 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiADTIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:08:00 -0500
Received: by mail-ot1-f47.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso48394529ots.6;
        Tue, 04 Jan 2022 11:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zol8RqhcqrOeExkKxHD6i/0eMcZgg4YGQ9xIXDGBZL0=;
        b=PjW3z79RptREbGLfbP+x+XsFuASMO38iK4GD+0s8viJLQg73kyiDYHo7ueIu+LciFO
         PNGK1YqTJOvhOiVI7gufSf6vw0l1cuGm/5Vk9WZoSY1v2LDE8GuA96PCS2oIEgK0whRG
         dSglLdpMuQzCebFqhRkiRIV4wfjklJTcqHppZ4PHjITrkVs7YJmY/PSsSS9wM08ahFUL
         zni7nUylYa8seGCosDSVne8jobjcf7QYzPmK/msVsPvXPNCp5g33tOxNapk8g+e9DqQV
         6Fyu5fQxMrBTVjRJLiN0C9ywaKdZCRN23jUUPFcG/l+kQjcvPqDDefmgxav302ArcK/z
         3TFg==
X-Gm-Message-State: AOAM532Nb31/airPzf6jy9jxlzK9zoG3FDTHcldZ85/aXfxfpWmbFvIu
        P04aJxwV3RgYtfuJdpxatT87Pls4ZQ==
X-Google-Smtp-Source: ABdhPJwD6As9c1PJJ5b5sN3V+8tRevP6v+G+WluIcZqLUbDDpYLuCj4xh6m/A3masXZmj4ALYIcjWg==
X-Received: by 2002:a9d:a55:: with SMTP id 79mr37401880otg.275.1641323279784;
        Tue, 04 Jan 2022 11:07:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm10005968oiv.35.2022.01.04.11.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:07:59 -0800 (PST)
Received: (nullmailer pid 1229576 invoked by uid 1000);
        Tue, 04 Jan 2022 19:07:57 -0000
Date:   Tue, 4 Jan 2022 13:07:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        abel.vesa@nxp.com, olof@lixom.net, kernel@pengutronix.de,
        stefan@agner.ch, ulf.hansson@linaro.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Mr.Bossman075@gmail.com, linux-mmc@vger.kernel.org,
        shawnguo@kernel.org, mturquette@baylibre.com,
        nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        soc@kernel.org, gregkh@linuxfoundation.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        adrian.hunter@intel.com, linus.walleij@linaro.org,
        linux-serial@vger.kernel.org, robh+dt@kernel.org,
        giulio.benetti@benettiengineering.com, linux-clk@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH v7 4/7] dt-bindings: clock: imx: Add documentation for
 i.MXRT1050 clock
Message-ID: <YdSbDTcA6qyZdJJv@robh.at.kernel.org>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
 <20220103233948.198119-5-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103233948.198119-5-Mr.Bossman075@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 18:39:45 -0500, Jesse Taube wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> Add DT binding documentation for i.MXRT1050 clock driver.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1->V2:
> * Replace macros with values
> V2->V3:
> * Remove anatop
> * Use lpuart not gpt
> * include imxrt1050-clock.h
> * 2 space tabs to 4
> * Remove oneOf enum
> * Change maxItems to 2
> V3->V4:
> * Nothing done
> V4->V5:
> * Remove extra newline
> * Rename ccm to clock-controller
> * Change minItems to const
> * Change minItems to description
> * Rename file to add 1050
> * Change commit description to just 1050
> V5->V6:
> * Add maxItems for clocks description
> V6->V7:
> * Nothing done
> ---
>  .../bindings/clock/imxrt1050-clock.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

