Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECF1497345
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiAWQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:53:36 -0500
Received: from m228-6.mailgun.net ([159.135.228.6]:50887 "EHLO
        m228-6.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbiAWQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:53:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1642956814; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=IHqd7yX1XGLLOu24CAliRnIh4Fy6X/3R/a7MUMsmKr8=; b=Yx2elFfEhNDd4sz+huIEXMySE0x4XHgOHg9q1kKo/EaSzgGK4j8gCRO91VZKargoay0XPngU
 YmQje69X27/O546uoPF5zQNtm6KpP8MC/jdTPYXjYFliGn032r2mIdsT+EaDIPkpEMd5X4tb
 t49bOaB4YNDJcraoRpRVrEGz5K8=
X-Mailgun-Sending-Ip: 159.135.228.6
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61ed880d7e1ee9b1c1ae3a18 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sun, 23 Jan 2022 16:53:33 GMT
Sender: michael@michaelkloos.com
Received: from [192.168.0.104] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id AD4AC40249;
        Sun, 23 Jan 2022 16:53:31 +0000 (UTC)
Message-ID: <c184c65e-c960-8ecc-7cfe-d58af1cde0a3@michaelkloos.com>
Date:   Sun, 23 Jan 2022 11:53:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220123034518.3717116-1-michael@michaelkloos.com>
 <fed7ee473044432180c67b4adc0eb45d@AcuMS.aculab.com>
From:   "Michael T. Kloos" <michael@michaelkloos.com>
In-Reply-To: <fed7ee473044432180c67b4adc0eb45d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No.  It only uses tabs.  The previous version used spaces.
Make sure that you are not looking at a line with a '-'.
The only place that spaces, perhaps combined with tabs, appear
at the start of a line in my patch is to align the '*' character
for a multi-line comment.  In this case, tab(s) are followed by
a single space for alignment.  I believe this is correct per
the coding style.  If I am wrong, please let me know.

	----Michael

On 1/23/22 08:31, David Laight wrote:

> From: michael@michaelkloos.com
>> Sent: 23 January 2022 03:45
>>
>> Rewrote the riscv memmove() assembly implementation.  The
>> previous implementation did not check memory alignment and it
>> compared 2 pointers with a signed comparison.  The misaligned
>> memory access would cause the kernel to crash on systems that
>> did not emulate it in firmware and did not support it in hardware.
>> Firmware emulation is slow and may not exist.  Additionally,
>> hardware support may not exist and would likely still run slower
>> than aligned accesses even if it did.  The RISC-V spec does not
>> guarantee that support for misaligned memory accesses will exist.
>> It should not be depended on.
> ...
>
> From the way my email client display the patch I think it is
> using both tabs and spaces for indentation.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
