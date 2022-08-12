Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF145911F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiHLOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiHLON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:13:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B21F2F4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:13:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z16so1331995wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=E4JPtvsTDamtMFqwau0g/GY/W4zUAlwh1hRHFDce25k=;
        b=c6nHRRoj/+2Dqa1s2A5U+L2edwSBxY52Lr7JUJnYsSn+M/jIlR7yUrl8oIztURxFPG
         MdvxQIxbF5PrXWzBHT8SuEHPKHYfZ7EfS+SDza250wY6DrPKVvL4jQyFUSiiBbarWBOo
         Ur422oX44qtxqPDFZEsg+naMASIjpODyOe0nQx2DDYx18ddjO4s6DdF60LoaK0/WO3sl
         bikkX8BezC6vTqt2eRac6vilxae1ORVubzVVCFLhSJJZ0DykBkWLC1UAgf4Jync5wJQm
         zwM6VqEMhjNMRawBwrU7PZ48jv1Y+91aQoRj9lyIOf7VkyEbeRIf1nj3gEopb3JsviKr
         CWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=E4JPtvsTDamtMFqwau0g/GY/W4zUAlwh1hRHFDce25k=;
        b=yErA8hQcXgJv+/Hc8tSU+5X7yJpwiZ7SIqXigOV2d17j80VkYT6AeTcXv1393O7Kq5
         JuDkdrILu1eKGPGozMk8fiLOuPuZ/RLrQDOZ9vaZLPq8dWAyqGw4+shLEsJz6ky1FxHH
         e3ZZsA2QEHigdNOfqqANIzlr7iF24YwdX1AoqKI7LGCtR/122m9VCWXB3XJyN00FqsDg
         7NSXuADYqz9T05NiOE7RrZHjDtjiZm0WTOlQTvz44HO7+HGQY6+lUue04CYhfRaUrULx
         m23SveqO7yjl8n5YfisEhTTOzeawlV9lYDrzdwXEthJQa+rNVMDL/Y5fVH9xT4K4t+a4
         Ioag==
X-Gm-Message-State: ACgBeo0rs72TJ/6Z1edOhP8Q050Me2ltIuqOqFrxp7c2spTirXXz9CBY
        oUrN3k/vwi4V3N48Iuaxd5hoSg==
X-Google-Smtp-Source: AA6agR4CRKUeJvXj9MfeYDX1d2OqDrZn9NbmbzCxoJBiRuZRrRhMvwNKsxx0TCWg9VxF4XAwAmreIA==
X-Received: by 2002:a05:6000:c1:b0:220:5c10:5c51 with SMTP id q1-20020a05600000c100b002205c105c51mr2181769wrx.668.1660313635838;
        Fri, 12 Aug 2022 07:13:55 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d494d000000b0021e4f595590sm2001393wrs.28.2022.08.12.07.13.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2022 07:13:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] perf: riscv: fix broken build due to struct redefinition
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220812135119.1648940-1-conor.dooley@microchip.com>
Date:   Fri, 12 Aug 2022 15:13:54 +0100
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2055040C-D443-47FD-B6E2-C4C6B3E600B4@jrtc27.com>
References: <20220812135119.1648940-1-conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2022, at 14:51, Conor Dooley <conor.dooley@microchip.com> =
wrote:
>=20
> Building riscv/for-next produces following error:
> drivers/perf/riscv_pmu_sbi.c:44:7: error: redefinition of =
'sbi_pmu_ctr_info'
> union sbi_pmu_ctr_info {
>      ^
> arch/riscv/include/asm/sbi.h:125:7: note: previous definition is here
> union sbi_pmu_ctr_info {
>=20
> This appears to have been caused by a merge conflict resolution =
between
> riscv/for-next & riscv/fixes, causing the struct define not being

union, not struct

Jess

> properly moved to its header.
>=20
> Fixes: 9a7ccac63f9c ("perf: riscv_pmu{,_sbi}: Miscallenous improvement =
& fixes")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> drivers/perf/riscv_pmu_sbi.c | 14 --------------
> 1 file changed, 14 deletions(-)
>=20
> diff --git a/drivers/perf/riscv_pmu_sbi.c =
b/drivers/perf/riscv_pmu_sbi.c
> index e7c6fecbf061..6f6681bbfd36 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -41,20 +41,6 @@ static const struct attribute_group =
*riscv_pmu_attr_groups[] =3D {
> 	NULL,
> };
>=20
> -union sbi_pmu_ctr_info {
> -	unsigned long value;
> -	struct {
> -		unsigned long csr:12;
> -		unsigned long width:6;
> -#if __riscv_xlen =3D=3D 32
> -		unsigned long reserved:13;
> -#else
> -		unsigned long reserved:45;
> -#endif
> -		unsigned long type:1;
> -	};
> -};
> -
> /*
>  * RISC-V doesn't have hetergenous harts yet. This need to be part of
>  * per_cpu in case of harts with different pmu counters
> --=20
> 2.36.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

