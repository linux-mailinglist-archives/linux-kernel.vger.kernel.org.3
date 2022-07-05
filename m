Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F056788B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGEUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGEUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:38:30 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD5DEC1;
        Tue,  5 Jul 2022 13:38:29 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id z191so12260362iof.6;
        Tue, 05 Jul 2022 13:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GDJzRfg3CLq/enCCXl/7+ZCKOLr3I0V4v0iaJ2Euu4E=;
        b=zWkwEgF9R+xlExkGRXD2aCDJuTry+J49CFf855M+fiVyA1xjWjL1jIo25AXQE7AmCP
         2imBqTE3uZTv5Rj/XytfFW7Grd3842DUlo6SSufoibi/Yk90d7FqFEZwn/p2gYvnZlwc
         da4StbcQyL8v+WujZbLQAoaWp2A15XdN1GHxS6yQeQ+3rso+qHq5okXEeX+F/29R6hPz
         Oj/ULe4lz3IMqzhiObgD7fjiKPzTehNqW7VODFEZ6pckTrHn44Q1EM43MaoGMamFoz5E
         eZVhCrB2BJYt1SIWwii+QffhN4vCRHNeQWOBbTqTyEcw9F6qB1QdEFOTsxEgt0ER4j17
         fVXg==
X-Gm-Message-State: AJIora+ZZnmTEXBO+Jir+/czX0oPen7Wxc28/7nydR71kZLUsaCBPwa2
        CjMDy8vNbyD2g8UnId9Wdw==
X-Google-Smtp-Source: AGRyM1trii1EpHOBibCSlo/2ChUwNWPZ2PHVASVqkNIDErfiuZURgoB51RlVuVr6xjllnkX2eJHP4g==
X-Received: by 2002:a05:6602:26c3:b0:66c:f8b2:53c with SMTP id g3-20020a05660226c300b0066cf8b2053cmr19468133ioo.50.1657053509227;
        Tue, 05 Jul 2022 13:38:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o1-20020a056e02068100b002dc1c1fcb29sm1749170ils.65.2022.07.05.13.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:38:28 -0700 (PDT)
Received: (nullmailer pid 2583922 invoked by uid 1000);
        Tue, 05 Jul 2022 20:38:27 -0000
Date:   Tue, 5 Jul 2022 14:38:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        vz@mleia.com, devicetree@vger.kernel.org,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, p.rosenberger@kunbus.com,
        krzysztof.kozlowski+dt@linaro.org, lukas@wunner.de,
        jirislaby@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 5/9] dt_bindings: rs485: Correct delay values
Message-ID: <20220705203827.GA2583869-robh@kernel.org>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
 <20220703170039.2058202-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703170039.2058202-6-LinoSanfilippo@gmx.de>
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

On Sun, 03 Jul 2022 19:00:35 +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Currently the documentation claims that a maximum of 1000 msecs is allowed
> for RTS delays. However nothing actually checks the values read from device
> tree/ACPI and so it is possible to set much higher values.
> 
> There is already a maximum of 100 ms enforced for RTS delays that are set
> via the uart TIOCSRS485 ioctl. To be consistent with that use the same
> limit for DT/ACPI values.
> 
> Although this change is visible to userspace the risk of breaking anything
> when reducing the max delays from 1000 to 100 ms should be very low, since
> 100 ms is already a very high maximum for delays that are usually rather in
> the usecs range.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
