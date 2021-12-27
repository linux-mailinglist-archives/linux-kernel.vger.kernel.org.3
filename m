Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72303480477
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhL0UDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:03:32 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:49958 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhL0UDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:03:31 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1AAB6209D13C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 05/10] ata: pata_platform: Drop checking IRQ number
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2b19d991-bcf5-eb3e-0956-56b46b0790c5@omp.ru>
Date:   Mon, 27 Dec 2021 23:03:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211224131300.18198-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/21 4:12 PM, Lad Prabhakar wrote:

> The callers of __pata_platform_probe() will pass the IRQ resource only for
> valid IRQ's, for invalid IRQ's the IRQ resource will always be NULL. So
> drop checking the IRQ number.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
