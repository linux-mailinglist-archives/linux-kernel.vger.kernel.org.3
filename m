Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9446234A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhK2VaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:30:18 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43623 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhK2V2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:28:17 -0500
Received: by mail-oi1-f182.google.com with SMTP id o4so37089906oia.10;
        Mon, 29 Nov 2021 13:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJaxuuJNzEliEnHbn427KBpFOmLAQo4WscHD5xvktJU=;
        b=o0Bu4AulGJwpITwrO9ihJbiMMmI6mC7ynihC/BqdL+CBCF1djiLP62qQ86kEAXKE90
         aUFVaO1QG2G9pkk2dmCaqvzkjEZA7yK8Zx8d3aTveqrWQA3U72ZpytbudQHBkicul3J0
         uP3jCS7Uaeck72EYXk9TtGqaj8nb2u6Wl9KFrquFlDpRqlxcdDtHnmGqOTIjuSpq8GSe
         n+GIwQgyvYxfMilFd+sFBP5Me8430Mn5h/V9TOT8XwJyfvme8/e7Xk8UM7lNlFLIut2s
         W7+plBaBxZc/lCr43j2c4JA9xNjr0ah3zy/effEKKETOJSwtfHpHIL+XKLbh9AKhYlu7
         szhQ==
X-Gm-Message-State: AOAM531990Du/emtGKx2FbxBY01MIwACjMsrBw0S3ADvIM8GCHmAZd62
        C51DNkJtMc5AEL9K/a+mZqnbNNgc5Q==
X-Google-Smtp-Source: ABdhPJxWPBlRQdxhkJLcpFq7U2ZYYAnAuViB+KQl2eeDSpMOfnRQDWI2g8lZLE3LGhGEU9tXEPBRpA==
X-Received: by 2002:a05:6808:23cb:: with SMTP id bq11mr558874oib.2.1638221098970;
        Mon, 29 Nov 2021 13:24:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t18sm2832277ott.2.2021.11.29.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:24:58 -0800 (PST)
Received: (nullmailer pid 635942 invoked by uid 1000);
        Mon, 29 Nov 2021 21:24:57 -0000
Date:   Mon, 29 Nov 2021 15:24:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] dt-bindings: arm-pmu: Document Apple PMU compatible
 strings
Message-ID: <YaVFKWQ9LFZzuPqs@robh.at.kernel.org>
References: <20211113115429.4027571-1-maz@kernel.org>
 <20211113115429.4027571-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113115429.4027571-2-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 11:54:22 +0000, Marc Zyngier wrote:
> As we are about to add support fur the Apple PMUs, document the compatible
> strings associated with the two micro-architectures present in the Apple M1.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
