Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088DE517891
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiEBUyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387509AbiEBUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:54:10 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49826B19;
        Mon,  2 May 2022 13:50:40 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id r1so16201213oie.4;
        Mon, 02 May 2022 13:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7dLfkQB5iRNEh+Agl2ljIZWdTsg7pWZ55/DrU1lX3U=;
        b=yBOxF9Ici3jkKgH3ukbY3khU7J14nGIVzlvI6IqoyExuzE54dfGddWul2f/QC0hBiz
         dBxI72Qb4R/TNGM9qqRzO7MIXI/js/eYgeo55x/ev0KVgDJwXwCioOGCpbq1fl06wCkk
         9Vcz0AE5tykyvvCmYOd5boun8ZNg25v+h/ykiSMS1vYgDRGES8HdcTWV1if4PdKAzB4l
         T93z0UNSdHY822sqfkWL3TMe1HgzWmfA19Hh47+k8rjbhOfXphcAwfKnO08loJQjF1jR
         lvkZHOUTr/HybHPQcWc84ehwO5RFauUAna3A/nLSZubv3Nm8EKqd+FDgrET/9kkbJdxw
         GGXA==
X-Gm-Message-State: AOAM530QuT4Eo5cqjDRlipNvzGmORPDdG0s56pCmi4u6eBYNlhofteWJ
        bIwAsIbx2uHPwCgB7QXnqg==
X-Google-Smtp-Source: ABdhPJx8kDbeKKYG/ADawW42HXqiWmqrHC2ycDpq4wT5cjjBJkWPZp69DHt8An0bXLasg+8qjsWfEQ==
X-Received: by 2002:aca:641:0:b0:325:473:403b with SMTP id 62-20020aca0641000000b003250473403bmr488975oig.116.1651524639465;
        Mon, 02 May 2022 13:50:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i9-20020aca2b09000000b00324f24e623fsm2687395oik.3.2022.05.02.13.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:50:38 -0700 (PDT)
Received: (nullmailer pid 1723863 invoked by uid 1000);
        Mon, 02 May 2022 20:50:37 -0000
Date:   Mon, 2 May 2022 15:50:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
Message-ID: <YnBEHdWD+Z5ojbu/@robh.at.kernel.org>
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 23:11:58 +0100, Lad Prabhakar wrote:
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
