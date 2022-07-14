Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1115746AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiGNIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiGNIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:25:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B873AE40
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:25:08 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Md76B-1nbk7k05pL-00aHEC for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022
 10:25:07 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3137316bb69so9469627b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:25:06 -0700 (PDT)
X-Gm-Message-State: AJIora+cBCM2/Um/q4pEP1VTDRafKT3IATWfiihJiP9TCrdS/s62Smwt
        QUi06BvOTEEXEqAidIGzRLeWrwuv+HsKEXIlcVg=
X-Google-Smtp-Source: AGRyM1vt2i+MLzQoQ8EUAstVq2RqNs3pwOpWRFUMpYqOFMtyP7eGTQHRST6xfO3JNud96tGfOfo+oDtOe953D88c1j4=
X-Received: by 2002:a81:d93:0:b0:31c:d32d:4d76 with SMTP id
 141-20020a810d93000000b0031cd32d4d76mr9102171ywn.135.1657787105766; Thu, 14
 Jul 2022 01:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220714025901.359695-1-xianting.tian@linux.alibaba.com> <20220714025901.359695-3-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220714025901.359695-3-xianting.tian@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 10:24:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-jKEs+uGL=_kjmfzao6DYgmrkO+YWtNhv5O+hFw_qog@mail.gmail.com>
Message-ID: <CAK8P3a3-jKEs+uGL=_kjmfzao6DYgmrkO+YWtNhv5O+hFw_qog@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] riscv: Add modules to virtual kernel memory layout dump
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Mike Rapoport <rppt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        huanyi.xj@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Meby81FiNPBNulXbVWAnTvyAvt6U7M6RS2gfN2IYZ8hmtP8fjwW
 3u3xSNODWk0PNrkgK4k8ONjJYlCMa/7f+2qxrKOSfytiFUov0S60vOiwfILh41QRwv46BvC
 8lxLGmxou09XWKziRIuAWAWPzG8+BlJPAmE3B5duC6HVm+wyiDqknVxA0+mUJ1nRCIk3bp8
 obtS0UIKMFJRcU1O5IktQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:94Kw0jlsFTA=:f8xaTEd4KXV3py8SxWBb6w
 2vTmwMCGcGlaa9TmHIsS3wsRPdPX4AB9VQMd8kgb8bgMRGZO9cs/cD+2OD9cmerxIysE2Db7S
 LVPkLXGQAwg15FEHCaXieZnx+6HbOOlsUfb7DJhuwRqIm25J73ZFXLUGMlHZr/hsJWUu7u6Gh
 l6UApB9oY4tgv4LbCxYhZ8qVkUlFdCJ+NAW43Pd4E4YUa+DPyLsEKfALt8eFTGr/U034VUoPu
 Ws0S/6XJb3gaXkd05VlM27HRxyJotcOKhAvCunK8TveZuhqBdZsQSf6gx4mUM8R9Q7YUkodGp
 y6cN6X2eGvj0l+QnMdA9U8ri/9vu4tqATQATRhQsbXL8ZjpmDTfav1f1DaPP/VszYm/8BzptE
 XVMYEk+s5VWPEG+biyw4EH/yHSwyD9raAogRXgZjwbtS4c51Fny4Q2yVd/0DE3jwwZy7PumGZ
 HlICjRGhaOmpSMhN82BYi2gB/Kd54QyP1csUridQfqjIrwn/yG72NyowdRsv1QRdZO6TkjChm
 Sp7I/O+uaV6mIX3Ml5w/FsHHxRRN6a5P5E6f+LLwv12Q0OJKIHaZ5rbana+PYYyCR+Pju2oDH
 yabiNIcQn242NrDf1JtBidBqsBByqZItocoRFp2mnqUNA/2DhG52NQMMIL9pUtTsluk46xLC6
 oqydCAgUjLwpPHPDPd6Z96N0SsSJS64RHBvIqknCHPSbDJGy3nLP58aFa0yGyMipmQ0Zufsj/
 fO27+TliBSd1P09TZ0vWP6q2CGivfQd5nM9he120MLfwfvcItPj+AMhlCvOzqP7ZR8/bFDh24
 AXTLuOLAiiM90gDiz0SlbJhw9/7TB5j6oxzOzmfBvdou3EmoiygN1os4ZB5s7p/IajeAJQfo3
 d+squEe7JvlGUtyuJwLQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 4:59 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> As MODULES is only defined for CONFIG_64BIT, so we dump it when
> CONFIG_64BIT.

Doesn't this cause a compile-time error on 32-bit?

>                 (unsigned long)VMEMMAP_END);
>         print_ml("vmalloc", (unsigned long)VMALLOC_START,
>                 (unsigned long)VMALLOC_END);
> +       if (IS_ENABLED(CONFIG_64BIT))
> +               print_ml("modules", (unsigned long)MODULES_VADDR,
> +                       (unsigned long)MODULES_END);

The IS_ENABLED() check prevents the line from getting executed, but
unlike an #ifdef it still relies on it to be parsable.

         Arnd
