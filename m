Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986545A599A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiH3C5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH3C5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:57:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FC274DD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:57:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y10so6770402ljq.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZZT1U3Vd0cEKhLrF7hrqw0ipdClhYds8rb9iRhSYclM=;
        b=ntxeLPc3os+/MRS9ZtbpezqNZASz3UT1qwhwZnXzzdWu7jc5o/5QsyV6b+orylseX1
         XaNu7zhdg17JIRpQurW9vKO44wX79OJQ7pKI3D149s7rsrGuS+K7nu3vJ3FYdBYAyrRT
         ix6rWFxS0koUqtF6d6bgE5OGlIMdJ+vL/XuHUb+RHpq+GnjlEGewFMrxJK9/F6qKJIT5
         eTfZUbxMhF8UdFo7Gq1ClwBvuVTAoiW6MoGX49SlX9dw8CSnb9XHqV6v2wzjP4krI4Yf
         a//3ftpbI4XJnBP8ipA6p2eXqDI2UXozcgu7Xc5CJyyWSdhAIW1zt7ARddZLYZCd4tyz
         hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZZT1U3Vd0cEKhLrF7hrqw0ipdClhYds8rb9iRhSYclM=;
        b=ibH1uEX8Z6G3LBsdHBuWoSIHl4zBowLoLOUDy2ZC3KAfm+UNCMd4zQWPropbtG4FsQ
         SYX574o7Q5PfyEBFMI4RoafGCrMMePY0OD3GPVG1/B7Wnr9MDVrubseUUj1lCj0gC3uf
         uSfc/83FFb/SMl/8foj/9TTz5cZGr14hBJlrFPuql5A/UcKHWayHLgesPeUb4TuYMq7V
         Mu/qxywcrPv5vJMKgBiM3i+AYz1JcYo0YIyO/E4bYUncS3yEdiplX0ND/8Qorib68Mt+
         5mKF2NknNZKQjdMLNdUqWWRtWvDxvEQX7MLuah8cnxZ2jmhDYAWN0s4eSYELZOQrtNcH
         VxVQ==
X-Gm-Message-State: ACgBeo1g795h2X/zpLTSQ+XnJ+Ui+M+ic90cvOy2+C3hxYHS6dtARkBU
        M/3hmEYOZWJ8O2RBv1PfhET4GuL80J8Ad3fYLJlbhRHJnJ4=
X-Google-Smtp-Source: AA6agR6AXVORIEDn/RN/pm5ODfxWHPuQBjjbE2B8Rv1Zhb0yNV8iJKWDUAwlMNomfvDEiP/NSQP346vwLH9srJ/z0uo=
X-Received: by 2002:a2e:9958:0:b0:264:ddc6:ad46 with SMTP id
 r24-20020a2e9958000000b00264ddc6ad46mr2350443ljj.443.1661828236796; Mon, 29
 Aug 2022 19:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-1-zong.li@sifive.com> <20220829062202.3287-2-zong.li@sifive.com>
 <1661798521.316365.2118959.nullmailer@robh.at.kernel.org>
In-Reply-To: <1661798521.316365.2118959.nullmailer@robh.at.kernel.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 30 Aug 2022 10:57:04 +0800
Message-ID: <CANXhq0pAbWeYXSTDcemq5gL-fPUD73QTDkcp4+whWyx1OzJbWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache to
 composible cache
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Greentime Hu <greentime.hu@sifive.com>
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

On Tue, Aug 30, 2022 at 2:42 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 29 Aug 2022 06:22:00 +0000, Zong Li wrote:
> > Since composible cache may be L3 cache if private L2 cache exists, it
> > should use its original name composible cache to prevent confusion.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  .../riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml}      | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/riscv/sifive-ccache.yaml: $id: relative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/riscv/sifive-ccache.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

Thanks for the tips, I would upgrade my environment and try it again.
