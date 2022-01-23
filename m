Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A0497162
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiAWMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 07:00:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:37673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbiAWMAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 07:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642939228;
        bh=Z7wOwgI8SPP+xCgir3nh+T10zSZ6RFwc+dMQGuX1KlI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZV6pPtdIdsERwSIT8/PbreQ5pJfIK9fZ5fdkiKXQMqUtw2P5l+ZOUbOC6czFuoMZV
         A7CCVWR/NVdIJ1rhSLP5hSKYqR3MeEs4P1yzYDLkts6AS3Bpq66e3yuN5N48LGVPIR
         4X8hydmEeSAamJLExt1hd847agCX4M4LM29/21uU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.228]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1md5o62pmc-00ZuTk; Sun, 23
 Jan 2022 13:00:28 +0100
Message-ID: <2ce0e792-ac09-a973-6751-6ed187b6fae6@gmx.de>
Date:   Sun, 23 Jan 2022 12:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: kernel crash/disc errors when unbinding USB devices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
 <Ye03Cz7fHFJ3bPmO@kroah.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Ye03Cz7fHFJ3bPmO@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9xLA//lmeicqarTUmaS/svC3jYoRb2dUYDYEgGZWbvqCVXtHhRN
 JFbHqCfYjdnMsLk61ppIk/MEW0GltH/pZLQejFEvR00br3W97PadfKeWtePn3bKX3/I1NlT
 aUvQBaceogSNfOpeoX1yv18HuW9t38bPFzHhagE22NJSXPqYr7ECUrqmKRhyB+Zdi45ZFU2
 BvOiBzWdHgfjMUyXF5VDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZeE+APYT5bE=:+fxOZ61O5CqhMyyhbKyPQ3
 4lpsP6IEWsrhSPUD9f3cHqYyJF1/W2KkFbPZZwR/z4mySqLDlAG5Og5nmN8m6qJAhTWmbb/Jv
 mp9D388VDCB6zH12Lw3Rf8JtW67+H8sgB+TQXj4LaY33clqJYaY9sAkjuGcg+lrtsbM0Nh/8b
 Gem1eyswFwo6T1ovfmr9HfUU+KyDzlMzfTpfZ5GMF0fUTPnCfXjbcmZWR4fssxHNn3J+CEepe
 SZLW3MmYDsq7mTlzkWUXd73RMlg7s/8wMJnptk0aH4u0S8INcmAOBvCJQw9NUua0f3IGCtqgm
 gkQbutPaSfg92C+1ZKyjZt6lH2LCYoLYQPxZdLkRO/x4cRIOx7bkQDaTuaHpXtiFo0HlgHkSu
 mA5AY4BIJfkJc0TQsTWwXJOie50gnV4dpiw4hP1YPXyK+xnA7l+0JdWBrBDCIXP5KdSGRu18u
 sqXTkAR0AbjADxdAU9TnJszv+CaoKxhn5Ew7cJsZdtBkg8QO4mP7NpWNBk18YYN/Gtizg3X+C
 SJfjrrWV9okBS8jzK9VL0C0YAM1JwwdBQIYW6WFbSRVL3WfpCOjzqi6/1o00opTapPAF8bvuC
 mJ2R+1IMzo3yGNN0a2zG0JyhAmYo/e2UPCaF81407eMKRnQinKMpBHlJy+mjbZlQVVglvrwOM
 yAzj3sAOwhLRIouwOO9xQEtLFrGPmJ8bQEkr4X0xfCIl634t4dWQWrmsY60qXrr5TRfFwT519
 arqQZ/Bvr8gn4AD0KMUbEBUDAlZ2eRgV97AWyn8HIqnbXznDYY+qcVTBghqF9ndpE3StgG8Ub
 6Bd2TTVV87tBBi45gf6ZByC7K7wO3RSYaFkae1EWppy7s4DEVnn06rFoSVKfoG/qytY78O1Cd
 dusWnSiN6SpIiy+ExkB+QZ2zn54cP8mHnqjxL3HJQtJmlfueABu+q0YYvKHllTCqgGa8pla3l
 Dp2E3vghYWmihSElxICupDovsAxNGyubd7STYrwuCXaWK2K0QztXCcHtwygh4CpEoT65pcEaj
 AhKBaT9ep4g3Yb7/nWLkkKJT7QsZerxFVcFmVJPSL+JFGcwa3qIAxelHoXXusbYHywPDHvMs4
 bcR8wuwG8ydpUc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 12:07, Greg Kroah-Hartman wrote:
> On Sun, Jan 23, 2022 at 11:40:01AM +0100, Helge Deller wrote:
>> On all kernels 5.15.x and 5.16.x I noticed that resetting
>> the USB devices with this shell script:
>>
>>        for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
>>          do
>>          echo $i
>>          echo $i >/sys/bus/pci/drivers/ahci/unbind
>>          sleep 1
>>          echo $i >/sys/bus/pci/drivers/ahci/bind
>>         done
>
> That is dangerous to do, why do this?  All of your block devices might
> have disappeard.
>
>>         # reseting USB3 ports (if there none you'll get errors)
>>         for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
>>          do
>>          echo $i
>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
>>          sleep 1
>>          echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
>>         done
>
> Again, why do this at all?

I need to reset some of the USB devices after a suspend/resume cycle.
The problem is, that some of the USB devices are
handed over into a running VirtualBox VM and after
the suspend/resume they need to be virtually plugged out/in
so that the running Windows VM will reconnect them.

If you search in the internet, you will find many places
where this unbind/bind process is mentioned, e.g.:
https://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-the=
-command-line
This procedure did worked in the past.

I think the main problem is, that it's somehow unexpected that
the SATA controllers are logically attached to the USB
controllers.
So, if you believe to unbind "just" the USB devices you
suddenly unbind SATA controllers too.

>> immediately leads to a non-functional system, because the discs
>> face I/O errors and will switch to read-only mode.
>
> Sure, the disks are gone, this is expected.

Ok.

>> Effectively I have to reboot the machine.
>
> I'm amazed it keeps working at all.

:-)

>> It's reproduceable for me on two completely different x86 machines with
>> different USB devices.
>
> What do you expect this to do instead?  You just disabled all block
> controllers in your system, followed by all USB controllers.  And then
> attempted to add them back, but given that the old devices still had
> userspace references on them, the devices will come back with different
> names and so you need to mount them again.
>
> So this looks like it is working as intended.  Just don't do this :)

Ok, sure, but I think it's unexpected that the SATA ports are listed
beneath the USB controllers, beside USB devices.
If I run "lsusb", the SATA controllers don't show up either.
They are listed when I run "lspci".
Shouldn't they maybe show up somewhere else, e.g.
/sys/bus/pci/drivers/sata/*

Helge
