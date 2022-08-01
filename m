Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB04A5863E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiHAGND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHAGNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:13:02 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C868E13EA1;
        Sun, 31 Jul 2022 23:13:00 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOfi-00016x-Cv; Mon, 01 Aug 2022 08:12:58 +0200
Message-ID: <af87095f-310e-9aea-94fd-2af06688b2ec@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Subject: [PATCH 0/7] new SoC support and further improvements
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
 <be60acab-7dfe-6841-b176-4bd1e875d52e@birger-koblitz.de>
 <CAFBinCB6bJbK2sx+oyCjo97Sv2=ywnCi_4v+E76f78DYMNqJkg@mail.gmail.com>
 <075b8d68-93e5-93a3-a247-6811152b35d1@birger-koblitz.de>
 <CAFBinCCorAkiBg+ZXOgKtNYfjr6PUmT2mN1OH7Q3SoMkY-yYhw@mail.gmail.com>
From:   Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <CAFBinCCorAkiBg+ZXOgKtNYfjr6PUmT2mN1OH7Q3SoMkY-yYhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334380;a4fe768f;
X-HE-SMSGID: 1oIOfi-00016x-Cv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for the tip on the build environment, so here it comes:
This adds support for the RTL93xx newer generation of Switch SoCs
from Realtek. It adds device flags to describe the difference in
capabilities with respect to the RTL83xx Socs, support for more
than CS#0, parallel IO and SPI bus frequency setting.

Birger Koblitz (7):
   spi: realteak-rtl: Add support for RTL93xx SoCs
   spi: realtek-rtl: set device capability flags
   spi: realtek-rtl: allow use of chip-select other than CS0
   spi: realtek-rtl: add parallel IO suppport
   spi: realtek-rtl: set transfer mode in transfer_one_message()
   spi: realtek-rtl: add support to configure bus speed
   spi: realtek-rtl: update devicetree documentation

  .../bindings/spi/realtek,rtl-spi.yaml         |  10 +
  drivers/spi/spi-realtek-rtl.c                 | 196 ++++++++++++++----
  2 files changed, 162 insertions(+), 44 deletions(-)

-- 
2.25.1
