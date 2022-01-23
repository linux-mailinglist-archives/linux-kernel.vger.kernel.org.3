Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3053B497169
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiAWMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 07:03:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:41945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbiAWMDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 07:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642939418;
        bh=i8b8Si73cyW2W/FTE47SgsDsloQbmWbBayhLyZY8pJw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=ezXhrfXyECL/JbdDDYCWESk/P7KTv5MByJ8umIA7037yXsfUjlfwIU97SJXtd+S23
         TyiNj8eEWFob3NbcBttCrnU/r9DtgfIz95J86pXLol5TbhLQ22B5fxl2VupWJC0pCN
         Hl5nceB2sv7oxSXVYkB6aEx5BojLezYYG2/XR4MA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.228]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1m8Xmm3Y69-013RIL; Sun, 23
 Jan 2022 13:03:37 +0100
Message-ID: <8be7848b-6078-7bf9-49c7-de66a3ac4d55@gmx.de>
Date:   Sun, 23 Jan 2022 13:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: kernel crash/disc errors when unbinding USB devices
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
 <Ye03Cz7fHFJ3bPmO@kroah.com> <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
In-Reply-To: <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MmZ7EfztWCb5o9zQPBADM1hTssQ52KopKPPBDT9bRAyBj1Y7gKx
 n60Jcrg0TNmQ2mE8+g3ce4Tdgd0xlcNiBorWPy8vyRKIgJaLgXumDRO7stiwmtdYc5oWiMi
 qb5/zYMdSANB/YkVLcZk8uvvzzywv+oAGlsjQaN1aVEk3PwyDlPaEke17auQlyLfQon/Y9U
 66Ob/DGEuhlfkDAgWa9XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ovBCu4yK6oE=:kMB6rh3hlUHiwZbvINEHqf
 7ynxkM5HGbmvhbzjJbaz1K/BTZG8eTGAiERPycMSt/B0b4V+cqkf+AKWlvGLdTbnymURo7yGK
 K9u5XUpPzgV8+oxD+JttfYnYz9QGXwmgJm5oz5QivGn+d6YbAW5rHvPYjaWyH8K/w3LMxcZr6
 SnrqPNfQ3/Eso3KcEZgU/57JOSQHkKSd/IHZMctX/okn+m7Lz4ywM4uOxETK7Ww9zNKE3kZij
 gEHBJc9k1+FoXoqjHzbGGiYSNlEwhYN5d4CPD/+NbFRF6PLQCygfSBOLAVjByQiboXhJ1WksY
 zSmaiEEJtyOi73yos/jNnskpKaDsO1LVMQfjoW3JWDjVZf8/JmTGJ+ApTuwjuNtRluudvWlIS
 pXO6d2+TbdM2IkakunBzpmAxXCN7VI0F3axZaezHN9xz6dukOonGI5wSG4OqC15gXBlv0esSJ
 /DeSXiIYrNxJNR7B5p3/ryH9nXHHePtwVRedG/9P1uoTgNR9OD+DCIWnGJzUAYTYylzmqpNRk
 dMeV8AW5qnUzVhinXNXgk08tjFlm5kQegrLVAE+gGPtrJ6s7fch+kCTdzuZ29DVrd4MvSNLPs
 PQDckvVlypNiT9apRxtJvjyn+u59q2W3FJp4TCtueHDEgV+NRH5zyBs4aK0DqDzd5CSsCKPac
 8ffS8szwkhD9fsuGAzlW+bzgAONZIG/raZx1xY45hp24ntqnA/BerQVJqowy0y9jwdYa55d3l
 6Y0nE8eBm+9XIqp2zlwJD1duhTSbGXHp+Mi9VzrFRFbFz6NQRSEQZTSL4d03rCLy0Q58cZFxf
 MhWauVYVTJh5mOGLmV4qFQYpZelKxFikjZ2SdIcadNpLuczaCR9eZwyoFfG3GpSxFbdWaf4FL
 6o0irlhn4NyL4hdDI7GuVHwQugNPz+z+8rWAi//TNGReFQPQM/R4P+Ayzzt0PUxUGaAaHyKLz
 1OjhNU4+xK0UM2SCd0XO/gLEttuyjxXvaMyBBdrwyfj+pABvX/ACJKt/PT6v8rVBAqTqEtGjG
 0KQYqaAbWbahZxWSNfaActmmSGJkuP/OLhnbvrekwTsvwYlI1HTfOfT0vZPcoNMLlwSOGj9CX
 DQBurOkf8HQKDM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 12:59, Helge Deller wrote:
> On 1/23/22 12:07, Greg Kroah-Hartman wrote:
>> On Sun, Jan 23, 2022 at 11:40:01AM +0100, Helge Deller wrote:
>>> On all kernels 5.15.x and 5.16.x I noticed that resetting
>>> the USB devices with this shell script:
>>>
>>>        for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
>>>          do
>>>          echo $i
>>>          echo $i >/sys/bus/pci/drivers/ahci/unbind
>>>          sleep 1
>>>          echo $i >/sys/bus/pci/drivers/ahci/bind
>>>         done
>>
>> That is dangerous to do, why do this?  All of your block devices might
>> have disappeard.
>>
>>>         # reseting USB3 ports (if there none you'll get errors)
>>>         for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
>>>          do
>>>          echo $i
>>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
>>>          sleep 1
>>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
>>>         done
>>
>> Again, why do this at all?
>
> I need to reset some of the USB devices after a suspend/resume cycle.
> The problem is, that some of the USB devices are
> handed over into a running VirtualBox VM and after
> the suspend/resume they need to be virtually plugged out/in
> so that the running Windows VM will reconnect them.
>
> If you search in the internet, you will find many places
> where this unbind/bind process is mentioned, e.g.:
> https://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-t=
he-command-line
> This procedure did worked in the past.
>
> I think the main problem is, that it's somehow unexpected that
> the SATA controllers are logically attached to the USB
> controllers.
> So, if you believe to unbind "just" the USB devices you
> suddenly unbind SATA controllers too.
>
>>> immediately leads to a non-functional system, because the discs
>>> face I/O errors and will switch to read-only mode.
>>
>> Sure, the disks are gone, this is expected.
>
> Ok.
>
>>> Effectively I have to reboot the machine.
>>
>> I'm amazed it keeps working at all.
>
> :-)
>
>>> It's reproduceable for me on two completely different x86 machines wit=
h
>>> different USB devices.
>>
>> What do you expect this to do instead?  You just disabled all block
>> controllers in your system, followed by all USB controllers.  And then
>> attempted to add them back, but given that the old devices still had
>> userspace references on them, the devices will come back with different
>> names and so you need to mount them again.
>>
>> So this looks like it is working as intended.  Just don't do this :)
>
> Ok, sure, but I think it's unexpected that the SATA ports are listed
> beneath the USB controllers, beside USB devices.
> If I run "lsusb", the SATA controllers don't show up either.
> They are listed when I run "lspci".
> Shouldn't they maybe show up somewhere else, e.g.
> /sys/bus/pci/drivers/sata/*

Ignore this.
AHCI =3D SATA...

Sorry for the noise.

Helge
