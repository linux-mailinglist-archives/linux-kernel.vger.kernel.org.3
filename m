Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD864D30D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiCIOM6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Mar 2022 09:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiCIOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:12:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6426110DA68
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:11:55 -0800 (PST)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmD2M-1nsB2X2Mca-00i8cC for <linux-kernel@vger.kernel.org>; Wed, 09 Mar
 2022 15:11:53 +0100
Received: by mail-wr1-f50.google.com with SMTP id q14so3280666wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 06:11:53 -0800 (PST)
X-Gm-Message-State: AOAM533qAZRWC7eZH/dJ+qNMuVFxDsxeSwLHEud//OwCh3sYdfLaeAcK
        GK7mZpmBBJyJKZhQqhrrKJgBq/Iyj+3H3JNVRYw=
X-Google-Smtp-Source: ABdhPJyukbMyJP7OGfxJ5RdYzM2rqvv71QZRCKhx1dYuWqZS9QCmtKMvH1ppzhMPiQlz0OnByU2vdAfekrUUoQZiVmA=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr17033731wrh.407.1646835113178; Wed, 09
 Mar 2022 06:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20220309140617.33860-1-yuehaibing@huawei.com>
In-Reply-To: <20220309140617.33860-1-yuehaibing@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Mar 2022 15:11:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UBX2c0-VQtQd885U-=+RHxn_mZzD6ELk-B4cq+09afg@mail.gmail.com>
Message-ID: <CAK8P3a1UBX2c0-VQtQd885U-=+RHxn_mZzD6ELk-B4cq+09afg@mail.gmail.com>
Subject: Re: [PATCH -next] perf/marvell: cn10k Fix build error without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>, bbudiredla@marvell.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:NKcwCgOWzgdESa8AjHHBRCbivUhrktjNokophbXjHQsBt+HAG6S
 /iNmq/x6Tu/v7MQsqvQL31/q7hNPDhzlwRrplGLc7O41LslzwRSZtIlEXmzpcah9XVcElVu
 ws8+sdOTfAAOuzhtVuAW9Vt2Z0lm4ycvE3iMV8hJsOz3tiuP/E7NevMg0XLfyyaV9yVxT/5
 UeLJZmgK88zFjgowuDBQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IR5wEp4kNaQ=:NnI4UNcGTgQYMCb5beL+Zl
 4K7nwZNcOhaY1w2vnz8kHMFpLHLnoINw0Riq/46FKHBWsumQ+ubO4oaFXF9pNx4J8dFv5gbzO
 1dGUPWcaoaDDPO06ZdUKxIthgo7DYgnYSZlpaafl4UAMv/7lcSM7o0Irw/XjwIVUQl2RSIFVK
 8AghSkJCUXPEQvf+DDAa7sDNj5cn9OZfmLfH8r2PPgmxrVXsDZ2wtBN/NLdVNp2dbsOYQF3oP
 /Px5W05cnm23uVn5yD6TSxjVorSOOlQzFcRkAAtH6bFYJVRqMb89OU+0HSyLm2HBIynRfDn9O
 lBeQI95HWVwp3NLVynurX4ZeHsIBYz9Gts9aLilAAEo1Jswer2zMIGji1HzmvjZ7s8lLHT5xG
 6+8VJRjG3oWj5ms2FfdWPSBUTaDqXNPiEf+NvGpYavgG/Ef5ds2EUwCCPpMc+8eiOzjIQ/S1K
 QWXmVfc7uvrIF4T0SNqH0KIYwG4nlHZiuSJuLbuiGR/3RqWKwydvDKHrOVxEpqYr6wNtswR6x
 fMszqhRx836kah8TOtd3Cp/o+WWNUWWkxZba2A45S6ethWGibPxQO4XcJM1hpSPLJfZDQoqZg
 UUYECXTU73+98EgpPN8MGxQtE4jCjR+8VBqHuet+m0W9dKbQjx8YFktyFOYs4qBLFVECFHUoC
 sJaa0y2VHu5wviH0Tv4XXBUY95p3abZYA+KBMh821p1AtQRay7pFT8ShxXt9USl9294w=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 3:06 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
>          .of_match_table = cn10k_ddr_pmu_of_match,
>                            ^~~~~~~~~~~~~~~~~~~~~~
>
> Use of_match_ptr() to fix this.
>
> Fixes: 7cf83e222bce ("perf/marvell: CN10k DDR performance monitor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

It's generally better to remove the #ifdef around the match table
definition instead,
which improves readability, and has no downsides on the machines this actually
runs on, because CONFIG_OF is always enabled on arm64.

      Arnd
