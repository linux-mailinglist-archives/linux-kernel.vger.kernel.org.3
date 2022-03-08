Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED64D0D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiCHAxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344137AbiCHAxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:53:45 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87733FD1C;
        Mon,  7 Mar 2022 16:52:50 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so7490867ooh.8;
        Mon, 07 Mar 2022 16:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sd+Yvw7691O5dkoC55ZXaEZXMBAfmesOquSTaxPr6kY=;
        b=XIeCRWr0oJCHzJfklxqzTR2EmtlZ3hmBrk/n0ehcxAN1+HbwYsWGopCYP46ZT9swoF
         CTZH4Wtd6vu0DzO29h/GPJ67Fj44yV3/0OYnFVMzvigF9cr3ibo2RuwGmVfrf8SJ7tN5
         re+U4fMQHI/DfQRT6pI+3x/3DKV/cU9hbeLnJySZ+uF6j3sCKtJHvj3cqDgCsEt+rAwJ
         yT5ENJlWTGv9X5SKOEd8EUVfB/ZGlWR9vWJNqM/29+21bxx/UteslrV+kECRtWd0erlU
         ltOS0X7orogtpT020xKVq8EJf6w4LBpiLL5gGsCmLCKEtgdCJHDZSRDUTxkLJAY4WKcv
         IrHg==
X-Gm-Message-State: AOAM530tZ/GcBndYuuKwkHdqLVbJekdNKMk7KgoRgtdB59hDzRQdnYSF
        uLfObbs1msHeP4lreVmf9A==
X-Google-Smtp-Source: ABdhPJyrPMIEYs2Re1cHCaK70TNE5OWYk3dnU6R6oQyemNgrc5HfUeAElgm60shCfY0mfNEIckSurQ==
X-Received: by 2002:a05:6870:8310:b0:d3:8767:a832 with SMTP id p16-20020a056870831000b000d38767a832mr941761oae.113.1646700769882;
        Mon, 07 Mar 2022 16:52:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c17-20020a056830001100b005b236450790sm2086502otp.77.2022.03.07.16.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:52:49 -0800 (PST)
Received: (nullmailer pid 3598816 invoked by uid 1000);
        Tue, 08 Mar 2022 00:52:47 -0000
Date:   Mon, 7 Mar 2022 18:52:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     john@metanate.com, linux-crypto@vger.kernel.org, heiko@sntech.de,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 17/18] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Message-ID: <Yiao36rJVmPw/yGL@robh.at.kernel.org>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
 <20220302211113.4003816-18-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302211113.4003816-18-clabbe@baylibre.com>
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

On Wed, 02 Mar 2022 21:11:12 +0000, Corentin Labbe wrote:
> convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 64 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  2 files changed, 64 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
