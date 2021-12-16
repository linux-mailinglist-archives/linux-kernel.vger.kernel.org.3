Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B77477ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhLPRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:47:00 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44008 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbhLPRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:46:59 -0500
Received: by mail-oi1-f177.google.com with SMTP id w64so3549098oif.10;
        Thu, 16 Dec 2021 09:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JaGgfHvudgnMdXZtaUZOLcdq7oOv9KOPdlqgV3mQsWM=;
        b=qnLW9SA8bmCOL+Cc1PHFPhfV0NB9Et2HMYkQ/Wr3KP1eqN71Qp+taltk15zVKALyUe
         CSRF5dWMCapueBMx0NWhvVBdzQ90b/Fqgg1oDk9lbJ2GrWQ+DNK97R9/kbb2NyKpIqfn
         Tnxad2dVnSdVQGrJJSxA0kM+GFWNaxbAaydvGJJZe04Xg4QVHyW9x78ZxQQeCMYT92tc
         lxT/VM48VoxDQvYpTR7ewA4fz43qhcteXv87hkgAEQoWSLy5uB33Trkz6CjxEsgbLoGO
         IupIGosxgnd7yjC089kD52gcW44/o2oEb9tw/sRI1cD5xwJRrCXulWwa+rXfQCFgWKfe
         JS1A==
X-Gm-Message-State: AOAM5335rqrToRU1Cf2ls0fTGI46xooudr3NLJzBmrs5Ov2zVySbaZIT
        nLqxzxF8cZgrGabEGrIurQ==
X-Google-Smtp-Source: ABdhPJzNOoY4JJ5zCfm1fo5+NzIB/piMBka9KzxVmdqNgRaMbsblLOm2MzE8e8ZEhr8k/Gk7Z6qLig==
X-Received: by 2002:a05:6808:2388:: with SMTP id bp8mr5187096oib.38.1639676818408;
        Thu, 16 Dec 2021 09:46:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o26sm1151084otj.14.2021.12.16.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:46:57 -0800 (PST)
Received: (nullmailer pid 459879 invoked by uid 1000);
        Thu, 16 Dec 2021 17:46:56 -0000
Date:   Thu, 16 Dec 2021 11:46:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: apple,mailbox: Add generic
 and t6000 compatibles
Message-ID: <Ybt7kEI6GI5CISRX@robh.at.kernel.org>
References: <20211215155527.36775-1-marcan@marcan.st>
 <20211215155527.36775-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215155527.36775-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 00:55:26 +0900, Hector Martin wrote:
> Much as we've done with other blocks, let's introduce generic
> compatibles so drivers can bind to those and still work with future
> SoCs, as long as the hardware remains the same. Also go ahead and add
> compatibles for the new t600x SoCs (we group those as t6000).
> 
> Note that no DTs instantiate devices with this binding yet.
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
