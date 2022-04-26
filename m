Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05817510019
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351452AbiDZOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351456AbiDZONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:13:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA35167DF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:10:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e2so19383310wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wRN4XnZH+bp0l+9PL6OM9KZysL7qxIPbpe7RWE8YCjI=;
        b=GK6Q7tgi6IBAfuJib4QqFC3ZCwT284o/2Dvsgkpqb8LKzorucli1I+Wq4ieOfFxWH/
         LDKNosws4aS+qFdsXURmg3gimLzlFoKMZLtOFHX3Idjey50xPYfXUKq/+Y5dEigwSjT1
         Hjq9tYoTbxdwLkaLUF9o64V2Sv42nnf583RYiWZ9f7edDJWSApD8c7M3iXfzeGM6bo2V
         MVSInYOWPuBatfIdcfpL2wtSDeYezXLmNgrd+dmmxgOOhvAJub1RDVz1HUGwasFCLYEW
         lUT6BlKyQ4cKWBquSrRGYj9F+qJAx2nQpLSGfmdJ+Y7mvtXNh9v3GtRL0keCcPm/ur37
         Ww4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wRN4XnZH+bp0l+9PL6OM9KZysL7qxIPbpe7RWE8YCjI=;
        b=JuoLmVebjIQSSPD8olwu4KpDmy8iesUu5nDj83f+xr6DoHzydTKZ5lHBCnCU7mU9Px
         hFvzWtiZg3z3Ky87855gguizcIfI31C7U3kbiPvkB39h9JB08BGunYGmEC5o05/msQld
         kerUVGumc766xlCJvne/sgEdVN1t0F2uYwkX4goF1SG3qs8QHgllOndYRS34BVYLIHZA
         9b8jTmBLsBCtwj/JByi3FdKh6mcH3zd+W0yeuw83L+9lid4f6d/urrNnpvboa84ffCYv
         66ss2QGuDZ8sA1FO3hHM5Pq4QAseiul8VLRDbaMizuAgET9rE4jlhBrhuzhANCzt69gw
         5dcA==
X-Gm-Message-State: AOAM532irkyZLiINVFTrgLcPAoEJVBPhdQTuDARv2GYIUb1mO3066PgA
        OUD6AFGcetOF3rW4ImXfJHWVBbDn/vLZPQ==
X-Google-Smtp-Source: ABdhPJxjlOLFpvgcH5acjqH3tr+ovmv8RsrB0nFOhu80CS76By6KG/rOAe/kM3QjcruuwIn4EENGrg==
X-Received: by 2002:a05:6000:1789:b0:20a:9fbc:b1b5 with SMTP id e9-20020a056000178900b0020a9fbcb1b5mr18267422wrg.581.1650982246020;
        Tue, 26 Apr 2022 07:10:46 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d13-20020adfc08d000000b0020ad7b380d3sm7483048wrf.6.2022.04.26.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:10:45 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:10:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: hi655x-pmic: Replace legacy gpio interface for
 gpiod interface
Message-ID: <Ymf9Y7QbIhSee8S7@google.com>
References: <Yk2maZuf+5FGL+eg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yk2maZuf+5FGL+eg@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

]65;6602;1cOn Wed, 06 Apr 2022, Maíra Canal wrote:

> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
>  drivers/mfd/hi655x-pmic.c       | 27 ++++++++-------------------
>  include/linux/mfd/hi655x-pmic.h |  4 +++-
>  2 files changed, 11 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
