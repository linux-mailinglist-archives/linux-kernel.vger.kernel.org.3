Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABB477D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbhLPUb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:31:29 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37477 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhLPUb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:31:28 -0500
Received: by mail-ot1-f45.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so335975otg.4;
        Thu, 16 Dec 2021 12:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OyruAna4eQK8uRw8f/nq559G0rjy0iQItWA5/0EZSI=;
        b=8Pzr83a7pdlEW4qzJiTV8ySeLF4Z3okWwyPB+JL1XoqWp0WvTVMkpr5MqsY+VXnwZG
         Z7pttXlEn5FVaepDvUMvAfEK3qMy8HQHxIOc8klnbhkd+vCg8eFCiaitF96XDHyegx+s
         j/3y6fEWr1mNb6FGfu046DJQwoI6R3nhd/ZkKX1INZziau5nWUTfWGf0OeWBYmeT6CDG
         QZgkRVwdlDHpx47RK1GkOTZ+Wy63WWbBvcmxgZfdknT7OD9wqy1OrQgjs3YQg9TYdaxq
         2hX4bVOi+JuaKfaw0xPgCOXngDl2kE8Ohdp4XyifuMoDEPLGx510QhmgvvSMJgQThaRm
         8R5Q==
X-Gm-Message-State: AOAM531/3IXLKAZzsKUhHTKqkHMk0182O67usLm9kG1Km13YT6iVPCT5
        nlqIyweJ1vdkOpO+ucX2OA==
X-Google-Smtp-Source: ABdhPJyOYXNB53yOciN7Z88z8EuVw1heccZg9ATVKolCRbHwQ8myX1kELq8j+Ks33oKO0ALx+/QjHg==
X-Received: by 2002:a9d:7cce:: with SMTP id r14mr13783658otn.114.1639686687735;
        Thu, 16 Dec 2021 12:31:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w5sm1221565otk.70.2021.12.16.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:31:26 -0800 (PST)
Received: (nullmailer pid 705168 invoked by uid 1000);
        Thu, 16 Dec 2021 20:31:25 -0000
Date:   Thu, 16 Dec 2021 14:31:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/8] dt-bindings: phy: phy-rockchip-inno-usb2: add
 rk3568 documentation
Message-ID: <YbuiHfUPezvB01CH@robh.at.kernel.org>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
 <20211215210252.120923-3-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215210252.120923-3-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 16:02:46 -0500, Peter Geis wrote:
> The rk3568 usb2phy node is a standalone node with a single muxed
> interrupt.
> Add documentation for it to phy-rockchip-inno-usb2.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> 
> This was the best solution I've come up with for this.
> I avoided creating another binding since this is such a simple change to
> the actual driver and would likely require renaming the existing
> binding.
> I've tested that this correctly flags if the interrupts are missing or
> incorrectly assigned on both rk356x and rk3399.
> 
> Thank you Johan and Rob for your constructive feedback.
> 
>  .../bindings/phy/phy-rockchip-inno-usb2.yaml  | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
