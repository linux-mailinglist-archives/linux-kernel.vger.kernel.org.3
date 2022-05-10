Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70E521611
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiEJM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242113AbiEJM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:59:09 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 05:54:36 PDT
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16512B09C5;
        Tue, 10 May 2022 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652187274;
        bh=3SEveaMj4jZCnJ5APQibQymks8/uOLuj8e/GbWas2KM=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=SBNtqWtVRzHMduAvz9KrxuD+zx4/QfELVFeQ0D5WxgqhwnG+VV0d8MCkRUcLy3nvW
         x2X1O0O9HS6rskAWVt+yncCuDQmlSEFdfeYWwUZv+TOOv9jOx/103WS/OctHtefPWa
         pFdQnMBbFCONGxLckExrhP6UTIZ7qz63iWlAmRXk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([87.155.228.41]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1ncaui288r-00EJWJ; Tue, 10
 May 2022 14:48:57 +0200
Message-ID: <b199d9f9-e3ae-df51-87b9-51202269d484@web.de>
Date:   Tue, 10 May 2022 14:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     linux-ia64@vger.kernel.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, debian-ia64 <debian-ia64@lists.debian.org>,
        Pedro Miguel Justo <pmsjt@texair.net>,
        Sergei Trofimovich <slyich@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Anatoly Pugachev <matorola@gmail.com>,
        Anton Borisov <anton.borisov@gmail.com>
From:   Frank Scheiner <frank.scheiner@web.de>
Subject: [ia64] Linux 5.17 (Debian) - Hardened Usercopy: kernel BUG at
 mm/usercopy.c:100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YMIOBBmOBAJ4PxtJ1uHxMIIQn8NjniDeiaH5CjgBAH5oeh/PZtr
 LV9mfPL/pvOUnAIZxE11BOJJR5CzHqOwEDIuKR/GS/x098OBhV9Sf+xoVgef8+d/Kh1rsyc
 onwaCEwOfBwc90RcSCrGqJ2n8zBaOHVfrq/EwVPEeA34Y8GKS6q9tqFgDx5x6I+eTv92Rq2
 4at9QRjWTy0KflgLK1aqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SlCnFZznTqw=:qOluRGBlFmFx+Ae6Zl/WKm
 ivVX4uhT90Fvu2FGBEkWbSEIKpaeiYfOvKAyFHs3Q7awVFB9KjUFfm0EEKZTTXJsB3dXsTFP5
 0S4ISoibnaxq9buC3PhSA0wwewVmSwnXsxH7za46YSAPkgAwVRcoNxMi896MEtp6FuIRxxkVR
 cM0zSlDpgO7bvuODc7r6I6u69HHPbJs9hniUQv1IAeICMMZgiEnB2f3oUxeq9VcK96sF1xHXa
 utpLVDhYI6/1yQ0lzJ1Kd7ULTcHo/NaAPjepmHKr0vKDgNWnRx7kUpLFER0LFWM4epUJNo4hl
 4GIKJRa4lcV8e7XpnPZ18n0Gp70VzrFDspKPl4g5DBSteUh+ckJKHlAe03JIgu82XZo5xmRG9
 ICk19NxLdxgDSaf7COcRp4mHoMDzbfB8HwJ6f6yPsyGn6kxJ4ZtviV5AVmjyoQGPFTQuwjqZC
 OeTNtPP90DtzG/FUh23lbKQ8uY3QtZp2OzFlwvyqRRp8JfXOmzgWDs+MW6rvUsLGGC/3uumj4
 POZJzYmCKmHN9ge3F7J5y2/Ar/D+unkM7C1fUwf15LarbxmnGUf5j6mDnh6koQWCmSq910hYp
 pmvHGsCdgPXgGJB91Jd099Gp9ZsqdXyAX8xPa3gsuZzxWOwhdQKORZaAvQcHxxuThz7kbZYHi
 s2FjTCm9Jm62Vdbou8Dzn/twdjiO0Slhh8DOMCvaBcJ9mBt3nJWqdtGJcuBYAYi6TNXqABCes
 hOlnFdCsWoe5aNpfbu0cL32DRqojLzF9Z+OsyYTJRNN/0faPdlgjMonkgznN1Dw2fcpGCGCw/
 A3ofJEHKWYkbZyyYM4ld9P0arURp0h4Couee1b3ZYPKKqsCuRQia7L6xOA69VnnjdNykyTF/P
 dxyCbBCvTW8Vxtw9K8FOUB8m/U7QDtqkYYb9+n/joB8oeryn7zWaNxVE+xru682dAv6x6quvR
 Kc26snyPiL8x+CplVr6Wt92/PfGURXiFCH4E+kT8Pg6/BBd8BIvlPm4/O76LR4N9Iu1i44vvq
 uoeexULBLq47WHNLcOFsR4U8dMRyhAUm4oRN09dGA7k92cAlq8d10aZ0cSZ71Aaz2uqyyL+I9
 EXpp04mCV0dgHVP/t1QIICYiTF64S5n/uNy76aefSu48JjmgYV5Fs3Tbw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

"hardened usercopy" does not work correctly on ia64. And deactivating it
with `hardened_usercopy=3Doff` in the kernel commandline seems to make no
real difference for specific Itanium 2 CPUs, namely:

* Madison (in rx4640 with zx1)
* Montvale (in rx2660, rx3600 and rx6600 with zx2)

...which can't successfully complete kernel boot with and w/o
`hardened_usercopy=3Doff`.

If "hardened usercopy" is deactivated in the kernel configuration
instead it seems to allow Montvales to complete kernel boot successfully.

@Pedro: Please correct me if I understood you wrongly here.

* Montecitos (in rx2620 with zx1 and rx2660 with zx2) instead seem to
work much better (both kernel boot and userland operation) with
`hardened_usercopy=3Doff`. They don't work w/o `hardened_usercopy=3Doff`,
though (rx2620 needs to be checked, true for rx2660).

* Tukwilas (in rx2800 i2) seem to be not affected by this bug at all.

****

I compiled the stack traces of the machines I tested on [1].

[1]: https://pastebin.com/raw/AKfZrjWi

Please also see the originating "Re: rx2660 + debian" thread on Debian's
ia64 mailing list ([2]), and specifically [3] where Pedro and Sergei
start to dissect this problem. [4] shows that usercopy problems already
seem to exist in Linux 4.19 (for Montvales in rx2660 with zx2)!

[2]: https://lists.debian.org/debian-ia64/2022/04/threads.html

[3]: https://lists.debian.org/debian-ia64/2022/04/msg00021.html

[4]: https://lists.debian.org/debian-ia64/2022/04/msg00022.html

****

If you need more information, please let me know.

I haven't yet created a bug report on "bugzilla.kernel.org" for this.
Does this need any more information than what I just wrote above?

Cheers,
Frank
