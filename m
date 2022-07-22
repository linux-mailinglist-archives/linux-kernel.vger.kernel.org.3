Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9051C57E646
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiGVSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGVSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:09:59 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EA61105;
        Fri, 22 Jul 2022 11:09:58 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id i5so2676026ila.6;
        Fri, 22 Jul 2022 11:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PIQt+5ITwOzmhuISQoyrlkf2sasQzT8bLBRP5gAJJHI=;
        b=WfP5agFa5phzj/XhVYj7Qbvf5JDUAyf9kvM21A/wjwhcg0WSwYLc+QoU1cLLT5nA6R
         lgc9lgsCkKHTlJCgfyH0BGbjZ+mM9lWptNqYscUCgW/j+VN1UQuDcOox8nwao8mOfZOv
         8TKSB9oDj6GiAfcisqIQ3thcjiFp02Llf8IH0sZ9Qu4FOrexBSRN4HIqTmvE1B95/ma+
         X7oF245h2OLJQbU9SMrJ9o7nswkcCwAtSpw+6OsUn/2JCcVkFA7Mis3IGW1En1gXPLq8
         cspPVXvQG/b+5qDsS1Oyo/uDTWyQGQ5qKoaw3fBsyK5DLgGtbwCFxQHHWsJ0SHGBgboP
         LktA==
X-Gm-Message-State: AJIora8V8S2q5DDqfjskmnG62ifW6iblpDxtevc94RN8dZPr2ynR5w7k
        qmKVEhKh7bifhYHTrLgWIw==
X-Google-Smtp-Source: AGRyM1viYesRRMCE+hE3852h7f+4YHNmRnNBlfzb2xqh4FaCp1/QljiBpc+/NB38QuvSIp2ETH6ijg==
X-Received: by 2002:a05:6e02:b21:b0:2dc:6d2d:5a61 with SMTP id e1-20020a056e020b2100b002dc6d2d5a61mr495214ilu.273.1658513397529;
        Fri, 22 Jul 2022 11:09:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x15-20020a92cc8f000000b002dd12857a13sm1950282ilo.80.2022.07.22.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:09:57 -0700 (PDT)
Received: (nullmailer pid 3797638 invoked by uid 1000);
        Fri, 22 Jul 2022 18:09:55 -0000
Date:   Fri, 22 Jul 2022 12:09:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
Message-ID: <20220722180955.GA3770737-robh@kernel.org>
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220605142333.GA3439339-robh@kernel.org>
 <CA+V-a8smk8TqyWpm1KXo-3dKnCAodKsiYsaqnK_3ubfXE9YauQ@mail.gmail.com>
 <20220706215827.GA572635-robh@kernel.org>
 <87a69lmesa.wl-maz@kernel.org>
 <20220712181916.GI1823936-robh@kernel.org>
 <878roy16iw.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878roy16iw.wl-maz@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:21:27PM +0100, Marc Zyngier wrote:
> On Tue, 12 Jul 2022 19:19:16 +0100,
> Rob Herring <robh@kernel.org> wrote:
> > 
> > On Thu, Jul 07, 2022 at 10:51:33AM +0100, Marc Zyngier wrote:
> >
> > > Can you please have a look at the latest instance[1][2] of this
> > > series, as posted by Samuel? I've provisionally queued it, but only on
> > > the provision that you would eventually ack these patches.
> > 
> > I did already[1]. They passed checks, were already in linux-next, and I 
> > didn't see anything major needing comments, so I marked it N/A (meaning 
> > someone else applies it) without comment.
> > 
> > Rob
> > 
> > [1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220630100241.35233-2-samuel@sholland.org/
> 
> How are people supposed to track this if it doesn't appear on the ML?

Look at patchwork?

How am I supposed to track maintainers that will rebase what they have 
in next to add acks and those that won't?

> That's not really an ack, AFAICT. That's a "I don't care".

I still look at it, so really it's an implicit ack. In this case, I 
probably just saw the irqchip-bot mail and missed your reply to the 
cover.

> Does it mean I'm free to take any random DT patch unless you or a bot
> shouts? I'd rather know.

Wait for acked/reviewed-by to apply? Isn't that the process?

Rob
