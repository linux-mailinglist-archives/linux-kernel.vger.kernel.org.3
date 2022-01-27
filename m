Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6749DE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiA0Jh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:37:26 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:36066 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiA0JhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:37:24 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru A25B822F1A03
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Zhou Qingyang <zhou1615@umn.edu>
CC:     <kjlu@umn.edu>, Alexander Shiyan <shc_work@mail.ru>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220124164525.53068-1-zhou1615@umn.edu>
 <578d6a7e-1488-43b9-9bfe-9c99c88da4fd@omp.ru>
 <f7262bda-8669-3910-9e8c-e72a68eb3325@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <90db4107-18a3-6324-1425-b7c24c399154@omp.ru>
Date:   Thu, 27 Jan 2022 12:37:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f7262bda-8669-3910-9e8c-e72a68eb3325@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/27/22 5:15 AM, Damien Le Moal wrote:

>>> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
>>> there is a dereference of it right after that, which could introduce a
>>> NULL pointer dereference bug.
>>>
>>> Fix this by adding a NULL check of ap->ops.
>>>
>>> This bug was found by a static analyzer.
>>>
>>> Builds with 'make allyesconfig' show no new warnings,
>>> and our static analyzer no longer warns about this code.
>>>
>>> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
>>> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> Please see my note about the typo in the fix. I kept you RB tag. Let me

   Oops, didn't expect such a stupid bug, so my brain did add the missing ! prolly... :-)
Not clear how he managed to shut up his static analyzer with this patch...

> know if that is OK.

   Of course, sorry for the messy review! :-)

>> [...]

MBR, Sergey
