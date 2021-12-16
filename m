Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291C3477DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbhLPUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:31:48 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46826 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhLPUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:31:47 -0500
Received: by mail-ot1-f44.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so282985oto.13;
        Thu, 16 Dec 2021 12:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/WZk6rTknr9ohPbMfgyEB9lTmn2kskX3wnXdJpxoO54=;
        b=xxDciDiEjcMe8H0Qqc3ZRcX3iRQvIYBqjSdJMgEJXfQKSK9Bh15tLHWEDSgl/HCnsO
         I1YfQYTtKZxxq/Inq3LEr8QSY9tZI4GqlxbeEDXF+VNm0j2cVWHYh2kA/Jgnshe+jqho
         zEe2J6zp2QV546JTofpV9vsXkcnqYVX5z4CGMG+f8H/S7er8v0wstXxBoHLMhEYJzKLf
         f83mxEOny7CDjhjndETGnMpX9T/ftj/tyqIuI+ipbOZBykUytfAEYu6eLlc2KuMq2Yfh
         TgXdZY8BSpENfFYD3eznYnMejvEPiW9EXQmFagXkNBmklyB1HHB3sOC4eh25+ooME83O
         M9ew==
X-Gm-Message-State: AOAM5334PaleF3liw6iTMRm4n0N8NlXHYz7Q/T7d40BwmTQhZr1l4Non
        Etmnh99UQyBfGXM7RnlYwg==
X-Google-Smtp-Source: ABdhPJxolUuSHrXvVWwD1DwilZGwq7k1Tjchu9lac4l0lol5CTbTY9vjTqv4KL+RF7m1rNgxNg36Gg==
X-Received: by 2002:a05:6830:1617:: with SMTP id g23mr13541257otr.117.1639686706300;
        Thu, 16 Dec 2021 12:31:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d12sm1196566otq.67.2021.12.16.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:31:45 -0800 (PST)
Received: (nullmailer pid 705688 invoked by uid 1000);
        Thu, 16 Dec 2021 20:31:44 -0000
Date:   Thu, 16 Dec 2021 14:31:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     nobuhiro1.iwamatsu@toshiba.co.jp, abel.vesa@nxp.com,
        ulf.hansson@linaro.org, stefan@agner.ch, sboyd@kernel.org,
        soc@kernel.org, linux-serial@vger.kernel.org,
        adrian.hunter@intel.com, aisheng.dong@nxp.com,
        linux@armlinux.org.uk, shawnguo@kernel.org,
        giulio.benetti@benettiengineering.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        robh+dt@kernel.org, mturquette@baylibre.com,
        linux-mmc@vger.kernel.org, Mr.Bossman075@gmail.com, olof@lixom.net,
        linus.walleij@linaro.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de
Subject: Re: [PATCH v5 6/9] dt-bindings: serial: fsl-lpuart: add i.MXRT1050
 compatible
Message-ID: <YbuiMIfmBGIc/vao@robh.at.kernel.org>
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
 <20211215220538.4180616-7-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215220538.4180616-7-Mr.Bossman075@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 17:05:35 -0500, Jesse Taube wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> Add i.MXRT1050 documentation for compatible string.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Rename imxrt to imxrt1050
> V3->V4:
> * Nothing done
> V4->V5:
> * Change commit description to just 1050
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
