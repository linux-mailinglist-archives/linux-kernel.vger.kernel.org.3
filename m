Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032A55F7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiF2HGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiF2HFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:05:49 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 00:04:03 PDT
Received: from cmx-alt-rgout003.mx-altice.prod.cloud.synchronoss.net (cmx-alt-rgout003.mx-altice.prod.cloud.synchronoss.net [65.20.48.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4AC0377CE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suddenlinkmail.com; s=dkim-001; t=1656486243; 
        bh=k3GZPqmqqDjq762E9ENa9fRMaSUa3/4fmyOC+AYO65Y=;
        h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject;
        b=iUPX3sqLgzwGJsIh/a+SEEXApCVRaDlaXm73+CFaYPcEuUNAFgAMwyAYPsV0RQ1bgx7CLdchIi03n2FJ6PFiN2xxfniW68ITfe6F3bgLsw2Za+2/izcvKfW6sAY9Q8CwAYZEtYlBFFWFeOIcf3ByXlqKjuZz4BRG2Up2lPaiQa6lLWLxrT3wRg/xfovyJKJDLvbtAkD+pM/5zjQRi5fyEyzw1kP/AYH5NsUc4460jntekkORk/+VT6M4KUTfs9YVuq93/kAIk5TzfScOKRDDLGRwyica60A7lHZ7+4hdhumzt1rHl2XrTtrhjnGajK1feYl8YibUYrcXEft+1j42bw==
X-RG-VS-CS: commercial-dirty
X-RG-VS-SC: 107
X-RG-VS: Suspect
X-Originating-IP: [66.76.46.195]
X-RG-Env-Sender: drankinatty@suddenlinkmail.com
X-RG-Rigid: 62B1A656013F4B63
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudegkedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucetnffvkfevgfgfufdpggftfghnshhusghstghrihgsvgdpqfgfvfenuceurghilhhouhhtmecufedttdenuceurggutfgvphhuthdqffhomhgrihhnucdluddtjedmnecujfgurheptgfkffggfgfvhffuohfpsehmtderredtfeejnecuhfhrohhmpedfffgrvhhiugcuvedrucftrghnkhhinhdfuceoughrrghnkhhinhgrthhthiesshhuugguvghnlhhinhhkmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehteehvdeiteffhfdvtefhkeffudeuheejgfelkeetuedttefgvdejudfgteduudenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghdprghrtghhlhhinhhugidrohhrghenucfkphepieeirdejiedrgeeirdduleehnecuuegrugftvghpuhhtffhomhgrihhnpehsuhguuggvnhhlihhnkhhmrghilhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedriedruddtgegnpdhinhgvthepieeirdejiedrgeeirdduleehpdhmrghilhhfrhhomhepughrrghnkhhinhgrthhthiesshhuugguvghnlhhinhhkmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: spam 107
X-RazorGate-Vade-Classification: commercial-dirty
Received: from [192.168.6.104] (66.76.46.195) by cmx-alt-rgout003.mx-altice.prod.cloud.synchronoss.net (5.8.807.04) (authenticated as drankinatty@suddenlinkmail.com)
        id 62B1A656013F4B63 for linux-kernel@vger.kernel.org; Wed, 29 Jun 2022 07:01:32 +0000
Content-Type: multipart/mixed; boundary="------------0cWz90enQgBH9CiuvT25DDyM"
Message-ID: <a8bce489-8ccc-aa95-3de6-f854e03ad557@suddenlinkmail.com>
Date:   Wed, 29 Jun 2022 02:01:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     kernel <linux-kernel@vger.kernel.org>
From:   "David C. Rankin" <drankinatty@suddenlinkmail.com>
Subject: amdgpu - BUG: kernel NULL pointer dereference, address:
 0000000000000000
Organization: Rankin Law Firm, PLLC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0cWz90enQgBH9CiuvT25DDyM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

   There appears to be a bug (regression maybe?) in the amdgpu driver 
resulting in a Fatal error during GPU init. This began with the 5.17 kernel 
and is still present in the current 5.18 kernel. However, the 
effect/consequence on the kernel due to the NULL pointer dereference seems to 
be getting worse and not causes the machine to hang at the end of the shutdown 
procedure. (tough for boxes that are remote adminned).

I have two servers with old AMD cards that have this exact problem. lspci -v 
(as user) reports the card as:

01:00.1 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] RV370 
[Radeon X300 SE]
         Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 0f03
         Flags: fast devsel, NUMA node 0
         Memory at fea20000 (32-bit, non-prefetchable) [size=64K]
         Capabilities: <access denied>
         Kernel modules: amdgpu

The host is:

Host: valkyrie Kernel: 5.18.7-arch1-1 arch: x86_64 bits: 64 compiler: gcc
     v: 12.1.0 parameters: BOOT_IMAGE=/vmlinuz-linux
     root=UUID=515ef9dc-769f-4548-9a08-3a92fa83d86b rw iommu=soft
     amd_iommu_dump= quiet audit=0
   Console: pty pts/0 DM: LightDM v: 1.30.0 Distro: Arch Linux

Machine:
   Type: Desktop Mobo: Gigabyte model: 990FXA-UD3 v: x.x serial: N/A
     BIOS: American Megatrends v: F3 date: 05/28/2015

Memory:
   RAM: total: 31.31 GiB used: 1012.9 MiB (3.2%)

CPU:
   Info: model: AMD FX-8350 socket: AM3 bits: 64 type: MT MCP arch: Piledriver
     built: 2012-13 process: GF 32nm family: 0x15 (21) model-id: 2 stepping: 0
     microcode: 0x6000852

Graphics:
   Device-1: AMD RV370 [Radeon X300] driver: radeon v: kernel
     alternate: amdgpu arch: Rage 9 code: R360-R400 process: TSMC 110nm
     built: 2003-08 pcie: gen: 1 speed: 2.5 GT/s lanes: 16 ports:
     active: DVI-I-1 empty: SVIDEO-1 bus-ID: 01:00.0 chip-ID: 1002:5b60
     class-ID: 0300

The NULL pointer dereference occurs during GPU init of the card. These cards 
are fanless and specifically chosen for that. They are used in server installs 
and have been flawless for years. If it was just one card acting up, I could 
see it may be a card problem, but I have two identical servers setup with this 
card and both show the exact same "BUG: kernel NULL pointer dereference":

[    9.660937] [drm] amdgpu kernel modesetting enabled.
[    9.661025] amdgpu: CRAT table not found
[    9.661028] amdgpu: Virtual CRAT table created for CPU
[    9.661040] amdgpu: Topology: Add CPU node
[    9.661296] [drm] initializing kernel modesetting (IP DISCOVERY 
0x1002:0x5B70 0x1002:0x0F03 0x00).
[    9.661302] amdgpu 0000:01:00.1: amdgpu: Trusted Memory Zone (TMZ) feature 
disabled as experimental (default)
[    9.661305] amdgpu 0000:01:00.1: amdgpu: Fatal error during GPU init
[    9.661318] amdgpu: probe of 0000:01:00.1 failed with error -12
[    9.661338] BUG: kernel NULL pointer dereference, address: 0000000000000000

Full dmesg output for this with backtrace is attached.

Bugs related to this problem are open with freedesktop, and with Archinux.

https://gitlab.freedesktop.org/drm/amd/-/issues/2070

and

https://bugs.archlinux.org/task/74346#comment209209

Are those the proper locations for the bug report or does a kernel bug also 
need to be opened to track the issue? Let me know there and let me know if you 
need any further information from the machines and I'm happy to get it.

-- 
David C. Rankin, J.D.,P.E.
--------------0cWz90enQgBH9CiuvT25DDyM
Content-Type: text/plain; charset=UTF-8; name="amdgpu_dmesg_NULL-pointer.txt"
Content-Disposition: attachment; filename="amdgpu_dmesg_NULL-pointer.txt"
Content-Transfer-Encoding: base64

WyAgICA5LjY2MDkzN10gW2RybV0gYW1kZ3B1IGtlcm5lbCBtb2Rlc2V0dGluZyBlbmFibGVk
LgpbICAgIDkuNjYxMDI1XSBhbWRncHU6IENSQVQgdGFibGUgbm90IGZvdW5kClsgICAgOS42
NjEwMjhdIGFtZGdwdTogVmlydHVhbCBDUkFUIHRhYmxlIGNyZWF0ZWQgZm9yIENQVQpbICAg
IDkuNjYxMDQwXSBhbWRncHU6IFRvcG9sb2d5OiBBZGQgQ1BVIG5vZGUKWyAgICA5LjY2MTI5
Nl0gW2RybV0gaW5pdGlhbGl6aW5nIGtlcm5lbCBtb2Rlc2V0dGluZyAoSVAgRElTQ09WRVJZ
IDB4MTAwMjoweDVCNzAgMHgxMDAyOjB4MEYwMyAweDAwKS4KWyAgICA5LjY2MTMwMl0gYW1k
Z3B1IDAwMDA6MDE6MDAuMTogYW1kZ3B1OiBUcnVzdGVkIE1lbW9yeSBab25lIChUTVopIGZl
YXR1cmUgZGlzYWJsZWQgYXMgZXhwZXJpbWVudGFsIChkZWZhdWx0KQpbICAgIDkuNjYxMzA1
XSBhbWRncHUgMDAwMDowMTowMC4xOiBhbWRncHU6IEZhdGFsIGVycm9yIGR1cmluZyBHUFUg
aW5pdApbICAgIDkuNjYxMzE4XSBhbWRncHU6IHByb2JlIG9mIDAwMDA6MDE6MDAuMSBmYWls
ZWQgd2l0aCBlcnJvciAtMTIKWyAgICA5LjY2MTMzOF0gQlVHOiBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwClsgICAgOS42NjEz
ODRdICNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKWyAgICA5
LjY2MTQxMV0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdlClsg
ICAgOS42NjE0NDBdIFBHRCAwIFA0RCAwClsgICAgOS42NjE0NTRdIE9vcHM6IDAwMDIgWyMx
XSBQUkVFTVBUIFNNUCBOT1BUSQpbICAgIDkuNjYxNDc5XSBDUFU6IDMgUElEOiAzNTggQ29t
bTogc3lzdGVtZC11ZGV2ZCBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgNS4xOC43LWFy
Y2gxLTEgIzEgYjM2MWY4NDVhMDBhNDM2OWUzCjA3OWMxMzkzNzhiY2JjNWIxMzFkNDkKWyAg
ICA5LjY2MTU0M10gSGFyZHdhcmUgbmFtZTogR2lnYWJ5dGUgVGVjaG5vbG9neSBDby4sIEx0
ZC4gVG8gYmUgZmlsbGVkIGJ5IE8uRS5NLi85OTBGWEEtVUQzLCBCSU9TIEYzIDA1LzI4LzIw
MTUKWyAgICA5LjY2MTU5NV0gUklQOiAwMDEwOmFtZGdwdV9kZXZpY2VfZmluaV9zdysweDJh
NC8weDM5MCBbYW1kZ3B1XQpbICAgIDkuNjYyMDIwXSBDb2RlOiA4MiAwMCAwMCAwMCA0OCA4
OSBkZiBlOCBkYSBhMiAwNCAwMCA0OCA4MyBiYiBlOCA1ZiAwMCAwMCAwMCA3NCAwOCA0OCA4
OSBkZiBlOCA2OCA0MiAwNCAwMCA0OCA4CmIgYmIgZjAgNzQgMDEgMDAgYjggZmYgZmYgZmYg
ZmYgPGYwPiAwZiBjMSAwNyA4MyBmOCAwMSA3NCA0YyA4NSBjMCAwZiA4ZSBjMyAwMCAwMCAw
MCA0OCBjNyA4MyBmMCA3NApbICAgIDkuNjYyMTIwXSBSU1A6IDAwMTg6ZmZmZmJhMGVjMGUx
N2IyOCBFRkxBR1M6IDAwMDEwMjQ2ClsgICAgOS42NjIxNDldIFJBWDogMDAwMDAwMDBmZmZm
ZmZmZiBSQlg6IGZmZmY5YzMxYzNlMDAwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwClsgICAg
OS42NjIxODldIFJEWDogMDAwMDAwMDAwMDAzMDVjMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAg
UkRJOiAwMDAwMDAwMDAwMDAwMDAwClsgICAgOS42NjIyMjZdIFJCUDogZmZmZjljMzFjM2Uw
MDAxMCBSMDg6IGZmZmZiYTBlYzBlMTdiYTggUjA5OiBmZmZmOWMzMWMwMWNkOWQwClsgICAg
OS42NjIyNjddIFIxMDogMDAwMDAwMDAwMDAwMDAyYSBSMTE6IGZmZmY5YzMxYzVkM2M2ZDgg
UjEyOiBmZmZmYmEwZWMwZTE3YmE4ClsgICAgOS42NjIzMDVdIFIxMzogZmZmZjljMzFjMTA1
NjBkMCBSMTQ6IGZmZmY5YzMxYzEwNTYzNzQgUjE1OiBmZmZmYmEwZWMwZTE3ZGIwClsgICAg
OS42NjIzNDRdIEZTOiAgMDAwMDdmZWJhYzRiNjA4MCgwMDAwKSBHUzpmZmZmOWMzOGJlY2Mw
MDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgICA5LjY2MjQxMl0gQ1M6ICAw
MDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICAgIDkuNjYy
NDQzXSBDUjI6IDAwMDAwMDAwMDAwMDAwMDAgQ1IzOiAwMDAwMDAwMTA2YjJhMDAwIENSNDog
MDAwMDAwMDAwMDA0MDZlMApbICAgIDkuNjYyNDgyXSBDYWxsIFRyYWNlOgpbICAgIDkuNjYy
NDk4XSAgPFRBU0s+ClsgICAgOS42NjI1MTJdICBhbWRncHVfZHJpdmVyX3JlbGVhc2Vfa21z
KzB4MTYvMHgzMCBbYW1kZ3B1IDRjNTYzMjZjNjUzZGEwNWRkODA5YTQyNDc3MjA3MTAzMDZm
Y2YwZmJdClsgICAgOS42NjI4ODddICBkZXZtX2RybV9kZXZfaW5pdF9yZWxlYXNlKzB4NDMv
MHg2MApbICAgIDkuNjYyOTE1XSAgcmVsZWFzZV9ub2RlcysweDM4LzB4YjAKWyAgICA5LjY2
MjkzOF0gIGRldnJlc19yZWxlYXNlX2FsbCsweDhjLzB4YzAKWyAgICA5LjY2Mjk2Ml0gIGRl
dmljZV91bmJpbmRfY2xlYW51cCsweGUvMHg3MApbICAgIDkuNjYyOTg4XSAgcmVhbGx5X3By
b2JlKzB4MTQzLzB4MzcwClsgICAgOS42NjMwMTJdICBfX2RyaXZlcl9wcm9iZV9kZXZpY2Ur
MHhmYy8weDE3MApbICAgIDkuNjYzMDM2XSAgZHJpdmVyX3Byb2JlX2RldmljZSsweDFmLzB4
OTAKWyAgICA5LjY2MzA2MF0gIF9fZHJpdmVyX2F0dGFjaCsweGJmLzB4MWEwClsgICAgOS42
NjMwODRdICA/IF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHhlMC8weGUwClsgICAgOS42NjMx
MTNdICBidXNfZm9yX2VhY2hfZGV2KzB4ODcvMHhkMApbICAgIDkuNjYzMTM2XSAgYnVzX2Fk
ZF9kcml2ZXIrMHgxNWQvMHgyMDAKWyAgICA5LjY2MzE1OF0gIGRyaXZlcl9yZWdpc3Rlcisw
eDhkLzB4ZTAKWyAgICA5LjY2MzE4MV0gID8gMHhmZmZmZmZmZmMwYmFhMDAwClsgICAgOS42
NjMyMDFdICBkb19vbmVfaW5pdGNhbGwrMHg1ZC8weDIyMApbICAgIDkuNjYzMjI4XSAgZG9f
aW5pdF9tb2R1bGUrMHg0YS8weDI0MApbICAgIDkuNjYzMjUxXSAgX19kb19zeXNfaW5pdF9t
b2R1bGUrMHgxMzgvMHgxYjAKWyAgICA5LjY2MzI4MF0gIGRvX3N5c2NhbGxfNjQrMHg1Zi8w
eDkwClsgICAgOS42NjMzMDJdICA/IF9fdm1fbXVubWFwKzB4OTAvMHgxMTAKWyAgICA5LjY2
MzMyNF0gID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDI2LzB4NTAKWyAgICA5LjY2
MzM1MV0gID8gX194NjRfc3lzX211bm1hcCsweDFiLzB4MjAKWyAgICA5LjY2MzM1MV0gID8g
X194NjRfc3lzX211bm1hcCsweDFiLzB4MjAKWyAgICA5LjY2MzM3NV0gID8gZG9fc3lzY2Fs
bF82NCsweDZiLzB4OTAKWyAgICA5LjY2MzQwMF0gID8gc3lzY2FsbF9leGl0X3RvX3VzZXJf
bW9kZSsweDI2LzB4NTAKWyAgICA5LjY2MzQyOF0gID8gZG9fc3lzY2FsbF82NCsweDZiLzB4
OTAKWyAgICA5LjY2MzQ1NV0gID8gZXhjX3BhZ2VfZmF1bHQrMHg3NC8weDE3MApbICAgIDku
NjYzNDg0XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQpbICAg
IDkuNjYzNTE4XSBSSVA6IDAwMzM6MHg3ZmViYWJkMTI5OWUKWyAgICA5LjY2MzU0M10gQ29k
ZTogNDggOGIgMGQgZmQgYTMgMGUgMDAgZjcgZDggNjQgODkgMDEgNDggODMgYzggZmYgYzMg
NjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgZjMgMGYgMWUgZmEgNDkgODkgY2Eg
YjggYWYgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4
YiAwZCBjYSBhMyAwZSAwMCBmNyBkOCA2NCA4OSAwMSA0OApbICAgIDkuNjYzNjczXSBSU1A6
IDAwMmI6MDAwMDdmZmVlNzJmYTY1OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAw
MDAwMDAwMDAwMGFmClsgICAgOS42NjM3NDddIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6
IDAwMDA1NjMyZDA4MGNjMDAgUkNYOiAwMDAwN2ZlYmFiZDEyOTllClsgICAgOS42NjM4MDRd
IFJEWDogMDAwMDdmZWJhYzRjYTMyYyBSU0k6IDAwMDAwMDAwMDEwZThlYmUgUkRJOiAwMDAw
N2ZlYmE4YjgzMDEwClsgICAgOS42NjM4NDJdIFJCUDogMDAwMDdmZWJhOGI4MzAxMCBSMDg6
IDAwMDAwMDAwMDAyNjEwMDAgUjA5OiA4NWViY2E3N2MyYjJhZTYzClsgICAgOS42NjM4Nzld
IFIxMDogMDAwMDAwMDAwMDAzNTcyMSBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
N2ZlYmFjNGNhMzJjClsgICAgOS42NjM5MThdIFIxMzogMDAwMDU2MzJkMDgwOGExMCBSMTQ6
IDAwMDA1NjMyZDA4MGNjMDAgUjE1OiAwMDAwNTYzMmQwODEyMzEwClsgICAgOS42NjM5NThd
ICA8L1RBU0s+ClsgICAgOS42NjM5NjldIE1vZHVsZXMgbGlua2VkIGluOiBjY3Agc25kX2hk
YV9jb2RlY19yZWFsdGVrIGFtZGdwdSgrKSBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgcm5nX2Nv
cmUgbGVkdHJpZ19hdWRpbyBzbmRfaGRhX2ludGVsIHNuZF9pbnRlbF9kc3BjZmcga3ZtIHNu
ZF9pbnRlbF9zZHdfYWNwaSBpcnFieXBhc3Mgc25kX2hkYV9jb2RlYyBzbmRfaGRhX2NvcmUg
c25kX2h3ZGVwIGNyY3QxMGRpZl9wY2xtdWwgc25kX3BjbSBjcmMzMl9wY2xtdWwgZ2hhc2hf
Y2xtdWxuaV9pbnRlbCBzbmRfdGltZXIgc25kIGFlc25pX2ludGVsIG1vdXNlZGV2IHI4MTY5
IG14bV93bWkgc3A1MTAwX3RjbyBzb3VuZGNvcmUgcmFkZW9uIGdwdV9zY2hlZCBjcnlwdG9f
c2ltZCByZWFsdGVrIGZhbTE1aF9wb3dlciBwY3Nwa3IgaTJjX3BpaXg0IGNyeXB0ZCBtZGlv
X2RldnJlcyBrMTB0ZW1wIGRybV90dG1faGVscGVyIGxpYnBoeSB0dG0gd21pIGRybV9kcF9o
ZWxwZXIgbWFjX2hpZCBhY3BpX2NwdWZyZXEgdmJveG5ldGZsdChPRSkgdmJveG5ldGFkcChP
RSkgdmJveGRydihPRSkgZG1fbXVsdGlwYXRoIGRtX21vZCBzZyBjcnlwdG9fdXNlciBmdXNl
IGJwZl9wcmVsb2FkIGlwX3RhYmxlcyB4X3RhYmxlcyBleHQ0IGNyYzMyY19nZW5lcmljIGNy
YzE2IG1iY2FjaGUgamJkMiBzcl9tb2QgY2Ryb20gc2VyaW9fcmF3IGF0YV9nZW5lcmljIGF0
a2JkIHJhaWQxIGZpcmV3aXJlX29oY2kgcGF0YV9hY3BpIHVhcyBsaWJwczIgbWRfbW9kIHZp
dmFsZGlfZm1hcCBjcmMzMmNfaW50ZWwgZmlyZXdpcmVfY29yZSB1c2Jfc3RvcmFnZSBjcmNf
aXR1X3QgcGF0YV9hdGlpeHAgeGhjaV9wY2kgaTgwNDIgeGhjaV9wY2lfcmVuZXNhcyBzZXJp
byB1c2JoaWQKWyAgICA5LjY2Nzg1MF0gQ1IyOiAwMDAwMDAwMDAwMDAwMDAwClsgICAgOS42
Njk2MTJdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQpbICAgIDkuNjcx
MzcwXSBSSVA6IDAwMTA6YW1kZ3B1X2RldmljZV9maW5pX3N3KzB4MmE0LzB4MzkwIFthbWRn
cHVdClsgICAgOS42NzM1NzddIENvZGU6IDgyIDAwIDAwIDAwIDQ4IDg5IGRmIGU4IGRhIGEy
IDA0IDAwIDQ4IDgzIGJiIGU4IDVmIDAwIDAwIDAwIDc0IDA4IDQ4IDg5IGRmIGU4IDY4IDQy
IDA0IDAwIDQ4IDhiIGJiIGYwIDc0IDAxIDAwIGI4IGZmIGZmIGZmIGZmIDxmMD4gMGYgYzEg
MDcgODMgZjggMDEgNzQgNGMgODUgYzAgMGYgOGUgYzMgMDAgMDAgMDAgNDggYzcgODMgZjAg
NzQKWyAgICA5LjY3NzE4NF0gUlNQOiAwMDE4OmZmZmZiYTBlYzBlMTdiMjggRUZMQUdTOiAw
MDAxMDI0NgpbICAgIDkuNjc4OTc5XSBSQVg6IDAwMDAwMDAwZmZmZmZmZmYgUkJYOiBmZmZm
OWMzMWMzZTAwMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMApbICAgIDkuNjgwNzc0XSBSRFg6
IDAwMDAwMDAwMDAwMzA1YzAgUlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESTogMDAwMDAwMDAw
MDAwMDAwMApbICAgIDkuNjgyNTQ1XSBSQlA6IGZmZmY5YzMxYzNlMDAwMTAgUjA4OiBmZmZm
YmEwZWMwZTE3YmE4IFIwOTogZmZmZjljMzFjMDFjZDlkMApbICAgIDkuNjg0MjU2XSBSMTA6
IDAwMDAwMDAwMDAwMDAwMmEgUjExOiBmZmZmOWMzMWM1ZDNjNmQ4IFIxMjogZmZmZmJhMGVj
MGUxN2JhOApbICAgIDkuNjg1OTgwXSBSMTM6IGZmZmY5YzMxYzEwNTYwZDAgUjE0OiBmZmZm
OWMzMWMxMDU2Mzc0IFIxNTogZmZmZmJhMGVjMGUxN2RiMApbICAgIDkuNjg3NjYxXSBGUzog
IDAwMDA3ZmViYWM0YjYwODAoMDAwMCkgR1M6ZmZmZjljMzhiZWNjMDAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwClsgICAgOS42ODkzOTRdIENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKWyAgICA5LjY5MTA5NV0gQ1IyOiAwMDAw
MDAwMDAwMDAwMDAwIENSMzogMDAwMDAwMDEwNmIyYTAwMCBDUjQ6IDAwMDAwMDAwMDAwNDA2
ZTAKWyAgICA5LjY5NTY5OF0gU1ZNOiBUU0Mgc2NhbGluZyBzdXBwb3J0ZWQKWyAgICA5LjY5
NzM4OF0ga3ZtOiBOZXN0ZWQgVmlydHVhbGl6YXRpb24gZW5hYmxlZApbICAgIDkuNjk5MTMy
XSBTVk06IGt2bTogTmVzdGVkIFBhZ2luZyBlbmFibGVkClsgICAgOS43MDA4MTZdIFNWTTog
TEJSIHZpcnR1YWxpemF0aW9uIHN1cHBvcnRlZApbICAgIDkuNzYzODUyXSBNQ0U6IEluLWtl
cm5lbCBNQ0UgZGVjb2RpbmcgZW5hYmxlZC4KCg==

--------------0cWz90enQgBH9CiuvT25DDyM--
