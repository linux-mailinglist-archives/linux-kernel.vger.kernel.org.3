Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85E56C90A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGIKly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIKlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:41:53 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1092420BC3;
        Sat,  9 Jul 2022 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=r3m94tTtK7I6eGh7AMqOljittZ51GScc3vlJq
        wvf8Ig=; b=BoVkBifoaoOo8xlUAWrrTUjhlIPNLKOGdcP/PHioDdwOhD0Fz2Va2
        f+NRhCMVYemzYGxnO8W2CXsNnDcgyMOEySJa7uLn264E7BARWs6fRlWl3Z17TWfw
        kthkZo8lCRk8hwI4ZXeZpJJ9mOD/goabziXlhk0adA8qZWUxOPw3nM=
Received: from [127.0.0.1] (unknown [36.63.165.10])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgC3Z2RjW8liJQUiAA--.22530S2;
        Sat, 09 Jul 2022 18:41:41 +0800 (CST)
Date:   Sat, 09 Jul 2022 18:41:38 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_04/21=5D_docs=3A_zh=5FCN=3A_page=5F?= =?US-ASCII?Q?migration=3A_fix_reference_to_mm_index=2Erst?=
In-Reply-To: <b263eef6480040befa582e8e00162e6fb4407853.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org> <b263eef6480040befa582e8e00162e6fb4407853.1657360984.git.mchehab@kernel.org>
Message-ID: <AA3C4F86-E1AE-4799-BC71-28B22B12A388@email.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LCKnCgC3Z2RjW8liJQUiAA--.22530S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKw1fArW7Ar4xJr45Cr4Uurg_yoW8Jr18pF
        1vkr4Iga9Iyw1rGr48Wr42k3WUA3WxGa13Gr1DtwnYqFZ8Aw4vkryagw4qg3Z7Xry09FWU
        WFs3Kryjg3yjywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqqb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04
        k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUU0tC7UU
        UUU==
X-Originating-IP: [36.63.165.10]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2022=E5=B9=B47=E6=9C=889=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886:=
07:17, Mauro Carvalho Chehab <mchehab@kernel=2Eorg> =E5=86=99=E5=88=B0:
>This got renamed, so we need to also rename at page_migration=2Erst=2E
>
>Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
>Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel=2Eorg>

Acked-by: Wu XiangCheng <bobwxc@email=2Ecn>

Thanks,
Wu

>---
>
>To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover=2E
>See [PATCH v3 00/21] at: https://lore=2Ekernel=2Eorg/all/cover=2E16573609=
84=2Egit=2Emchehab@kernel=2Eorg/
>
> Documentation/translations/zh_CN/mm/page_migration=2Erst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/translations/zh_CN/mm/page_migration=2Erst b/D=
ocumentation/translations/zh_CN/mm/page_migration=2Erst
>index 566880a41ea0=2E=2Eea9647d060fb 100644
>--- a/Documentation/translations/zh_CN/mm/page_migration=2Erst
>+++ b/Documentation/translations/zh_CN/mm/page_migration=2Erst
>@@ -1,6 +1,6 @@
> =2E=2E include:: =2E=2E/disclaimer-zh_CN=2Erst
>=20
>-:Original: Documentation/vm/index=2Erst
>+:Original: Documentation/mm/index=2Erst
>=20
> :=E7=BF=BB=E8=AF=91:
>=20

