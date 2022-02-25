Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032FD4C46C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiBYNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbiBYNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:41:53 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 526B5210D40
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:41:18 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21PDeuvg019280;
        Fri, 25 Feb 2022 14:40:56 +0100
Date:   Fri, 25 Feb 2022 14:40:56 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225134056.GE18720@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
 <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
 <20220225103239.GA18720@1wt.eu>
 <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
 <20220225122546.GB18720@1wt.eu>
 <20220225082850.2277179f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225082850.2277179f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:28:50AM -0500, Steven Rostedt wrote:
> On another machine that has the same issue but with different characters, I
> captured the output from the console, but also took the output from dmesg
> (both are attached).
> 
> The console has:
> 
> [    5.886056] thermal LNXTHERM:00: registered as thermal_zone0
> [    5.891773] ACPI: thermal: Thermal Zone [TZ00] (28 C)
> [    5.897082] thermal LNXTHERM:01: registered as thermal_zone1
> [    5.902800] ACPI: thermal: Thermal Zone [TZ01] (30 C)
> [    5.908053] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> .0I 15
> 10y0e 
> 9No
>  Lt
> 2t.d)
> .t v
> 6be
>  a20tp
> 0a2ni 
>  s
>  s
> 1s
>  s
> [..]
> 
> 
> and dmesg has:
> 
> [    5.897082] thermal LNXTHERM:01: registered as thermal_zone1
> [    5.902800] ACPI: thermal: Thermal Zone [TZ01] (30 C)
> [    5.908053] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    5.914461] 00:08: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    5.916204] 0000:00:16.3: ttyS1 at I/O 0xf0e0 (irq = 19, base_baud = 115200) is a 16550A
> [    5.917161] Non-volatile memory driver v1.3
> [    5.917617] Linux agpgart interface v0.103
> [    5.922965] tpm_tis 00:09: 1.2 TPM (device-id 0xB, rev-id 16)
> [    5.988960] tpm tpm0: TPM is disabled/deactivated (0x7)
> [    6.001410] brd: module loaded
> [    6.001865] ahci 0000:00:1f.2: version 3.0
> [    6.012113] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x5 impl SATA mode
> [    6.012804] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst 
> [    6.016433] scsi host0: ahci
> [    6.017170] scsi host1: ahci
> [    6.017730] scsi host2: ahci
> [    6.018326] scsi host3: ahci
> [    6.018880] scsi host4: ahci
> [    6.019469] scsi host5: ahci
> [    6.019921] ata1: SATA max UDMA/133 abar m2048@0xf7c36000 port 0xf7c36100 irq 24
> 
> 
> The ending has:
> 
> For console:
> 
> [..]
> .Kp
> 6Kt
> [K-g
>  Ke
> 1iah
> 3inc
>  inc
> 6inc
> 1inc
> 6inc
> 6inc
> 1inc
> 6inc
> 6itu
> 6a 
> .a c
> 6Pe
> 8tm
> 6R r
> [   16.841072] Freeing unused decrypted memory: 2036K
> [   16.846604] Freeing unused kernel image (initmem) memory: 2372K
> [   16.857905] Write protecting the kernel read-only data: 22528k
> 
> 
> For dmesg:
> 
> [..]
> [   16.624186] Key type fscrypt-provisioning registered
> [   16.627743] Key type encrypted registered
> [   16.628167] ima: Allocated hash algorithm: sha1
> [   16.634951] ima: Error Communicating to TPM chip
> [   16.645952] ima: Error Communicating to TPM chip
> [   16.656946] ima: Error Communicating to TPM chip
> [   16.667939] ima: Error Communicating to TPM chip
> [   16.678937] ima: Error Communicating to TPM chip
> [   16.689943] ima: Error Communicating to TPM chip
> [   16.700938] ima: Error Communicating to TPM chip
> [   16.710941] ima: Error Communicating to TPM chip
> [   16.726787] ima: No architecture policies found
> [   16.746928] alg: No test for 842 (842-scomp)
> [   16.747440] alg: No test for 842 (842-generic)
> [   16.838166] PM:   Magic number: 10:503:332
> [   16.838607] tty tty53: hash matches
> [   16.839099] RAS: Correctable Errors collector initialized.
> [   16.841072] Freeing unused decrypted memory: 2036K
> [   16.846604] Freeing unused kernel image (initmem) memory: 2372K
> [   16.857905] Write protecting the kernel read-only data: 22528k
> [   16.864836] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [   16.871969] Freeing unused kernel image (rodata/data gap) memory: 1180K

Interesting, it looks like the characters are rare samples from the
expected output. I.e. many '1' or '6' and 'inc' for "16* communicating".
But it looks like some chars help getting them resynced. A wrong bit
count and/or stop bit count could somehow provoke this, with one char
having the bits properly placed to be detected on the other side, then
many being shifted, arriving without the proper start bit condition,
and/or with the stop bit wrong causing them to be dropped, until some
of the low-bit count chars (0x20 or 0x0A) making it easier and resyncing
on end of lines.

Maybe you could try to change the config on the receiver to try to resync
with what it sent and see if you figure what setting is being used ? I
would personally try to set it to 7 bit with 1 stop and no parity, same
baud rate just to see.

Willy
