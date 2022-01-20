Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91213495349
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiATRbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:31:11 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46975 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiATRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:31:09 -0500
Received: by mail-ot1-f53.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so8420399otc.13;
        Thu, 20 Jan 2022 09:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMTXEcZxQxRzrFEKOmRLESrmaSoYPyAT1QBxmrRgXoY=;
        b=ERWvxRmUzOuIklvhmXnRMFwH9V98VGLRrWYHgbwGLiK50zFd8HLDdnkWv3H9oXot5y
         FXqRHpwU4pNcNxlrfJ7LTcXHxdn6TX7N96TFh/S1W0AtN7sE5zVFaGPTFVOuadYTwrKp
         OZgaTVJJVGPHO4aSYfTWJnqqLKVWYRCFI0mB6PWNjPo8dbMy2BxAPqJvco0qiEhFXqyp
         EuhTmBXBiEZdSeHhLU9Oya5ocGzLdLWmaQLJT9R2/PxNDkXPDl+OsP7FgiPDksgU6OG1
         VGZ2SUBhEso3WBUi75LPih3uSM/MSZjiCEAUd9BVgeiDffQ9klRl4m0zmqWgg9kbRy/V
         EiuQ==
X-Gm-Message-State: AOAM533hj3oDtJy99UbSKhDN98COL6QPPnvLC4AtEzN+kveO7PRYRjkt
        tRzgB0CtlVTvV20TzWEOTw==
X-Google-Smtp-Source: ABdhPJznZsq3frzrWBnKFqj14N/KU+rasgJsMU2qzvqt/4ysH0WSKas00TKDzWr+0mXxSaDbbASLEw==
X-Received: by 2002:a05:6830:1313:: with SMTP id p19mr17963963otq.173.1642699868590;
        Thu, 20 Jan 2022 09:31:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y198sm1884115oia.22.2022.01.20.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:31:07 -0800 (PST)
Received: (nullmailer pid 1640608 invoked by uid 1000);
        Thu, 20 Jan 2022 17:31:07 -0000
Date:   Thu, 20 Jan 2022 11:31:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3 2/3] of: property: define
 of_property_read_u{8,16,32,64}_array() unconditionally
Message-ID: <YemcW0c8U5mtucP+@robh.at.kernel.org>
References: <20220118173504.2867523-1-michael@walle.cc>
 <20220118173504.2867523-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118173504.2867523-3-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 18:35:03 +0100, Michael Walle wrote:
> We can get rid of all the empty stubs because all these functions call
> of_property_read_variable_u{8,16,32,64}_array() which already have an
> empty stub if CONFIG_OF is not defined.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v2:
>  - none
> 
> changes since v1:
>  - new patch
> 
>  include/linux/of.h | 274 ++++++++++++++++++++-------------------------
>  1 file changed, 124 insertions(+), 150 deletions(-)
> 

Applied, thanks!
