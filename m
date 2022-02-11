Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB874B2849
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbiBKOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:50:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiBKOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:50:44 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E46DFE;
        Fri, 11 Feb 2022 06:50:43 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so10520310ooa.11;
        Fri, 11 Feb 2022 06:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cvpuKd3fiT4FiCUCbbqi+7/AuUDAVHBSUVUT5Fs19VM=;
        b=7fPOn2iMD15siDWBvEjMq3ffAWGYbIWftzkGGChIoH0bLThgncIhqahPC9R4us+kSm
         TvC3/qzCpcfvGsaMUQ3570tKBsAb6Ws57nHuwdqigTPRjmlCQvHxKZ3seqp1uiFq2+4x
         Ccuoi+P8aWGP7oMbDVixj3dJGfl65uloSZe9qNMhph+RIDsEuV9gmvebL5+cgJKNVjHW
         Svg6VEp4EW3e+HoAfHdAwDxi+nQWBndY2OyKDXXmwCOw6BR3N5vn/Df8pU7+AkaMO9St
         7vmSbAjrl0+Ilra693x0GR6VQPZrumieDmhkAugaWukGPwSCWYHRJIEtN/qpBWc5OEbZ
         JQvQ==
X-Gm-Message-State: AOAM5302+jWPULRQ4cX2Z7FmdKvsz2uNx2xhRE2yO9JqD+Rct/lDH7Az
        1giad4DrwH8LjLZlwE6uhg==
X-Google-Smtp-Source: ABdhPJz7JEqUsKepxfFdBGqq4yWES/g7N7yyATspyeMEnGYVyfW8ML4Eedy5M7sAdxuBTNIm8yTXvQ==
X-Received: by 2002:a05:6870:9202:: with SMTP id e2mr253775oaf.226.1644591042413;
        Fri, 11 Feb 2022 06:50:42 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id s3sm9987388ois.19.2022.02.11.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:50:41 -0800 (PST)
Received: (nullmailer pid 345762 invoked by uid 1000);
        Fri, 11 Feb 2022 14:50:40 -0000
Date:   Fri, 11 Feb 2022 08:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, geert+renesas@glider.be
Subject: Re: [PATCH 2/6] dt-bindings: clock: r9a06g032: Add the definition of
 the watchdog clock
Message-ID: <YgZ3wOxgntrtYWMN@robh.at.kernel.org>
References: <20220204161806.3126321-1-jjhiblot@traphandler.com>
 <20220204161806.3126321-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204161806.3126321-3-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2022 17:18:00 +0100, Jean-Jacques Hiblot wrote:
> This clock is actually the REF_SYNC_D8 clock.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  include/dt-bindings/clock/r9a06g032-sysctrl.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
