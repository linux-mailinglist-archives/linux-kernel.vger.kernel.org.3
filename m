Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637E14AE86A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiBIEKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiBIEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:07:18 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F1C061579;
        Tue,  8 Feb 2022 20:07:17 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso705117otl.8;
        Tue, 08 Feb 2022 20:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SlUTfORdsnc28tLEfE1geAYG+A9VRD+iXQo9kSBBGU=;
        b=MrQlSdFCQqrAIpnACo431kz4pdy3zVemfvm6CokPpfXSDWCxhgd+pWZYgrG4VXusDo
         1BMKJGg24Q9uYoiKn4XGj/TKLV8i10IuDUqN2nn9xcF62Sa4nP3xF6TShqd8vhLwmOQU
         BMyMWFOmIBCBc8QWTwn4X6dc3HFYoqOoXFikcaYSX4JMUrBaNKhqRFqT6CA20aAVhdt5
         80GzFBN4BondvCJKWidyDN2iXKr77E1ttEa3Z2bx1RRzBMznB148GTTtpBDYTpldpMW3
         +CNy+tjM57NbGOwHBGRQ7bFKxhkWXYYUrAsE/rLbG1H4m9vaMXXz31X3iInh6eJi9VB4
         wzFQ==
X-Gm-Message-State: AOAM531Yba1QYjTlH/9qXHXoH6poLVdHz/iFYWaUMpYLPc7bmbizRkQD
        RmEQkzFABb5E5oDOdzILsA==
X-Google-Smtp-Source: ABdhPJw6Scyx5dzsHwxnzN7Mj5MuFSM9+a94On89xDB7U2azXkCI0FCjcs4h2HE0ouBxZojmq/wkrA==
X-Received: by 2002:a05:6830:12c1:: with SMTP id a1mr213959otq.374.1644379636810;
        Tue, 08 Feb 2022 20:07:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x19sm6148453otj.59.2022.02.08.20.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:07:16 -0800 (PST)
Received: (nullmailer pid 3636515 invoked by uid 1000);
        Wed, 09 Feb 2022 04:07:15 -0000
Date:   Tue, 8 Feb 2022 22:07:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/12] dt-bindings: riscv: add binding for Nuclei
 platform boards
Message-ID: <YgM980WbioH/gkPL@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-9-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-9-icenowy@nucleisys.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 23:16:43 +0800, Icenowy Zheng wrote:
> As we added support for RISC-V SoCs from Nuclei, add device tree binding
> for the currently supported board-bitstream combo (DemoSoC with UX600 on
> DDR200T board).
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  .../devicetree/bindings/riscv/nuclei.yaml     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/nuclei.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
