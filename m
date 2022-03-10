Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC954D4430
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiCJKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiCJKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:05:41 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4ACD31C8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:04:40 -0800 (PST)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhDAi-1o6HVE1Ws6-00eIhQ for <linux-kernel@vger.kernel.org>; Thu, 10 Mar
 2022 11:04:38 +0100
Received: by mail-wr1-f50.google.com with SMTP id i8so7090996wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:04:38 -0800 (PST)
X-Gm-Message-State: AOAM530bsbHBCj5CyVZ2C2XyDNB8fLZlScwvY1mX97WHBbv2ol1Q0jcE
        X0/i0j7U3LidVFsdylehtPXGo5aTau6WThIb+tk=
X-Google-Smtp-Source: ABdhPJwnKkJ9m+P/36XGjGEqD3vlvPg/jRF/Wj/K07yk9VHlwA7y90Q0iyMDL91ReCja0B5RxvS4XCUyvrRCFeWnn90=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr3073422wrh.407.1646906677979; Thu, 10
 Mar 2022 02:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20220310065045.24772-1-yuehaibing@huawei.com> <20220310095852.GA1699@willie-the-truck>
In-Reply-To: <20220310095852.GA1699@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 11:04:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2=iRLqM36wwxtQRrCwrZ2-tkBZPZCqqba-4kmk9GxcCw@mail.gmail.com>
Message-ID: <CAK8P3a2=iRLqM36wwxtQRrCwrZ2-tkBZPZCqqba-4kmk9GxcCw@mail.gmail.com>
Subject: Re: [PATCH v2 -next] perf/marvell: cn10k Fix build error without CONFIG_OF
To:     Will Deacon <will@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>, bbudiredla@marvell.com,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4txp9izM6MzI2bGLKs7I9aN0ltuX67LQEcn81l2ASUQSJk4y2zT
 iB3+6f00h9mfP0DVC/9SLlt0RserDJMxM5XluVkvnkC75/3DK9kRqPlkXhZ9vgmrjwHQGdk
 fRQovkYIY/CcHZwJGJrZYZVa9zThSoD3dniuvbEEGagAXoU+4SskSNeMWvY/qxd8154HtwV
 5EUrMJEnqUO1hSI7hFP6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGYBwem63ok=:46p3qSSbACnG6nRhYzE0F1
 s/3FLOfMJYQHldM4wevytNe7HJtsHfcWMDzgvTOensO44yN5Cst0XgmPEGQIFXp7M4kNo/ml+
 7aJAu7180K0OyjC7Ds4K8j6LurjwZIKLJOpAMK2UjxMtrhZWHVS3gkRtUgnhix9/nlJNCMtlQ
 ogrs+wjVDyWGhJPobGjiZYYpeBm7hw7WCEkkrFbX/jO4w/6Y026tozOQRprCuMw+kWsBH6e5E
 gNozqG4r1koPIlkh6PUShatAlCzh3mDcURe6sn1HwIx5iMU/lwhvKRnLvjz2VDmuEqjPMReZ9
 OM9mi28S5aa0NyvZrFaVVPy/1j6DaELlhoyBoUMa6LdU//U8ijy+qYd8j3aIGZ5CZC6/TrCrw
 TeuycY9aaA2Z5dO58fUL7nGHdnatUXXMkUVOyNrAGILW4onlB1cLaxjexu5kFlZYqMB/eZ/BF
 /qScz3TShul3EGA9iHvieDpgi7EQM2paufbmnNKOfpnJtrtVV8H8WRiID3Vz9LJKIbGy4LsQh
 BycWL6WF7o38ifz21sX7i66ltfzItxKqAiy3IaiNmCbLN+ks3v8qGvCvMJEY36zmbZzHcLSP0
 ztLzxL+mqV0+xnXpp/ulEtCIzhU+x7+tneurydEc3O1cCkq7u7mxI4AFyIRTtqdP6Qf12yQDu
 NP1fVjVCYe+W4h4FhOVKGzrlEwpuqF3ssbStXhv80FvJhhip0cGn5bdiZV3q+UQdw27s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:58 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Mar 10, 2022 at 02:50:45PM +0800, YueHaibing wrote:
>
> Ah, sorry, I already fixed this when the conflict was first reported:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/perf&id=6676a42f1e4f1b8ec166b723a3801b7113c25a0e
>
> However, I thought this driver could be compile-tested on architectures
> without OF and then we'd get some report from that? At least, I'm certain
> I've _added_ these ifdefs to other PMU drivers in the past.

The #ifdefs are never really needed, the only reason to have them is
to save a few bytes on architectures that don't normally use DT,
at the expense of making it slightly less readable.

For compile-testing purposes we don't care about the size of the module,
and compiling in the table unconditionally is easier.

          Arnd
