Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AB55DF70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiF0Rxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbiF0Rx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:53:28 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF2D130;
        Mon, 27 Jun 2022 10:53:28 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id a10so10334988ioe.9;
        Mon, 27 Jun 2022 10:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lrAGRKXc3vc08X6zXzyE0eXaLkMTZTwYIY4rAztu1Y=;
        b=6TZCIiMd8Riu4FRBUzYoUOYPWKDtesPQaB1/vqISc8/4cqHq3MqrKuJ9DXizYqyfkT
         w644SbGP9Pm80jMLX9eYR5qkI5Xd3cf99yO113TEMAcgTllsadFHSH1eYD376I9c8ceK
         sJaoUOVd3U2Yi345SseGGOCpTBQtQ5BK0qsI6ZGjVaeyj5usBUFc8uUI6MGOCt5d7rUn
         utGG3yQ3OyOrbMuh+/hM171/VwUeYQ6L66oL9DTTAzUMyoSG9yrpgjHU+W7zjbvs8L3B
         MtV6aoi0L1G9pde8DJBl7ifJm3Xvhe7/gtSQ+brHOUgdsFuGLpTCDowV+g1t+49Dw/GI
         LXxw==
X-Gm-Message-State: AJIora+cGMlw11M7VLeD7mB/XiEa5ruPQ23CiP7ht+sbYRVW60nslw0p
        2xrvtrfFe0oS2c/e+SLmDw==
X-Google-Smtp-Source: AGRyM1uowlzaPeags6XA/Ao944NXy1Eo3XwRxuaogTcOOorXi0BD6Q3AdHUyAPin/Mk429mmHi46Sg==
X-Received: by 2002:a05:6638:1313:b0:331:f465:3a with SMTP id r19-20020a056638131300b00331f465003amr8938947jad.59.1656352407511;
        Mon, 27 Jun 2022 10:53:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j18-20020a056638053200b0033792143bf5sm4965751jar.67.2022.06.27.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:53:27 -0700 (PDT)
Received: (nullmailer pid 2665429 invoked by uid 1000);
        Mon, 27 Jun 2022 17:53:26 -0000
Date:   Mon, 27 Jun 2022 11:53:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     devicetree@vger.kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: base: Modify function description
Message-ID: <20220627175326.GA2665319-robh@kernel.org>
References: <20220624011247.1735-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624011247.1735-1-wangdeming@inspur.com>
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

On Thu, 23 Jun 2022 21:12:47 -0400, Deming Wang wrote:
> Delete duplicate words of "the".
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
