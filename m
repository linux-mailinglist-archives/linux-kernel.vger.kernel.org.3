Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3C4B9B43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiBQIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:38:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBQIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:38:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE71FCBC4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645087074;
        bh=4mhqX1evkQ31sV+XbtD3eomF6rseIEg3D3FtMSelXhc=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=VpEWqqm9NurKDw8bRdEeBK+lpb3bBon+7hRLdWMMFhKRFK1phEsm7fdX49DQi2WLx
         YScQjvgHdj610sRFszN2DlR+/VFuxSSE3yJRNnpdDAzNXm0RbogsAgEcEX9n61ORSx
         9eEQ0LfqqbPKZFukGoHthlxqt2wLCX05lLqYbEm4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel3n-1nt8AW065t-00akQ1; Thu, 17
 Feb 2022 09:37:53 +0100
Message-ID: <85bfe02c-9432-c5b0-04e0-8096adf37b93@gmx.com>
Date:   Thu, 17 Feb 2022 16:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: v5.17-rc3 compile failure on aarch64
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s0tc8KYPnkKgjOezLzbEi5WUCje+CbW1vcyMNQDiZx3oO58OXbO
 rhHS5Dx0345kL0vGiY91JGUtGnskAXnS40FArZx2jErx9eO1f8Z+8ZX6695cnlQ7hihnrW2
 LKrBsl4S1dt2T1uIupZ+nHQVDVe+U8g7uI7T2uKvzjwo1JK/hUnosJQ5JvHU0uo7LNzRfQU
 uqHmYGZrxss16kDaLyGIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+TgRwgr3BIk=:1LNpqw630lMB6ajaHvKhfk
 zzcRPupr92TqatyPodSU97pBjQrJAiMcBLmpmT0UVxuwPL3HrEm+CcvNgPWzmdSUSoDGFNDbt
 ShpxVLymuPr3DI9gRzwpR7hnitRDjY1K19pBKYZxrvTdaPZHaWXf28cGdvFoI6tm+4Ox0GPSG
 elJVWqgo2QQRUwjQ1AtM8mgh1T1UFpdTalJf/P7jw1hskXppQe/ZnMe9IsO7bPc2slZpEajse
 RZ0s029ihQXfikfRPX8RRQjFNSrW3EEAh1maH3VwBY66WxgHHwwcQGo6Vk+TkaJHLh04aSgqL
 u6yIPV9Cx9/e0JePQoQ6pQ7N3CUpcMdXDyDcdg8RwGLgrxuRDvrILPZE44cqgodCs7HpalYgb
 nLlKzLGc8gwAcqSnJGi2BGb+Gs7hAK6Cz4OaKFuy18ga+XdhahzcUt/tC8GNCN9MUhYoT+r1r
 j7SCkOc5rv1jQ9cuHY+PkFkaf9QIU5Fzoau/2FIaqfMYzZWRXanilVNW9EUjOuHoVY/SYlRiH
 g1Se8vOj/Qv6/5veEaoYuJjsJ2OPK56Z/ZgwvGZa9eO3azxBv/toTPS9LMP5BNlUE6zBxkM4G
 B+Ld8Nuls4ZJZroG8BOzCcN5UjUMB99dKlb7jPAbWNk7EGNiL4MhGy2XfcifGXtEd6Wu16V5l
 PCgOXOlrP2Z5hYQtll64DaLW0m2TOqAoDKTKYmMHmgrSEyh57YZ1bdj9W3xu1Ec5gUdHXvsdF
 yakngkgWtxPAzqY+nrGAYETG8DqyY4MlAyQq8sCrfct31kZ90lU5GB1jVSx1l7r00wRwZkz22
 yrepvzugKeBlY0hNLk13c9pKnsIHdXfFWOf4Pkc6YDO9GaFgQq5PJxU3dtkcxMOVLM41EsOnM
 r4jY3mnUdEdOhQqDaGE5Hf3BrY3Hd8T/4hyq61P4orkdZruR5lYvqW6QYZ9VjtbRQ/JqK6anh
 hW+eAmS0duQvRqAVn4jiblmLFhzklcxf+aufrDqt4VihK9QxJLh7QmhCPEwVDGPrm1e6EYr+c
 i2ITb/5rlmRsoswLiEDX1HUk5Kx9A2Yl/PytoQ7y9nGRvPUrsX3IJQ80WsahqMv//ag76dRvd
 eROwho5e9iDjz8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently I found v5.17-rc3 kernel failed to compile on my aarch64 setup,
it failed with the following error messages:

   AR      lib/zstd/built-in.a
   LD [M]  lib/zstd/zstd_compress.o
ld: __patchable_function_entries has both ordered
[`__patchable_function_entries' in lib/zstd/common/entropy_common.o] and
unordered [`__patchable_function_entries' in
lib/zstd/common/error_private.o] sections
ld: final link failed: bad value
make[2]: *** [scripts/Makefile.build:484: lib/zstd/zstd_compress.o] Error =
1
make[1]: *** [scripts/Makefile.build:550: lib/zstd] Error 2
make: *** [Makefile:1831: lib] Error 2
make: *** Waiting for unfinished jobs....

But the same code base compiles fine inside my x86_64 VM.

The aarch64 environment is an VM running on RockPro64 or RPI CM4.

With a little older gcc (v10.2.0) and bintuils (2.35).

While for my x86_64 VM it has newer gcc (11.1.0) and binutiles (2.36.1)

I'm super happy to upgrade my tool chain for my aarch64 VM, but I'm a
little concerned if there is something worthy fixed.

Thanks,
Qu
