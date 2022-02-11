Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2D4B1A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbiBKALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:11:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbiBKALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:11:06 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1A02724
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:11:06 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p5so20089598ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCMpPtMCiOJ/G+Eq+FzjqaIZUVvMGCRl0NKCrIWOD3c=;
        b=XBA4n8JWpO28GAY8KpOE5Fii8tHnNL0Lrh0fWhsI07c/cJA8Nz2/XqJrI8jSV2cGSw
         1P91jvRZCfGSCKLJFuS4PTIM4Jrs9opnFDu/wrZbAPpeYBJIuKAmK0RMYD5fuMInBFOf
         iqwoArv+BP9V2GE9k3aY5bFzaaKeNSPnZsA6cfEROnmQ+rJQkw2sW30UUjE4EuCq4ikh
         icWobOZJ4w6Rp/ozGYoTyCQTvUjdUEJIel+Nb5PzXVswvIAZiQ/1IjWYXRYZO/SM993j
         ArKAc51/+S5BDuPNadLYzJ1vU5rEqAvCBsfeSmPlSAJNUnwlrUNC4CLcwMutRgaVaLqY
         TrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCMpPtMCiOJ/G+Eq+FzjqaIZUVvMGCRl0NKCrIWOD3c=;
        b=45N19sa+FaNJmpwerprFrZ3Jcz+Ngh4puBGYcYqeaC1tSQoVLUfNNxk9weQelxAK9/
         QIsvSCYvbPAcFy9ar2utvEyPkS3i/OgJcg8pi1XCOJ9tdgDqxAUdprmgLOqZG0tXqANB
         YpPuW1Cv/+Xzulwa8/p/wipcI8ckIWzBKBIleWOzfFVqJfw8g1yu5RMz2AknR0gwK4fW
         Z3BgGXapSV7HCUvZuH5RPvDkeq35uHvhq2iMGtjBRmY0/wZS2l+ch6wusL3vldJ0w36v
         Y4tsCKIGVKkdGBQjmjUrPvx2CEQeVMtlcGePMCt3EjVdTCSY8qP5cIP3WI+EyyECsyex
         /k7A==
X-Gm-Message-State: AOAM53339xoOr2E3mIBJWRQV9c90NhcHI6F4UfqWjaQCX59lrCONTDOB
        57J9ZYHf73IjvpXO4KAtU3patUnqpSy7xNq2xF4f6rvkJVzcXw==
X-Google-Smtp-Source: ABdhPJz2D8S8vUC1h5FU6mERCeQjOZLOQvAmkY2lC5MMdhv3su82ZuGu4xueTzqReYLkVp6s5xRXwZIwEmBX5LooWjY=
X-Received: by 2002:a25:103:: with SMTP id 3mr9342711ybb.110.1644538265780;
 Thu, 10 Feb 2022 16:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20220210062122.23974-1-guodong.liu@mediatek.com> <20220210062122.23974-2-guodong.liu@mediatek.com>
In-Reply-To: <20220210062122.23974-2-guodong.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:10:54 +0100
Message-ID: <CACRpkdbNef4MH2UFOC6wvCFB4jUV6Qmar6H2Dqq9GYfmGtfkPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file and
 binding document
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 7:21 AM Guodong Liu <guodong.liu@mediatek.com> wrote:
>
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

I see complaints from Rob's robot so please address these
or explain why they appear.

Yours,
Linus Walleij
