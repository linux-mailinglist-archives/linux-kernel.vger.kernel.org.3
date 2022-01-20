Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50EA495345
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiATRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:30:55 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41941 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiATRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:30:54 -0500
Received: by mail-oi1-f179.google.com with SMTP id q186so9886996oih.8;
        Thu, 20 Jan 2022 09:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8yQBERTvpfmaH1s1wVWlH9urutXAd/YcFyqq0Ym61g=;
        b=j6JmIGAe0irixEkfpddGNoDipE7T08FgKmm24pn9osiAJNsretwDBPSFntA+RtfJIW
         ir6v/UdfXZ3yoYAt41tY3K/UG+Vk2KNGU4JfgqOT6B1i65aoYMDMqxqpl2PFwEtQ9cK4
         MihscEsqLBjfSP4AYpBdC/Uk/NC6TynyiGE4A1Lt7NGyhmk1Jvo0aNH3WKQZktZsWIJy
         dlT1R4diY4zUZlTb0kaF1YuJGsFtHJ8u2ySofxnQ3oEvWeyj6q1BLEK6AnwnkHGltl8s
         egXrsE4nBMJ/V1HzNFRiOhWF/8oJgzxaIi+YyhHxjj++biJQYXfXSEPowXR0y/HuHTlU
         4JYg==
X-Gm-Message-State: AOAM5336POkKR50JC40djXSuFBasBMvJpxNbOdWIfXT1KtmHdMrBAlRK
        rRsl2EmJDsz+4B45qqk63UrtpihJ3g==
X-Google-Smtp-Source: ABdhPJyZqkBzpg/1+RU2t2JzeXzOhg+6gIYQoqsIiie7MtQOR3mLd2E1JbEC0uXUiqice6t1yHaNnA==
X-Received: by 2002:a05:6808:158c:: with SMTP id t12mr8583121oiw.156.1642699853768;
        Thu, 20 Jan 2022 09:30:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm1617078otg.54.2022.01.20.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:30:53 -0800 (PST)
Received: (nullmailer pid 1640219 invoked by uid 1000);
        Thu, 20 Jan 2022 17:30:52 -0000
Date:   Thu, 20 Jan 2022 11:30:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] of: base: make small of_parse_phandle() variants
 static inline
Message-ID: <YemcTJ640SlBkT0V@robh.at.kernel.org>
References: <20220118173504.2867523-1-michael@walle.cc>
 <20220118173504.2867523-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118173504.2867523-2-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 18:35:02 +0100, Michael Walle wrote:
> Make all the smaller variants of the of_parse_phandle() static inline.
> This also let us remove the empty function stubs if CONFIG_OF is not
> defined.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v3:
>  - rebased due to now signed index parameter
> 
> changes since v2:
>  - new patch
> 
>  drivers/of/base.c  | 128 ++----------------------------------
>  include/linux/of.h | 157 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 135 insertions(+), 150 deletions(-)
> 

I moved the index < 0 checks into __of_parse_phandle_with_args 
and applied, thanks!
