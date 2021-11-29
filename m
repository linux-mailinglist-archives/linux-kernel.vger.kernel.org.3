Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654E4627F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhK2XQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:16:03 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44577 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhK2XPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:15:53 -0500
Received: by mail-ot1-f53.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso27664816otj.11;
        Mon, 29 Nov 2021 15:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xvaWNOHxIX5RQDegrPAkNqp+TbGhYaJoM7ojwcLXG0k=;
        b=XFttEqfrL8eO+Z+QetzVDWBugsSNgxZtAwEXY1k83kLICYq8KRl+A502ZuvJood92B
         z0GHmDY19W++IVnGoiPgBVZL8uOHMusC85VrGzBlrMU7Yt8Osg1jZLZ+yUFaJK6secCJ
         Wb10tExLckIpubJmVXiixLsTXep82BNRHrsoDuresJ98ZAl0//1XrNiQnvwoN5YWtgrx
         o7oZJfa1qQ4tZpKlWUEeR11kE7GhLdSC2qruptP2T6G+U/6PpunHtwS2Bznzlc5hT6cJ
         IGFDUuc7/5YMtgMSU86XaPYCcgCuNy094D5C91ZFzefZxD+sguerJ23+g7q971pJVI50
         vuvQ==
X-Gm-Message-State: AOAM531ceCTSg9RquSuwajyIzasu2l5FeAUohPOhZJIPQEAtrZtOIKWw
        j8Nfl4wsbRhLS/Wjb/hYrw==
X-Google-Smtp-Source: ABdhPJzrih+obICiu/TVSMEEZYpJytpel1DHE1SZn5KyWgNg2OIz1uW2EsNEa2nmDMz91dgwpPY1WA==
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr47326858ota.150.1638227555071;
        Mon, 29 Nov 2021 15:12:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e16sm2443380ook.38.2021.11.29.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:12:34 -0800 (PST)
Received: (nullmailer pid 788051 invoked by uid 1000);
        Mon, 29 Nov 2021 23:12:33 -0000
Date:   Mon, 29 Nov 2021 17:12:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: media: Add compatible for D1
Message-ID: <YaVeYd939OMtSJTI@robh.at.kernel.org>
References: <20211119031519.23430-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119031519.23430-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 21:15:17 -0600, Samuel Holland wrote:
> D1 contains a video engine similar to the one in other sunxi SoCs.
> Add a compatible for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
