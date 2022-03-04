Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF914CD20A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiCDKIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbiCDKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:07:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D91A6F81
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:07:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m14so13283716lfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9N/+0wL229i7Cr0s0i/SfdtJ37Scr7qSFfPXGXOJAb8=;
        b=B/YZnZmXk+cPE+SLnVMTvL+U2S/CtlbWn/U739600NjbYOgcXAxG8WCU2yRBjisfuC
         +frjfu2rY/SnANWK1dLGAs/0z1xu7B6DMA4m1YJIPk6A5xYTqTdbpk1y8XsPv3rb+ga9
         aDtun+/h+dXbSFZ/5ob3bzGHlmieDmC4xIvkXgsUOfl4qY5PqH9CQ/hvmc0f2DgjtcjD
         6hxGudm6kdVDwI/hu7kQHrEgGbfFv0cXFp2WfCwF+sfhF1HNVMieAimy9bR8wXOvddAm
         8iE9QbWxZfCyZBjLWHfefjQFIR7RxOBlFW50NClzGubgPOstEkzQwNEErKE0juDYUCVK
         ck7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9N/+0wL229i7Cr0s0i/SfdtJ37Scr7qSFfPXGXOJAb8=;
        b=Pw9k6SRLQv5iHDSPPa+WgEImqrfsWaOW8XfaDoTlQ2YrL5CFhzjx1+5VSlvnvLBFW0
         BaLF83zfRj5DwduOnXvNU4UtjzQ/E7xK34rp4nlr2MlJPxHPHEJGJYGICCwC4cqqRMnG
         HLxVv+EsAKQDvnpjWqzZWu8JV+rfAhi6Y3yNxIuXzQwAn8ML5VYS+GXYyqgDwMXo/YZU
         33NDHPXlK/17a0QTS6SzpzQw/9kb/97loPTP4yD0f4JN/whLUgDB2HJAtuUNVlRCwO2l
         QDPdUV6hOjTSSvh1fzYZs3oSbdtJkACEFd+B8wftscNa07xBu3HSpkk1OrzIk7LX0uAI
         vChg==
X-Gm-Message-State: AOAM532JzdVMJNwDpZ2Lo0yEvjDOF7iBBQXtguse1QiuMi5v8p+BDHCO
        +wYFMToJw2EvHg3oyFn1vsxwPeK+qWKhKyXra1PGGKTfx/Q=
X-Google-Smtp-Source: ABdhPJzzsckyVKUW8W1OIZWYaDHSOvqmRFodfGrIYlID4E+90v/KNHd9qlpABx0N56/55lpGFlwSygo+aAATq1UOy80=
X-Received: by 2002:a05:6512:1510:b0:445:cbc3:a51f with SMTP id
 bq16-20020a056512151000b00445cbc3a51fmr4227577lfb.116.1646388428750; Fri, 04
 Mar 2022 02:07:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646383150.git.zong.li@sifive.com> <12cff3b68de1bd02a8915bd70999bb4edafaca1b.1646383150.git.zong.li@sifive.com>
 <1664de3d-8e33-596e-19ff-4fb174f2a178@canonical.com>
In-Reply-To: <1664de3d-8e33-596e-19ff-4fb174f2a178@canonical.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 4 Mar 2022 18:06:57 +0800
Message-ID: <CANXhq0o68-_jYgZD=iVjQDrQeo-vB6iP+FR3PDTLy5bvD9QVug@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: Add dma-channels property and modify compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 5:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 04/03/2022 09:42, Zong Li wrote:
> > Add dma-channels property, then we can determine how many channels there
> > by device tree, rather than statically defining it in PDMA driver.
> > In addition, we also modify the compatible for PDMA versioning scheme.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
>
> Can you add subystem/driver prefix to the subject? In current form it
> looks generic, but it is actually specific, so:
>
> dt-bindings: dma-engine: sifive,fu540:
>

Thanks for your correction, I will send the next version to change it.

> Best regards,
> Krzysztof
