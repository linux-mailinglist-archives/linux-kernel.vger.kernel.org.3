Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DF14AA30C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348706AbiBDWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:21:00 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:42748 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiBDWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:20:59 -0500
Received: by mail-oo1-f41.google.com with SMTP id w5-20020a4a9785000000b0030956914befso6210381ooi.9;
        Fri, 04 Feb 2022 14:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=51UcnV8idQFx159Np6IWbNC0MFaAO1dhJYFWbgqko8Y=;
        b=n616Hfjp5o7S9cTHA+j2/faOFxtjK3VEyp7W5WSNEGmKTaJCazUnDsPpAdLZ14TY+l
         KJSFS1/q2RRn4UrAcpTAt0ACYeBqneQeOn6BIsPPS++K3Imq4VWTgDn8bhdLg/8UFXxL
         8AOpKh2qEk0xe4mexhNtLarNUGk22Cp2F/OHvyoD6Xmz3BidDZY5IfDkcDlopeE+OnRR
         NpVYYhZ2tpuqCaEjMH6bjJHLXI3DS1Gro3j/Tna6b51z3nm+gRE2JATPXDs1DKn2x0CI
         QO9DTmzHjVXRGNO0DVMy/wjNJyWVmVdauizFQRtIzSonfxbeVYGcxqeGhi8VXNr4QIYu
         E96A==
X-Gm-Message-State: AOAM531h7ybrmhKiyt6J+z9Z36u10mSq6uwKwfUc7bIEInFWITEOqLI5
        T2MJhd1Rl1IwcDzHKncVxQ==
X-Google-Smtp-Source: ABdhPJwvUqeWoik7ZNFtYmaKADKWiDeedTQlW+VdSFjU9fb9NCAECIy0T20ANVIH1ZXCc5VefSf6RQ==
X-Received: by 2002:a05:6870:e6d6:: with SMTP id s22mr300999oak.261.1644013259101;
        Fri, 04 Feb 2022 14:20:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w62sm1303039oie.4.2022.02.04.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:20:58 -0800 (PST)
Received: (nullmailer pid 3285339 invoked by uid 1000);
        Fri, 04 Feb 2022 22:20:57 -0000
Date:   Fri, 4 Feb 2022 16:20:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Message-ID: <Yf2mySxEeH6zru1C@robh.at.kernel.org>
References: <20220203141023.570180-1-hsinyi@chromium.org>
 <20220203141023.570180-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203141023.570180-4-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022 22:10:23 +0800, Hsin-Yi Wang wrote:
> List panel under aux-bus node if it's connected to anx7625's aux bus.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../display/bridge/analogix,anx7625.yaml        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
