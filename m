Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65FA482DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiACE7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:59:06 -0500
Received: from mout.web.de ([212.227.15.3]:36331 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbiACE7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:59:05 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jan 2022 23:59:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641185943;
        bh=HmxNcSlJD/9da6dyDW2ehByKsA6AedoSNPaTtlEXE/8=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=RizyQgdjl/e0GYHtH2BJArvaGnRRdgf5JTMu8mJgAKALp08qk3bO7vQmFSsHzP8FY
         r/aXtBbxnkvSKl+3N17ucGFtkkhWJcE+LsCClkgYVpj/pQR9q8HQ/ZAgISeN+bqXob
         US72cuVCmNocF+F7dtIBml3+71aZAFGLoXVb/yPU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from arch.localnet ([93.219.152.58]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1mAvwo37v9-00yBjJ for
 <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 05:54:01 +0100
From:   Fabian Maurer <dark.shadow4@web.de>
To:     linux-kernel@vger.kernel.org
Subject: Usage of the UIO framework with DMA and x86 ports
Date:   Mon, 03 Jan 2022 05:54:01 +0100
Message-ID: <6089204.lOV4Wx5bFT@arch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:A8EpY6g6GaybWX546juI8zUDDXgDTYL5P6Qr8/mcB727ugPNePm
 QW20VhhosKh7gqcQvcp/R1mJSa4grbuqg+5iwogRpdZ41dStDxfY1ojc/ZPjnvphPeqe13Q
 K2pKRAw45WvFyzm41NrsQnSUiLnSBYZPBS3kDI2v2cRR3mkL1BKYyZUXX4BzaqsmeFlADgI
 jdhhHtcm8ZyzoN4PbERSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ji6+pUMuduw=:Os4Vtpi5O+Tohe7mdS9azT
 M+TZ1vZaHH8ELaRLj/x8wmVul/w14UhKkAbozBDq9hwklB3E4rvtlK/mcmHQgpeoiXVgWEbI4
 x/5u0PWHQoVaMK18k0vxKRFzgHfGrIVUfCwN16AYjCA4EcHmd/n4WfvhD4kpBMOqfzvJjff1d
 X2ZMuRu5gBv07GN2NWlmhVlD/RwOlRqqh/H5ipLpjQVbxTMqcKS540NgqcZtrjaI6vCvfu4C7
 1Z3cftJtJMRH8DsZduVYKXijkW/mnrPhKkSPYJVXRRFCL9NZf7+TCQpp4l4yQjuqOCkqpEgOo
 2G27EgPdIckS4jKXtEquoHLxenIeXJef1SG4T0LExRDKgNo04p1rX8X9dbotRTlgrPSf7LWJd
 6/TTFnTIY2pTO7rKbuvN78dappa+ZvMOhnnjUgJW7sPHXYu2OhIaGgOCoNJStSwSI9lHShKtf
 T6q8YGWvZCgOPmdFBcpmHkmoOJTvTuUKqE+b3FziGryNPcc9NVvEM4Bf3Xm1rX/gHYYf0+nz+
 VxPVUp6a8mvhDvLT7ikhoH5t7TLrpgiLnkYop3B1aeyESDNfQGnnIXVYtKlU/XRcoyAj30eeT
 4gI3l5NbHjqmMilTQP08Z7bzX80EeDC8CV0LjnJE6lHD99jqiMgsQOmNyxKyaQJd/jFC/m0I8
 FWH0orpZ67zHjcKx0OJ2CPkBmM3yz9XOpf/57yyO0CKiZ3ejielFx3I6cwML+2CaVEwXq4Y4i
 pS3j4FKDpPwuAa9SGj8T2o/gd0KSoxo1CmeUhYcAJxh5Cj8GAlA56qBENrOYWxz4r6QyrdEaS
 hj72sRECG7q6UIsjc5GsmlMHI+FZTF82Tl1em0sGuEX7Ch17Pmo3CbKV+PHJ2jBb7lDs+lQQd
 ZuHrAcszQMo1+ABZrvmNzvNQANR7Db/x/CtoTT9tTM0jd7jm3DVjrw7J2GWQBCkNZz8AFSeu/
 t/Fd+7qkMP2jEoeVunZ+SZdm4WyDMUcKF2EmPiDyA9DSgdyaqosLUeB27LoaLVlHedSyg9pqj
 W+MX2zCCqkPp+Gn/1ATV5WvLuwyUAUy73miEGOMh06w+vKzUg5pbYfG7r4MbBVlHppi6f8L/C
 XqtF+IM7K61NBE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to port the pcnet32 driver to userland for learning purposes. Maybe=
 for
something like ndiswrapper but in userspace.

I wanted to ask if it's possible to use UIO for PCI devices that need DMA =
and
x86 ports access. Preferably without writing my own kernel module.
The documentation I found i a bit... lacking.

Interrupts and memory-mapped-io are possible with uio_pci_generic, but not
sure about DMA and ports. Ports are doable with a custom kernel module, bu=
t I
didn't find anything for using DMA with UIO. Except for creating your own
solution.

Is there something in UIO that allows me to avoid messing with kernel modu=
les?

Second, low priority question:
For the ndsiwrapper-in-userland idea I'd need to do the same with USB. Do =
I
need to create my own solution here or can this also be done with UIO?

Please CC me in replies.

Regards,
Fabian Maurer


