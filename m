Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B0046234D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhK2VbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:31:08 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:46868 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhK2V3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:29:07 -0500
Received: by mail-oo1-f52.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso6066907ood.13;
        Mon, 29 Nov 2021 13:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tc7H78nHbfwBsabV9v/0HmsrveC5/JQ0wXPnMQogHI=;
        b=PWDCzo7sLHNBe5klHzrTkHjXnd0cay5kCEn3gw6MHE9D60ckvynTPrJy5oJU2b+hUM
         b2jTOBsLmaHoOJK0qryha/pBQraJZ95o+ickpb2te39UzKyCnvISaOrgT0Zoa1/+9Xsj
         luWNZM4eJ2K/R6h8pDxPhrCmIhy6ZGQqvpYDVnIijiN8x71RfjevrBUzn4HdKFhnikxW
         uwxyCwGvsn7MmrFbBEl7To3BeAjGOtQp9r6l9GNhtKu5UqnjE+d5bFy+WbgHw9IaIi2o
         l4OMZEZ549rMNxupe9Fz7nsk3c9Z78hIgKlVUJBsJx2V9X4jN/tkWfZRJCs1UpuffCbI
         JQcw==
X-Gm-Message-State: AOAM5305UIJgmQ/pZNBB0hTlRwMyqDDVODg2lYNNow3h/1/60k5u1NBv
        Wua31ENRUl7QWy6QmXghVA==
X-Google-Smtp-Source: ABdhPJwFUO/KILnFJ9CrAcpEDN/Pf49gr1RpwzHYTKNfTs31MlqPAk5PxWdkZsAnMB8Kg5oXQ8oShg==
X-Received: by 2002:a4a:2705:: with SMTP id l5mr32292651oof.51.1638221148665;
        Mon, 29 Nov 2021 13:25:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r23sm2400395ooj.37.2021.11.29.13.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:25:48 -0800 (PST)
Received: (nullmailer pid 637129 invoked by uid 1000);
        Mon, 29 Nov 2021 21:25:47 -0000
Date:   Mon, 29 Nov 2021 15:25:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: apple,aic: Add CPU PMU per-cpu
 pseudo-interrupts
Message-ID: <YaVFWwhHAr+aCE4F@robh.at.kernel.org>
References: <20211113115429.4027571-1-maz@kernel.org>
 <20211113115429.4027571-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113115429.4027571-3-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 11:54:23 +0000, Marc Zyngier wrote:
> Advertise the two pseudo-interrupts that tied to the two PMU
> flavours present in the Apple M1 SoC.
> 
> We choose the expose two different pseudo-interrupts to the OS
> as the e-core PMU is obviously different from the p-core one,
> effectively presenting two different devices.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../devicetree/bindings/interrupt-controller/apple,aic.yaml     | 2 ++
>  include/dt-bindings/interrupt-controller/apple-aic.h            | 2 ++
>  2 files changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
