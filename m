Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DE578C44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiGRU6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiGRU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:58:04 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975F326CE;
        Mon, 18 Jul 2022 13:57:56 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id c17so5698000ilq.5;
        Mon, 18 Jul 2022 13:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=skd+Llk7HYcalR5o66WcBJMV3ItUCnfuuaqe2Rm/kXI=;
        b=TbhqIBMFofvNhqmU4TN9CNEzDzvi7WAg4NNt0DMrEbP4of+IDe9AX763Li1cS3C9Z8
         2mQSY9RAlFyA5l4KJ+nMUjlw5SOKitVJ6BKQr3NoraejXLHm5pTnCD9REnV7yjqyvs2L
         5z4ctuNCSZXX6lDv6Q+nbKKnKHnkpXcNQZMl2IqKvnvBvYzyrNVcMqr77FQvmK1wKQsi
         7j8mbLOgyXruvpy0FTCHRfsMpEJ2FqSQyC1dGjL8c6DpEmIkNpxT1Z2Gl46PIVUnLDLJ
         mZTqyyJbEWWUgRlb83LRkMwamFgG3HAio8Hr7jQN7hPuwr68fo4sC2/MPq5mGwUrJYIR
         nPjQ==
X-Gm-Message-State: AJIora9UDKSXDzeZtanZBk8N59wOxxsArRbX36FbVrxbYTadGoe58RkR
        SgbZpuS5UrpLX/G4LZB5Xw==
X-Google-Smtp-Source: AGRyM1ss+7G12B/ibwW5xFiIItMlnZP1HZdzqGAKcz3grY5lmrWQ2e09PCHdxKdm64dPZaEd/6Q1jA==
X-Received: by 2002:a92:ca07:0:b0:2dc:43d4:1e9a with SMTP id j7-20020a92ca07000000b002dc43d41e9amr15091543ils.240.1658177876023;
        Mon, 18 Jul 2022 13:57:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638034600b0033ea1d9858bsm6090991jap.36.2022.07.18.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:57:55 -0700 (PDT)
Received: (nullmailer pid 3541236 invoked by uid 1000);
        Mon, 18 Jul 2022 20:57:53 -0000
Date:   Mon, 18 Jul 2022 14:57:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20220718205753.GA3541174-robh@kernel.org>
References: <20220713200123.22612-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713200123.22612-1-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 22:01:23 +0200, Pali Rohár wrote:
> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> indicate SoC in example.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
