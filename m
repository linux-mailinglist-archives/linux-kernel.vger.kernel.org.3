Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2101F4D6568
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbiCKPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350285AbiCKPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:53:52 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B51CD9D7;
        Fri, 11 Mar 2022 07:51:52 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id w2so1686125oie.2;
        Fri, 11 Mar 2022 07:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFQmY8Q3Xcs50vqeMZuNuMuDo4MjkwmEEkUJ4NeBy6w=;
        b=bsQFtUu11nacc7Cv0yQLN2cLXRQeUo57ZUQmugMBB7HjIWYAuZ71sTPS9BlEp2h6IQ
         Ar/xpTbSm4gePcgZIBMOI0y0NizOYto9mCMjbXqanS1iLg03NWIwJ9YC4Q3dO272Xjxt
         2nmde3gwFDJ1l9nrn6bwHAMj4GyS0rw45HDiAABFvZuYZjqjomZiS6rYDX8J8gWl/yFk
         p0aD2xJwZrZMa43/bWcWbfc5cHPJlctiWHgLQXwv2HZf9o0wZza1rHOOprquPMFc9GLp
         RFL4AkWBEj2YsBQLOXTPp3gl5XKFg7HGtRGZSVcNz2TT0dAj+08f6z5f64PHdgR+ukgE
         f1fw==
X-Gm-Message-State: AOAM531w1g+ptjMY8OwiYkmbmiPxLt2eUFp/jfVqQaOmc9zsPr7As7F9
        37S4BzB3lrZmi5h0Yp4U9w==
X-Google-Smtp-Source: ABdhPJxOckzuMfoeKLRh2uMhfA7547OHTQ+38S+0GQ+35G6dShSqk8U+eYRPpxG5WGYqgKkP1XXYIg==
X-Received: by 2002:a05:6808:218b:b0:2da:5fd1:a85b with SMTP id be11-20020a056808218b00b002da5fd1a85bmr5388120oib.71.1647013902733;
        Fri, 11 Mar 2022 07:51:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r21-20020a05683002f500b005b249ffa43fsm3856004ote.22.2022.03.11.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:51:42 -0800 (PST)
Received: (nullmailer pid 3868935 invoked by uid 1000);
        Fri, 11 Mar 2022 15:51:41 -0000
Date:   Fri, 11 Mar 2022 09:51:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steve Lee <steve.lee.analog@gmail.com>
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, ryans.lee@maximintegrated.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [V2 2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
Message-ID: <YitwDaQcXUApGKW4@robh.at.kernel.org>
References: <20220311132906.32292-1-steve.lee.analog@gmail.com>
 <20220311132906.32292-2-steve.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311132906.32292-2-steve.lee.analog@gmail.com>
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

On Fri, 11 Mar 2022 22:29:06 +0900, Steve Lee wrote:
>  This adds support for the reset gpio binding.
> 
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
