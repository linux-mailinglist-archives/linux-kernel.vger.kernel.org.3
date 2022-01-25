Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9D49BC28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiAYTd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiAYTdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:33:51 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1905C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:33:50 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q127so3514893ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2mh7I9RVtB7UsMUi3Pap6a4lxrdNL9g+CKep6e2zGwo=;
        b=B7Tf5SdiuBdrN+Zs/966hzqHG9UrbgGVknyldysY95ZcbKqHKXR4VkZQ1t0Tf5asCM
         mLIFt9y9ibVlRl1vXK9UxYaFiH/MTHacO/WZuAiXoq5S4h/ErAN1ECYbzCe+vTsULIkD
         HMrl8LXAGJWEzNrKB/dzTD8TKo6l2cjxS5U1/bbD3Ap36hppcAog26Fo2NJvOCU6FR5R
         2xKW1IS/eCyBJToYAuP5knvUqaGa/iH05lpFEmltyfGghzywL5d/Rs560dtQyNuBh59A
         MMoOvc/4+pGpKg35vRsfcZI8KOmOuEhM/xh7uvi4mEXjUMF5viqEmNp7k9VOhhhYAgKh
         PgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2mh7I9RVtB7UsMUi3Pap6a4lxrdNL9g+CKep6e2zGwo=;
        b=1HDvENI/usnWKnlu+rPYiOMkJe9fGrOOmg28uk2ShJzXHmcW8itqYzdD46KKNMzbJ6
         iQXRDA2Vc0FwtcI7csVHJWAMUVq6OUf47KogSliNOhlehW4WsYw+OKWZg+i+Rc9Np2dw
         jECwiWGilDuFR8wvXUAXLboAsxFdao++95r7kCk5Y25jWTdtpN5i8sBELhYiSj6/eDA1
         0U80aVDxHqh8wIodOTO3eAMl5MbhgTYoiPuNypl3x0WlHqD9S3qHveOX25ZCnPkD64QE
         TXGEbEHsLd+ViG99jj7Snn7+s6s7u1h3XLTXvRgF/r2QHDfojC8B90LgxWmn1uGTpt1I
         a56g==
X-Gm-Message-State: AOAM530058vYc4RrUkjkdgO0C2rp/icfqOJAWikwpHXJ2pFinIMb7r5H
        hy1u0lpCpOuapGlzEW3psWw/hCCNfi1CBoRb
X-Google-Smtp-Source: ABdhPJweHb/RUDIVB9kRybj0CmKxyU0F5QQKq2fVl8DmULjUEwvzP7kn9X1wPhZ5NVMNzBAgDGOREA==
X-Received: by 2002:a2e:a4c6:: with SMTP id p6mr9764301ljm.20.1643139229329;
        Tue, 25 Jan 2022 11:33:49 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id b24sm1581642lfj.26.2022.01.25.11.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 11:33:48 -0800 (PST)
Message-ID: <8b5681a0-a9ab-8ad7-b293-ce1342e43099@cogentembedded.com>
Date:   Tue, 25 Jan 2022 22:33:47 +0300
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
 <a179c80c-7ce8-da1a-f344-5d72b65c3da4@cogentembedded.com>
 <874k5s8a32.wl-maz@kernel.org>
 <a7a6ddd2-9d40-3ac2-2b7f-bb521c8d3728@cogentembedded.com>
 <871r0w86wv.wl-maz@kernel.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <871r0w86wv.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Such HW can stay in the bin.

Huh? Industry is full of ugly hardware (that is still surprisingly useful to cover practical needs at 
low cost - which ensures it will persist). Sure I'd prefer to spend time for something better than 
negotiating workarounds to keep ugly hardware working. But after 20+ years in the industry, I can only 
agree with the statement Linus wrote back in 2006 in [1]:

| For a driver writer, there is one rule above _all_ other rules:
|
|	"Reality sucks, deal with it"
|
| That rule is inviolate, and no amount of "I wish", and "it _should_
| work this way" or "..but the documentation says" matters at all.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.64.0604241156340.3701@g5.osdl.org/


Can we finally stop blaming and propose a practical way to solve the original issue?

If the only solution you are ready to accept is the code that supports inversion only, and uses node's 
"interrupts" property to provide info for interrupt-grand-parent, please state that explicitly.


<skipping all the statements I don't agree with>


 > (I really should put a WARN_ON() in the irqdomain
 > code to catch this sort of things).

I do support this idea.

Is a WARN_ON() in irq_domain_set_mapping() checking that nothing is already assigned to this hwirq in 
this domain good enough to serve this purpose?

I.e. for a linear domain (which shall be enough to catch the wl18xx-on-kf case where both parent domain 
and irq-type-changer's domain are linear):

--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -521,9 +521,10 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
                 return;

         mutex_lock(&domain->revmap_mutex);
-       if (hwirq < domain->revmap_size)
+       if (hwirq < domain->revmap_size) {
+               WARN_ON(domain->revmap[hwirq] != NULL);
                 rcu_assign_pointer(domain->revmap[hwirq], irq_data);
-       else
+       } else
                 radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
         mutex_unlock(&domain->revmap_mutex);
  }

This does not hit on my code.

Could you please suggest a better location for WARN_ON() that will hit?


Nikita
