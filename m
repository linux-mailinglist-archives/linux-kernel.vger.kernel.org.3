Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E682F55DFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiF0Ri3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiF0Ri1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:38:27 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E6BC11;
        Mon, 27 Jun 2022 10:38:27 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id h85so10318007iof.4;
        Mon, 27 Jun 2022 10:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXpG8a54i73DxyJ8pjX+3sdV3EJr4mPuRN2vogX5Pjs=;
        b=PNzQtMWrS4L5c9G70xKfj/tH+hnZ3LSczeprtQ1ydtrSu5pJhnCxp95l2ccEyDlYrs
         rVQgnvvF0ikS3AJbQ5OWj+L0s3V8TiZITsH5xbNtCniBrqkOh7egvp9Ii85reXxLJeVB
         MjS+i13Tc9RR9j9vs+VkdxYdNhaDUKGn1Fol7j6S+tVrjMUgn46777QyBgEodXrxK53v
         VWrNu+Ky/GSoLBE1os0UvoxN8TrzZqB1p97m3gDrYgmfGim+gsGmctc3v/2rdPSu8xwW
         wOlknquK8CXbHsLTpY/c+ex00acjTKVOjUond3KLVNROKhZBoi6NuDeWYa3vRdQb7qG+
         hGZg==
X-Gm-Message-State: AJIora8LFCaBiSKP7o6Gd0bgnOxNLwU/oT2azzNl46RwGQlhyDU4mLST
        61rYmJ3dY0ZlpNQN7oZJ+Q==
X-Google-Smtp-Source: AGRyM1vaLHPxfl47WVkP1GJtHbKyi/rnOH1ihcmiGZYS1xOjmUYwkTbg4KMWTFWVfPlmPj7BSMj60Q==
X-Received: by 2002:a05:6638:1690:b0:331:950f:8ea9 with SMTP id f16-20020a056638169000b00331950f8ea9mr8507145jat.67.1656351506390;
        Mon, 27 Jun 2022 10:38:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z3-20020a6b5c03000000b00672714b81e0sm5614956ioh.26.2022.06.27.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:38:25 -0700 (PDT)
Received: (nullmailer pid 2643194 invoked by uid 1000);
        Mon, 27 Jun 2022 17:38:25 -0000
Date:   Mon, 27 Jun 2022 11:38:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: device - Remove duplicate 'of' in two places.
Message-ID: <20220627173825.GA2637590-robh@kernel.org>
References: <20220621154222.13714-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621154222.13714-1-jiangjian@cdjrlc.com>
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

On Tue, Jun 21, 2022 at 11:42:22PM +0800, Jiang Jian wrote:
> file: ./drivers/of/device.c
> line: 22
>  * @matches: array of of device match structures to search in
> changed to
>  * @matches: array of device match structures to search in
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 874f031442dc..1582388156a9 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -19,7 +19,7 @@
>  
>  /**
>   * of_match_device - Tell if a struct device matches an of_device_id list
> - * @matches: array of of device match structures to search in
> + * @matches: array of device match structures to search in

Maybe that was supposed to be 'of OF device match'? 

But really, something like 'NULL terminated array of struct of_device_id 
entries to search' would be better.

>   * @dev: the of device structure to match against

Like 'of' here.

>   *
>   * Used by a driver to check whether an platform_device present in the
> -- 
> 2.17.1
> 
> 
