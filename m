Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1B4807D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 10:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhL1JdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 04:33:24 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:45716 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhL1JdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 04:33:22 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7FF2B20EBC84
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <a582a93f-0176-1500-5113-2330948cda39@omp.ru>
Date:   Tue, 28 Dec 2021 12:33:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 04/10] ata: pata_platform: Use
 platform_get_irq_optional() to get the interrupt
Content-Language: en-US
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <25bf8893-7369-954e-bd5b-f3d592af5b09@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <25bf8893-7369-954e-bd5b-f3d592af5b09@omp.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.12.2021 22:58, Sergey Shtylyov wrote:

>> To be consistent with pata_of_platform driver use
>> platform_get_irq_optional() instead of
>> platform_get_resource(pdev, IORESOURCE_IRQ, 0).
> 
>     But why can't we be consistent with the unpatched pata_of_platfrom(), and then

    Sorry, pata_of_platform.

> convert to platform_get_irq_optional() after merging both drivers?
>     I'd like to avoid patching the driver to be gone if possible...
> 
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> [...]

MBR, Sergey
