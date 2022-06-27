Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C655B5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiF0Dok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiF0Dog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:44:36 -0400
Received: from email.cn (m218-153.88.com [110.43.218.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60376302;
        Sun, 26 Jun 2022 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=Aa9VFD/brhjnAewjg23l+uXotwh571KmXbhLe
        Kyitjo=; b=FV/66KkVJcgVoFw77q+5kWLcRO0dSE573lkUv/ZN4NsSkYGt7sFDb
        Lc0PT0tqraoA5J1SVk0JzNt7CtVkKDQX4lNHx6hh/EnAUHTX9QQ1R5rSH9BeXiAG
        3S95kOEiLApjavVw/djgaAaYopdmQ61BDOhNECcBNNo972Awxx05PE=
Received: from [127.0.0.1] (unknown [112.96.54.50])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBX_xN9J7li7QciAA--.28330S2;
        Mon, 27 Jun 2022 11:43:57 +0800 (CST)
Date:   Mon, 27 Jun 2022 11:43:57 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Ira Weiny <ira.weiny@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: rename Documentation/vm to Documentation/mm
In-Reply-To: <20220626101352.109601-1-rppt@kernel.org>
References: <20220626101352.109601-1-rppt@kernel.org>
Message-ID: <F3F0294B-49FD-4CD0-8BD9-0B1B276827EA@email.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: GiKnCgBX_xN9J7li7QciAA--.28330S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDKr4xAFWkuFyUGFyDKFg_yoWDArgE9w
        4fWr17Kr47AF48Kr43X3ZIyrykWrs29ayDXr1DJr40v3s8K397KFyDA3W5ta15Xr4kur98
        G3WrZFZ2gF12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbYxYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW8GwCF04k20x
        vY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7IUjD73DUUUUU==
X-Originating-IP: [112.96.54.50]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E4=BA=8E 2022=E5=B9=B46=E6=9C=8826=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886:=
13:52, Mike Rapoport <rppt@kernel=2Eorg> =E5=86=99=E5=88=B0:
>From: Mike Rapoport <rppt@linux=2Eibm=2Ecom>
>
>so it will be consistent with code mm directory and with
>Documentation/admin-guide/mm and won't be confused with virtual
>machines=2E
>
>Suggested-by: Matthew Wilcox <willy@infradead=2Eorg>
>Tested-by: Ira Weiny <ira=2Eweiny@intel=2Ecom>
>Acked-by: Jonathan Corbet <corbet@lwn=2Enet>
>Signed-off-by: Mike Rapoport <rppt@linux=2Eibm=2Ecom>
>---
>
>v2:
>fix hmm=2Erst reference in Documentation/translations/zh_CN/mm/memory-mod=
el=2Erst
>
[=2E=2E=2E]
>-  =E4=BB=A5=E5=85=81=E8=AE=B8=E8=AE=BE=E5=A4=87=E9=A9=B1=E5=8A=A8=E7=A8=
=8B=E5=BA=8F=E5=8D=8F=E8=B0=83=E4=B8=8E=E8=AE=BE=E5=A4=87=E5=86=85=E5=AD=98=
=E7=9B=B8=E5=85=B3=E7=9A=84=E5=86=85=E5=AD=98=E7=AE=A1=E7=90=86=E4=BA=8B=E4=
=BB=B6=EF=BC=8C=E9=80=9A=E5=B8=B8=E6=98=AFGPU=E5=86=85=E5=AD=98=E3=80=82=E5=
=8F=82=E8=A7=81/vm/hmm=2Erst=E3=80=82
>+  =E4=BB=A5=E5=85=81=E8=AE=B8=E8=AE=BE=E5=A4=87=E9=A9=B1=E5=8A=A8=E7=A8=
=8B=E5=BA=8F=E5=8D=8F=E8=B0=83=E4=B8=8E=E8=AE=BE=E5=A4=87=E5=86=85=E5=AD=98=
=E7=9B=B8=E5=85=B3=E7=9A=84=E5=86=85=E5=AD=98=E7=AE=A1=E7=90=86=E4=BA=8B=E4=
=BB=B6=EF=BC=8C=E9=80=9A=E5=B8=B8=E6=98=AFGPU=E5=86=85=E5=AD=98=E3=80=82=E5=
=8F=82=E8=A7=81Docmentation/mm/hmm=2Erst=E3=80=82

typo

Documentation

Please fix this minor problem :)

Acked-by: Wu XiangCheng <bobwxc@email=2Ecn>

Thanks,
Wu

