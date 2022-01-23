Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081849763D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiAWXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:03:10 -0500
Received: from m228-4.mailgun.net ([159.135.228.4]:23569 "EHLO
        m228-4.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiAWXDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:03:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1642978989; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=y1h7LZQUH/315cUWgICxYsfKN2rIJtSAVtMI/BEmfGM=; b=TWCkDyCNL4QawHSkxV3RAUPvObE7fJoQiSFST0UbHntP9B3iu5ZQ8RRxTZuXDrulLCAam3Ua
 HwgTXLEBUCMHISH3E5SVRtd+ZLtuPCyeiYYcQ/RnwruZ+Odgz8yS8KHKR43LxU1e/XL2UnD4
 eJ2aMEgRFqk3ZcRF6qGBY1XTwWc=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61eddeac06362278a1d42f32 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sun, 23 Jan 2022 23:03:08 GMT
Sender: michael@michaelkloos.com
Received: from [192.168.0.104] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 0870040118;
        Sun, 23 Jan 2022 23:03:07 +0000 (UTC)
Message-ID: <5dca7098-0986-1e2a-1452-124c506b1241@michaelkloos.com>
Date:   Sun, 23 Jan 2022 18:03:07 -0500
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
 <c184c65e-c960-8ecc-7cfe-d58af1cde0a3@michaelkloos.com>
 <228cbdb42a5c4c2f9d7214d2685fcaeb@AcuMS.aculab.com>
From:   "Michael T. Kloos" <michael@michaelkloos.com>
In-Reply-To: <228cbdb42a5c4c2f9d7214d2685fcaeb@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem.  If you have any other concerns about my patch, please let me know.

	Michael

On 1/23/22 17:35, David Laight wrote:

> From: michael@michaelkloos.com
>> Sent: 23 January 2022 16:54
>>
>> No.  It only uses tabs.  The previous version used spaces.
> Ah, it was the old one that was wrong.
> One of them was.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
