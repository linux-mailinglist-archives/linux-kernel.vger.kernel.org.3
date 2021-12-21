Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8D47C6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbhLUSpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:45:02 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:43164 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhLUSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:45:01 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7A54420595A8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 4/4] ata: pata_platform: Make use of GENMASK() macro
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221162614.25308-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <ec21f060-beb6-04db-ccb2-b7e1dfc0a696@omp.ru>
Date:   Tue, 21 Dec 2021 21:44:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211221162614.25308-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 7:26 PM, Lad Prabhakar wrote:

> Make use of GENMASK() macro instead of open coding.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
