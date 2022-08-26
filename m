Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30DD5A2DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbiHZSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiHZSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:03:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D99D13C;
        Fri, 26 Aug 2022 11:03:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so2947044lfg.10;
        Fri, 26 Aug 2022 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nN6w6sWQ+M9O3+SbU/L9UQPJ6uhDVHY44yRSnhXBG2Q=;
        b=Zjcw2tEC7LCiCHeV9kInMVYMRpmy9FO40aLz7vstZ8VBdbHoWrY8VbN+grSflt4dt0
         vpt/oW/a57hcgZD6dD9zCxw7sMDThJkaTtBP9PR80z40B7LPGoLviZDDV0SW8OMzagTr
         QxUkoSMgkWMsUZoO8eEEHGu8QROsLF4QqFO3xCldYhya2drghTmwshfm7cMkV49KfKP/
         vltjWUEY/O48ijdLXiRgtH1t0CcP3HIrAK8dngL06VvAB7d/pR7N1wohyuRbTP1IB7/O
         NoJBL5IV3PRWUP+lFc6zx8Km85H0uDBid07u3vIfjcC/GORkMbxC5oIllQ2Ptd6bW6vO
         0weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nN6w6sWQ+M9O3+SbU/L9UQPJ6uhDVHY44yRSnhXBG2Q=;
        b=mKixcI91A4kNV2S5WjisdWVU6qrOrukw8bXro5p+kdVNiy+8pyz5B+slTXdCfZetg9
         2kGD9WQl5Ys9r+taxGnwTqzgCm/7r9CfVBHIolA5b5YNAfVK1U3B5haW1FgL1/Eop1QI
         jphCjKRR+6uh7qpSdrIjJsGY8wZ4w2kpoRt13dnm4527nPONcklu4pt5BKdgqE/mR1cM
         nkjZLr7+R63Dh9De49UM7asvrWcNoTOLWcPPv7RM52J6zhPw+v+cNUZx/yzZmLDOg3rk
         SZbtLLDT33sbXtHGiqkTWAZ0zBwTw84L9uSU1fkhfcsAvunJncRITwr10Kd21QIcW4T7
         o6sA==
X-Gm-Message-State: ACgBeo0o/oQF0o/GcvfwTCaHOn9kPTWpfJqa8VPtKUWnID0lgC/GDMJI
        B+qnSJRHpxKdMTGTtfRc4IE=
X-Google-Smtp-Source: AA6agR72FDX83CKrMH1ppMdJEGUa7hjVbvDIDtWig2tmOQcmWnVFTMlWLKO6CWjN64R3I+BNEm/x/w==
X-Received: by 2002:a05:6512:131f:b0:494:5d2f:c34b with SMTP id x31-20020a056512131f00b004945d2fc34bmr34433lfu.324.1661537010406;
        Fri, 26 Aug 2022 11:03:30 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id be18-20020a05651c171200b0025e41bbf225sm534412ljb.39.2022.08.26.11.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:03:29 -0700 (PDT)
Date:   Fri, 26 Aug 2022 21:03:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 00/11] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20220826180327.yazfoydjiyygd7qf@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudip

On Tue, Aug 02, 2022 at 06:57:44PM +0100, Sudip Mukherjee wrote:
> Some Synopsys SSI controllers support enhanced SPI which includes
> Dual mode, Quad mode and Octal mode. DWC_ssi includes clock stretching
> feature in enhanced SPI modes which can be used to prevent FIFO underflow
> and overflow conditions while transmitting or receiving the data respectively.
> This is only tested on controller version 1.03a.

Thank you very much the patchset. As I already said adding new
controller features support is always welcome. Yet there are some
things which need to be fixed before the series would be fully
suitable to be merged in into the kernel. Here is a short summary
of ones:

1. The eSPI capability isn't specific for the DW AHB SSI controller
only. It can be found on the DW APB SSI controllers of v4.x and newer
(though the SPI_FRF field is placed at different offset in CTRL0 CSR).
Thus your patches will need to be fixed so the in-driver infrastructure
would imply that.

2. The mem ops check procedure provided by you doesn't verify whether
the passed cmd, address and dummy data lengths meet the controller
constraints or at least the constraints set by your code. You always
expect the address and command being 4 and 1 bytes long, which is way
not always true. So the implementation provided by you just won't
correctly work for the unsupported cases with no any error returned.

3. From what I see WAIT_CYCLES is specific for the Read-operations
only (see the controller HW manual, the paragraphs like "Write
Operation in Enhanced SPI Modes" or the SPI_CTRL0.WAIT_CYCLES field
description). So any dummy-bytes requested for the Tx operations just
won't be sent. Even though AFAICS the dummy cycles are specific for
the Read SPI NAND/NOR operations it still would be correct to
explicitly refuse the non-Rx transactions with non-zero dummy data
length.

4. I don't really see a reason of adding the address, command and
dummy data length constraints. You can as easily update the
command/address/dummy lengths passed in the SPI mem-op structure
thus providing wider SPI memory devices range support.

5. The main problem I can see in your implementation is that you try
to assimilate the eSPI feature for the current DW SSI EEPROM
read/write infrastructure. Note the SPI MEM ops currently available in
the driver have been specifically created for the platforms with the
native CS'es used to access the EEPROM devices. For such cases I had to
use some not that nice solutions like IRQ-less transfers, local IRQs
disabling and the outbound data collection in a single buffer in order
to bypass the nasty DW SSI controller peculiarities. All of that isn't
required in your case. You can implement a very nice and robust
algorithm.

6. You said your controller supports the clock stretching on Tx and Rx
transfers. This is a very useful feature which can be used to bypass
the main DW SSI controller problem connected with the native CS
auto-toggling when the Tx FIFO gets empty or data loose due to the Rx
FIFO overruns. Thus you won't need to always keep up with the Tx/Rx
FIFO levels and implement the IRQ-based SPI MEM transfers.

7. You unconditionally enable the eSPI support for the generic device
snps,dwc-ssi-1.03a while this is an optional feature which yet can be
disabled for any new controllers (see the SSI_SPI_MODE IP-core
synthesize parameter). What you really need is to simply auto-detect
the eSPI feature availability by checking whether the SPI_FRF field is
writable for the DW APB SSI v4.0a and newer and for any DWC AHB SSI.

8. There is no need in the IP-core version added to the compatible
string because it can be retrieved from the SSI_VERSION_ID CSR. I
would suggest to add a new generic compatible string "snps,dw-ahb-ssi"
for the DW AHB SSI controllers and forget about the compatible strings
versioning.

9. Always study the driver coding convention before updating. In this
particular case should you need to add new methods, macros, etc please
add the vendor-specific prefix as is done for the rest of the driver
entities.

I've deliberately collected all the generic comments here so you'd be
aware of the required changes in total, because I very much doubt all
of them could be fixed at once via a single patchset iteration. But as
soon as all of them are fixed we'll get a very nice and neat solution
for the eSPI feature.

I'll give you some more detailed comments right in the corresponding
patches, but they won't cover all the issues noted above on this
patchset iteration. So feel free to update your series based on your
understanding of the issues (you can ask me if you don't fully get
what I said above). It may reduce the number of the further series
re-submissions.

-Sergey

> 
> Ben Dooks (1):
>   spi: dw-apb-ssi: add generic 1.03a version
> 
> Sudip Mukherjee (10):
>   spi: dw: define capability for enhanced spi
>   spi: dw: add check for support of dual/quad/octal
>   spi: dw: define spi_frf for dual/quad/octal modes
>   spi: dw: use TMOD_RO to read in enhanced spi modes
>   spi: dw: define SPI_CTRLR0 register and its fields
>   spi: dw: update SPI_CTRLR0 register
>   spi: dw: update NDF while writing in enhanced spi mode
>   spi: dw: update buffer for enhanced spi mode
>   spi: dw: prepare the transfer routine for enhanced mode
>   spi: dw: initialize dwc-ssi-1.03a controller
> 
>  .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
>  drivers/spi/spi-dw-core.c                     | 288 ++++++++++++++++--
>  drivers/spi/spi-dw-mmio.c                     |  10 +
>  drivers/spi/spi-dw.h                          |  19 ++
>  4 files changed, 291 insertions(+), 27 deletions(-)
> 
> -- 
> 2.30.2
> 
