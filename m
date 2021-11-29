Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C41462299
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhK2U7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:59:01 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44714 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhK2U5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:57:00 -0500
Received: by mail-ot1-f46.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso27240585otj.11;
        Mon, 29 Nov 2021 12:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O5phL/jvYeg+hJdzDu+EzloScJKYSqephaKd+f3MqAk=;
        b=P+S5LnqCJof/7mRHLNzEGv2EwkG1T1EbvELHvwwJUwHW0smckTHtWnieOC+bn+7bPp
         F0oyBVXzXd58x30fQltyJguxtbgiUXMsH1C02cemawk/S3ztaunU+5ZyrVIPOQvF5Q1A
         XssY+X7kgj5HGzNnQapTlVt7NH2u3v6CjlaAH6HHJVD2I/FcRqhJEXUSd0QtPnmO1w2m
         nVb9MwImrELQiGvBxmFlhfmORiJ0nMTRjY9we6IJJXC1qi/wSCqeRDmC140fhTG6KDO/
         moBt7nukmPwV2QGLyQd7VXEgM9XNGzLviNG2Md5etUWPRU7Cf/trQeHrjHgzlxqNeTPP
         pQ+g==
X-Gm-Message-State: AOAM532nKo0T5muKfDklTbwoOT/+iWN9ukOrCME+GlDMJ1x61z4ovDoj
        xyEkwG9qByweTyrnjuCpJg==
X-Google-Smtp-Source: ABdhPJz/LyBaEyES+FDgkNvSLTdH7DzsMrDqMgF3cGiLAZDPRWI9Ut0H8bHhZ9f7b3s9/Su4m+kc/g==
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr46954142ots.240.1638219222537;
        Mon, 29 Nov 2021 12:53:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t12sm2450270ood.22.2021.11.29.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:53:42 -0800 (PST)
Received: (nullmailer pid 590668 invoked by uid 1000);
        Mon, 29 Nov 2021 20:53:41 -0000
Date:   Mon, 29 Nov 2021 14:53:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] dt-bindings: fsl,layerscape-dcfg: add missing
 compatible for lx2160a
Message-ID: <YaU91SxgAFXtDMyW@robh.at.kernel.org>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
 <20211110222200.6780-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110222200.6780-3-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:21:51PM -0600, Li Yang wrote:
> The compatbile string is already in use, fix the chip list in binding to

same typo.

> include it.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
