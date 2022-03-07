Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174B34CFF54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbiCGNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiCGNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:00:20 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A169CC5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:59:23 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8QBa-1nVcoD1ZdQ-004QPD for <linux-kernel@vger.kernel.org>; Mon, 07 Mar
 2022 13:59:21 +0100
Received: by mail-wr1-f42.google.com with SMTP id u10so21504746wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:59:21 -0800 (PST)
X-Gm-Message-State: AOAM5322wUHBPXxQnyDOlZKvC+SbJPL9FYCv0QqHssQ0tu8Qz1Pq4JJr
        F5AcJPhCCTE/je2UJwmShSdK7qYeunepH6UpTrw=
X-Google-Smtp-Source: ABdhPJwEW97XP1aD5oJu/V+lw6FoSmidRGJeCDciCJq7QxuUReTn9FhvaXLdAhA7WRC8L+q7Z58VJuoxjg1ktWcYWfM=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr8649943wrh.407.1646657960939; Mon, 07
 Mar 2022 04:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20220302074245.257153-1-alankao@andestech.com> <CAK8P3a2s34a0gcuZ31ns8mZx2Ve-DF8+z_EhURwbOeOth2ayKw@mail.gmail.com>
In-Reply-To: <CAK8P3a2s34a0gcuZ31ns8mZx2Ve-DF8+z_EhURwbOeOth2ayKw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 13:59:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2WihTrGCw-4peuVOOXjygSCHu=Ar8cnabQspzdJ1WuNA@mail.gmail.com>
Message-ID: <CAK8P3a2WihTrGCw-4peuVOOXjygSCHu=Ar8cnabQspzdJ1WuNA@mail.gmail.com>
Subject: Re: [PATCH] nds32: Remove the architecture
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vwhfWHsEwZKIcA2NJxJD/BNRcBv0seIbqwo9+DVXpzLHYDOcZh8
 ehWe2HY5wZPBZYzb986+I14cD2zybmXqDEYRDWPXAVjiQJrTTphyLOTGlmhGfT9QHzLf+ZH
 H+6ghrijoomytpiZqnNniai5j8AxSb3OO53/e8C2UubLMYQHKIOUuipUqoBsvXDkZ76qduA
 8zpG8rwVWMo1709Em2pmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0UbAyYqfSmU=:7qRrQVAXVDBKFX3NDdbpCK
 PZVruX4p6IPEqFva9JTlgj0feUvNBkUeaFKKsjS9+rhwsDHS0u6d5jY1gg98fTKMtEtHbFRa/
 F5R2tAWIOfLyt+yeEK4vJvVrx0KRxGkJcFIAG1jZnY3EWamBu+hMjJTkpTjG75KQJT7OhETI/
 E8updbi0NzgOAkY8GlF/FByc9IqowBwG894jmzYAUsprMJwojrjQjf/T0jySMLT0Bh4Ykrkvf
 aWjAf6nlGeN0WFIXGT5EAeeEXZsxM2WKwO2huF0nKWO7SNXE+VoRhhdjoWO2/6ZiOMLPlQVTj
 Wkm4nuxbRjBykVWU3seKevADsRP1fIf+CyCcsoUlmzWaMeK6OBRDNt0QY/w1RKB0S+Wp93482
 b2hSkkc8q9e5JNZcAi4W4cLSRUfMobQ2Pl9J0dBDF2PfXX5KGf2FQldWNXRf1AxxeA9axPpK4
 +qltbdNofZclutxbiKHjuzuLdjJ1kMCIIlUXDdIX+1eRlVIQmO/Z+jxluUPBuFP48tljMtKYK
 w8WoAD9Df0HWy4bKKoQQXw8o9KDBDcYCvUkmrSzxsFfc7q9tNg3z2lvD1BCJhthRAQlTgbx2g
 z1FscTZ09vWm7EbyFpNjiIKA6cyF2JH8Uzqd9LbKe23P0UDszp3fhIAI9lE/7s6UFCgkNVR2P
 4LQPOw05k9F3ZQ9N7bplew8qKNwB8N1Hw1oC0Bju84XQzRsRB9OfBEROGLm2emnRMHtM9Amqv
 qEvmr/ShawzPgTpkoM0v4murlkBTcQTrL0/HIe/QhZXKRlN0IZLZqG4RU0qrVl4faCkU7Idhe
 7XHdJvo+9OKlbDm7w/PcEhYqaoU0UT4XGO3iE81tXacY4F+0OQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 8:50 AM Arnd Bergmann <arnd@arndb.de> wrote:
> n Wed, Mar 2, 2022 at 8:42 AM Alan Kao <alankao@andestech.com> wrote:
>
> Applied to the  asm-generic tree now, thanks for taking care of it.
>
> I'll probably amend the commit to have a more detailed changelog when
> I'm back in the office next week.

This is now the modified changelog text:

8<---
nds32: Remove the architecture

The nds32 architecture, also known as AndeStar V3, is a custom 32-bit
RISC target designed by Andes Technologies. Support was added to the
kernel in 2016 as the replacement RISC-V based V5 processors were
already announced, and maintained by (current or former) Andes
employees.

As explained by Alan Kao, new customers are now all using RISC-V,
and all known nds32 users are already on longterm stable kernels
provided by Andes, with no development work going into mainline
support any more.

While the port is still in a reasonably good shape, it only gets
worse over time without active maintainers, so it seems best
to remove it before it becomes unusable. As always, if it turns
out that there are mainline users after all, and they volunteer
to maintain the port in the future, the removal can be reverted.

Link: https://lore.kernel.org/linux-mm/YhdWNLUhk+x9RAzU@yamatobi.andestech.com/
Link: https://lore.kernel.org/lkml/20220302065213.82702-1-alankao@andestech.com/
Link: https://www.andestech.com/en/products-solutions/andestar-architecture/
Signed-off-by: Alan Kao <alankao@andestech.com>
[arnd: rewrite changelog to provide more background]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----->8

I also checked all removed Kconfig symbols and header files to see if any
remaining references were left behind. I found this oneline change missing,
and included it in your patch now:

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fa5f624eadb6..9c85ee2bb373 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -81,7 +81,6 @@ obj-$(CONFIG_INGENIC_SYSOST)  += ingenic-sysost.o
 obj-$(CONFIG_INGENIC_TIMER)            += ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)            += clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)             += numachip.o
-obj-$(CONFIG_ATCPIT100_TIMER)          += timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)              += timer-riscv.o
 obj-$(CONFIG_CLINT_TIMER)              += timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)            += timer-mp-csky.o


       Arnd
