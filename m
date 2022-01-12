Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CA48BF64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351328AbiALH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:59:19 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:38094 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351315AbiALH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:59:16 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n7YXC-000AUV-IM; Wed, 12 Jan 2022 07:59:10 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1n7YX9-00BnrE-Mh; Wed, 12 Jan 2022 07:59:05 +0000
Subject: Re: [PATCH] um: add generated capflags.c to gitignore
To:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220111222353.1501350-1-benjamin.beichler@uni-rostock.de>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4ae59d27-6778-0376-58db-a67899ac125d@cambridgegreys.com>
Date:   Wed, 12 Jan 2022 07:59:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111222353.1501350-1-benjamin.beichler@uni-rostock.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2022 22:23, Benjamin Beichler wrote:
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   arch/um/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/.gitignore b/arch/um/.gitignore
> index 6323e5571887..8168b3bc08b8 100644
> --- a/arch/um/.gitignore
> +++ b/arch/um/.gitignore
> @@ -2,3 +2,4 @@
>   kernel/config.c
>   kernel/config.tmp
>   kernel/vmlinux.lds
> +capflags.c
> \ No newline at end of file
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
