Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C74E342D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiCUXQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiCUXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:15:52 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE0135860;
        Mon, 21 Mar 2022 16:04:13 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id q129so15864089oif.4;
        Mon, 21 Mar 2022 16:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHOKYDScePWDDSbSmtsT1wVgFfFGhYJ+k2Q4cOfKji0=;
        b=zp0NGDCiRhnilJZApP0mUpd/oQyyj4aCtJ0+wK9bosYdeYNRDWJlQ/bOkfx21pu3uf
         lS6grcTunxcb9yqlyNdSlwldCdHtp3PdIwgnHp36nzC/aY0dvEBsjspzVLuev33LaVZ8
         qZIj5xksyzOapY+OMyu/QbclwCmLR/7oO/btDbTJ8NAQlyS5wLqx5eCLPBJ0SqpO4J+Y
         8wzLvqmCBJhyzIcyWMoQ0+XHCUpC+5ooJOI37JvPRij7bwZCVoAKyW4NeJOd0ZewSS11
         UI3bCiOlTEceKVoHOjGLhys1ndWxUpr/cINZZ4wU81BJNNq3+ThCCosvqTvjWGZLPoDN
         LksA==
X-Gm-Message-State: AOAM532WaLNp2ULZx7RibdHQ+8mP9sFpmECNftny7mF6RuZ0sz4ZLOHb
        uwcje7D2w13o53jfS4PxAUreQ+/RjA==
X-Google-Smtp-Source: ABdhPJz6A0A5I98y1ro+8CsnpmI5/R6rIW6STOxSSwZW2ZogOKhBbi4SN/sPf9/sQqRwvSw/X5UBDg==
X-Received: by 2002:a54:4899:0:b0:2ef:3d97:2528 with SMTP id r25-20020a544899000000b002ef3d972528mr618063oic.211.1647899132525;
        Mon, 21 Mar 2022 14:45:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568301e7100b005b256697d7csm7727797otr.72.2022.03.21.14.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:45:31 -0700 (PDT)
Received: (nullmailer pid 592971 invoked by uid 1000);
        Mon, 21 Mar 2022 21:45:30 -0000
Date:   Mon, 21 Mar 2022 16:45:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible
 string
Message-ID: <Yjjx+nxf+j6zPPXG@robh.at.kernel.org>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-2-luca.weiss@fairphone.com>
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

On Mon, Mar 21, 2022 at 02:33:13PM +0100, Luca Weiss wrote:
> Document the compatible for the UFS found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - add second hunk for clock validation
> 
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Are maintainers supposed to know that this is dependent on a patch in my 
tree? After a week of vacation I don't even remember that without 
checking.

Rob
