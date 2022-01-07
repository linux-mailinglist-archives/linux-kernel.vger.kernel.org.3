Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3AA487C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiAGSVD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jan 2022 13:21:03 -0500
Received: from aposti.net ([89.234.176.197]:55030 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240599AbiAGSVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:21:01 -0500
Date:   Fri, 07 Jan 2022 18:20:44 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/6] DEV_PM_OPS macros rework v3
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org
Message-Id: <KYQC5R.1KGGF7OLTKZV3@crapouillou.net>
In-Reply-To: <20220107181723.54392-1-paul@crapouillou.net>
References: <20220107181723.54392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven., janv. 7 2022 at 18:17:17 +0000, Paul Cercueil 
<paul@crapouillou.net> a écrit :
> Hi,
> 
> A V2 of my patchset that tweaks a bit the *_DEV_PM_OPS() macros that
> were introduced recently.

I meant V3 here. Bad copy-paste.

-Paul


