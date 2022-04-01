Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BC4EEA21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbiDAJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiDAJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:11:53 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7C198EE3;
        Fri,  1 Apr 2022 02:10:01 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 3F4EA20B0ADF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1] MIPS: ip22-gio: Add check for the return value of
 kzalloc()
To:     unSimple <unsimple1993@163.com>
CC:     <tsbogend@alpha.franken.de>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <ralf@linux-mips.org>
References: <1648454654-27200-1-git-send-email-unSimple1993@163.com>
 <6dd8bcf0-20a1-0bab-b48e-ec1bac5c15f0@omp.ru>
 <16aa9238.4bf6.17fd8fe37ad.Coremail.unsimple1993@163.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4eb43887-44a4-4693-8488-4847d80b6bd8@omp.ru>
Date:   Fri, 1 Apr 2022 12:09:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <16aa9238.4bf6.17fd8fe37ad.Coremail.unsimple1993@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 7:03 AM, unSimple wrote:

> OK, here is the new version.

   That won't do, your original patch description should be here.
And it should be a fresh posting with [PATCH v2] in the subject.

> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---

   You need to describe what changes between v1 and v2 here...

>  arch/mips/sgi-ip22/ip22-gio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
> index dfc52f6..f94f58b 100644
> --- a/arch/mips/sgi-ip22/ip22-gio.c
> +++ b/arch/mips/sgi-ip22/ip22-gio.c
> @@ -363,6 +363,10 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
>  printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
>         slotno, name, id);
>  gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
> +

   No need for empty line here.

> +if (!gio_dev)
> +return;

   Hm, the tabs were there but they got eaten when I replied.
Your mail seems to be base64-encoded which I don't think is
acceptable for patches -- they should be posted as plain text.

[...]

MBR, Sergey
