Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C059F490CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiAQQ6G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jan 2022 11:58:06 -0500
Received: from aposti.net ([89.234.176.197]:56930 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237844AbiAQQ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:58:06 -0500
Date:   Mon, 17 Jan 2022 16:57:52 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/6] DEV_PM_OPS macros rework v3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Message-Id: <GS5V5R.BVK5SB217XZU2@crapouillou.net>
In-Reply-To: <CAJZ5v0htDq+qFhEoV+PLQ9_pOy_xa7+rMoaGtqK7QpEbpUDA+Q@mail.gmail.com>
References: <20220107181723.54392-1-paul@crapouillou.net>
        <IKXS5R.AB16PVIGN8Z9@crapouillou.net>
        <CAJZ5v0htDq+qFhEoV+PLQ9_pOy_xa7+rMoaGtqK7QpEbpUDA+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun., janv. 17 2022 at 14:37:45 +0100, Rafael J. Wysocki 
<rafael@kernel.org> a écrit :
> Hi,
> 
> On Sun, Jan 16, 2022 at 1:05 PM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>>  Hi Rafael,
>> 
>>  Could patches [1/6] and [2/6] make it to 5.17-rc1, or at least -rc2?
> 
> Yes.  I'm going to send a PR with the whole series later today.

Ok, perfect then. I saw my previous PM patches in upstream/master and 
assumed that you already sent your PR.

Cheers,
-Paul

> 
>>  I'm afraid that if these two have to wait for the 5.18 cycle, then 
>> I'll
>>  have more drivers to fix later.
>> 
>>  Should I add a Fixes tag maybe?
> 
> No need, thanks!
> 
>>  Le ven., janv. 7 2022 at 18:17:17 +0000, Paul Cercueil
>>  <paul@crapouillou.net> a écrit :
>>  > Hi,
>>  >
>>  > A V2 of my patchset that tweaks a bit the *_DEV_PM_OPS() macros 
>> that
>>  > were introduced recently.
>>  >
>>  > Changes since V2:
>>  > * [1/6]: - Keep UNIVERSAL_DEV_PM_OPS() macro deprecated
>>  >          - Rework commit message
>>  > * [3/6]: - Reorder the code to have non-private macros together 
>> in the
>>  >            file
>>  >        - Add comment about the necesity to use the new export 
>> macro
>>  >          when the dev_pm_ops has to be exported
>>  > * [5/6]: Add comment about the necesity to use the new export 
>> macro
>>  >          when the dev_pm_ops has to be exported
>>  >
>>  > Cheers,
>>  > -Paul
>>  >
>>  > Paul Cercueil (6):
>>  >   PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
>>  >   PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS 
>> macro
>>  >   PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
>>  >   PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
>>  >   PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
>>  >   iio: pressure: bmp280: Use new PM macros
>>  >
>>  >  drivers/iio/pressure/bmp280-core.c | 11 ++----
>>  >  drivers/iio/pressure/bmp280-i2c.c  |  2 +-
>>  >  drivers/iio/pressure/bmp280-spi.c  |  2 +-
>>  >  drivers/mmc/host/jz4740_mmc.c      |  4 +--
>>  >  drivers/mmc/host/mxcmmc.c          |  2 +-
>>  >  include/linux/pm.h                 | 55
>>  > ++++++++++++++++++++++--------
>>  >  include/linux/pm_runtime.h         | 24 +++++++++++++
>>  >  7 files changed, 71 insertions(+), 29 deletions(-)
>>  >
>>  > --
>>  > 2.34.1
>>  >
>> 
>> 


