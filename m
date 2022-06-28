Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8255EE16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiF1Tt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiF1TtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:49:14 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3A3C710;
        Tue, 28 Jun 2022 12:44:58 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id w10so8873320ilj.4;
        Tue, 28 Jun 2022 12:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8oqYF8CYF/NfPnLUHRXbuyYwNz4NY7b0UEaAoOBFKI=;
        b=uvbEVOgThCS2LX4CvbsxW7UoLegrobiXrMOQfyiqf/sRDCgAR77mXAomzO8QUhhoSq
         Y+MnUVmqw5Nvxf+YQNYXDeKoyLdgeJ3lgzbCciAopFSLZuP5fxeryHWpdsXdBLXecocv
         NaWe5rPhuYClrPO0hNBUJpUZ/u5QjDEU3JhkkIxTN1qosrVmsqQewuY9yjndZu08dbjD
         vyLRlrljX67o4AZz9Ua4ZSGpGuoN45d4hzlUMxP2FB4kjMLZG6PtyXCkoi0fNKJjs/8O
         nnAcR0nz8E5ssNC8xqE84TUM6nEOYBp8GRpgzUV9iu7CiE+/j3xH3j5IzgGF6SpMcQHp
         7CVg==
X-Gm-Message-State: AJIora9k1C5b1XM1calVKY/xar/scnT+Tn3YFkm5mmJr9zTrwHp+kE7o
        VYmDVLINdPg8YWZTWyAMYQ==
X-Google-Smtp-Source: AGRyM1txmib4nODs+eTLxrl5HRxMhZB1byUNtBdxp/31Zmns7iKmug7AOiZqEys9+SGEZanmP8UxbQ==
X-Received: by 2002:a92:6603:0:b0:2da:82b6:34a3 with SMTP id a3-20020a926603000000b002da82b634a3mr9166995ilc.250.1656445498116;
        Tue, 28 Jun 2022 12:44:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k15-20020a02a70f000000b00331b9a3c5adsm6357712jam.170.2022.06.28.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:44:57 -0700 (PDT)
Received: (nullmailer pid 863361 invoked by uid 1000);
        Tue, 28 Jun 2022 19:44:55 -0000
Date:   Tue, 28 Jun 2022 13:44:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     =?utf-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: support label/name
 only partition
Message-ID: <20220628194455.GA863329-robh@kernel.org>
References: <20220622010628.30414-1-ansuelsmth@gmail.com>
 <20220622010628.30414-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622010628.30414-2-ansuelsmth@gmail.com>
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

On Wed, 22 Jun 2022 03:06:26 +0200, Christian Marangi wrote:
> Document new partition nodes that declare only the label/name instead
> of the reg used to provide an OF node for partition registred at runtime
> by parsers. This is required for nvmem system to declare and detect
> nvmem-cells.
> 
> With these special partitions, the reg / offset is not required and a
> 'partition-' prefix is needed.
> The node name with the 'partition-' prefix stripped, is used to match
> the partition allocated by the parser at runtime and the parser will
> provide reg and offset of the mtd.
> If the partition to match contains invalid char for a node name, the
> label binding can be used to declare the partition name.
> 
> NVMEM will use the data from the parser and provide the NVMEM cells
> declared in the DTS, "connecting" the dynamic partition with a
> static declaration of cells in them.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mtd/partitions/partition.yaml    | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
