Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E55A0F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiHYLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiHYLnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:43:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2B9A9B6;
        Thu, 25 Aug 2022 04:43:06 -0700 (PDT)
Date:   Thu, 25 Aug 2022 13:43:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661427784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8RS0b6uyw+ZbGUJeFZ495BAO8+GBnEEn0vAVb6oeWI=;
        b=t+Lnv6col5ktvcFKUdThUK9WpkN3x6Vp0eUmO5UMlScJYJoE8uFIjRA3KHmByzGNfhor0g
        m3lflpRkL/2P/Gk7qyEm1C7mYBORim6c05rdEWnNY+a/I6Zv3MILr9ncEusKGSVdWG9TKW
        yFP7/epDWHMqQ16ZOV50Cjdqldd+QwKZ679X1yzDcEp26zpyHPZ0UxER7BKmW98dYtyx3q
        Bos/JmG94iHegmwRpeqH/sUlfBkLdjONKT2zYte8cV7j7Fg09RlhpXyY9lSGUjKTFV9tJJ
        W/3CYTU/pIJiB2OnWh77N+RhxzlS+Q/FnNrF6ADjWgTpZ6yYXTEgQfoOpN5iqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661427784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8RS0b6uyw+ZbGUJeFZ495BAO8+GBnEEn0vAVb6oeWI=;
        b=qnpNC8a0/S0yzChyZ2Ul7tZLcyI/uUtstDu1ehWbq2ypJ3450cPrBnH+1X59bhj2kC57Ep
        1hgrhFa3nRsXnjCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RESEND PATCH] Documentation: ABI: Mention retbleed
 vulnerability info file for sysfs
Message-ID: <YwdgRyfoLDPCbemf@linutronix.de>
References: <20220801091529.325327-1-carnil@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801091529.325327-1-carnil@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 11:15:30 [+0200], Salvatore Bonaccorso wrote:
> While reporting for the AMD retbleed vulnerability was added in
> 6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability") the new
> sysfs file was not mentioned so far in the ABI documentation for
> sysfs-devices-system-cpu.

Borislav, could you please merge this one?

> Fixes: 6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability")
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index bcc974d276dc..3cda940108f6 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -527,6 +527,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
>  		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
>  		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
> +		/sys/devices/system/cpu/vulnerabilities/retbleed
>  Date:		January 2018
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:	Information about CPU vulnerabilities

Sebastian
