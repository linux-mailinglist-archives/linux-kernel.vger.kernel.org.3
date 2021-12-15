Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE77476230
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhLOTv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:51:28 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44733 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhLOTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:51:27 -0500
Received: by mail-oi1-f170.google.com with SMTP id be32so33120336oib.11;
        Wed, 15 Dec 2021 11:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1p1PQrqDAJTBlAEU9eTaqXLhU+FeqafP7VNkw1V6x4M=;
        b=IdDlIoNDd9y5sxkH89qTH2vxKqIUpoSeP8LG9hEkYHYr/KSxUY4D4c7FYN7vUR4I/j
         87XrEoPbhQy4lCzqvVD/0HTEXLpnAgokhtEm+QWIMR3awzLjsWHIAGlg1s87ppTlt+X/
         KPyJ9QsU7jHZEBE7D8bE79MisU+TxH5gyyFTKdCaf5Tvozl/uKk5Yy7wkJImcrmmMvN3
         I4ePLLC2kBubPJ/Yl3dQRv9kIjeM0n3oeWTCzapFzsre1VAE31guk0o7/V8JGlsVMTvD
         GOaAbXg4GKpOb0tW/SnjtJlTSODjDH0lcTru9abkaPd5y2wij0GDeHNRRM9fOlzOF1Zz
         CrqQ==
X-Gm-Message-State: AOAM533OpkE3b/KBeXkCRn0v4DiHLat5QptgosOyQMvTXG6sx3OpD90k
        4xGPIYRiLofUtOdnLbOlEQ==
X-Google-Smtp-Source: ABdhPJw6V5sSTfL+uRxvQ2C07gj9VqUiSInxCB3vdcAEt8qqdj6YEbamz7vxe0Y5oQERaTi6m1SK7A==
X-Received: by 2002:a05:6808:b08:: with SMTP id s8mr1360010oij.126.1639597886569;
        Wed, 15 Dec 2021 11:51:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s17sm616782otp.20.2021.12.15.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:51:26 -0800 (PST)
Received: (nullmailer pid 1725656 invoked by uid 1000);
        Wed, 15 Dec 2021 19:51:25 -0000
Date:   Wed, 15 Dec 2021 13:51:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: define support for
 name based regulators
Message-ID: <YbpHPU7PsGO2i+uw@robh.at.kernel.org>
References: <cover.1639099631.git.quic_collinsd@quicinc.com>
 <2d78b0f19991f8028d9be913be0a5aefd7d1ee17.1639099631.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d78b0f19991f8028d9be913be0a5aefd7d1ee17.1639099631.git.quic_collinsd@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 17:54:41 -0800, David Collins wrote:
> Allow SCMI regulator subnodes to be specified either by ID using
> the "reg" property or by name using the "regulator-name" property.
> 
> Name based SCMI regulator specification helps ensure that an SCMI
> agent doesn't need to be aware of the numbering scheme used for
> Voltage Domains by the SCMI platform.  It also ensures that the
> correct Voltage Domain is selected for a given physical regulator.
> This cannot be guaranteed with numeric Voltage Domain IDs alone.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
