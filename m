Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF2531DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiEWVgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiEWVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:35:55 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA654B0405;
        Mon, 23 May 2022 14:35:53 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id t144so16111194oie.7;
        Mon, 23 May 2022 14:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+TgBtPobFnZqW+JV/jTeMD8TDD9K+4IfxOQM4kNDjbU=;
        b=lLMH9X4pFFDvldQtc8uZs7CPZB6Cq51jkEaNI/kkrAICpU4ssuk74JVEM6f2msc+CR
         riKuYn5g5j/P4ORyXursWCZrTWZqZbvUa0VfEy+K/heZw1CeRxmsC1QFvUNDr50YBKcR
         PcpxIvlP4/At8a+gwL8q+UFpq8x+7XiaXAVCVRa1r/ksAkJCMf0rLbJvKvc/4Azz08G1
         XPsHfQG1gdvBXgeNpxbQowsxO53PzCuwW5NiAQWPfQ25JlTdBV2UtrGt50TNlVmAd66e
         PLW+8RgrsLxRgD3pyPt2gTRBUqY2wPXgR1aeOiVH5KwcyjjOt0fe59uq9uS9VnudJ2IK
         A+qw==
X-Gm-Message-State: AOAM531ypHqY2vLHOp3MU8nxjSGG8V3VwANTCI/RcuU1baY1G+CQOGkI
        eHyKlkVQ0Tp/xDOoqQiRjRKxVy6fIw==
X-Google-Smtp-Source: ABdhPJw+eWDMrOeCej7ML2cFYaLbt91CxwVeMBv28ddpFureQWt4OKuSh312ezdb6yg6M1GxSX87mQ==
X-Received: by 2002:aca:100d:0:b0:32b:44a0:cb4d with SMTP id 13-20020aca100d000000b0032b44a0cb4dmr612177oiq.32.1653341752957;
        Mon, 23 May 2022 14:35:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l8-20020a056830238800b006060322125dsm4519100ots.45.2022.05.23.14.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:35:52 -0700 (PDT)
Received: (nullmailer pid 2231754 invoked by uid 1000);
        Mon, 23 May 2022 21:35:51 -0000
Date:   Mon, 23 May 2022 16:35:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] of/irq: fix typo in comment
Message-ID: <20220523213551.GA2231681-robh@kernel.org>
References: <20220521111145.81697-59-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-59-Julia.Lawall@inria.fr>
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

On Sat, 21 May 2022 13:11:09 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/of/irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
