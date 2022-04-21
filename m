Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F65099E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386087AbiDUHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386179AbiDUHt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:49:29 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80561C125;
        Thu, 21 Apr 2022 00:46:18 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ec05db3dfbso43103727b3.7;
        Thu, 21 Apr 2022 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gF7v+u5qfekoFHMTILqb5HQnMHDt0hFlVj2XdsKKGE=;
        b=p1/u3kRmGTnPOnkOOYHSHuQuprla3aEGkJM1K20hYwFiIcBqtKc8VZ5l2RYVJX8A19
         xDqvxne87HNMxNiF/dFgkyNtZWuGxIAzJPoYazLlAhwfunLUwzSGyXwe9h3le23C1XKz
         9Rm0gOpg1RJAm3H+I9rU67mXH+7RdBIXEjYuZZZrFG7eDf1NcsdALI8gggv1co40om14
         sBnzLmEEjUav4hVb6RZY9DZb/Zaijxj3m95TY3JVFci1wpPjxlqCix8EPglReA6rgVw5
         Np+axScD6ngbpMakuKFgSdoJmpPGGuVL8M4GuUteGZJIdlgE2T9V3haFR9OfLJx03l/h
         9OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gF7v+u5qfekoFHMTILqb5HQnMHDt0hFlVj2XdsKKGE=;
        b=n8oqSU41aD2xZcCTI37+K33QdA9SZs7ToSPTWNhIitM3z5xnFl/zmqq+IFtnWyGndx
         Sc1UsNlShfnt4bOcvLs5YFRETRENZEOT23JcPFZ+IQQMKCON3ps9GdLr+xL9m8oNrLXT
         TNnZJk8aKaJC7OXAP0IT+J4tRtQv5ZQd07KW+7tiJpTXGvNEdVFlSWLxEJLPhfKoBAMH
         Ft9tL9Dq5FmYFcdXKswO2Y5nCQ+MXVgLY0hkzzK/YdkQA/YEZfEQi3TGUxvFUtbxIiCq
         ocNACAr1v7UJmdfq8M+rAo6BHYlKAgEwkyPOamukPHHIepfHEM2Gz4vhp15CznuKqG9F
         GHzQ==
X-Gm-Message-State: AOAM530Ttwve69c2H6lhp9ycAd0XLT2qb/SrGLwYQP6r5EELdIDyrdUZ
        FDqIAZFP/rNy7Cz7QNmRXXKwE+w4JnJiqZLkmGA=
X-Google-Smtp-Source: ABdhPJzQrF1xp8NXrzFDvpdgsCnONl8jgJLemRqlmq6FO4deZtH3gAF9dhs8jOdAoU/wyLB1x/pba4wdzIvSpXBh1Fc=
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr24596938ywb.132.1650527178014; Thu, 21
 Apr 2022 00:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220421065401.9303-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421065401.9303-1-krzysztof.kozlowski@linaro.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 21 Apr 2022 15:46:06 +0800
Message-ID: <CAEUhbmVBM1PG_6amTU2OCCNJDiTd6oKEJCGGv=2DOr8hOw16xw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: fu540-c000: fix duplicated dma compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 2:54 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Remove duplicated compatible to fix error:
>
>   u540-c000.dtsi:171.4-42: ERROR (duplicate_property_names): /soc/dma@3000000:compatible: Duplicate property name
>
> Fixes: 7eba954a8de8 ("riscv: dts: Add dma-channels property and modify compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
