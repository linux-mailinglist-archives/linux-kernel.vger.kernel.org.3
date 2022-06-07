Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5837553F84E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiFGIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiFGIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:38:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933AA23BF2;
        Tue,  7 Jun 2022 01:38:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso2265734wms.3;
        Tue, 07 Jun 2022 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jjMIOURiqBgt1XuOBupgxyJ8SiKwkL50UheFyS/nhUs=;
        b=oUBBWohkWrVW3ZHW0YQHSXqQiVif0gZRuU7rU1VDlqc55SqMwl1M+E96F+OyOyzSIq
         uS2ypmpqiem/WjoUI5uBRWbDdBqn+jwdSw+zzVnn1XwPhwjJ7N0J+OBRoWfV5l4oC9Sv
         9LjHM+b6MonYT273X6TBH/k1oeEw2awDa6CHertIZCXYQIzFyBnj7AFQFgyk8qPeKFHC
         ja875OOi/oYn+U/90Bk9AMl3L+qKrYd9bn3gvR3mMF5QY6c4s7ZV71pMY2ZPXmfI49jP
         XY2ZRl9KIU/QOi4Ln3WYBfJUgfuKvlqYU7WGSjZ5/fqTel2NVvEmV6bi3ol6crW3UwNZ
         mxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jjMIOURiqBgt1XuOBupgxyJ8SiKwkL50UheFyS/nhUs=;
        b=iybUlrEOGUMCemiq9QTSQKpk7RnrN8qOHOX5L14f2m6iDvHun+8MFDoqywq1Ffs/Lh
         WAq0hXa+8mw8Qrz+vC0Wyj2pAQT0uoU3RpyIxDY0tfh2ZeDGk1Zi21ME4A1bsEgyp2CV
         iMEZJloi1Q+Iv0GN0WnmZPDgkIPZF1A+A3/ApbC8zYMRKz4dg6sqvSQbkwmZNQqjLJoG
         uKLPAxF9+X4Hdo5oY3TO/YF/mo99nFxMKQa47Dzm2bE3kJP2EWPa7DK3la3aUdWdzxd7
         dzQvEgl1JhInkkXtYucqxJtOZGBMGQXoydo+M0CjC3Uy2zc4rFcFv6ImwjQEQoTVZfhj
         k2Yw==
X-Gm-Message-State: AOAM530KSnbhQFTAdMSa7PII8dkER+7kVO7gaNUqHK8syvAD1BaEJg/x
        7KpBWu2TWuj9fecYHII4omYHhrI7lzMxpBpYIWyTolU0MdI=
X-Google-Smtp-Source: ABdhPJzVrQd50BB5eIvflfDQDEueszQVC37lKmsZ20myiKuFoxyQk9RC+1nqkahOxEcD46KaFfxm2+WnZ5xGxnoIjJE=
X-Received: by 2002:a05:600c:4ed1:b0:394:8352:3ea1 with SMTP id
 g17-20020a05600c4ed100b0039483523ea1mr27467952wmq.153.1654591084057; Tue, 07
 Jun 2022 01:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220505101433.1575096-1-gengcixi@gmail.com> <CAF12kFvQsz-EKD-VdVkJVCUwNj1FL=4=uVarwnTyYTb_dRNZbQ@mail.gmail.com>
In-Reply-To: <CAF12kFvQsz-EKD-VdVkJVCUwNj1FL=4=uVarwnTyYTb_dRNZbQ@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 7 Jun 2022 16:37:27 +0800
Message-ID: <CAF12kFvRJM9Y9VPzhjuZJ+vR_SWrx=vS+5XfEwd=Tyny3-h+3g@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add ums512 clocks and relative bindings file
To:     sboyd@kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cixi Geng <gengcixi@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=BA=8C 17:25=E5=86=99=E9=81=93=EF=BC=9A
>
> Cixi Geng <gengcixi@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=885=E6=97=A5=
=E5=91=A8=E5=9B=9B 18:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > This patchset is add the UMS512 clocks support
> >
> > v2 changes:
> >   adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd=
"
> >   compatibles to fix match failed logs in the dt_binding_check.
> >   add the property license and copyright notice.
> >
> > v3 changes:
> >   fix wrong indentation and hint: "maxItems" is not needed with an "ite=
ms"
> >   list when use the latest dtschema.
> >
> > v4 changes:
> >   move the syscon bindins from clk to glbreg yaml file by pickup
> >   chunyan's patch for global registers bindings
> >   fix the comments from Krzysztof in v3 patchset
> >   add the Acked-by: Krzysztof in patch v4 3/4
> >   fix the  warning Prefer "GPL" over "GPL v2"
> >
> > v5 changes:
> >   Add review tags.
> >   fix the comments in ums512-glbreg.yaml.
> Dear maintainers:
> I have not received any new comments so far
> Is this patch ready to be merged?
> I'd appreciate any information of your reviews.
> Thanks
>
Hi Stephen:
Could you review this patchset wether meet the merge condition,
if not,please advise me what I should do next
Thanks

> Best regards
> Cixi
> >
> > Chunyan Zhang (1):
> >   dt-bindings: mfd: sprd: Add bindings for ums512 global registers
> >
> > Cixi Geng (3):
> >   dt-bindings: clk: sprd: Add bindings for ums512 clock controller
> >   clk: sprd: Add dt-bindings include file for UMS512
> >   clk: sprd: Add clocks support for UMS512
> >
> >  .../bindings/clock/sprd,ums512-clk.yaml       |   71 +
> >  .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
> >  drivers/clk/sprd/Kconfig                      |    6 +
> >  drivers/clk/sprd/Makefile                     |    1 +
> >  drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
> >  include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
> >  6 files changed, 2742 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512=
-clk.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-g=
lbreg.yaml
> >  create mode 100644 drivers/clk/sprd/ums512-clk.c
> >  create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h
> >
> > --
> > 2.25.1
> >
