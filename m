Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422BC46F16E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhLIRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:19:13 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:44563 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhLIRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:19:12 -0500
Received: by mail-ot1-f52.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso6853987otj.11;
        Thu, 09 Dec 2021 09:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nSukUYeagf4Tnng/ksS/gcxkNP9zX8DKonoFbajwVGo=;
        b=6ks91g9H+3tr2toRfogwmAw7sNIkirWP9G9kOJa8N4P3du7IprPCT7RoAJsrzf/cTV
         KqrLgeq7HEjotRgNdzqLohAh9hoP8W7f0cCXCA4ESVbsEfLucoi3g6Kxk63Z4AARsxJe
         /nvLU0GbxJToRliKrVQc523H3zOH62/7cvnXvtgCOWiE6cQh2JbD3apCzSpXd4+LtdSN
         wIqGMuW8gep5tzhJOW9xzuqpNH/IyRtRnNLheC2urfcGQ1bOMt3m6KaT9iGOAHRy4y8w
         xU0zufNxRmLQ1mhjL+tPQmjFAVk4sY/g6fgUjaN9yQCq9i4T0k8tC01y4e28beKeUXVc
         IoQQ==
X-Gm-Message-State: AOAM5334s+4Uy7DjhvZHALLHfkllrlaj2WJ3ip4YqoEBbdVM1kEViS3P
        MTwIEpP8Vqb1l2bEnUNo0Q==
X-Google-Smtp-Source: ABdhPJw0M7kd1XRLCQjKyI5gXvmUn0fvT7NhByKejFd9B1GWARaqIlq83SGfKVgR18ju4BI76k3hfg==
X-Received: by 2002:a05:6830:4d1:: with SMTP id s17mr6595739otd.246.1639070138515;
        Thu, 09 Dec 2021 09:15:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bq5sm111149oib.55.2021.12.09.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:15:37 -0800 (PST)
Received: (nullmailer pid 3113423 invoked by uid 1000);
        Thu, 09 Dec 2021 17:15:36 -0000
Date:   Thu, 9 Dec 2021 11:15:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 3/4] dt-bindings: pci: apple,pcie: Add t6000 support
Message-ID: <YbI5uK2w5vQ4xBrm@robh.at.kernel.org>
References: <20211209051001.70235-1-marcan@marcan.st>
 <20211209051001.70235-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209051001.70235-4-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:10:00 +0900, Hector Martin wrote:
> This new SoC is compatible with the existing driver, but the block
> supports 4 downstream ports, so we need to adjust the binding to
> allow that.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 28 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
