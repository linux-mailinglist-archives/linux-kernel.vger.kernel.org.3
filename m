Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD005A37B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiH0Mti convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 Aug 2022 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiH0Mtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:49:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DA491FD
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:49:31 -0700 (PDT)
Received: from mail-ej1-f48.google.com ([209.85.218.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MgNMV-1p4HCg3ZLL-00hxMx for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022
 14:49:29 +0200
Received: by mail-ej1-f48.google.com with SMTP id sd33so7588617ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:49:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo0O5sN0nMSxbKM0p9Fikk69MZnY7vef1bvF35hF3ygvq+VSYzCu
        6PjX4Q+L/IZEZVtvI1uFffZtKIM3AYeHv8Xz3i8=
X-Google-Smtp-Source: AA6agR4J9XTdGZjJb8R8xF2Baz3XbMezjaE/aWqaT70o2dkgXf9PwjIXOYEASc9MIhHdMWKvcgt5om3QPK6lTDMaEZo=
X-Received: by 2002:a17:906:8450:b0:741:5b1b:5c7f with SMTP id
 e16-20020a170906845000b007415b1b5c7fmr501641ejy.766.1661604569536; Sat, 27
 Aug 2022 05:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-2-tongtiangen@huawei.com> <CAK8P3a0ixaYimjCh77QBJpbHbVsw+9C7RiW2LEnwQ8HnwG_jHg@mail.gmail.com>
 <c0e286b4-3005-71fb-3bb2-476944099d4e@huawei.com>
In-Reply-To: <c0e286b4-3005-71fb-3bb2-476944099d4e@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 27 Aug 2022 14:49:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0akgBkyVQuAfi5qdi9O5DhxZJ3FknxGH-gedpJpAVw6w@mail.gmail.com>
Message-ID: <CAK8P3a0akgBkyVQuAfi5qdi9O5DhxZJ3FknxGH-gedpJpAVw6w@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/2] riscv: uaccess: rename __get/put_user_nocheck
 to __get/put_mem_nocheck
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Ph1mSXHvx7ywdmimX2k4dMJltenSjeYp6dLHodCcQqPFWwPmcxZ
 agvJVY3UUKBvOrubqP8IxCqibIKXYNaGQOFn/DYGFkq5nndB3zbahgZLzY+QiaJWWRbipdI
 zYB2yPV3UPVlB7MnFH69lU9VnOgb1chtV0r8reEKjguN+R5Fdy+aAG1GXvAoxpQ9ZMPo0iQ
 csAC/sPuJh+3cxK1JO9VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zIQiTkI6cW0=:wZ0731ZaM9g/WD9beeaEqn
 gL3lU5b9H3IORECa1TdwJEwtO+eUjoNO+Fyzvevn5xRNEdpRmO6JhG/QAdJA9VYnYkosFjODL
 2t2BiDRqdBNFNGOBX+xRdbQU6SIuazZf+LWGgZdgXQIgASozkfug6HVkBZUkVqnP8Dn06xX0/
 fCCCpI1FAIqfAQTbYUqy3SA4+3WLrjL+GRglUHBToLZ0a6pJ8e0TX9C5wri0aDmcUTdoZI674
 k43i7K2JbVqe2PTjimbOTs1y6lXVkr2ZAvukZdGFNdURpp7JqXWRAg3A1oph4vaKmC6X8dBd2
 nfsZm4FU4aAnN/VQ6fNT1SnIbNhgZ79AZrZXIDk/rSMKQVGoXlYLUV0x1byf18bCIkoxqGsqx
 s0sW15OKcAMLZ4wFpxuynPWLgpHgN0QwsNJ/NcASZ244VR34SJ//B728rc0CPIG6RBUlKxvms
 W6D3opWLKhUCYgPECIHlmfLlKzfrmIvjw/I+w1So3RAi/opzjGZyjrEskfLmh74d2Y+frMRYO
 u9Yqfo0NOiPGapq5RjylhJCaq0Mv3hMzkA+RyMqc3whu4W5ElNW7Ljq6Nt1tNcNEp4QgEkyDf
 KPfQQxWsFyV4Dsg2isEaQTi8db/3A5gPzUEhZTpA+3q8xBvR0acaNrznlwkhPtjh1w9mmkaqp
 ILGR8rKAPjCSS4+LvRJvRv6hue91RcfFJtAIOzyUxNzyhcjs/ZUGYAuIzLhMVVRDQaJs1Ul7C
 F4o0LKOPucBQdP2VH5V6uGROLZY2YiscKoGojw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:43 PM Tong Tiangen <tongtiangen@huawei.com> wrote:
> 在 2022/8/26 17:30, Arnd Bergmann 写道:
>
> I am very interested in the implementation of X86. I need to investigate
> and consider a cross architecture implementation.

One more point about the cross-architecture work: it generally makes
sense to do the most commonly used architectures first, usually
that would be x86, arm64 and powerpc64, followed by riscv, arm,
s390 and mips. If we can find something that the first architecture
maintainers like, everyone else can follow and you don't have to
rework all of them multiple times before getting to a consensus.

> However, I understand that the modification of the current patch has
> little to do with the two points mentioned above. We can optimize the
> code step by step.

You are correct that this has little to do with your patch, my point
was mainly that your patch is moving the code further away from
the other architectures, so it would make it harder to then do the
changes we actually want.

       Arnd
