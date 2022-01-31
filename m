Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210A4A494B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiAaO10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:27:26 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41928 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiAaO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:27:24 -0500
Received: by mail-oi1-f178.google.com with SMTP id q186so26918847oih.8;
        Mon, 31 Jan 2022 06:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7B2eJOfazyQSxFmnrtcWt0ACIbO8k35PqVOi7mXIUA0=;
        b=YqvdUhwh5ijS+FJHPfPezb29SajCysqEz0T1wNVw/QmFl5Auo4vm51CA1yKwqDyh/8
         tSjwM9ScO8Kcki8GXPnlneN3sZGFlnwSRSZM+6yVwtmhEdzRKFFcOm3O0ZxM7ZfhsAzy
         qbx8/DcJohfRiiLlxuOaxR9bSlUHo4tcq145We+U8pbr2P22cIbeuVxH5Pns9fNbJoGC
         dhE1Hl4OqUFeBtXJ3VqIK/3jZCsx647PVTQJZ4yeTewXt7sVl27WqRU6X9+USd00iCjK
         oSuxNoFvYoXBrB6wr/XhojjgCQU47eVCEtI9SCuZKT8+qitTx7M2HE/9BvS1WNN1SUpJ
         Remg==
X-Gm-Message-State: AOAM532UlAzfnar3OEknyUnEBvJxh5G5WxdcFp8D9VKcUEn6wnuWU56A
        hI9JtYCQXfLHNGlpYGifdQ==
X-Google-Smtp-Source: ABdhPJxRim4pVmlHSD6qqCnIfmktUviKcg17ieW7JDEp5k5wwW3uF1fxvYcOSUkP2ngKPQrdQr6btA==
X-Received: by 2002:a05:6808:e8f:: with SMTP id k15mr12999953oil.26.1643639243786;
        Mon, 31 Jan 2022 06:27:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j9sm12948895otp.23.2022.01.31.06.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 06:27:23 -0800 (PST)
Received: (nullmailer pid 226899 invoked by uid 1000);
        Mon, 31 Jan 2022 14:27:22 -0000
Date:   Mon, 31 Jan 2022 08:27:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm,cci-400: Add interrupt controller to
 example
Message-ID: <Yffxyq/49w2g6RXG@robh.at.kernel.org>
References: <20220126231146.1632819-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126231146.1632819-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 17:11:46 -0600, Rob Herring wrote:
> In order to parse the 'interrupts' an interrupt provider node is needed.
> That is because the example is a full example (starting with root node)
> and on those we don't guess and generate a fake provider.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/arm,cci-400.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!
