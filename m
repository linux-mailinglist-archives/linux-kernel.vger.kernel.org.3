Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE75652EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiGDLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiGDLAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:00:02 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342710D0;
        Mon,  4 Jul 2022 03:59:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 1FA7AD0E;
        Mon,  4 Jul 2022 12:59:52 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received;
         s=dkim20160331; t=1656932391; x=1658746792; bh=OsIWiXUEYCo45MHB
        NAtw8T1MH1g0PqlfjghU8IT8d48=; b=ULUH0B6ZkkNL+dBXV1R6+mlD4wAbsP/P
        BKvPA/cwH2SLOz3OUs+Ha2NnFeqKSuPVbypW0qURXIcCTd852CMPd5xrZQIYF1+I
        qjVnEfCtmFrwmq9BU5Pq0o8sRoHB2PysXeHklHKi+H/wxcFiJRlR1tgpm0zZqXd7
        uBPMwnG3xSVGIbhA38z0UiW92+N0GlOlajEWuX/dsNnauqmDzby1EiEaGaf61QrD
        dSVfy0KgXdbwJvLNIja7Z/MmX3AyUEX0+KYM6gg8hG5jacM+qWZlUX45yuqLA4hq
        ky7lHdsrMSgqh5Yc/NX1sEBoiOb0VjT6poGH7189/4SS5uFxvMelFd+1fl4EsMrX
        8uRPtsjxv4+tytASa5PspViIxqisvJoDYiTs43Ak+QBTbZxxqDOl4ywXtZvhNPSz
        21tD0ZA141FHbOAJOzwpFVfa9M8pfOYDxSniihF9ffEkr2J4SCRoeitLu6Obus9V
        Cotb8UDszIs/jbDNFYXDNS/lH5ht8ZgYvuCJGPgVzmfJ/TYgti4e7eflNU3m5hqx
        VzxDyvMeK/NWKf36MynUwjCLTFqjQBg1k5yzOvQvj4kwX+LBMKrE1ttwx0X88dA6
        RU/17D+dVnYlbwS97XyvU2FEkA7RkmgazEKRXHwFyBn7nlgt1VmLnIb1Ka/whBqi
        pdetF1c2KFY=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PmZtLwz8Ykbd; Mon,  4 Jul 2022 12:59:51 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id F07CE1448;
        Mon,  4 Jul 2022 12:59:44 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 9C2E938EB;
        Mon,  4 Jul 2022 12:59:39 +0200 (CEST)
Date:   Mon, 4 Jul 2022 12:59:33 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/11] docs: it_IT: align to submitting-drivers
 removal
Message-ID: <20220704105933.c26zmkzyvdjmxb5a@numero86.vaga.pv.it>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-8-lukas.bulwahn@gmail.com>
 <20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it>
 <CAKXUXMzAzT6c=Atwbnif0MQg50B9UpG6_rV65_OvkaJPTzaPcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMzAzT6c=Atwbnif0MQg50B9UpG6_rV65_OvkaJPTzaPcw@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:49:23AM +0200, Lukas Bulwahn wrote:
>On Tue, Jun 28, 2022 at 11:16 AM Federico Vaga <federico.vaga@vaga.pv.it> wrote:
>>
>> On Mon, Jun 27, 2022 at 05:18:15PM +0200, Lukas Bulwahn wrote:
>> >Adjust the Italian translation to the removal of submitting-drivers in the
>> >English kernel documentation.
>> >
>> >Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> >---
>> > .../it_IT/kernel-hacking/hacking.rst             |  3 +--
>> > .../translations/it_IT/process/5.Posting.rst     |  5 ++---
>> > .../translations/it_IT/process/8.Conclusion.rst  |  3 +--
>> > .../translations/it_IT/process/howto.rst         |  3 +--
>> > .../translations/it_IT/process/index.rst         |  1 -
>> > .../it_IT/process/submitting-drivers.rst         | 16 ----------------
>> > .../it_IT/process/submitting-patches.rst         |  6 ++----
>> > 7 files changed, 7 insertions(+), 30 deletions(-)
>> > delete mode 100644 Documentation/translations/it_IT/process/submitting-drivers.rst
>> >
>> >diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
>> >index d5c521327f6a..4bec4669cf48 100644
>> >--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
>> >+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
>> >@@ -795,8 +795,7 @@ anche per avere patch pulite, c'è del lavoro amministrativo da fare:
>> >    di un semplice impegno su una parte del codice.
>> >
>> > -  Infine, non dimenticatevi di leggere
>> >-   ``Documentation/process/submitting-patches.rst`` e possibilmente anche
>> >-   ``Documentation/process/submitting-drivers.rst``.
>> >+   ``Documentation/process/submitting-patches.rst``.
>> >
>> > Trucchetti del kernel
>> > =====================
>> >diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
>> >index 1476d51eb5e5..a036f38fc82e 100644
>> >--- a/Documentation/translations/it_IT/process/5.Posting.rst
>> >+++ b/Documentation/translations/it_IT/process/5.Posting.rst
>> >@@ -16,9 +16,8 @@ e di procedure per la pubblicazione delle patch; seguirle renderà la vita
>> > più facile a tutti quanti.  Questo documento cercherà di coprire questi
>> > argomenti con un ragionevole livello di dettaglio; più informazioni possono
>> > essere trovare nella cartella 'Documentation', nei file
>> >-:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`,
>> >-:ref:`translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`, e
>> >-:ref:`translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`.
>> >+:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
>> >+e :ref:`translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`.
>>
>> Fixing plural. The final correct statement must be:
>>
>> nel file :ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.
>>
>> Notice 'nei file' -> 'nel file'
>>
>>
>
>Are you sure about this proposed change here? In my patch, I just
>changed the enumeration from three objects (submittingpatches,
>submittingdrivers, submitchecklist) to two objects (submittingpatches,
>submitchecklist).
>
>So, it should stay plural, right?

You are right. My mistake, I miscounted '-' and '+' in the patch.

>Lukas

-- 
~ - ~ - ~ - ~
Federico Vaga
