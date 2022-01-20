Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8B4954EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377446AbiATTgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:36:17 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36373 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiATTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:36:16 -0500
Received: by mail-oi1-f174.google.com with SMTP id r138so10458908oie.3;
        Thu, 20 Jan 2022 11:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOq7x0yVaTljW1EjDfxCdNhTg4DVSwDiAfuhm2P6J1I=;
        b=M2oNPn+uoWRcQpC1mf8IGvYfwv9Oe14BKnXMSlchsvtOLP4xzUQcN/YH5MCR/98ZJ9
         ec5Al/WJOqAdcWR5ZrlX9dphfgNtk7VVsQieE2Mw69Y3rX5YQWCoomOBMFfDxhtUG9C9
         PoZR5ncjeTMnKpBnmpsH2JSFaXL0begsZaYqtakjs6uNcDJXCBrpEPChFRrBRMdjelwQ
         RuCLoXE6XAShFPu3Vl602cRPhBpgxGgAUCvAxbAYt6+kRk7xbTPi71/dvGaKS9oA+nA6
         KLHA1jGHjyHowewfKmy4mGnmp7bsTiy3DYoc0rkOiBNMyTu2W5wxJjvTqXs5wpEl9gyV
         TeBg==
X-Gm-Message-State: AOAM531P/4B47//3rj7yboyLVOewBGt5VG7LqLJLHyUTN/myy2iz3+Pz
        VnxgjywN/3W5tamF0HnA8g==
X-Google-Smtp-Source: ABdhPJwxCLpHCyhx44N9LfWQt9YtGk58bPTzZASlbBG8+oBHuLazjY74dmWVhanjP/4/nIwa5mMguw==
X-Received: by 2002:a05:6808:159f:: with SMTP id t31mr9087116oiw.60.1642707375490;
        Thu, 20 Jan 2022 11:36:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bn14sm62895oib.8.2022.01.20.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:36:14 -0800 (PST)
Received: (nullmailer pid 1814592 invoked by uid 1000);
        Thu, 20 Jan 2022 19:36:13 -0000
Date:   Thu, 20 Jan 2022 13:36:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        - <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: cirrus,madera: Fix 'interrupts' in
 example
Message-ID: <Yem5rQ7RFG3bUUxV@robh.at.kernel.org>
References: <20220119015611.2442819-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119015611.2442819-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 19:56:11 -0600, Rob Herring wrote:
> The 'interrupts' properties takes an irq number, not a phandle, and
> 'interrupt-parent' isn't needed in examples.
> ---
>  Documentation/devicetree/bindings/mfd/cirrus,madera.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied (with my Sob added), thanks!
