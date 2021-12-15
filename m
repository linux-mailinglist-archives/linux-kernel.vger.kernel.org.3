Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8A4762DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhLOUM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:12:28 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46063 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLOUM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:12:26 -0500
Received: by mail-ot1-f43.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso26251332otf.12;
        Wed, 15 Dec 2021 12:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUwhWp69/waHBYXapCIjDdkdI9M+dBeTaXYy1vJzULc=;
        b=vh2Pj0w/fUUU2W3S9farwxBlZVcFVUgy4YS0CmLWH9xeqNNGpiuLMOsFHPxs9ZMFqL
         05RAGWChX5MGjjFLS60pG/SrxHRs2fGIM7yywJLYuBbwRYzrHyf6CT+o4fvQr3JW7ri+
         GdcxNojW1mys7abzeRuwg0nMawi6eC3UtHJFNU2TOgUdnu+PjPA0SwwPHgAZ3tJebn04
         gq9Lmhi9+zbIcf0MK+hM4WGbHcizJlzrcgjuhyeICCITxc2ZXum3mC7VqwiHykjd9Kj7
         DRETCqet32xwkhckDsKMOMi9uxuKG85+vOHlz69fcDQLCPZY8WldtHPKmnxyitO9VWCd
         +4KQ==
X-Gm-Message-State: AOAM532IDaNjd0RMe1BDCWaZV1Itir698bnpuBrL7wH+pLsvJyUvFClW
        f8L8ql+nHwIJh/MZbhZYqw==
X-Google-Smtp-Source: ABdhPJyuTj8kTZYONfaRYevXkaI6IC+EMhGx2zpvo+UWotingMavN9Y4ugjy/8QnShnPWnN8Rs2hTw==
X-Received: by 2002:a9d:63d2:: with SMTP id e18mr10004124otl.28.1639599146003;
        Wed, 15 Dec 2021 12:12:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u40sm524791oiw.56.2021.12.15.12.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:12:25 -0800 (PST)
Received: (nullmailer pid 1757913 invoked by uid 1000);
        Wed, 15 Dec 2021 20:12:24 -0000
Date:   Wed, 15 Dec 2021 14:12:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, romain.perier@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: mstar: Add compatible for Miyoo
 Mini
Message-ID: <YbpMKLeetcIN9bQb@robh.at.kernel.org>
References: <20211213100112.1791192-1-daniel@0x0f.com>
 <20211213100112.1791192-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213100112.1791192-3-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 19:01:11 +0900, Daniel Palmer wrote:
> The Miyoo Mini is a SigmaStar SSD202D based retro emulation
> device.
> 
> Add a compatible for it to the list of infinity2m devices.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Link: http://linux-chenxing.org/infinity2/miyoomini/
> ---
>  Documentation/devicetree/bindings/arm/mstar/mstar.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
