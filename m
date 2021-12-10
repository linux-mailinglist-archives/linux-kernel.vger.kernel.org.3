Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2F470CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhLJWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:17:30 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:39628 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhLJWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:17:29 -0500
Received: by mail-oo1-f52.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso2731831ooa.6;
        Fri, 10 Dec 2021 14:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qE3m/snsqjUVeFIpdBqjZTc+sDoGDcLavARfU2nmN0o=;
        b=YW/5FLFsYFx/1tGsAiGqTwVJwaAK8AeaHhNaUH/RVnPMaoacFMJwmnPXQtoW4AQJCE
         KyDUrNj0Ms9ah8ZRSlDDclbsjdpxiKpzILJeeRHWiAbEYnkwFcgifM1abQ4wEr01R+Ce
         m72/v57Iwr3mWrvuSmx6toe5xy4aRPGJgp2E8JreQzmseaARANiCqa2M6FlDbG1jXcOo
         rxbqSxIxI3Tbq3dID/+MsCaP0p0SO9AVIvPyh4YSUH2URDNXLmO1Ao0jPDxONfPlp2MM
         a8Ljf+AoUwAN6bPKckk0tTnflaBCGmLDe6ZXRMH0HQaJzCZrQVdMmjpZWYSSjD1Dn/IG
         8/Xg==
X-Gm-Message-State: AOAM533rPJzNWVfxtG4diOZ1cwTW4L4ANkv3GxHxMRGbmQrHeNCATSdn
        B5T114MBg2FH6qtcKy+VMw==
X-Google-Smtp-Source: ABdhPJxHmQonNORigxE+WD+JbSFf9i2sWZuKFuMnNb8g5ohNo+Y33Omm5/Z2s4mIliRzyq3y8pML8A==
X-Received: by 2002:a4a:1b02:: with SMTP id 2mr9908151oop.2.1639174433377;
        Fri, 10 Dec 2021 14:13:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w80sm909640oif.2.2021.12.10.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:13:52 -0800 (PST)
Received: (nullmailer pid 2023018 invoked by uid 1000);
        Fri, 10 Dec 2021 22:13:51 -0000
Date:   Fri, 10 Dec 2021 16:13:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org, devicetree@vger.kernel.org,
        system@metrotek.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: bus: imx-weim: add words about
 continuous bclk
Message-ID: <YbPRH+X/w7/pujOO@robh.at.kernel.org>
References: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
 <20211202055724.4416-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202055724.4416-3-i.bornyakov@metrotek.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 08:57:24 +0300, Ivan Bornyakov wrote:
> Document continuous Burst Clock option. With this option Burst Clock, if
> enabled, will output continuous clock, otherwise Burst Clock will output
> clock only when necessary.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
