Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36758FD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiHKN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiHKN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:27:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C752868AA;
        Thu, 11 Aug 2022 06:27:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k14so14451940pfh.0;
        Thu, 11 Aug 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cnf/MAxWiWhTvww3StaIlwbuuIs/IrBQv9ORD2Fnzb8=;
        b=hhPtoXRk4+PMkZG0gZrNZYrmTu9yA5qnBlJW/2XP1icOeQdYBgKVgkMbHgOpOKC57a
         fc/S6afY1H/glfIdPydeAvLShJHuTnYm58U0zvqTKxx4wi6lWk98E4Pg0+2hjd9P/GPg
         i5R5cAmbRMUyTI8diaSBjd6o90JhNnWjlOuTi+k9x9W27uMu8ibnrboZIunXU2w4xYtt
         uebnfFQBZJELurcjq5g+4gCgW/r5rqUp2RW7oWtVDrz0iqDCauBtgPOuPS6q4WjpWmMO
         m4Z7PyO5A7R8KtrQobFQ0BstZLgzzW0Zhd9FepB7/OfA0ywYwdtBdM3UUUIsgitDlpiN
         K9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cnf/MAxWiWhTvww3StaIlwbuuIs/IrBQv9ORD2Fnzb8=;
        b=6eTC8qlJ+bxKz7F9re0kvVr+PsWx/2EqnnZOIFKb5WPpsfJzLjCMZtI4U3ZxtwnsuZ
         Ea6/YkKryz3jMzqYPXrSEkZzVdz7i5VuHLBdVQOckJa7zMFTUaQkXXqomIoJZP4F/j6B
         SThONhsDG4raogJcnn6GdOyFLEZrvHCG8mAdLVd+1IjpTur7n4nswMYvbnfJp8S+5CuH
         EWAXwscV3rw0obQlkFMq5CUHopw9Ax+pxn8l/8JHyO69ci1B0PVMUSPzoLY4+GcFa+5K
         sdPNVXSIgzoo8ucfdihrjlPf2TTDa5qubae9umrFtcQfQTriJ0CanguGE+SDVIdINKSQ
         fQ7w==
X-Gm-Message-State: ACgBeo3KwGSQcbB8u/ohNGC26FSDYTpRNUTGh63lhhwsnnyHpFrOC29I
        SoG2gXZMKqK62XonqoGUAVY=
X-Google-Smtp-Source: AA6agR5HAInDscx1ZEMqvtifjzDB5GvCTp7d9zggxvQzL5N6SNN9kA68Z6Wvry9fG8i2/7CjEkGCOw==
X-Received: by 2002:a63:8a42:0:b0:41b:dddd:b81f with SMTP id y63-20020a638a42000000b0041bddddb81fmr26717842pgd.229.1660224434107;
        Thu, 11 Aug 2022 06:27:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-16.three.co.id. [116.206.28.16])
        by smtp.gmail.com with ESMTPSA id x130-20020a628688000000b0052dd9dbe291sm3972954pfd.105.2022.08.11.06.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:27:13 -0700 (PDT)
Message-ID: <f2336f93-53b4-b031-9e1c-67b6d1470f64@gmail.com>
Date:   Thu, 11 Aug 2022 20:27:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V6 6/6] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
 <20220811074150.3020189-7-xianting.tian@linux.alibaba.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220811074150.3020189-7-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 14:41, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS, PAGE_OFFSET, phys_ram_base
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END
>     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> 
> This patch just add the description of VMCOREINFO export for RISCV64.
> 
Better say "Document these RISCV64 exports above".

-- 
An old man doll... just what I always wanted! - Clara
