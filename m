Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C117568C18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiGFPBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiGFPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:01:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9F525582;
        Wed,  6 Jul 2022 08:01:27 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqqLB-1nmftE15hx-00muQM; Wed, 06 Jul 2022 17:01:25 +0200
Received: by mail-yb1-f171.google.com with SMTP id l144so15276019ybl.5;
        Wed, 06 Jul 2022 08:01:24 -0700 (PDT)
X-Gm-Message-State: AJIora8bv1HbZ8dyLtCnB5cQEVfh/x9Co6yDXL9jB1rxVkCaM7AsJ5uV
        8rTy6eIcZpJPt8PU+GSiuVKhrmsdWUmbb0tKb5M=
X-Google-Smtp-Source: AGRyM1umUC3WLeZlmJt9WhhCXt632xH5c1TSYZPaema52uTt6F/+nW7yUSNfOjLzvYo07C+MTUQ72TTNkGVtiR4Edpk=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr41195052ybc.480.1657119683920; Wed, 06
 Jul 2022 08:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656396767.git.qinjian@cqplus1.com>
In-Reply-To: <cover.1656396767.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Jul 2022 17:01:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1HoB74TA9EKJFuPLuw_zJfy_p7fwkm0M45+jaGkK6ivA@mail.gmail.com>
Message-ID: <CAK8P3a1HoB74TA9EKJFuPLuw_zJfy_p7fwkm0M45+jaGkK6ivA@mail.gmail.com>
Subject: Re: [PATCH v20 00/11] Add Sunplus SP7021 SoC Support
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ypLhKQ82qJ3Jd9Zbh42IHDFZcSYyv4W4wKiD68YVxyTDj+G2oWi
 WJtV/nmVTW7IyYj7YoHglN+HExwTyakY9j2ZqTDczyTDq9DafsFNneUneB2UjGRSG6HJbc8
 8g9fLK+jM2OCRG6PzbG9jg4j7KJULMx6nbgEXow/hbe1KTfOU71gKZsiInn7x7MBb9HiB6n
 /PufdB4AOiABB6PsUkvjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ls0OqjUPHqA=:l6pWBF+wMOxDPjBsgu3WWM
 UEyCfQt6oNhqvlcalzWBhWkfT9sOtZDEYivnTmSurWI3cqeqUJuXaIgT7dfFb3Ew5l15M1Zr1
 BUHgWel4782FoIT9OzF5qGmUBmqEyXU1SHJ/C43h2J12mEA9xH1pw6cwl8dITSkeCKujkTEHz
 zB6fyfvhXRvbqEqji9xAlLemgboghmUFCPGENJ1bCQkE9ex1qaV/Ghe/dlO9EKGRfWIOqM39y
 HlktMQEjZR2JMFpyv//FROl5EMHJF1wTP1VNUPe/sWYd8LmC9IiumFU6vOvXBbka3WU9/H+hb
 xNULNefr9AhuFRkaDtk7Yy+2sKW+3ZiXtzLUJqre5AiQgDc9kUpnsixz8ynJR+5qOK2e9UfMi
 mPhPjOt2fweDF2Zb8roJRQRyjPvEkUJC8VLJBpKisyXnmuYsi7oFu2MYKMWw/lCjDXCteZMqb
 n1Xye85qrUMpxo7rBFhLtaTjVRWF4bl6AWaDVZD8BwaYm42K5bGvVHo9kFbGaQ+fNrLY0NCZj
 5oTWn1JmiVgLpOOr8qspL8oX58yahYvr+jBGwDNw8UGr6WHNjz3arEaTP/g7kIuFdM2kiTwMn
 UtDzs8RBfyf8ib4HpD/r3UJZS+3j8r+VjzzJFcildIOt0+f0xAZNCOZVg6zgjnwLahabAEfqU
 ZGno9rXVsLAaq3Hhm7ayLoO09J4wRAXHjJ0yi/QuWSwhIdtgoJ2V1xk3a/8rXz4Qpgz7uS95H
 6K9NG/xG2+Y9U7u+QJzkG5ClnLGFi6iKiCnguNQpk19YDHtNRZb2yq/nCQZmzdxkVdij6op1a
 GSDR0RJ2jbpxu/wmY304SbP/I8TRalG8Qz6z2vEvHe7GMy/xkUqqwmfltjrdGb2JudhxXfxBM
 6l0OW4ZENsdSsX7lmykKuBNvO7ZxgOXfgBBOlGyXI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 8:26 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> This patch series add Sunplus SP7021 SoC support.
>
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
> peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
> single chip. It is designed for industrial control.
>
> SP7021 consists of two chips (dies) in a package. One is called C-chip
> (computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
> process (22 nm) for high performance computing. The other is called P-
> chip (peripheral chip). It has many peripherals and an ARM A926 added
> especially for real-time control. P-chip is made for customers. It adopts
> low-level process (ex: 0.11 um) to reduce cost.
>

As far as I can tell, all review comments have been fully addressed,
but I'm missing an Ack from Stephen Boyd so I can apply it through
the SoC tree.

        Arnd
