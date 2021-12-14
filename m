Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7B47480A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhLNQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhLNQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so13933934plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fayYzjKhb1ITyWmmaWz8uvl0NT3hSIICX61WlJhr3bw=;
        b=3npQRSPn3WOiUQhrf9MpV8DLsDL9s6gJNk/Znn5i59UJLylHLEUrhypvJQsHEEac13
         uDWA9mKNZTLaCv2cR86VpsIhTXy6JO/zem/hiZWYl3lvyrIA2VowEgJRs9DZ0GDdBWDD
         S97izKBkUaCTl5P/zwLEdsexrP2oH0C9JckZqv0Er9/7b9ydHzXxXqyndDupoLgTM2y6
         +Uinrk35kZ5MeXwq1iFKWL+zEuZzfXQnOSMEqK2GEkIHrFjuR5fxlLqZQ1tkt0AX14Nv
         dxDgSFJqA4/+8NEFxsMFuaj+izi1bMESZoWqVLusU5GgRzEP9Hqv3t1CrsAIzihJKJyc
         ot9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fayYzjKhb1ITyWmmaWz8uvl0NT3hSIICX61WlJhr3bw=;
        b=t/75noPojpVgjFZi1LUuqym73xCGgpMriNAFlTajWyQYg5NiQfhSJocdj0WpsPDfRo
         8UAbNG9+zzcFO37RkEYIoy8NdaSiwlc/sBSVf75PMBLmTJclDjbYEj2I4Cxul0Qfpbma
         Q4MkRuzF8yzwdLACNpj3xDADbAXEnyNZd/gc5M8tgjKKzSOYDLVO/x9EdZ5sKx28csxh
         4gEHbjouljuppHK7oORbuG7EtwZfUtW7JPBJO/IHVmelIJSqTINpLiDzGBFFmBuvmfQJ
         htP4Vr7F0umRK6VkidObLDxlDYBdS2wgA8KGW+rS4KOhF76ogepGGWDVLVMyzHa2e61D
         t+QA==
X-Gm-Message-State: AOAM532zHnKPCedEk/Yvq7QSMkNpx4OI9PiDofGO5NMGb986apQnzKjp
        VhoO4AxIl4CB5Wo/GD1x4jbCoA==
X-Google-Smtp-Source: ABdhPJwOgS8e5HRf6pPdJmD2U49z8CKChwO98Niai4ReRjn+TLf4LCgi205EvPKkH6nWiCeu+uu0HA==
X-Received: by 2002:a17:90a:4142:: with SMTP id m2mr6812300pjg.80.1639499360077;
        Tue, 14 Dec 2021 08:29:20 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id m6sm291037pfh.87.2021.12.14.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:19 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:19 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 18:17:52 PST (-0800)
Subject:     Re: [PATCH v9 02/17] riscv: Rename __switch_to_aux -> fpu
In-Reply-To: <8e02819b9f8220f64ca43c330192c20594903ba9.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-ff1d6a4b-a332-40bd-afab-f0d176b03164@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:14 PST (-0800), greentime.hu@sifive.com wrote:
> From: Guo Ren <ren_guo@c-sky.com>
>
> The name of __switch_to_aux is not clear and rename it with the
> determine function: __switch_to_fpu. Next we could add other regs'
> switch.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/switch_to.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 0a3f4f95c555..ec83770b3d98 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -45,7 +45,7 @@ static inline void fstate_restore(struct task_struct *task,
>  	}
>  }
>
> -static inline void __switch_to_aux(struct task_struct *prev,
> +static inline void __switch_to_fpu(struct task_struct *prev,
>  				   struct task_struct *next)
>  {
>  	struct pt_regs *regs;
> @@ -65,7 +65,7 @@ static __always_inline bool has_fpu(void)
>  static __always_inline bool has_fpu(void) { return false; }
>  #define fstate_save(task, regs) do { } while (0)
>  #define fstate_restore(task, regs) do { } while (0)
> -#define __switch_to_aux(__prev, __next) do { } while (0)
> +#define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
>
>  extern struct task_struct *__switch_to(struct task_struct *,
> @@ -76,7 +76,7 @@ do {							\
>  	struct task_struct *__prev = (prev);		\
>  	struct task_struct *__next = (next);		\
>  	if (has_fpu())					\
> -		__switch_to_aux(__prev, __next);	\
> +		__switch_to_fpu(__prev, __next);	\
>  	((last) = __switch_to(__prev, __next));		\
>  } while (0)

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
