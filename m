Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656864A8C56
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353731AbiBCTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:17:45 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:48250 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiBCTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:17:44 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 6BCE120A3BE3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] MAINTAINERS: add myself as Renesas R-Car SATA driver
 reviewer
To:     Joe Perches <joe@perches.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>
References: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru>
 <5d0c792dd4aadb2eb68ea23da18e77a7411f59a3.camel@perches.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9794b347-3200-b6b9-e375-c8a3b9824009@omp.ru>
Date:   Thu, 3 Feb 2022 22:17:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5d0c792dd4aadb2eb68ea23da18e77a7411f59a3.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 9:54 PM, Joe Perches wrote:

>> Add myself as a reviewer for the Renesas R-Car SATA driver -- I don't have
>> the hardware anymore (Geert Uytterhoeven does have a lot of hardware!) but
>> I do have the manuals still! :-)
> 
> Thanks.

   Should have done this while still with Cogent (and working on Renesas stuff)
but the patch traffic appeared low enough and I saw the patches flowing by on
linux-ide anyways (if I wasn't the author, that is :-))...

>> --- libata.orig/MAINTAINERS
>> +++ libata/MAINTAINERS
>> @@ -16469,6 +16469,13 @@ F:	Documentation/devicetree/bindings/i2c
>>  F:	drivers/i2c/busses/i2c-rcar.c
>>  F:	drivers/i2c/busses/i2c-sh_mobile.c
>>  
>> +RENESAS R-CAR SATA DRIVER
>> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
>> +L:	linux-ide@vger.kernel.org
>> +L:	linux-renesas-soc@vger.kernel.org
>> +F:	Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
>> +F:	drivers/ata/sata_rcar.c
> 
> I believe it's better for every section to have an S: entry

   Hm, you're right. I'll recast...

MBR, Sergey
