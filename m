Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C0479B29
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhLROIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:08:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48259 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhLROIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:08:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EB4CE5C00B5;
        Sat, 18 Dec 2021 09:08:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 18 Dec 2021 09:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=y
        G8E8NafU5nFfy3ppS+9sVq5TWWnS/0M4pY+VrrpzF4=; b=VcsMVtoFnsKXCdUFu
        VOgN0gHbj8AYPRWn68vBjW6RFnhTHUoyy1jNboHZE3vN4zZmoZicF3JVPoZpHI6h
        KSZTqFZSXaBK6WF1J/hfVPwAqMs6kW9F34Suf9YRBjcHCsx2RoEcwcex/9cno1If
        ZTG4kvtAhH+jFmqMWTEqypK4fmDXFZXKHnHENNXsb/Jhc6Z8bzdciTF7Ml3pu9f8
        rAvX7mqChwQMyCRlytjfkU0neTewIIjqvdAEAt92xX5SagJzSpsij+jnWwtnxq0T
        k4CBAw5dnICPtirpHApqWslrkvPwH2Dr/CXBFH48ROHUMDO3F/dlDYDR8BDBExSd
        gJb5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=yG8E8NafU5nFfy3ppS+9sVq5TWWnS/0M4pY+Vrrpz
        F4=; b=CjD+CcfCEWvNzE6BIrdPXXqh/OLjKPyT4gKX3KC6S9V79FyURipl1yDLe
        nnzBi5TkhtRnRZ7iVXyLqmNC1c1UrFvQjGEp+20aCEUFAnb33sSn9cq0MLoRVSE7
        Z1ybnUfFAs5w4arKa+XzcTHkLKpD19tn5zCvTxd267075XKQl2rH6ThTjhjYPjm3
        duZEDzUbMpGu/ncbmKKYFon/Bn9d8FeSh1ZHGspendA+xL58GqgiKmPzCsfyZcvY
        LO9Ik/xjHPgVyvXpSuT3XjZdszAlH3oCy81MIyIUulmSkPMRWq6eJ5wA9d4ppzkb
        derCRkdcW0anVcfACVt3GrefiwItA==
X-ME-Sender: <xms:TOu9YVkEtO-lifxOCEQmSR5yBdYFnROU3OGNvnztWaQcC8TUnNWzQw>
    <xme:TOu9YQ3sj0OcisxVGEqfZL_PWP5dlQmM_2vG4zEu6jP0cqnge-Rmr3McsWVjkJjVl
    5GBKVZZGdQRUtZiqJQ>
X-ME-Received: <xmr:TOu9YbqHt-t_RtqfvWH4MhbZwZjs1C2phvLydLROMRChw5SmniNcDNUQcd2FfPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleekgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:TOu9YVlScfH0jXOfjDh1HVPROtenM-Nlkkzl4K9L_Ypt3xdPSzXwtw>
    <xmx:TOu9YT3Ki_GDwrnQF4HkGivb_pFtMUsw45YmOBBBEPTcaOCcLxb8yg>
    <xmx:TOu9YUuGWkfe_0SUBF0T68PxS_E3iuwSLfQEQSx39-at5ah6DAy0zA>
    <xmx:TOu9YUxKk09vpYgG3JX6t1vzZAKns-GoD0Gc544tHLt-chgbw5Sp4A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Dec 2021 09:08:11 -0500 (EST)
Message-ID: <a04357b6-c762-ebbe-e983-ee2890b97be9@flygoat.com>
Date:   Sat, 18 Dec 2021 14:08:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 2/3] MIPS: signal: Return immediately if call fails
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
 <1639797789-3001-3-git-send-email-yangtiezhu@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <1639797789-3001-3-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/18 3:23, Tiezhu Yang 写道:
> When debug sigaltstack(), copy_siginfo_to_user() fails first in
> setup_rt_frame() if the alternate signal stack is too small, so
> it should return immediately if call fails, no need to call the
> following functions.

Hi Tiezhu,

Thanks for your patch.
If we are doing so I see no reason for keeping the err variable.
Just

if (copy_siginfo_to_user(&frame->rs_info, &ksig->info))
     return -EFAULT;

seems much more clear.

Thanks.

- Jiaxun

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/mips/kernel/signal.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index c1632e8..4cd3969 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -761,15 +761,28 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
>   		return -EFAULT;
>   
>   	/* Create siginfo.  */
> -	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
> +	err = copy_siginfo_to_user(&frame->rs_info, &ksig->info);
> +	if (err)
> +		return -EFAULT;
>   
>   	/* Create the ucontext.	 */
> -	err |= __put_user(0, &frame->rs_uc.uc_flags);
> -	err |= __put_user(NULL, &frame->rs_uc.uc_link);
> -	err |= __save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
> -	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
> -	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
> +	err = __put_user(0, &frame->rs_uc.uc_flags);
> +	if (err)
> +		return -EFAULT;
> +
> +	err = __put_user(NULL, &frame->rs_uc.uc_link);
> +	if (err)
> +		return -EFAULT;
> +
> +	err = __save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
> +	if (err)
> +		return -EFAULT;
> +
> +	err = setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
> +	if (err)
> +		return -EFAULT;
>   
> +	err = __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
>   	if (err)
>   		return -EFAULT;
>   

