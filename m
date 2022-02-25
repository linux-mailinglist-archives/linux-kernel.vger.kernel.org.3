Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F84C4E50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiBYTJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiBYTI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:08:59 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D7194149;
        Fri, 25 Feb 2022 11:08:26 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so7485797oop.13;
        Fri, 25 Feb 2022 11:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gLaPPylCSRSRt4wztREpwI4m1e+FOfbTqnD+bNNy18I=;
        b=kL9NxMiS1LVbbdKX+GR0T/uG7CddPaelVkJGwB4iBIygLacZTv6DKPxnzPXGyBobRs
         dzftPpYXo2shLcjXVn2nrl63dP35xidAOsXu07HFMtHpGrFQyssADaQ+28uTIEdDrUTG
         IMhxAuxXRz3k6SRkomOcvRZDgCECY1vlFl2esG9iOPJOG8Nt25HbCtIVAewZEBfXJely
         bRQnYi0y7sJgaNafyPiKH7/9Vzr3wFFW1kRugBX35pVQbTn/tPkiLBQ7JU9HWlveMvwb
         HCEniL1TxKhOjdxqaz1/lejXP2Hff7LacMRMqsj3DSoX2HVK/5uqeIvJP2Ul+BxtVpbk
         TccA==
X-Gm-Message-State: AOAM533wqrijLKKuGkvVQBcxDOr4fLzde+QCn4GtUuZyNm7sABWfczkP
        gdYjTwiJKUs5bElMaEXDbOU1sdv0pw==
X-Google-Smtp-Source: ABdhPJwjQqWTZ60aOvX3GXryd3E9kdB2g5bch4rI35l6Axo2X1+NCXqYiukhpG/7sn59PDrE+LlA5Q==
X-Received: by 2002:a05:6870:5b9e:b0:cf:f6de:3e89 with SMTP id em30-20020a0568705b9e00b000cff6de3e89mr1919572oab.94.1645816105917;
        Fri, 25 Feb 2022 11:08:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 23-20020a9d0b97000000b005ad33994e93sm1495550oth.31.2022.02.25.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:08:25 -0800 (PST)
Received: (nullmailer pid 1262255 invoked by uid 1000);
        Fri, 25 Feb 2022 19:08:24 -0000
Date:   Fri, 25 Feb 2022 13:08:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add AVM
Message-ID: <YhkpKI7scFKaqAqC@robh.at.kernel.org>
References: <20220221135259.GA7306@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221135259.GA7306@ubuntu>
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

On Mon, 21 Feb 2022 14:52:59 +0100, Daniel Kestrel wrote:
> Add vendor prefix for AVM Computersysteme Vertriebs GmbH (http://www.avm.de/en)
> 
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
