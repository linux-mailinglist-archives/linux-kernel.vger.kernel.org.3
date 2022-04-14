Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4696E500C52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiDNLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiDNLpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:45:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0A56407
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:43:10 -0700 (PDT)
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5fQq-1nYvTD28fS-007AXW for <linux-kernel@vger.kernel.org>; Thu, 14 Apr
 2022 13:43:09 +0200
Received: by mail-wm1-f46.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2987745wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:43:09 -0700 (PDT)
X-Gm-Message-State: AOAM533DzTwEJ6tneHnpMJqWZckocWPQ/b33zL1UuOSeeuJXtzfR9NZ8
        aP+iqp6WNCneTnmxMePpIO7q/307lVssxZtD/N0=
X-Google-Smtp-Source: ABdhPJwyuaHiBqp25K63KJ94LjNVOLjmoQMGgnJK2Uo34IKm32rZZPdlVgnEeNBcFHyaIKdZ+bFPSxjnzUfcUiKGIBA=
X-Received: by 2002:a05:600c:25c5:b0:38f:f0b9:4c8c with SMTP id
 5-20020a05600c25c500b0038ff0b94c8cmr2925041wml.20.1649936588976; Thu, 14 Apr
 2022 04:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220414014010.28110-1-palmer@rivosinc.com>
In-Reply-To: <20220414014010.28110-1-palmer@rivosinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Apr 2022 13:42:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=iBLDC5X-+OEUUvQmcWpPXkuBnk__6g9GNORo9k0zBg@mail.gmail.com>
Message-ID: <CAK8P3a1=iBLDC5X-+OEUUvQmcWpPXkuBnk__6g9GNORo9k0zBg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add CONFIG_{NON,}PORTABLE
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sS96UWakCliuiVL0Dcsz2HDVK1h7JTR/Mw6cbsokzcgqz3hszSd
 cEmSlArl3DYs5H0AfujQ/iioPY/zED7zz5tHHLUQDMDYH6OhV+oRH39yETn0hvsBlqtsNY9
 5V+wvq9rOCLXyTbw+v02yBiB/dL9Iw4ZbtM/s9nM2LYGaRl5m1tQfhJmDclRG2WGglXsbSe
 Rens9/gQtM3HyTQygoIPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZKIcZz3zqxI=:Zleej6AauDnsnh/Wya29W4
 wet80YXpLQs13XBRkESsHQodQ7yCfgnJuEd1CxjIJEa5h0RZJ9T2j71L30ait5ytrwaJz2c9g
 mCEGMZb/dhFCzS2I4F+WgbEAGM3GLbrWy/63oOY77nEEPCk3m36icLLy4vvagMYWb25D8KqdL
 xFpZ6BPISTV8HEGGcaGK21xjNxy5uzryAaDi84wv6BdDjxawpxVKlsU5iX5oYN2GfPr/GM+09
 E2o5CeF3Hg3zDXhvmMuy65l4uRBklpL++olMExOwKoZl2RfXOLIRGSOMTv0uGvc+QOpm57XFv
 qRuT6LlRPz7Zhb3tbmMIpbmwfF/lGIJuHoesy4Ivsa8vBxFuvKtL1V1WG2wNrB45WKW5c7Mlr
 JOdeS20th7iCVVPUUjdCQYlUsw0U3H07RLGLYd+lmy+ysVmx4R4wYz5GZ7mV01ZXY5Ym6FNt6
 fGd+ANsQLxrkBCKLk57Ih+lksCBHVZa6+aCZhulwbyM2ZL8MOfH7dfQV5qEqXTyRvBHVzGJ9/
 H/6h9JOWbGUjaIG80163WQymNDIArRMiA0W6zbXczM/Yb1D+9BQJgYQC48ZluycYCMGmbEksZ
 WAu/koDMVLIRsN7/L561yj9bxEK8ua1DJ8JxFOOsFk9tp7whBhFehVCV+kifhTZUjPLi8xjFU
 Ueg7iEppAQQntmDQsC6FLQUAyED1ZUsbJz1ylHp8O/+txhY4Hf9YOFLmiZ/nMg3RO1X18mybZ
 Vt+26q1Q03uhW2o0GZrkatdw/whmfMW5cq4Q47HINkN9C3HYazAjffFxJpQ9flhhdyF8kqMMj
 gUiMNIFjnG/6ntegQFCVZv6VeMmADUoDyNHVdHAENE5OelF3WE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:40 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The RISC-V port has collected a handful of options that are
> fundamentally non-portable.  To prevent users from shooting themselves
> in the foot, hide them all behind a config entry that explicitly calls
> out that non-portable binaries may be produced.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
