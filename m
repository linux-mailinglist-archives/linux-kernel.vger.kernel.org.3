Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65509490916
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiAQM6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:58:46 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:56590 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiAQM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m5kIBOoiXpb3N+lgSWcHZRw+Kr+bgXJDOWmyyH88Lp0=; b=SrRagzFyGX+P+2zxwfDSs3RDzz
        NbBYSRB0agzrnS+5ejdNFQr9UveEZQssybBF4ooPSJnBgGZ3JQ8UmyV6u4zaTIO/gS/KIAoCpv0Ob
        VJX1fLCmzMVnpg5I0NsqL8TSm1oE6+YDKzzzk+LwE7VY/+FP3jyNuIdXXLgE/Coe0pAC4rXEsvyzM
        CsNo7EtIyuC7agvfulou6SMbhym1V2NxDepnjJC+efEFRqNWQtiB19HMJ+n9DZisVHkL1SDzt9unY
        Dh4c9pd7jr+Nm7qhjdmf2UoM3AtHCaAUjKLyxv3lMmVQtfXIYxGEgRjY1iBbfLeD38lDaYadV4NXW
        7Rd58jUQ==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n9Raq-0003xP-ER; Mon, 17 Jan 2022 13:58:41 +0100
Message-ID: <5c52f546-a821-6195-b531-8251f108f587@igalia.com>
Date:   Mon, 17 Jan 2022 09:58:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pmladek@suse.com, kernel@gpiccoli.net, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        feng.tang@intel.com, kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220117033344.GA2523@MiWiFi-R3L-srv> <20220117061315.GF2388@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220117061315.GF2388@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 03:13, Baoquan He wrote:
> [...]
>>
>> Patch can'e be applied on the latest code of linus's tree, can you tell
>> which branch your code are based on?
> 
> OK, this is based on linux-next, I will apply this patch on the
> linux-next/master and have a look.
> 

Indeed, I'm sorry for that - should have mentioned, but I forgot in the V3.
It's based on linux-next because it's on top of some patches there - if
I base in Linus tree, it wouldn't work on -next heh

Thanks in advance for the reviews/test =)
Cheers,


Guilherme
