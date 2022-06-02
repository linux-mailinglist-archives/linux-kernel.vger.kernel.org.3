Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26753B2B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFBE0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFBE0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:26:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4F29566B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:26:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so8230999pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=07OKdl+NR+lEY+BPv6L1IZEtN57lA0Mz6uUlDluxQyE=;
        b=Qrmeo5c948/IdijZouKusOBj8+3ApTb48cCYu5OOEdxGq7X+xEraJzHzO9puKeByBf
         P13j9MpgJWHCXk9eZQ/Diw53LN4YtWN5svBN4a9aApyyPK6fDxbGdSzss6G4Sehyr+59
         BUw/GFmNdhx3Kzr6rUp8kzFfFiNcvOfmhKJ8c9TgACi0J8q944ZjJd18oJiAzOctnRcA
         b61rR7COJEsB/u2FtIwsne+MVvw/eetYgYmIfsCLlR9rlHHKDF59TtMqmXa2bV/338Yg
         9xKys9CoZ+t+obTEHMx4ZaG8nWD5Qd6+iSnehoCUS+7x7BQqN3RlGJZaqCs0yR7ZFVMz
         wA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=07OKdl+NR+lEY+BPv6L1IZEtN57lA0Mz6uUlDluxQyE=;
        b=uhxH8oFtKWkM1hgu/KZ2n84vtj/wy+Y6eyHRc7pzBdMJNOh54ND+y0UAtbNVKAAyCV
         qMUQyi/N3vB8OuKzBuuoPDfsAh4YEdhNsuGcPMS5EDUs4+8MQJRFjIYyj244lcQHOdMM
         1sbApLGdWAc1nuDSElh2SI1X6dw6ICfHInmh0zOUpOSVZ6zVX8iPo7C4b9ERB2u04X+w
         INZdFW7sU/80BYWk9mvyvxKCdYAlTG7DESkYFM75c7ijrDX4PbQhjWeXP++FbisjyWT7
         sxzId53ZOV3vNewqalLuLFFc1HYEe9qpujnXEkQP8Jm7FfoFuOUBd7C7k30UJDsZ9uqs
         XQag==
X-Gm-Message-State: AOAM531CVrnCDbqAlRGJIR6Thh4Ai/1tl8S8XVuKMipdtni81qX3vV1D
        ouwLjG8d1rcnEX5KIY382O4A7Q==
X-Google-Smtp-Source: ABdhPJxJZEw2/wu1mLFm7uXm2h9zayuqLLNGNyNu5dUcwkEWMsKxztPJejEVkOOycK4a8cW19zPQeA==
X-Received: by 2002:a17:90a:aa8c:b0:1df:359a:1452 with SMTP id l12-20020a17090aaa8c00b001df359a1452mr3057296pjq.75.1654144000765;
        Wed, 01 Jun 2022 21:26:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 137-20020a63018f000000b003fbfd5e4ddcsm2218899pgb.75.2022.06.01.21.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 21:26:40 -0700 (PDT)
Date:   Wed, 01 Jun 2022 21:26:40 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 21:26:06 PDT (-0700)
Subject:     (RISC-V KVM) Re: [PATCH] RISC-V: fix typos in comments
In-Reply-To: <20220430191122.8667-6-Julia.Lawall@inria.fr>
CC:     kernel-janitors@vger.kernel.org, atishp@atishpatra.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Julia.Lawall@inria.fr, anup@brainfault.org
Message-ID: <mhng-523319d8-fda9-4737-9c43-d54bcfd7a7f2@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 12:11:20 PDT (-0700), Julia.Lawall@inria.fr wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  arch/riscv/kvm/vmid.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index 2fa4f7b1813d..4a2178c60b5d 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -92,7 +92,7 @@ void kvm_riscv_stage2_vmid_update(struct kvm_vcpu *vcpu)
>  		 * We ran out of VMIDs so we increment vmid_version and
>  		 * start assigning VMIDs from 1.
>  		 *
> -		 * This also means existing VMIDs assignement to all Guest
> +		 * This also means existing VMIDs assignment to all Guest
>  		 * instances is invalid and we have force VMID re-assignement
>  		 * for all Guest instances. The Guest instances that were not
>  		 * running will automatically pick-up new VMIDs because will

Anup: I'm guessing you didn't see this because it didn't have KVM in the 
subject?

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if that helps any, I don't see in anywhere but not sure if I'm just 
missing it.
