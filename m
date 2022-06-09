Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03708544FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbiFIO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbiFIO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:56:19 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855938ACAA;
        Thu,  9 Jun 2022 07:56:16 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id f7so18931849ilr.5;
        Thu, 09 Jun 2022 07:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQZHh4HZrb6UztaIZM6VI0Jf69XnT1r33At+ff78LYo=;
        b=oSkzThKrZjHXD+pj/MitsccacFqFTyHjZXhBA0ALSG9lH/zIQXOOUDjBw+6Ie5JIVx
         txk/D+jJvpWL2b1WUBDJaOKhZAHnVl6r4n0Ck8L+CpQrF6n2QRj+iPOD8q6jrZb4w7eP
         sTPIEpzEHYsrWk896iDfYt/HwUUXhhY/T2stZn/GIr6D6jXJccu0MBtga7u2SwAFTM9n
         RNRUbmH8C7g1ckrWxAkjom8aD1yIWoGCr3BQzjL66LK7Nevp16vqUPFM3cvX4uFmGwTc
         RbWdoyxnndJzegGirGhu8dtoMrjbPlr8lpbsghUXLwQqvRoaOtCCq3Pqg51J7Zs9V3Ou
         v9cQ==
X-Gm-Message-State: AOAM531ZA4Yic5nfrfZNcfv2YSJry9bvwt3UowhYvrFyf6AaoZ+9UG6W
        3yxHk34BRyBhl4BwjwlcdW5LybKZiQ==
X-Google-Smtp-Source: ABdhPJwCIDMYT0AOMlBbbLg6xi3Pq6uRQbAraq0DNrtDKX8HWA6rmSYdetAX+C/X7jiHDNTHkaxrhg==
X-Received: by 2002:a92:3609:0:b0:2c6:3595:2a25 with SMTP id d9-20020a923609000000b002c635952a25mr22682156ila.233.1654786575297;
        Thu, 09 Jun 2022 07:56:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y38-20020a029529000000b0032e583132e4sm9569353jah.123.2022.06.09.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:56:14 -0700 (PDT)
Received: (nullmailer pid 3783357 invoked by uid 1000);
        Thu, 09 Jun 2022 14:56:13 -0000
Date:   Thu, 9 Jun 2022 08:56:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add resets for LPASS audio
 clock controller for SC7280
Message-ID: <20220609145613.GA3783291-robh@kernel.org>
References: <20220604062137.14584-1-quic_tdas@quicinc.com>
 <20220604062137.14584-2-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604062137.14584-2-quic_tdas@quicinc.com>
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

On Sat, 04 Jun 2022 11:51:35 +0530, Taniya Das wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
> 
> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../clock/qcom,sc7280-lpasscorecc.yaml        | 19 ++++++++++++++++---
>  .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
