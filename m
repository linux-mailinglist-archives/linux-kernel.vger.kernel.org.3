Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7752D4F2387
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiDEGr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDEGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:47:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63A58389;
        Mon,  4 Apr 2022 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649141128;
        bh=+1slJEu5cLbwBdL0YQpYCGoEQBeIZUYx/flGYBmPf6I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TVJeiZ4UQ+S6GQ4KQRf3kuiMXjPdPfOEnj3ZsNwa1VL8as+US1fnFUN3gFfo4nHPL
         prE3zeSAkLaHeU/DEm6+poG1bAYARZJ7ZsQR/4GDwEOAOSU18vC4S5sqJyxavh0lr+
         UGfHyZF2Mv4coimdZtfja6BGcmiGBHInOdhXOodw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.146.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1o71NV0jY5-015dN7; Tue, 05
 Apr 2022 08:45:28 +0200
Message-ID: <545e68c7-2872-9ee7-0b39-59c39f2bb9d1@gmx.de>
Date:   Tue, 5 Apr 2022 08:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Build regressions/improvements in v5.18-rc1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18AtG2wfjYSw8q/3JGcJoSDoHkD/A8XLyXqZvvwuHqVuSYR0eaj
 yijlhuKN1keynjJJfxfRunIMjbjpxFliSM6n9lGxs6e8iaScrVZmBB3/NU8XmB8z/5Ky1Eh
 TvCroJoRVOwi9ZppTRE9dzJKk6MseZAEYs0FKnw3l4tEMsHZrshwlfnE65XLawdWsoAWQNk
 dER5ZLQmn9ji+DK5rqZDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QOsvVIY3XxY=:TgNAh0VtkVCHe7pKtIsPVU
 T2qROq/JeWKaRZQKNC+/Lk3oQM7qJdc/JrFu/qfsbKWZDZcwuwAxFcKwAPojwEQ3WnKiaXGc8
 2Vq9BT8QLfOlDAYmdWaV4PqLyeQkt7ZUt7f2gHAAIY+5yFitp9CzlVMXgcURT8aXdDaYEXd5/
 ydtGsxmC9r6lH34qCHNl9d1bNe2qzTuWi42i4T0MkpjsBIiVGb+TP4Y/LDa1Gqd8Z8aeo7MtQ
 NE6kF6PkhIe5oWPCWrKzEMrefXWO4zepCzwGMQp7Hhr+tlNqNLzB5e6yV9Vn4nlWfMIvldR5F
 +1KSdLuHJgSiy5GS9Hjthd1K9MTFj4oNj9+dI1+BTJWjm4hsDb5CNK2+2NP1z4g1Pq3yHW6O7
 aH/Oi1c8VbGdWYMIILlioIEWbJ1BXiAGT2zkgoqd+sfYJozR3WPstoUkfLuh4loaGC+eoIYSj
 VhkoD8HGnKx9XRvr5kNWXYqx3sWBc4VQ11IR2sneRx679pLTfq2K9AuZxte4Lfa6OkYsO/HSy
 BhvNFBCpYy3FBrwDzQzLjUPG8+z3bXyR3QZt+1ciUxllktI4rWDLH1aXN/DQZF3ZmQlUA1byH
 2nVUzJ4Lo7b/000GNGcCSPDDSKVK4TUQ8brrn1d1qiVhi6fOjrkqyY/6lmrZ1xrnFQNzOIPIA
 8ZcYBHYKWAYK3q/fdyfUtM72llLwzxkB2TxgT/oTmAMsAEgF+QFi+5PnX5k8wcEe0uoGmytBr
 DKTtBEXzeIMzyJdEH5ur4sorv4RHak6STTFZXw/bMl6jXc3/9jG/QuZJDoqa+SURunZJfzcxn
 tnVaMmUAueEtruolZ4IsFz24T2Fz3tFLxzB2wLla6Ep5RxecPoBSmGoNkrotsArMS2KXtrZvv
 eqPIPTXd81RwHfy7vUlGovtQZVR+BsIrN3nDWkOxZwcM3JJmkddax/59xvwAWfakvjggIe7Up
 Ma4l+Pmas8n+CViPTEHqiBHKuC/EnjlgD1My1QohhPrv9Hl+OTsNS8fCXsSaKd+ZE6aPoJnsW
 gG5UQ8Ptp6KEhZCAGTCDIY845q43Upzg3UTC3cFCkOcvn/naInwJlKNXJClrCHX8xhO2KrYI+
 4uSLzt6VuvhhwE=
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 10:16, Geert Uytterhoeven wrote:
> On Mon, 4 Apr 2022, Geert Uytterhoeven wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.18-rc1[1] compared to v5.17[2].
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3123109284176=
b1532874591f7c81f3837bbdc17/ (all 96 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f443e374ae131=
c168a065ea1748feac6b2e76613/ (all 96 configs)
>>
>> *** ERRORS ***
> parisc64-gcc8/generic-64bit_defconfig
> parisc-gcc8/generic-32bit_defconfig
> parisc-gcc8/parisc-allmodconfig
> parisc-gcc8/parisc-allnoconfig

Someone needs to adjust how the parisc kernel is built on kisskb...

The parisc platform got vDSO support, so now the 32- and 64-bit
hppa compiler needs to be installed when building (for 64-bit).

In addition, it changed how to build a kernel:
 make ARCH=3Dparisc                         # to build a 32-bit kernel
 or
 make ARCH=3Dparisc64                       # to build a 64-bit kernel
(before ARCH=3Dparisc was sufficient to build either for 32- or 64-bit).

And, in case "CROSS_COMPILE=3D" is given, you need to give "CROSS32_COMPIL=
E=3D" as well.
It's preferred to leave out both CROSS[32]_COMPILE=3D parameters and let
the environment detect the compilers automatically. They just need to be i=
n $PATH.

Who can change that on kisskb ?

Helge
