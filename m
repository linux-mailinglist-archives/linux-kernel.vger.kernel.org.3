Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01B75A7386
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiHaBt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiHaBtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:49:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295EB2493
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:49:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 193so2156764ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WBgIYiK0R8MyjOrBW9Qr0NQe4i20glZFZfsxiGjR9Js=;
        b=UrrZ3gdP0DYEzt2tLaTueomDMpcDl9rxoco194EQny8lyNhVtuVOjWt0NhoRhkcQXf
         MToHlti/EMdQyxSlvPHLd299yLJj/5rpKMd99Ugqaqyqp332oBu0v9TF1tStCO4Wf1pZ
         hybPkjtxwYlWHqdBAuPxA9U3Czk1LSlkvi9cOeEfNBPmTQiGChjDHINeA9IfVG0Hw92s
         z0dRDzENZOXd0RuKe0vP6cyFn2Fs8RWXdhLBUnCzlub4yMsxiTb4hHdJ6bQj+6KJFEm1
         cagvjZcos4RlGUx1EOi9Liz2wC9KfP40z2qkwmEAGrX1lljSKkdJ/Tw4/VKjlJQqCLdw
         00xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WBgIYiK0R8MyjOrBW9Qr0NQe4i20glZFZfsxiGjR9Js=;
        b=SniVo5MlsE6sNOsZwpV+6B9YpBaRbSnVcAY9PO0bpmaeZsUbTg5KjRQmdAGYaAuoOB
         IA0o9u4I9aqt+LKFD9vR2vMNpyO3uEnzq4nHT0SrDycGJ/EUxwTwMg00s7SZScuH6hHV
         YRokEpyBrNEPqAL33rghRSD+NOZgmYlhc4EyhwKr251ni8S1jJA1+xhN2eguz2NG63rv
         VyZVE1Qrn0KFbgP5vVOBad59C2Eu4V0zNc/lLiJInACYOiHoD3jbRyHWOP5tcEFd00Xm
         w2ymHZT0iHfxNPsPdPbs138DtLZvYZqO/NlCSYRXGdGBEJRdrsns5rpOUkTPRNBjlOfN
         LLZg==
X-Gm-Message-State: ACgBeo1c0qQJ3rZ1adr5WO38DEAiGXGhDy5YY97zPDYPMYdbZ/KlSENC
        8WW3WgdKMf/Itoq80vvJbZ2zOXoqjJVOjHcrz4Y=
X-Google-Smtp-Source: AA6agR5v+P0bjKc/LRs/ofzxWFzyP4hxcvl7IhyadMjop5OY67JxjkkGONKU+jN+FlyzR2h3D89Cee0OXwhomiRh1XQ=
X-Received: by 2002:a25:9948:0:b0:67b:fc24:642d with SMTP id
 n8-20020a259948000000b0067bfc24642dmr12933701ybo.42.1661910581149; Tue, 30
 Aug 2022 18:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
 <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv> <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
In-Reply-To: <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 31 Aug 2022 10:49:30 +0900
Message-ID: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
Subject: [PATCH v2-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To:     Baoquan He <bhe@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.

Add one more extra cmem slot in case of crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
Cc: stable@vger.kernel.org
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c
b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..a11a6e14ba89 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
  u64 i;
  phys_addr_t start, end;

- nr_ranges = 1; /* for exclusion of crashkernel region */
+ nr_ranges = 2; /* for exclusion of crashkernel region */
  for_each_mem_range(i, &start, &end)
  nr_ranges++;

-- 
2.35.1
