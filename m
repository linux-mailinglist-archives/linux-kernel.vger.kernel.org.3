Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD944806A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhL1FyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:54:07 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:41610 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhL1FyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:54:06 -0500
Date:   Tue, 28 Dec 2021 05:53:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640670843;
        bh=b0v3NT4fQxh1NjGM+5rW44xiyu7ufiazlHOFGQAISL0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=XOh1i2V38nQHJyR+spqWmeBNkYQowJv15SeI+nVk1sF+UCHhi3IYcjDj/NehoEEdW
         L8utrSe9FmwD5E/hcfRzJwOk/QFxiCz1jmaFV1QauZH0CwiY9soFWcei98q+iX87xi
         ZoWpuqQtwMiAOTru0JQbeXIigBqmLQX6HzWQCl8F9LNYoaedbll+wclUFbTYmS1iCx
         Ler/J9MYKYLvNOAnEamFiNo+wv9cbjQnieXZ3/jezWaXMu/P9450YVkoDef1M3HNJP
         7gvJXtTWGAyYMANOTnIwjrc/De1svWqdP48itnJARsriERd8rcaCSh8rfd3C7SCB5p
         4ziDfuFMyvNKQ==
To:     Aditya Garg <gargaditya08@live.com>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "admin@kodeit.net" <admin@kodeit.net>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [BUG] Slow bluetooth speed on Apple MacBook Pro 16,1
Message-ID: <20211228055353.1b4c09e9@localhost>
In-Reply-To: <3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com>
References: <3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 14:24:09 +1100
"Aditya Garg" <gargaditya08@live.com> wrote:

> The file transfer speed on MacBook Pro 16,1 from an Android device to
> Mac is too slow even if I transfer a file of a few Kbs. In case of a
> transfer from Mac to my Android device, it simply fails.
>=20
> Some logs that might be helpful :-
>=20
> -- Logs begin at Fri 2021-11-26 21:34:04 IST, end at Tue 2021-12-28 08:38=
:16 IST. --
> Dec 28 08:28:29 MacBook kernel: Bluetooth: Core ver 2.22
> Dec 28 08:28:29 MacBook kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI device and connection mana=
ger initialized
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI socket layer initialized
> Dec 28 08:28:29 MacBook kernel: Bluetooth: L2CAP socket layer initialized
> Dec 28 08:28:29 MacBook kernel: Bluetooth: SCO socket layer initialized
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART driver ver 2.3
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol H4 registere=
d
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol BCSP registe=
red
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol LL registere=
d
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol ATH3K regist=
ered
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Three-wire (=
H5) registered
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Intel regist=
ered
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Broadcom reg=
istered
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol QCA register=
ed
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol AG6XX regist=
ered
> Dec 28 08:28:29 MacBook kernel: Bluetooth: HCI UART protocol Marvell regi=
stered
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: failed to write upd=
ate baudrate (-16)
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: Failed to set baudrate

When it fails to set baud rate, btmon has the following:

< HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6=20
        Encoded baud rate: Not used (0x0000)
        Explicit baud rate: 3000000 Mbps
> HCI Event: Command Complete (0x0e) plen 4                       =20
      Broadcom Update UART Baud Rate (0x3f|0x0018) ncmd 1
        Status: Command Disallowed (0x0c)

Not sure if this means the command is unsupported by this chip, or if an "E=
ncoded
baud rate" needs to be specified.

> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: chip id 150
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: features 0x07
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM4364B3 Trinidad Olymp=
ic GEN (MFG)
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM (001.016.075) build =
0099
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: firmware Patch file=
 not found, tried:
> Dec 28 08:28:29 MacBook kernel: Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
> Dec 28 08:28:40 MacBook kernel: Bluetooth: BNEP (Ethernet Emulation) ver =
1.3
> Dec 28 08:28:40 MacBook kernel: Bluetooth: BNEP filters: protocol multica=
st
> Dec 28 08:28:40 MacBook kernel: Bluetooth: BNEP socket layer initialized
> Dec 28 08:35:02 MacBook kernel: Bluetooth: RFCOMM TTY layer initialized
> Dec 28 08:35:02 MacBook kernel: Bluetooth: RFCOMM socket layer initialize=
d
> Dec 28 08:35:02 MacBook kernel: Bluetooth: RFCOMM ver 1.11

