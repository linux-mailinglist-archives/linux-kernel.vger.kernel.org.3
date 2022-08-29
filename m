Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785D5A5418
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiH2SmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiH2SmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:42:04 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF082766;
        Mon, 29 Aug 2022 11:42:03 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id v125so11456228oie.0;
        Mon, 29 Aug 2022 11:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=LXkEPrKAVM00r7oWbx73qYiaSM+RhvXxRLquIsmnm1w=;
        b=ZMvJ9FpJkby3WOHVXYDHjST/jqY4/4HSTljwowxMFvI3u0rsvn/0jvF95iY7erAA/x
         bPMeuSMgGP7SSOdYvlKbVyvvu/N+ZtlLOmD0/kLTKu9VSUI0FyEOAczPwVLbNJJnj6iy
         TZyIvolAIfADUJ83Kr7LXlAu71HM68Z5pKSfbX0LU1Oi1VVomdoQrlQ16WN2xr2A4zZl
         uiiIcHxPLFPQTr7To/u4fDekAxRvdrD207xU5aLwP6bLFzz5PrgISbWeP3OtKHqcBkjg
         p2eQ9tHrqc2J2W5uLH2hnRc0M0znqVdaXCWYNqI7dU2xomTCcVS4lfjMkvbzlDEJq5PN
         0vDA==
X-Gm-Message-State: ACgBeo0FbbSuOkMR3m7PZPJUdJRBJzfgjmohpSMDEUYx1Hs272kUuEkh
        qYSVxhZdl8GbuGyi8tEiXw==
X-Google-Smtp-Source: AA6agR42ZU6Hvi/yKVQOmrNtnY8Z/N6ngoK1AmvM742vrzGwV1LSvyBk0CuqpQSMIwTLFyQapO6Rqg==
X-Received: by 2002:a05:6808:21a2:b0:345:d23e:d2e2 with SMTP id be34-20020a05680821a200b00345d23ed2e2mr4725175oib.273.1661798522665;
        Mon, 29 Aug 2022 11:42:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n29-20020a056870241d00b0011c8332922fsm691084oap.29.2022.08.29.11.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 11:42:02 -0700 (PDT)
Received: (nullmailer pid 2118960 invoked by uid 1000);
        Mon, 29 Aug 2022 18:42:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     robh+dt@kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, conor.dooley@microchip.com,
        paul.walmsley@sifive.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, greentime.hu@sifive.com
In-Reply-To: <20220829062202.3287-2-zong.li@sifive.com>
References: <20220829062202.3287-1-zong.li@sifive.com> <20220829062202.3287-2-zong.li@sifive.com>
Subject: Re: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache to composible cache
Date:   Mon, 29 Aug 2022 13:42:01 -0500
Message-Id: <1661798521.316365.2118959.nullmailer@robh.at.kernel.org>
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

On Mon, 29 Aug 2022 06:22:00 +0000, Zong Li wrote:
> Since composible cache may be L3 cache if private L2 cache exists, it
> should use its original name composible cache to prevent confusion.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  .../riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml}      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/riscv/sifive-ccache.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/riscv/sifive-ccache.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

