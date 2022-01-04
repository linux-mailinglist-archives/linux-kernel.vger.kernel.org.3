Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E70483DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiADIGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:06:48 -0500
Received: from cpanel.siel.si ([46.19.9.99]:47674 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbiADIGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FTIQ58c8Pxh8g1dcpcLQvOwm5QlGAkx3hNLDdb/ITCs=; b=FNEHOKG1RwThn271fMZsoAgDw1
        sZ8tTBwV3kv+AdUaJ9RMUrzhUqfYl+6///vqzpdUtm8to+Lv/nA2GgCUleu0jh97Ers+OntbOx96O
        7nw829HiIDS0E08mwPKmZiJm5JU9Siqx7eXsCRqjgHr/SeqrfaNsLc+AaBS4w5aijqclwkXxilTkZ
        yYy3r7cFHd4VW48BchXtw6D4kNfvna//U03vfUvWH/oBqw1Nc1avXLDU2roMjq8HO50FYHCRlvD0P
        +V2aUVJ95pofF1BzIBYdY1oYU+Xl5hjXO+ngK96qPmWKns6tWVgVnmmlxWm9O3E2FcF4rgRVoxVJ8
        JAZMzXTg==;
Received: from [89.212.21.243] (port=36710 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1n4eq3-008kJ3-6L; Tue, 04 Jan 2022 09:06:42 +0100
Subject: Re: linux-next: Fixes tags need some work in the watchdog tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220104083659.4e5f2754@canb.auug.org.au>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <432b6c61-f8c6-368d-2386-590bed2aee7a@norik.com>
Date:   Tue, 4 Jan 2022 09:06:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104083659.4e5f2754@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 3. 01. 22 22:36, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    02d04e694fa3 ("watchdog: s3c2410: Fix getting the optional clock")
> 
> Fixes tag
> 
>    Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")
> 
> has these problem(s):
> 
>    - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: e249d01b5e8b ("watchdog: s3c2410: Support separate source clock")
> 
> In commit
> 
>    ce3401c72f01 ("watchdog: da9063: Add hard dependency on I2C")
> 
> Fixes tag
> 
>    Fixes: 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
> 
> has these problem(s):
> 
>    - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 968011a291f3 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
> 

Yes, that's probably right for my patch, sorry for that.

I was puzzled on where to get the SHA1 of not-yet applied commit, 
because this patches ("watchdog: da9063: use atomic safe i2c transfer in 
reset handler" and the fix "watchdog: da9063: Add hard dependency on 
I2C") followed quite closely together. Is there any way that I can get 
the SHA1 of the commit that was applied? It should be a part of some 
branch right? I'm asking because I couldn't find a repo or a branch that 
this two commits are a part of.

Anyway should I send a v2, or what is the procedure here?

Thanks,
Andrej
