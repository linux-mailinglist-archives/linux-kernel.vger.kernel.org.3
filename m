Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADB461E22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbhK2Sc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:32:56 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:65255 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377554AbhK2Sar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:30:47 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id rlN7mrVOWdmYbrlN7mc7pN; Mon, 29 Nov 2021 19:27:26 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 29 Nov 2021 19:27:26 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] bus: mhi: pci_generic: Simplify code and axe the use of a
 deprecated API
To:     Hemant Kumar <hemantk@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr>
 <1625765577.10055.24.camel@codeaurora.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <cd72331c-c3d3-f1e9-e1b2-7572b6cdf0a2@wanadoo.fr>
Date:   Mon, 29 Nov 2021 19:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1625765577.10055.24.camel@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/07/2021 à 19:32, Hemant Kumar a écrit :
> On Thu, 2021-07-08 at 06:30 +0200, Christophe JAILLET wrote:
>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>
>> Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an
>> equivalent
>> and less verbose 'dma_set_mask_and_coherent()' call.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>>     https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
>> ---
> 
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> 

Hi,

Polite reminder.
This is still not part of -next.

The patch is old (July/21), I can resend if needed.

CJ
