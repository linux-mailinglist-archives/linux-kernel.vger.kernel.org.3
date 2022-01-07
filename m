Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FEF487F61
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiAGXat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:30:49 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44027 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiAGXas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:30:48 -0500
Received: by mail-oi1-f174.google.com with SMTP id u21so10321899oie.10;
        Fri, 07 Jan 2022 15:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Ku3IAgEkgHh7baff2sdCGb4YaDMcEw0gEOxEZPSL3Q=;
        b=PrPRndy3rtBFQ5H73CLYWn+5dvcF9Jcq8+ybcRMnOh2r88CCYw0zL1I8r6jh/AtJh0
         QplZrL+LdYRjTG500RuN7ppJyhdl3k6EmiqC4B3NxuYn1kTmtMtm/5iGdO2eLjXmylYw
         dbuGqeBeg5goWEBxiaJHjK15Nj9XLthjCGPw/lW93NNY7m/rq6ZLJBsrHcxO7z2r1Pd5
         +WpCDtbqmb+R0VS4c60pupJaQkaTm37L+k1sSFgG3VZJcTSN+VZiKOEc/yazUfc334//
         reuRyub/zJcnbsX9LqNa51YJfS8NcUVqMU2wWHM3g76iT64tIIy1ortFyAf1pCwW1NRn
         R7Eg==
X-Gm-Message-State: AOAM5302LoSWA7LUDur5UmYSMigrQ9PPlTIcmnSpxzMY3rWcUt9Dhqm0
        o10pfbNtTx5CZByuvnqv0g==
X-Google-Smtp-Source: ABdhPJw0RD9FGT6IDYvNxl1rq2qWGYIMZI9WHM7Ep5i/wqRiOvTPFZBZH8oierakDGs8izXGr6+5Bw==
X-Received: by 2002:a54:4014:: with SMTP id x20mr11715290oie.129.1641598247682;
        Fri, 07 Jan 2022 15:30:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l3sm21325oic.37.2022.01.07.15.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:30:47 -0800 (PST)
Received: (nullmailer pid 4140477 invoked by uid 1000);
        Fri, 07 Jan 2022 23:30:46 -0000
Date:   Fri, 7 Jan 2022 17:30:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] of: unittest: remove unneeded semicolon
Message-ID: <YdjNJmjzyw8gJy3q@robh.at.kernel.org>
References: <20220107002826.77939-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107002826.77939-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 08:28:26 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/of/unittest.c:1961:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
