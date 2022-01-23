Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D30497197
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiAWNIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 08:08:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:37521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbiAWNIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642943312;
        bh=aj8DhUaaDv08tU9DJpj36L9Kt6ubO2eQXui4kDAaAuU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gDzasPGbLU/m5LE281jnybqmvnSmv5q9BOH7iGATFYQDY8gQKymZWDUsub9WdzWBv
         ri0wX/l5UHikkAdKomORPQSIebmQBx1h1zxJDKK70oyWbHmYS1Sp1Vq+vK7kMkLnAP
         2WTMWp0C7DqRsSbC7we61Ca6DpF8yD//vJ494YeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.228]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1mzIHV19Kv-00CSZX; Sun, 23
 Jan 2022 14:08:32 +0100
Message-ID: <1a5d9e02-856c-8e2d-4eae-cb5a1b5c4652@gmx.de>
Date:   Sun, 23 Jan 2022 14:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: kernel crash/disc errors when unbinding USB devices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
 <Ye03Cz7fHFJ3bPmO@kroah.com> <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
 <Ye1LCATpTIRr/yZt@kroah.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Ye1LCATpTIRr/yZt@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TvpEaKDq9MiKg7jBT8rJ3ycuo5euXn8Fabk/UD+dJexZ9IOHayB
 i119k458E0COup8mMSKIPvUwL7lOPs5TCTAKChXERFdm21kNcH7qElUjdM1cWmYlw86vKJd
 PYiMQXpv4ApWbL70mv0Jf+flwNLI+I9av8dVQNzCM8LM/g6qbU+Eky2+B9VCW6/temW3Bnt
 lfy7Etafqu8ZEUHaC0v3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9jkXdklqkA0=:9LMWRozWHAlauiM5hsoEy8
 zzr3hmLwrYkoDP960HxPBwzQxPIBWaTbnV1SH98ei1Akcz1UKexlIN0p1fLGsD+pd/cuPmNER
 VRaTnYaWP6rcc97Dr7PRW9K3f55hbNZNsehzMcwVCqY9hKcIhUZ39P2glqRSKj2KsjBD7i39D
 XwxWcAlAWVwLK7pIJi7wooAE0Tng1dlO5kG1oPp2G5qlFZ+NvpteTGSAOoxTKpH4GomtzczrO
 FYiYdpx0jD6SVK8qhfRocnl+sNcdmgX4L21MvVuyKg5/nP+b8uHOc8PG66w9sFGu4OoAYD7rg
 7ltfLG0VYY+fvhT1BKaJv0MYZbWlapSnsTZS7UJBuc8CTtQOvKjA+IxCqHlky8JoMBECDneYm
 IVEGbhuCU0Pj5Iu76r+WI6fnqeGdy+sNUeYA5pnp13oHefc274Bx+Y3kp2n9ieEXgbPgZltjv
 WGzsZEddMPXKVo/ciTdAiF5DqgF1jH6wSKHfKExKQIcIrhpFB2MoG6D2vgwsLMuNonlCYdoOQ
 U5PpvQYFIXLePRELuDLorHW4btlJnZ4wnD7rDyaiPCt1BkHC1er3rApBLueuK/4Ihau2caRP2
 u4F/lIOiNN2+fr2o7bR5vU9Yl/HL0dpTxeJk8MTIT8+kN+pZU0SV9liqn3GoGbPB/6K+wfoqc
 rl+AwK7JPIScjJfv/TM9t2414XOWv6snD2I/zXnkl5hdgwt83G96I3kkUe4Dj/885zAy3GmG+
 cmgGFfx1h6JpXHHPD0ijPAPjNk1N5oU1Q6gMpFKVitm8KhgFNd8HXjBXSYiLrseMaCuQi+r35
 0evv4tg6I37hxara3PRJsaPth7UaVn1FZAGkBHqpVzHTl479f4f//nIpfVplh+IDzvBIqEmH1
 PATaRAhT77wKohWUHUhkFH3Z1ClpX/CNqQAShCWHXpy1FElMe/si8H+lWk/nVDMEgzsRY/iis
 dMyNcs3oyKjTpuxVnCY7PUSZ6ofYvbozaI5OP0BNpLFwMZazJUFcxW5/C/uRA5KNf3xOMLnrc
 RSiYMrYLWjZiCHl0SpBjD/YBr/3HNJvXbSillTqP12Dpuu+LFPCTTUrF34weSzoYndAca/fOy
 OPLHJnPQGbzwGs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 13:33, Greg Kroah-Hartman wrote:
> On Sun, Jan 23, 2022 at 12:59:21PM +0100, Helge Deller wrote:
>> On 1/23/22 12:07, Greg Kroah-Hartman wrote:
>>> On Sun, Jan 23, 2022 at 11:40:01AM +0100, Helge Deller wrote:
>>>> On all kernels 5.15.x and 5.16.x I noticed that resetting
>>>> the USB devices with this shell script:
>>>>
>>>>        for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
>>>>          do
>>>>          echo $i
>>>>          echo $i >/sys/bus/pci/drivers/ahci/unbind
>>>>          sleep 1
>>>>          echo $i >/sys/bus/pci/drivers/ahci/bind
>>>>         done
>>>
>>> That is dangerous to do, why do this?  All of your block devices might
>>> have disappeard.
>>>
>>>>         # reseting USB3 ports (if there none you'll get errors)
>>>>         for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
>>>>          do
>>>>          echo $i
>>>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
>>>>          sleep 1
>>>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
>>>>         done
>>>
>>> Again, why do this at all?
>>
>> I need to reset some of the USB devices after a suspend/resume cycle.
>
> The devices, or the host controllers?  They are different things.
>
>> The problem is, that some of the USB devices are
>> handed over into a running VirtualBox VM and after
>> the suspend/resume they need to be virtually plugged out/in
>> so that the running Windows VM will reconnect them.
>
> unbind/bind is a very harsh way of doing this.  but do it on the USB
> devics, not the host controllers.
>
>> If you search in the internet, you will find many places
>> where this unbind/bind process is mentioned, e.g.:
>> https://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-=
the-command-line
>> This procedure did worked in the past.
>
> Never trust the internet :)
>
> But note, there is a usbreset program mentioned there, which is part of
> 'usbutils' and should already be installed on your machine.  Why not
> just use that?
>
>> I think the main problem is, that it's somehow unexpected that
>> the SATA controllers are logically attached to the USB
>> controllers.
>
> Huh?  No they are not.
>
> 'ahci' is a SATA controller.
> 'xhci' is a USB controller.
>
> Two totally different things.

Right, and that was my fault.
I mixed up "ahci" and "ehci" (the USB2.0 controller).

So, my report was bogus.
Please ignore.

Helge
