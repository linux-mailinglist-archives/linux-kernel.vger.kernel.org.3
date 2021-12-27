Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFADD4804B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhL0UyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:54:05 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:50258 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhL0UyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:54:04 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7A9C120A4740
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into
 pata_platform
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
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a0f90ec0-b49a-de0d-b8f5-0443cb904847@omp.ru>
Date:   Mon, 27 Dec 2021 23:54:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcgknapFkZx5YhNhUgaHKGHBXdeTZ+pBcP_G9wnwfFSnw@mail.gmail.com>
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

On 12/25/21 8:16 PM, Andy Shevchenko wrote:

[...]
> ...
> 
>> +       if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
>> +               dev_err(&pdev->dev, "invalid number of resources\n");
>> +               return -EINVAL;
> 
> return dev_err_probe(); ?
> 
>> +       }
> 
> ...
> 
>> +       if (!dev_of_node(&pdev->dev))
>> +               ret = pata_platform_get_pdata(pdev, priv);
>> +       else
>> +               ret = pata_of_platform_get_pdata(pdev, priv);
> 
> What the difference between them?

   One parses DT props into the private structure, the other inits this structure without DT...

> Can't you unify them and leave only
> DT related part separately?

   He can't -- grep *defconfig for PATA_PLATFORM=, please.

[...]

MBR, Sergey
