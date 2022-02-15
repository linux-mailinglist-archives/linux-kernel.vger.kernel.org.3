Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EEB4B7ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbiBOW4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:56:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiBOW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:56:47 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F642B91D0;
        Tue, 15 Feb 2022 14:56:37 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id n5so140367ilk.12;
        Tue, 15 Feb 2022 14:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeNpWnsdEBSIAdgZ4rc+NttAZNtgh6UEy35+0pZJ0PU=;
        b=NrNpCcJuvt+CFR9+N5GwoSE4wYDFH2IY6ShgRXdTA0+FG7PogHxTSKG0mOvply+aV6
         3sscyrPcj2ufroN2h0p4bNts1EwMlgr9YUqtPcItgJT274tdhF7VXN+ZD9vkXdwYgXnU
         oGOJSJF5rJbYdjeyT4wOJMmn3L+i4IX12N2waKt8fqS86YemGiHLVGwUwp4hDzoMCvlc
         VwWE4R7YOvSH9PPTlAZ5Qw6oLc9AQT9xW2S5z+fIkklf+NCATR7fqEU5LKcdlgGYBz+r
         vPw1CTE49rn2xx4R9UUq0RDRfjX52QSh4TaND5NMf4klf+xCiUjHKJH0QGWyJ7mbdzoF
         gNtg==
X-Gm-Message-State: AOAM531Z9KzAIiXDTKrd/fYSGpcy40iEkq0vuByu5GGCMNe5XVCbu2br
        M25tBQML1VFP2zM0jeHKMQ==
X-Google-Smtp-Source: ABdhPJznftkYIpt01opf8UkdBTHjoIG3wyj6NjXO8VkO1mlt3KReXJUUXOr75f1kf6TzdSSAHpT92Q==
X-Received: by 2002:a92:bf08:0:b0:2be:fc43:14c4 with SMTP id z8-20020a92bf08000000b002befc4314c4mr8776ilh.80.1644965796667;
        Tue, 15 Feb 2022 14:56:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q2sm17616920ilt.33.2022.02.15.14.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:56:36 -0800 (PST)
Received: (nullmailer pid 4072247 invoked by uid 1000);
        Tue, 15 Feb 2022 22:56:33 -0000
Date:   Tue, 15 Feb 2022 16:56:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     sst@poczta.fm, linux-iio@vger.kernel.org, lars@metafoo.de,
        jic23@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: potentiometer: Add Maxim DS3502
 in trivial-devices
Message-ID: <YgwvoUTOmTi8/NsS@robh.at.kernel.org>
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
 <20220214033620.4059-5-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214033620.4059-5-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:06:20 +0530, Jagath Jog J wrote:
> Maxim DS3502 is a 7 bit nonvolatile digital potentiometer.
> Add DS3502 binding into trivial-devices.yaml
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

