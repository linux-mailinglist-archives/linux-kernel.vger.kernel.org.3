Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296D34804B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhL0Uzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:55:54 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:50944 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhL0Uzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:55:53 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru DEEC0209F8C5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into
 pata_platform
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VcgknapFkZx5YhNhUgaHKGHBXdeTZ+pBcP_G9wnwfFSnw@mail.gmail.com>
 <a0f90ec0-b49a-de0d-b8f5-0443cb904847@omp.ru>
Organization: Open Mobile Platform
Message-ID: <73042c85-c194-e1c8-296c-6d9322624d83@omp.ru>
Date:   Mon, 27 Dec 2021 23:55:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a0f90ec0-b49a-de0d-b8f5-0443cb904847@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:54 PM, Sergey Shtylyov wrote:

[...]
>> ...
>>
>>> +       if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
>>> +               dev_err(&pdev->dev, "invalid number of resources\n");
>>> +               return -EINVAL;
>>
>> return dev_err_probe(); ?
>>
>>> +       }
>>
>> ...
>>
>>> +       if (!dev_of_node(&pdev->dev))
>>> +               ret = pata_platform_get_pdata(pdev, priv);
>>> +       else
>>> +               ret = pata_of_platform_get_pdata(pdev, priv);
>>
>> What the difference between them?
> 
>    One parses DT props into the private structure, the other inits this structure without DT...
> 
>> Can't you unify them and leave only
>> DT related part separately?
> 
>    He can't -- grep *defconfig for PATA_PLATFORM=, please.

   I take it back -- I think I misunderstood. :-)

> [...]

MBR, Sergey
