Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8248843E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiAHPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:36:52 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:38980 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAHPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ksDx2/aVzsr3FZhZnXzgOkQqcI19EivKVZQ8aUre55w=; b=LQiRs/gXSiRJj7ddoJiPntEh8r
        n4VPIxVypb3caWg6MKPZNSUR38kjB+DZtqaZran0xuF41kCQbVnT43i8eoDvZ7TmpTORFP416Qxr1
        IEMdUUqJrwgzfxS4LaQfifCMeTGVJKtDaEufXSgOazSo6vlGNm+pmTwIGjujAyjR8QmGP6eB92cB1
        sIzcfJA2EKMDdjooXoagR98G1DYPcfz4cF7Ye9h42sB8TmGhlTrZ8OS7zzuvin356OLokjPFdZ4vC
        qDIOpa664OjcLUYOilD91yG0jdIF/e1BXOu9dBSsqvCv36hGbyF7WC6R22bQSCJ5aA924GL88v9Vq
        Mz17mcjg==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n6Dlw-0005wP-Ip; Sat, 08 Jan 2022 16:36:48 +0100
Message-ID: <c2923957-9719-ef23-802a-24765ead7630@igalia.com>
Date:   Sat, 8 Jan 2022 12:36:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
References: <20220107191233.172644-1-gpiccoli@igalia.com>
 <CAHp75Vf8SisR16tK=hwiF9ET0PoQRcu1h5LCZHZAGX8M3KysRA@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAHp75Vf8SisR16tK=hwiF9ET0PoQRcu1h5LCZHZAGX8M3KysRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 20:07, Andy Shevchenko wrote:
> [...] 
>     +       if (!buf)
>     +               return -EINVAL;
> 
> 
> I also implied that you don’t need this condition.
> 
>     +       while ((func = strsep(&buf, ","))) {
>     +               addr = kallsyms_lookup_name(func);
> 
>  
> 
>     +
> 
> 
> Btw, this is redundant blank line.
>  
> 
>     +               if (!addr) {

Thanks Andy, just submitted a V4 that incorporates your suggestions.
Cheers,


Guilherme
