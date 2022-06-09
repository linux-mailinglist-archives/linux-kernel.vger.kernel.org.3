Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE0545432
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbiFISd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiFISdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:33:55 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC736E1E;
        Thu,  9 Jun 2022 11:33:54 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id d6so8555960ilm.4;
        Thu, 09 Jun 2022 11:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjLp36AHdSqY0OzW26Jz18S5rMmSenhLhsO9ff9VDN0=;
        b=gd6Bihklt5tvu4cu1EXf8FCpsauEehwJnpvmCtjHI886iVUHGe3nkFiV9p/GfuNpvT
         8s9UGzPlWzg8jRY06ec6/zKzW2sj+8x/YsarzdykezQH9OnzIJVl1Nch9WroJGZhRf3/
         nxrbjrWH9SgTORA2opKTQ7dhepD/u2uOe7Uf41xeTyiRxtJGB3NXY2oqOpWYIzYaW3uB
         I/DP+XOb85y5tbReUdB9uT/tvFK4J9SGg5TUmXrVr+xt32/s4+L5tHX5yea9hL87CIMX
         xcLr+RjW822H5woplXD9qca7AjuLv5bbbadOA4cv9sqX/FTIAjFBfLGm5oxG5VV7EAt3
         +KGg==
X-Gm-Message-State: AOAM5306BwhbXbi3NicKteTUojRFiSKXxZVWKFzKUZ0jkjisHpk2IyYN
        MPVZNkV07J83CGw5zZN79g==
X-Google-Smtp-Source: ABdhPJw5uhY5WYkLXPaUEKy4FK6Ff3jLXV7VjuZ37mMIdftbI88KntHhJABZm5VboUtyoRtKqshWNA==
X-Received: by 2002:a05:6e02:1ba6:b0:2d1:b582:a9db with SMTP id n6-20020a056e021ba600b002d1b582a9dbmr22860477ili.90.1654799633880;
        Thu, 09 Jun 2022 11:33:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x4-20020a023404000000b00331f63a3dfasm1973963jae.122.2022.06.09.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:33:53 -0700 (PDT)
Received: (nullmailer pid 4083400 invoked by uid 1000);
        Thu, 09 Jun 2022 18:33:51 -0000
Date:   Thu, 9 Jun 2022 12:33:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: partitions: add additional
 example for qcom,smem-part
Message-ID: <20220609183351.GA4083315-robh@kernel.org>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606151417.19227-3-ansuelsmth@gmail.com>
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

On Mon, 06 Jun 2022 17:14:16 +0200, Ansuel Smith wrote:
> Add additional example for qcom,smem-part to declare a dynamic
> partition to provide NVMEM cells for the commonly ART partition
> provided by this parser.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../mtd/partitions/qcom,smem-part.yaml        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
