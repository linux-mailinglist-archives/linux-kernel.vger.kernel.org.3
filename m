Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434353265D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiEXJZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiEXJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:25:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE074DC6;
        Tue, 24 May 2022 02:25:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e28so24198313wra.10;
        Tue, 24 May 2022 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YziY1Q+V5DNxZb3YLwFQ1UrWpeAm6I+532vLrlfJyNg=;
        b=B7PTtOyrL3ttaTsYZy+ZKqBMvDmHCirI35RhvErFXx4vGNveqkojVtUZU43kAkjPjc
         uz2lN8afY+iKBHejc5PA00kdVp3L0CEG9i20Y7foFzD36Kyy3La3GRScHTKYsvH/g9kb
         hyhqGvvonSYF2/hMpr9+xCZ+vn6pUOWIN8MoXy0GhCKJIoPE+EYf/fNa8ymj/cfFQwB5
         0Sy8aeboscwYUa46tVHLKut6mZkk314SxiH2L1nrVUJafHXRbdHFAeN7HNfvitL0+7ql
         arn2RdZCibwaTSAbffw56ZzU4KEigK1Anb4QGW40rxxLARZ26tO7HehO7+5Iv+VL9soY
         Irdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YziY1Q+V5DNxZb3YLwFQ1UrWpeAm6I+532vLrlfJyNg=;
        b=fjRPBD1al8N3vhB7Xckbz75wL7v2V1sl/s5gAIfs958yfikiyvmk2OfllskpZAX2aL
         RAvJlqvZ4QSrRMBKqUWLfkPcqJdfz90eZRrEb3qZunRBIdslcAlwmd+eb2XGdV+tbhsN
         9uDlatI68rqcAyDhhR0qIeoQzHk9fVLRFo0xkxwncNn/W6cTqW1jNp5EgqQ54Bqg+6hE
         OkXTvUhRdBn105veuCWSdc7tT/ccsrR1UmuOcFWo3LCS0ycNZlbKnLKXAhp2a8EZsaQg
         tzXe6Z3TwB8LRKhnYnfdy4RjU8C6m7Sl8//uL83eA89SFE3sUlVP4Ido3yIvnVGLt3ej
         ZSFw==
X-Gm-Message-State: AOAM532whWYhNTb3RzRg4EDkD66P8ZjPiMTznPJu7xyDqrmRW9k46dou
        RlGqz4tZaTWghQ1+QGsRz6toZ/qTfI36/S17Wn8=
X-Google-Smtp-Source: ABdhPJzHiYjluBD4AYDA+/LfIUOKdEveBjfeVVTC5dm4Prdt71cD1NbaaJrtZsTM3h2G5RvUSdjJCHE9G4rh1XYR/Dg=
X-Received: by 2002:a05:6000:362:b0:20f:f8f5:ef7d with SMTP id
 f2-20020a056000036200b0020ff8f5ef7dmr607263wrf.468.1653384345616; Tue, 24 May
 2022 02:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220505101433.1575096-1-gengcixi@gmail.com>
In-Reply-To: <20220505101433.1575096-1-gengcixi@gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 24 May 2022 17:25:09 +0800
Message-ID: <CAF12kFvQsz-EKD-VdVkJVCUwNj1FL=4=uVarwnTyYTb_dRNZbQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add ums512 clocks and relative bindings file
To:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Cixi Geng <gengcixi@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=885=E6=97=A5=
=E5=91=A8=E5=9B=9B 18:14=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> This patchset is add the UMS512 clocks support
>
> v2 changes:
>   adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
>   compatibles to fix match failed logs in the dt_binding_check.
>   add the property license and copyright notice.
>
> v3 changes:
>   fix wrong indentation and hint: "maxItems" is not needed with an "items=
"
>   list when use the latest dtschema.
>
> v4 changes:
>   move the syscon bindins from clk to glbreg yaml file by pickup
>   chunyan's patch for global registers bindings
>   fix the comments from Krzysztof in v3 patchset
>   add the Acked-by: Krzysztof in patch v4 3/4
>   fix the  warning Prefer "GPL" over "GPL v2"
>
> v5 changes:
>   Add review tags.
>   fix the comments in ums512-glbreg.yaml.
Dear maintainers:
I have not received any new comments so far
Is this patch ready to be merged?
I'd appreciate any information of your reviews.
Thanks

Best regards
Cixi
>
> Chunyan Zhang (1):
>   dt-bindings: mfd: sprd: Add bindings for ums512 global registers
>
> Cixi Geng (3):
>   dt-bindings: clk: sprd: Add bindings for ums512 clock controller
>   clk: sprd: Add dt-bindings include file for UMS512
>   clk: sprd: Add clocks support for UMS512
>
>  .../bindings/clock/sprd,ums512-clk.yaml       |   71 +
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
>  drivers/clk/sprd/Kconfig                      |    6 +
>  drivers/clk/sprd/Makefile                     |    1 +
>  drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
>  include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
>  6 files changed, 2742 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-c=
lk.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glb=
reg.yaml
>  create mode 100644 drivers/clk/sprd/ums512-clk.c
>  create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h
>
> --
> 2.25.1
>
