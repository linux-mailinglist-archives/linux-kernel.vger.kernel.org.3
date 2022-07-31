Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337C458614F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiGaUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGaUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:24:38 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74F1208A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:24:37 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id IFUIo1NhHvbzbIFUIocT7q; Sun, 31 Jul 2022 22:24:35 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 22:24:35 +0200
X-ME-IP: 90.11.190.129
Message-ID: <c7a0251b-403b-37b4-6b17-5e5e2b7c318a@wanadoo.fr>
Date:   Sun, 31 Jul 2022 22:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/10] mfd: intel_soc_pmic_crc: Merge Intel PMIC core
 to crc
Content-Language: fr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
 <20220731201258.11262-2-andriy.shevchenko@linux.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220731201258.11262-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/07/2022 à 22:12, Andy Shevchenko a écrit :
> The core part is misleading since its only purpose to serve Crystal Cove PMIC,
> although for couple of different platforms. Merge core part into crc one.
> 
> Advantages among others are:
> - speed up a compilation and build
> - decreasing the code base
> - reducing noise in the namespace by making some data static and const
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2: added tags and rebased on top of new patch 1
> 
>   drivers/mfd/Makefile              |   3 +-
>   drivers/mfd/intel_soc_pmic_core.h |  25 -----
>   drivers/mfd/intel_soc_pmic_crc.c  | 163 ++++++++++++++++++++++++++++--
>   3 files changed, 158 insertions(+), 33 deletions(-)
>   delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> 

Hi,

in v1, there was a:
    drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
    delete mode 100644 drivers/mfd/intel_soc_pmic_core.c

Is it expected not to have it in v2?

CJ
