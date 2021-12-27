Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6048049E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhL0UjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:39:01 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:41600 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhL0UjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:39:00 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru D8058209FA26
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 08/10] ata: pata_platform: Drop validating
 num_resources count
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e2e26aae-9e8d-6c91-b6d5-47ba74e7d0c2@omp.ru>
Date:   Mon, 27 Dec 2021 23:38:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211224131300.18198-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, this ended up in my spam folder... :-(

On 12/24/21 4:12 PM, Lad Prabhakar wrote:

> Drop validating num_resources count as pata_platform_get_resources()
> already does this check for us.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]

   Good patch but should have been placed before patch #7...

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
