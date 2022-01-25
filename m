Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4686449AD25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442571AbiAYHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442257AbiAYHGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:06:43 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E7C061781
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:47:40 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t9so3363153lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sGwN6/PZ/JlBAeZ5KsZg9fZ+Ao13VjZFxZr+RAWIxdo=;
        b=A09YnLzTaKn9EdmzYmyvMZaiISrRLWuv19XFxtLOw3S6UPh1zv0pIaCbBEM/3ErV+j
         GDk2Nri6Sb1TUOBftHisD5mGt/GxY5QPwBsD5EGcpKkyiGRHPzWUp1TfUfMFs/RVPEj1
         sNs7fDgdxfCiXwyZ/tCvDxjNsIVUdsT57pb9oXfZOXx4k8GH1+ZPo99KV8YtEmf9pMyN
         05KfEPMbzMcsC1HOoai8xnmvR2s83rpAPLDdwh6R0klWgQN6c7bF0hGoNJvgFCfEUOsg
         Ym/pfuCr3lv4S/4NrtcyrqKROVdJkwJKot2LDNOVm1hKm6PRqrJj9Z5WoOSMDCUwV6kr
         +I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sGwN6/PZ/JlBAeZ5KsZg9fZ+Ao13VjZFxZr+RAWIxdo=;
        b=psFZCuC4hItfP12570Yp7joBKlM8TmR/x6Qj7zFgFd4TXDZCgxnrKAbtugYVv3+FxC
         j4dtCLBDu+XPywh2BWNKZIdSNcz1UNq5Ia6GjB/Jo58e3sAESOMnIvyai/ImATbr5+Pa
         LS28/0j+zXZzLCxEd9HAiKhAtGWPYkKrYxrR7QWne5XGEjend5BeeBUb8pBVeZjkqjrd
         mct1l1HN8eXPom+AsiyWrle0GW9zZwbU4uKjf7XD6RHTSoJISrfqlSmu+KXmxdTZl28Y
         2MH7Ooy3ysj6j/M9/hOReu5lGpja6mTeRbYFz3xZMCF6W2S9ZjfCdsBqDA++z1GJDPbL
         BxJg==
X-Gm-Message-State: AOAM533eV/uyGg1PFssn0sR9JS6Crj0fUN9zAxgJvZLAsjtQAwuxZpM+
        6roVCuqt0BB+zwJXI2Gau0vUJA==
X-Google-Smtp-Source: ABdhPJyJchuAfqKxEoZHNfeglu2mhDn/41Om9kU2nisHx2f3LxWjzQNJw2845GY1KKIPbaNRREE35w==
X-Received: by 2002:a2e:854f:: with SMTP id u15mr2955901ljj.237.1643089658510;
        Mon, 24 Jan 2022 21:47:38 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id b11sm1374206lfb.277.2022.01.24.21.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 21:47:37 -0800 (PST)
Message-ID: <a179c80c-7ce8-da1a-f344-5d72b65c3da4@cogentembedded.com>
Date:   Tue, 25 Jan 2022 08:47:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drivers: irqchip: add irq-type-changer
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org
References: <20220124095652.522099-1-nikita.yoush@cogentembedded.com>
 <878rv58ghy.wl-maz@kernel.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <878rv58ghy.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

 > I also don't see why you model this as the actual device that triggers
 > the interrupt.

Well, that somehow matches the physical reality. In the case of wl18xx on KF, physically the interrupt 
signal indeed originates from the intermediate chip - the inverting level-shifter.

I remember your suggestion to configure interrupt source's node with interrupt-parent set to inverter 
and interrupt details for inverter's parent. But this looks hacky and inconsistent for me.

In contrary, an abstraction of intermediate entity that does a static conversion of the trigger type and 
does not need any software control, looks sane. And, hardware designers do strange things sometimes, I 
won't be surprised observing a change from level to edge one day. Thus it looked a good idea not to 
limit the conversion to inversion, but support arbitrary one. Then, irqspec inside the node for the 
intermediate entity obtains a meaning, making the entire model consistent.

I don't strongly insist on this approach, it just looks cleaner for me.


 > I'm also pretty sure that with the current code,
 > you end-up with *two* interrupts (one for the inverter and one for the
 > end-point).

In driver's init, I only call of_irq_parse_one() for interrupt defined in the changer's node. This does 
not create a mapping for it. The mapping is only created when changer's "interrupt-child" creates a 
mapping for their interrupt - then changer's alloc() routine calls irq_domain_alloc_irqs_parent() in the 
same way as all other hierarchical irqchips do.

I don't see where double mapping can appear here. Please explain.


 > You need a proper DT binding...
 > Geert commented on why this is wrong...
 > Use struct_size()...

Will fix all that after we negotiate the basic approach.

Thanks,

Nikita

