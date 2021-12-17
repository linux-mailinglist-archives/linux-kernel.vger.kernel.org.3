Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23462478BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhLQMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhLQMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:47:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:47:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j9so3926961wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LZ1nA4lOfecYVsrLmuy8ux7dkjFcWb7gPP3Ts+l07A=;
        b=PuF6u5NZOxCYr++SNE2eIMZuuw+/7PM+J1oBlyRcJJb/NXnB6qUPH16jOlEG28jDo+
         +0Cp3yo6dL3124MDrSS0JktdEwGIFYryfTgZhwnD5NLvouYUddqVGCIiN5eHnTr36bpx
         h95GTmrA9VaU9Vj3KcWXFk9RiyVVvKa10XAlkzn7SFxluPnmH8YsfO1QcyY75ipgp+3r
         ECNUmESCyaD1HkzuW7X7gK3s+ZAESrVqKFBMfsiIM6K0x8Q8xroOGwsO+N0xD0Aqq7GP
         s44LbOWpPAGoHuirahK6lsMmwhN5THiPMN13DNUzHgqkCk2RZIHoEGjAQetPJGS4GsYG
         U8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LZ1nA4lOfecYVsrLmuy8ux7dkjFcWb7gPP3Ts+l07A=;
        b=VBUXrxAsu3FcoWTPtka6ulTvpSKdBkSfRrpQUnvplzYaXBWtuT1IrSGK4xut9ioBrG
         dHxCUo2Sj+W2b1LsHEHR3rHl58Omx7Du/yz3AaNHaJzGcilohKD6DUDZMr0FsZ3R4dAR
         7E3GB49YIaT8ZcSdgNND5pvlioH9/Schqhz9FY8pZpVdVktuIJ9NGsDg//ViZbd1iW96
         I1dj5/cRZx/c7gDa32MdDj1A3eT10wPLkwzEPz+wM/meLuGYQqocXBqPqh8v1Wig0A9b
         XgrIFm+g2MTGFdtU/1IVPoHoNMAcrulQ6BmhW0zMVP3jAbIBDj5h3J9Eu8ZzuFewuxGM
         eNyw==
X-Gm-Message-State: AOAM533EbGl2YwUcSRGMnZRZUqcxRcLXtAI1Tgw7yOLgkLBJI7eVIcpf
        fUK9vL3aAROQiB6BqQ1YC2MysnnodSgC6sgn3Sttsw==
X-Google-Smtp-Source: ABdhPJzjYjt70Q7N1FbMgpg3l8n8x5MHMcym81T3FbJlsD8EVPhmffm2PND5L2lTJE72NXW2s1+mO7ue8lgFNEkcaSk=
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr2448344wrn.690.1639745253808;
 Fri, 17 Dec 2021 04:47:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639744106.git.geert@linux-m68k.org> <3af15b09a5f05d49e2d99386f189cdb13245d40a.1639744106.git.geert@linux-m68k.org>
In-Reply-To: <3af15b09a5f05d49e2d99386f189cdb13245d40a.1639744106.git.geert@linux-m68k.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Dec 2021 18:17:22 +0530
Message-ID: <CAAhSdy2xTW0FkwvS2dExOb7q1dVruFfTP_Vh_jWju+yi7thCeA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Fix number of interrupts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 6:04 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The number of interrupts lacks an upper bound, thus assuming one,
> causing properly grouped "interrupts-extended" properties to be flagged
> as an error by "make dtbs_check".
>
> Fix this by adding the missing "maxItems".  As the architectural maximum
> is 15872 interrupts, using that as the limit would be unpractical.
> Hence limit it to 9 interrupts (one interrupt for a system management
> core, and two interrupts per core for other cores).  This should be
> sufficient for now, and the limit can always be increased when the need
> arises.

I disagree with having "maxItems" as 9.

We are in the process of increasing max CPUs supported by
QEMU virt machine to 512. There are already high CPU count
systems already announced (example SiFive P650 which will
have 16 cores). The "maxItems = 9" set by this patch will soon
be out-of-date.

The "maxItems" should represent PLIC spec constraints so
please don't add any synthetic value here.

Regards,
Anup

>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>   - Add Acked-by,
>
> v2:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 28b6b17fe4b26778..0c6687511457413e 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -62,6 +62,7 @@ properties:
>
>    interrupts-extended:
>      minItems: 1
> +    maxItems: 9
>      description:
>        Specifies which contexts are connected to the PLIC, with "-1" specifying
>        that a context is not present. Each node pointed to should be a
> --
> 2.25.1
>
