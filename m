Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE958E042
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiHITdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245292AbiHITdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:33:18 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52523163;
        Tue,  9 Aug 2022 12:33:13 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id v185so10397110ioe.11;
        Tue, 09 Aug 2022 12:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KbbQmWU4qA4C5SAgaTHau91UtMwlzzGKrvvzwpZ4910=;
        b=viBznppw7y61QCnj+xTZZdr757B/JP6jEnsX6XssUNjUZhOFYBb2O313TC8hIxGodN
         jSE1lnyxs2Sro7bWlMtGWph9Nt6/INvS6MFz3bHpQ8dqXZgU8fPeiCUHHQPG/CmIZfu4
         B7yrBKIIvqpqfFysOD4QTvkm85tf+XeM4usYO8ZkCPYSVm5WqeWFw/sk1iSXTwpPmyEH
         rb24GvAeB7bNQF6Qd10nS/vZLneofN0oF04+Od/Imluqk1ZvO57HV+ktZQBvE6f3Rh/D
         AtFwzRThKvG0EbCg8epK3G32Z6SJa7/csFAl3bBLWDRMeXE3+zi54kBYnqjZYUjruQXm
         fcgg==
X-Gm-Message-State: ACgBeo3Xz+JHx1PLR/fJq40bxECP+kDkjnJECR5ZkEF4eg0YAruhbvtY
        eNTG/1cxQocKGgImzLe6SM/m+LQNHA==
X-Google-Smtp-Source: AA6agR5gwwnr/r/AZS7KgL3Iw9NgQckA8lPV0+OriPK7Db+sj37t3wV972uRUfF92jolGMkuLTiqcg==
X-Received: by 2002:a05:6602:4192:b0:684:6256:e892 with SMTP id bx18-20020a056602419200b006846256e892mr6315524iob.89.1660073593070;
        Tue, 09 Aug 2022 12:33:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b3-20020a056638388300b00342f67a4789sm3436507jav.164.2022.08.09.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:33:11 -0700 (PDT)
Received: (nullmailer pid 2251083 invoked by uid 1000);
        Tue, 09 Aug 2022 19:33:10 -0000
Date:   Tue, 9 Aug 2022 13:33:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: remoteproc: Add AVM WASP
Message-ID: <20220809193310.GA2251034-robh@kernel.org>
References: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
 <20220804210806.4053-3-kestrelseventyfour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804210806.4053-3-kestrelseventyfour@gmail.com>
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

On Thu, 04 Aug 2022 23:08:05 +0200, Daniel Kestrel wrote:
> AVM Fritzbox router boards may contain an additional ATH79
> based SoC that has the wifi cards connected.
> This patch adds bindings for this remote processor.
> 
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> ---
>  .../bindings/remoteproc/avm,wasp-rproc.yaml   | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
