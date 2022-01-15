Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08A348F87D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiAORaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:30:52 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40617 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiAORat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:30:49 -0500
Received: by mail-ot1-f41.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so683058otr.7;
        Sat, 15 Jan 2022 09:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3t9nBgeTBjIZbTnYp+Jp4UVlxxnSMO/+rzL7IjxEVIs=;
        b=FLbd/JBzTJOzICjgxsyn5sRYoHFqoZyRNllc2raokQmIXFTvTsAJD9zyxgCqlwfUIF
         uNYkUTqcIz9oBT8WLwqtS1F8Uk4dy9uENLgx6FP9hlEv3tJUgwpU1nksb2gD8N1yrggb
         W91PkO+KnZ0uMLKsrWXF2AJ2FRKEo7ziqGYIoG/galOSzfOCMjfBnXxs9PzTxCn5P8l3
         2FlOEFdf+hMsumE4DfmVVIbDlb1WEdm5Or/F4U6scOdNSCbJLxt5mz4LF2OFdqWPHAHF
         4JuGi7AKSgM99hQFmkXXtliW7zWq109KgmQImyMZBP0gLfyGMv1/TQ2UtWTT9VDcxDmG
         /MTA==
X-Gm-Message-State: AOAM533PnoHql2Y6A6uq34tf+J/+yvcRSfwYnWK81Hv7DBOsL1zvLWgp
        +j5tT1aU1uFAFYvrWzaR6DzGRwTDDg==
X-Google-Smtp-Source: ABdhPJyb1hozHxAR9pgoKPTYNL2He4+TUfRi+8NKfRhzgFUvBQACstUUxJpNTD8z7Gc+O0vvUFJRAg==
X-Received: by 2002:a9d:5613:: with SMTP id e19mr10796872oti.303.1642267848509;
        Sat, 15 Jan 2022 09:30:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e6sm2329494oiw.39.2022.01.15.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 09:30:47 -0800 (PST)
Received: (nullmailer pid 132309 invoked by uid 1000);
        Sat, 15 Jan 2022 17:30:47 -0000
Date:   Sat, 15 Jan 2022 11:30:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] of: base: add parameter doc to
 of_parse_phandle_with_optional_args()
Message-ID: <YeMEx1z1YeQAuOlT@robh.at.kernel.org>
References: <20220115113156.435037-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115113156.435037-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 12:31:56 +0100, Michael Walle wrote:
> htmldocs produces warnings about the missing documentation. Add them.
> While at it, fix the typo in the referenced function name.
> 
> Fixes: 952c4865d27a ("of: base: add of_parse_phandle_with_optional_args()")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  include/linux/of.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Applied, thanks!
