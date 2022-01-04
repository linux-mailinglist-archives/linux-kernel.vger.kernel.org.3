Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDBB48483D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiADTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:07:01 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:45009 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiADTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:07:00 -0500
Received: by mail-oi1-f171.google.com with SMTP id be32so60783520oib.11;
        Tue, 04 Jan 2022 11:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8CgkkbPTMgwITurXcyYa8txS8XSAkqNrdvXpQYKmlLs=;
        b=PW+Zbue2x9sV2A7jkKgm3L0/yF5RAmig5KXW3AQ0OYlPzVN4Z1uegLYyNUNd8SsrZX
         /TytF5+gzGw14GaJrrXjUN+MuPePTuvy+BElpAFf3ZsjFB5F0j8w5ln2bP7sARW092e3
         yJ625SkPFB0EUtUNAX8Lfm79qJq5z6dMv2fpaa4IDq/x+n5PgYvBYBnNO7bTrt7zNhUZ
         1/o371Ap6KWv3Ct4rM3NaG5FkLPS67N3Esu0u2YDI3fLMrGGopBWny9A7bEzQlGGKbjL
         9+iWmiuJWVo4uULU30mTc2gC6DPGecjXGJFv1rZRgJ+1O1GCZZKvndjZvhwvtgtF6io0
         k+Mw==
X-Gm-Message-State: AOAM531aiEwfFfPfCGnj86iMpS9+Tu2tOGOzUaDPE9xBKMlDd9b/j0HS
        /mK1zUayrpjeZkgxtcR3bA==
X-Google-Smtp-Source: ABdhPJw0hrSMFia3kzR3oD+Vdenn5ohLpgJhiNYL5ZTwCMdi+PUKKbvtKnFvGJJVRysmx2lanYsxeg==
X-Received: by 2002:a05:6808:155:: with SMTP id h21mr31124067oie.121.1641323219578;
        Tue, 04 Jan 2022 11:06:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r17sm8378611otc.65.2022.01.04.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:06:59 -0800 (PST)
Received: (nullmailer pid 1227279 invoked by uid 1000);
        Tue, 04 Jan 2022 19:06:57 -0000
Date:   Tue, 4 Jan 2022 13:06:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
        abel.vesa@nxp.com, shawnguo@kernel.org, jirislaby@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, robh+dt@kernel.org,
        festevam@gmail.com, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, soc@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, mturquette@baylibre.com, linux-mmc@vger.kernel.org,
        giulio.benetti@benettiengineering.com, sboyd@kernel.org,
        linux-gpio@vger.kernel.org, Mr.Bossman075@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk, stefan@agner.ch,
        ulf.hansson@linaro.org, aisheng.dong@nxp.com
Subject: Re: [PATCH v7 2/7] ARM: dts: imxrt1050-pinfunc: Add pinctrl binding
 header
Message-ID: <YdSa0ScOpb/5sMF/@robh.at.kernel.org>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
 <20220103233948.198119-3-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103233948.198119-3-Mr.Bossman075@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 18:39:43 -0500, Jesse Taube wrote:
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
> ---
>  arch/arm/boot/dts/imxrt1050-pinfunc.h | 993 ++++++++++++++++++++++++++
>  1 file changed, 993 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imxrt1050-pinfunc.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

