Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1528C5AC6AE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiIDVil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:38:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE60A2B601;
        Sun,  4 Sep 2022 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662327513;
        bh=0KjFQi9UqHxgJ6bhPSHcDBTT0TyTiVE9UjfWI3A2MPk=;
        h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
        b=VktzxEdvVsyo08klT05zgBrOXupuUDZdM4JhnWV65zvXo8bzB//oSlQurGhwirPQi
         dqV1ZFI7txd9kXH+dMd2BJ73ZE/TfGwUHdVedUeV2jNOtslUFPCgO7egxt3YSrXeF/
         ZExGx7hbl91RbJcixXHBD0JWPMN8lbgilKCk2/jM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.14] ([5.147.48.155]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mdvqg-1p3k6x2FDq-00b0kR; Sun, 04
 Sep 2022 23:38:33 +0200
Message-ID: <0bdfdd52-4e73-0554-ef94-5da5af0ae01b@gmx.com>
Date:   Sun, 4 Sep 2022 23:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   jflf_kernel@gmx.com
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
 <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
 <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
 <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com>
 <60a08cc9-a96d-9453-1cef-a440527a79f6@suse.com>
Content-Language: en-US
In-Reply-To: <60a08cc9-a96d-9453-1cef-a440527a79f6@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nhmMpsMuyxO4X5lLH7/5mRw/+s+n2hUwyFBMV6mxLD+8zCWR840
 7SJ5tmbH0eGM6EaeD35SycxQ+MlR8MLcHgnTiBvexgK3Bh3JIDBfYBYWkWAIjTl+iZrWw8D
 3a28n6F+ihahKyjP59ql/ZCPi00qK32A/c0pQcqaXVwvRdKrzmn7icqgQGkiyMhjOdBTH2I
 0fAm9631H7osjfiCY/yQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMFfavmrZW4=:LCfNleHLT4rAzwJTfCa1rF
 8v3Ypbrd4q8wr3+1lFaacMXEEVrSqHYwWARKBLiUgx9aj/Z3EIcLw8fPI33tEhZBiSryIdRQp
 Ki6rTlD/qXAlJd/lZrdbGg+TEAyr2EiV2T6z3WzUmg1jjcPDy6QfNys7Uf1yK9QU+aOHUMHPd
 XE8WkOsq6xAhDKAGgaa+iVPCOUwYBry1BIMyd6KLB5+Rcx5/pr9XTs8WieVayY2lGn8166uzL
 vn9xvExKY8P7N0c94r9KctjZ24vgDVcQGDqNoJus5+a2UDYDHb4LBCxb3XvNcpyTCMSYRUSB9
 WJWLID9m4HoUZB8WQ/0tn+OORK1Nr2xduGAA5CAJ3Ll+mvbchs/XiNpdtpLkyMOpIpzHsAPZu
 bQtmNXcZsu8l4DTbCr6VH+3aNgVprmFm1sY8zYG7GngstA0y891TP4N/xvHmBbJd2b7wb+Eh7
 c++Hl++cyUA3YmPUa0+88ViiXHQrxjnc1H1THVo2TV1dqOQTwmdfgKp545TvyB9cdzcyc4TVN
 c/uunEkYyaDvc7OKn4hhBgRsoydFSP/QCt04mZR/cmYFjwgeVdV8hpOo/xkcd9Yfd25FmsBSj
 VitBsx3mEMvyO5k7+Wja2DvQeXINKKylpnWUlGF0PIDi/teDNCPIk7ua6WxIAEFeLZ7wj1ujR
 qLWcG2YDlqvkSbv8cTRPDTwK0pm8GVFV2tZWNhvyrhL2nycEPcEhtr+0QzaL4e1ZO68XQA0NF
 5TjA7plHQh1sP0kg2N/gZpAByvL18GPGyVRPGBFXxvwJUWjQKzbocn7fLMSsH+p7I7xzqfOFR
 oWy/mHmdG+Rouwax/izbREh0EGpQoyZMMNFG+Uc53vjmO4rzB80+gHD8p/kRmBqhDwto7xq20
 lwaGFFRvjIHLJjHmURAlum+jcfGLggoc01KzqEl9UabLch+E+YccR1iRzIV7WzFW9Bgn82Muz
 0EeE1xraKy5XTXdXGq9jG6PWUxGVljBQTdGpCJ++knk3wwN/k6ceHpoyRDSAJBTgpQjYGZfyL
 kHzuevxXiFDOnWkoeUyjBNetw/oiRnTJ7y9I4uI8I8HIkx8QesouFl7T8Wds92rTJwsaSaUQO
 sp/6+MF/HxI9CTLkYRst07W4l3inmrOa314pIZimTpIRxEGOfZV8CJa9SDqhMOXq4JrR/kzrT
 N2BdJNWzy9Ep55w6qMh12J3NG2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/08/2022 11.16, Oliver Neukum wrote:

>> I'll run some more tests out of curiosity to see how things behave in c=
orner cases.
>
> While you do so, which is a good idea, could you restate your current
> results in a more precise way? We should have 4 results for each hub.
> It is not the case that RESET_RESUME has no effect if you give
> usbcore.autosuspend=3D-1 if the system has been suspended. Hence we have
> the cases of
>
> no RESET_RESUME/default autosuspend
> no RESET_RESUME/autosuspend=3D-1
> with RESET_RESUME/default autosuspend
> with RESET_RESUME/autosuspend=3D-1


Hi Oliver,

Apologies for my last unclear message.

Both VL812 hubs behave the same way so I have a single table for both. The=
 settings are applied to both hubs, on both USB2 and USB3.

I have separated USB2 and USB3 as they behave slightly differently.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Settings                        USB2 hotplug    USB3 hotplug    State afte=
r waking up
=2D-----------------------------------------------------------------------=
---------------

power/control=3Dauto              works (1)       fails           broken (=
2)

usbcore.autosuspend=3D-1          works           works           broken (=
2)
OR power/control=3Don

power/control=3Dauto              works (3)       works (3)       works
and USB_QUIRK_RESET_RESUME

power/control=3Don                works           works           works
and USB_QUIRK_RESET_RESUME

HUB_QUIRK_DISABLE_AUTOSUSPEND   works           works           works
and USB_QUIRK_RESET_RESUME

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


(1) I have yet to find a device that would be rejected by the USB2 side, w=
hile I have reliable reproducers for USB3. The problem appears with specif=
ic devices only, which otherwise work flawlessly on other hubs, other syst=
ems, etc.

(2) After a system wake-up the hubs are in a seemingly random state. Numer=
ous errors appear in the syslog, and some ports may be dead (changes from =
wake-up to wake-up). This can affect both internal (to dock built-in devic=
es) and external hub ports.

(3) With RESET_RESUME the hubs (both USB2 and USB3) stay active and don't =
autosuspend, even when power/control=3D=3Dauto.


In all situations above a keyboard and the integrated ethernet controller =
can wake up the laptop from suspend. In situations (2) they may not work a=
nymore after waking up.


The bottom line is: we need USB_QUIRK_RESET_RESUME to deal with the spurio=
us hub state after waking up, and we need to prevent the hubs from autosus=
pending to work around the USB3 issue. RESET_RESUME does all of that right=
 now, but can its behaviour be considered stable? Is there any chance that=
 some day it would no longer block autosuspend?

If RESET_RESUME is stable, then my current patch is enough and it can be r=
e-merged. If not, I have an updated patch ready with HUB_QUIRK_DISABLE_AUT=
OSUSPEND.


Also, RESET_RESUME keeps the device nodes active, but not the hub interfac=
e nodes. HUB_QUIRK_DISABLE_AUTOSUSPEND and usbcore.autosuspend=3D-1 keep b=
oth of them active:

    $ grep active /sys/bus/usb/devices/2*/power/runtime_status    # USB_QU=
IRK_RESET_RESUME
    /sys/bus/usb/devices/2-1.1/power/runtime_status:active
    /sys/bus/usb/devices/2-1/power/runtime_status:active

    $ grep active /sys/bus/usb/devices/2*/power/runtime_status    # HUB_QU=
IRK_DISABLE_AUTOSUSPEND
    /sys/bus/usb/devices/2-1:1.0/power/runtime_status:active
    /sys/bus/usb/devices/2-1.1:1.0/power/runtime_status:active
    /sys/bus/usb/devices/2-1.1/power/runtime_status:active
    /sys/bus/usb/devices/2-1/power/runtime_status:active

I do not know what impact this could have. In my tests both accepted the h=
otplugged USB3 devices, so keeping the device nodes active is enough.


Thanks!
JF
