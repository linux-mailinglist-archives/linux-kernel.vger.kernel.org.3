Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429DB48A376
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbiAJXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:12:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38248 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbiAJXMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:12:50 -0500
Received: from [192.168.86.154] (unknown [50.47.106.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9D96D20B7179;
        Mon, 10 Jan 2022 15:12:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D96D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641856369;
        bh=z/9FTLNoZVswH0nLcNsLvXoVzVtyCU6mfWv83MGOF/w=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=tAALtaT2G0xnI5uvuenj+mgt+hpQvIbhfnqYT0rwZgFvJHNIW95Yx1OVPYKang1Jq
         L8OL40x15LSwlRNoocuBrsESjURDUzBsdGCVMp5JHz+GXpFBfQjEBCUCgVR8MxCjtj
         kyVw8mynfsegYFQLoURhrjMG1s42voHrHxTwTmlU=
Message-ID: <57513f5f-1e66-3758-a56b-1eced486a4df@linux.microsoft.com>
Date:   Mon, 10 Jan 2022 15:12:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25q512jvm
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220109044418.4657-1-dphadke@linux.microsoft.com>
 <262a03e185c29583450180e3dc8c4e6c@walle.cc>
Content-Language: en-US
In-Reply-To: <262a03e185c29583450180e3dc8c4e6c@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/2022 7:10 AM, Michael Walle wrote:
>
>> +    { "w25q512jvm", INFO(0xef7020, 0, 64 * 1024, 1024),
> 
> OTP_INFO(256, 3, 0x1000, 0x1000)
> 
> should enable OTP support, could you please test this using the 
> flash_otp_{dump,info,erase,write} tools and add that line?

The board I've has HW filter between controller and NOR and doesn't seem 
to allow security reg access opcodes (read to be specific).

So long as adding this doesn't affect probe, I can add it. Otherwise, 
will have to leave it for later when that's fixed.


On 1/9/2022 9:07 PM, Pratyush Yadav wrote:
>
> You need to show the dumps of the SFDP and other flash parameters. See
> [0] for an example.
>
> The patch looks fine to me otherwise.
>

Lemme collect SFDP dump and include it in v2.
I ended up sending stale patch that has extra comma between INFO() 
PARSE_SFDP macros, so need to re-spin anyway.

Thanks,
Dhananjay
