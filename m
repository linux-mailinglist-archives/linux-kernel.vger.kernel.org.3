Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9F56C2EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiGHWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiGHWOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:14:20 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA62A707;
        Fri,  8 Jul 2022 15:14:20 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id z81so284306iof.0;
        Fri, 08 Jul 2022 15:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qizlKD9bE5dN8tJcWqnW6FaDP0qSa79ZfPV40HiDdGQ=;
        b=Yiu1EWliG8RLFfRL/e3eAzDNbrkLPyf+vzABOthH0KsHQ/X9K0O9HkrwSedV5c5C3H
         bAm8pLNlNJx7+3vo6yHhEggx879Bk782o5qFCQ72Bljrud9REIxrTbEQZ5e2ov5JVQ9U
         EwDtpSlRn5r3OKh1o9o0asnbd1QQ78+dsVCQbd1u5DrNo/ZI0zC+ywc6Cfq03fzCgmNA
         GlG9oiBOTNfw6cd7tWmEWLY+fifqnTxzb7dgXFdNgifPMqVtDrlx1o8aTl4jAa8YWUjC
         7HkOtmXZW83AmvwAfnTwxaxwY8zFAxO+9r0ORM2U60kOzrEdRcnCaEByg/L/zP4oCbth
         BNLg==
X-Gm-Message-State: AJIora/79bt9+kiZRi6/LrVQTowdNGHjwc5S+LE8qhf7g1aaaKkA/nEj
        /ZpILCjeya8DnRQ7gAOMvQ==
X-Google-Smtp-Source: AGRyM1t4peia84G04eriBOduqU7X4VUiKCFhcEgAmMHSCwj5GjAENVk5PMLOfC7mJNOQOcZb13sK1g==
X-Received: by 2002:a05:6602:2e8e:b0:669:d5b1:3fc9 with SMTP id m14-20020a0566022e8e00b00669d5b13fc9mr3158325iow.210.1657318459564;
        Fri, 08 Jul 2022 15:14:19 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id w10-20020a92db4a000000b002dad39ff841sm10133296ilq.19.2022.07.08.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:14:19 -0700 (PDT)
Received: (nullmailer pid 1573273 invoked by uid 1000);
        Fri, 08 Jul 2022 22:14:17 -0000
Date:   Fri, 8 Jul 2022 16:14:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mia Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, devicetree@vger.kernel.org,
        tmaimon77@gmail.com, alexandre.belloni@bootlin.com,
        yuenn@google.com, KFTING@nuvoton.com, venture@google.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, YSCHU@nuvoton.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com,
        benjaminfair@google.com, mylin1@nuvoton.com,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time
 Clock
Message-ID: <20220708221417.GA1573219-robh@kernel.org>
References: <20220707073054.3954-1-mimi05633@gmail.com>
 <20220707073054.3954-2-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707073054.3954-2-mimi05633@gmail.com>
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

On Thu, 07 Jul 2022 15:30:52 +0800, Mia Lin wrote:
> Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> 
> Signed-off-by: Mia Lin <mimi05633@gmail.com>
> ---
>  .../bindings/rtc/nuvoton,nct3018y.yaml        | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
