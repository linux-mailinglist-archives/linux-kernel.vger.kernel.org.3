Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4344B5A07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357508AbiBNSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:39:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiBNSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:39:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B807D6517F;
        Mon, 14 Feb 2022 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644863915;
        bh=XY5ZWnZvUHBRCFSdMYdlfBTZB4KKA6S7EhwJTQMpBuo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hwqk6iGjsVw7QZchD0mckpA/zQ02aJTU+9YOjoNv8RwJd30h2l1nENgUgEcB8310A
         4O8hPPo5/4Ew8DcGVCOMgDkyAr9SByp+vIER8OlX1+7wRzsT2cjJYF/nlmW0kZVvLd
         wHDeOtGZ0DfZ57q6ScliOqUw7QiYxhVGQeVEA89s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1oHXPx3CBi-013fLl; Mon, 14
 Feb 2022 19:38:35 +0100
Message-ID: <5d710a45-1924-1a52-fe48-097deb12cb1c@gmx.de>
Date:   Mon, 14 Feb 2022 19:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] serial: parisc: GSC: fix build when IOSAPIC is not set
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20220214180019.20384-1-rdunlap@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220214180019.20384-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:egCZaBxnkD9Tc7+dELp3P4BzdSFTt1jByG9kWcU2NDGK/MsWf0B
 wOSrH28Hacb+LzLoSzCfBM3AMbdybWiKiHN0adPQYHrBocu8vXcBy7J4WRHWOCQADmLVH2A
 P/hGe/tj8XQXoviHRQ41yuvmm4OYPeKHeH9ZxwBzxnWwtE7YVeyQGCHywWiY9i5YPUPY2+5
 3njKxCFO2lu45JlRx5RSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dVnUYHNfZVA=:j5FUgXw0MuvKQJDevv3ofz
 ZsxRPizrtZaQEmIA0lWbQwpKwS6PgxA6e5f68kZy2P9ASlg5kRsEGIK16FnUDj7GUKNIX4WEA
 LUSI3pF2qHKDFUbpyyLHASLEwK8hofz4C6uba0rkCkVKOlzfCimk1hupoZaW1Gh+8CdjsFo2r
 stDHXAreb2G4RrgmZdCKcbwENhOa741Q03zh8or21PrLN7AUM/esde3JoJrsmlxTCaocK2Luf
 MbA9/Kqia3Yg5uEXPfh5xsxycai1ElmzaCBfIPhdLEIJvjW8kwvf5SLKUBgkBUYpJ9fOcis+R
 cjzG9va5tCZxk1LpVJrDzh66DXbj2JHaAnU4UjXZ15fjYb9OQrtqVCIfFF3rgPcCCBcwCJrP9
 sNyzH2P6fdQKTbb0rWWWpEjC8NiO9l4i3CxXCCvAynh2spxlvgIK1/SnNbLFUInA6T2MFCbTQ
 z6kXEJ3QZnGWSplujIe3NLuQkIjS8/FLeVwP9SwWnoUNj9EiFncR95Z75rnNUDBHcfatoa3Dj
 5k5z0dysEPnqtS5kTgvpCGcvKxGZtjcPsGHximYZmxN9Pl5g50U6Kjtkvw5mUMczObeHQkMXu
 qGMBdD+7s2Ntt1nm1hxl/om0FOaer8IPQ0ujTO/cU3INSmSjyPqCNDT31vqtAC5WBQH6queov
 br9MrZlZTbukdVj5dPWI635nin3fuPrW+BVSg1ZUKBbAmHtIRFXTXqev7szzKWsFiibO0M8vx
 yWMzDEXB6M2LlS3NB0JgKgPqlHkt+hcY7WJSSyuR8tM8SK2dB00qwAroT0jc9mMe8igYLPBHS
 ARO8f/RXOgVgcSJBzqqRgEFNF1KFloyEF7Y692pTrWOfxfd2Q3TVpYY0XgCq2ZjJdpDwp5N/n
 kahYQGXZ6eu0YdA2jPP5hWx8pzT7bLoRV2YUD1dq9c7cMWND5Iyrt7CkvtVdjKbJCSiMDHT1P
 ALTo8qGqPn2oK+NxVh9+08/UfeeXTq5RDXTPn3E/2bpzNZdSkUXklm+kIiKCJ/IlVp/jQ50cD
 kZpm2J/22w3rRJXyG4kehorkLIT1QEK47T2NtIEzHEBIqKvG+Mzp6yVKWBYhGJLj4b8uDl1vf
 o/RFyMJN9CaDak=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 19:00, Randy Dunlap wrote:
> There is a build error when using a kernel .config file from
> 'kernel test robot' for a different build problem:
>
> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>
> when:
>   CONFIG_GSC=3Dy
>   CONFIG_SERIO_GSCPS2=3Dy
>   CONFIG_SERIAL_8250_GSC=3Dy
>   CONFIG_PCI is not set
>     and hence PCI_LBA is not set.
>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>
> Make the use of iosapic_serial_irq() conditional to fix the build error.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Suggested-by: Helge Deller <deller@gmx.de>

Thank you Randy!

Acked-by: Helge Deller <deller@gmx.de>

Since this patch only affects the parisc platform, I've added it
to the parisc for-next tree (with a stable tag), unless people want it
to go through another subsystem tree...

Helge

> ---
> v2: make the call to iosapic_serial_irq() conditional based on
>     CONFIG_ settings (thanks, Helge)
>
>  drivers/tty/serial/8250/8250_gsc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220211.orig/drivers/tty/serial/8250/8250_gsc.c
> +++ linux-next-20220211/drivers/tty/serial/8250/8250_gsc.c
> @@ -26,7 +26,7 @@ static int __init serial_init_chip(struc
>  	unsigned long address;
>  	int err;
>
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
>  	if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
>  		dev->irq =3D iosapic_serial_irq(dev);
>  #endif
>

