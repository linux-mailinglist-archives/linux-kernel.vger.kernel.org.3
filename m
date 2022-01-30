Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24C4A355D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354470AbiA3Jaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:30:35 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:41206 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354461AbiA3Jaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:30:30 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 1737A20C475F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: linux-next: Fixes tag needs some work in the edac tree
To:     Borislav Petkov <bp@alien8.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220130103712.391407a7@canb.auug.org.au>
 <YfXW6+1hTVVTodeI@zn.tnic>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3b00d41c-b25a-fc5b-c1b7-b3cdbc5e5bba@omp.ru>
Date:   Sun, 30 Jan 2022 12:30:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YfXW6+1hTVVTodeI@zn.tnic>
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

On 1/30/22 3:08 AM, Borislav Petkov wrote:

>> Fixes tag
>>
>>   Fixes: 0d4429301c4 ("EDAC: Add APM X-Gene SoC EDAC driver")
>     Fixes: 0d4429301c4a ("EDAC: Add APM X-Gene SoC EDAC driver")
> 
> 
> Somebody ate the trailing 'a'. Fixed.

   Oops, that was me, :-/ TY! :-)

> 
> Thx.

MBR, Sergey
