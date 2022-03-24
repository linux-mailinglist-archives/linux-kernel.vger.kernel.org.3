Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF34E63FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350417AbiCXNUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiCXNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:20:08 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30F71A03;
        Thu, 24 Mar 2022 06:18:36 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id r8so4852044oib.5;
        Thu, 24 Mar 2022 06:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QsCxD91gYZRywdPEm5/HAl9nSNp+sICZ3w09LMCK6DI=;
        b=RSL7xq8d6rDd2rdDl5/VsBb/ip/kaAkf009l7kpMsYc4tEiGC3oaj0LvfFqbUZarHv
         x0kYJJpgJg4U5tFre2Ywsu4KeVfq/Eh/n4WT5czVCuuPL058ot57W6djC8vYh7UcuN0F
         njKdZhOyMEZNR3/Rgf44dghtZGKQyxovkFqYzYTqrww3FrwgHO04+++M46kAnNQ5l6Fv
         iUFfn7zSQGrQ1nhiQYHlZ4rQXPVGDaFmZrPyJUNx7zOfU2qjukhI8eQHUefeMZigScPn
         LjHPonOmphxJg3xHUgpFKhhyb3x2V6eYMiJFNKmYF4VyR/cStFYyyGxdaDFzwZ2CzaXt
         g0hQ==
X-Gm-Message-State: AOAM531vJ4slBU9ar2Vjx08FbqLYNSLz58TLydRR3DHOU66HK9tb/UCZ
        sdWpscawSCTgKoqNkPcjYQ==
X-Google-Smtp-Source: ABdhPJyHBGnuJ/5vuGOuv0i3duGQMinOQLDQ1LtklPVGYQGE5laVYDQlW52jwpNtGpiJx/BFw7MvVA==
X-Received: by 2002:a05:6808:118f:b0:2d9:a01a:48be with SMTP id j15-20020a056808118f00b002d9a01a48bemr6835145oil.265.1648127915708;
        Thu, 24 Mar 2022 06:18:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d63c8000000b005b235a56831sm1319919otl.49.2022.03.24.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:18:35 -0700 (PDT)
Received: (nullmailer pid 1907796 invoked by uid 1000);
        Thu, 24 Mar 2022 13:18:34 -0000
Date:   Thu, 24 Mar 2022 08:18:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v1 0/2] Add USB HOST OHCI driver for Sunplus SP7021 SoC
Message-ID: <YjxvqoZRV3ZWpZL4@robh.at.kernel.org>
References: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
 <Yjth1mAtn/hX2Xvx@robh.at.kernel.org>
 <CAPvp3RjPW1x-k4oA7QHHXm+QCNySMJLiR5TcqtCK-0geRtrd8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPvp3RjPW1x-k4oA7QHHXm+QCNySMJLiR5TcqtCK-0geRtrd8A@mail.gmail.com>
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

On Thu, Mar 24, 2022 at 06:48:41PM +0800, 施錕鴻 wrote:
> Rob Herring <robh@kernel.org> 於 2022年3月24日 週四 上午2:07寫道：
> >
> > On Mon, Mar 14, 2022 at 01:32:02PM +0800, Vincent Shih wrote:
> > > This is a patch series for USB HOST OHCI driver for Sunplus SP7021 SoC.
> > >
> > > Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> > > many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
> > > etc.) into a single chip. It is designed for industrial control.
> >
> > Looks to me like the generic-ohci binding and driver should work for
> > this?
> >
> The generic-ohci binding and driver did work for Sunplus SP7021.
> And do I need to submit the patch for the ohci driver and binding doc
> for Sunplus
> SP7021 SoC ?

Just need to add the compatible string to the generic-ohci binding. For 
the driver, I don't know, did you have to change anything?

Rob
