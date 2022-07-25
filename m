Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB65805EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiGYUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGYUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:47:56 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85285E030;
        Mon, 25 Jul 2022 13:47:55 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-10d9137bd2eso16305150fac.3;
        Mon, 25 Jul 2022 13:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wM1hK2c/dTp5U3qgSjbl+Mkf9GAgKrulWLu2l8asXMg=;
        b=PI+N7/O2Z4m58Erb5nDnV1AKkk0VweFFIOZD6QE3S525fh3sGYzdbHCVIsFOrTGxvh
         +sU12ttR/BrmIG2I21bcm6pWAGoujjymfU2Ct+bo7TWqpsMxgB7XJMie33kx749a+Ns2
         w9DFEkv+RIY/hF9FX/tBv3ah8SJJxrXnJsqV8dFr4CKN9IL2CrEQhzzdEdjiS6CX+5kA
         NYHhakT21iNx8kBowlsn93G9GFkCD+I0hf6haS9vDZ2rKyeoz9a7JOFsT2HhgGbhPqEk
         OkXiQDTawzsoScp1+Fb2nSsLzaum3j1dNpLrF6xMVv/tXlNv8zBLbV31wqQkMtjYAhtH
         kdJA==
X-Gm-Message-State: AJIora+kgUd7QLA6Rl0K0MReFXqZXyCBxokTLIzE2PJzJ4Q1nBO+8iND
        Ihh2vlbadUG1oE8hL0vivJSW653y0A==
X-Google-Smtp-Source: AGRyM1uYYn9eDDDIyVDp1EozaBHVGSFeYmutnuF07N2Do7HDPkvBIRyLKm0gPmoaR0mEba9mzl7nSw==
X-Received: by 2002:a05:6870:231b:b0:10b:7a08:bfbf with SMTP id w27-20020a056870231b00b0010b7a08bfbfmr14335133oao.11.1658782074708;
        Mon, 25 Jul 2022 13:47:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w21-20020a056870b39500b0010bf07976c9sm6539499oap.41.2022.07.25.13.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:47:54 -0700 (PDT)
Received: (nullmailer pid 2696639 invoked by uid 1000);
        Mon, 25 Jul 2022 20:47:52 -0000
Date:   Mon, 25 Jul 2022 14:47:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: panel: raydium,rm67191: Add missing type to
 'video-mode'
Message-ID: <20220725204752.GA2696554-robh@kernel.org>
References: <20220719215201.1877997-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719215201.1877997-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:52:01 -0600, Rob Herring wrote:
> 'video-mode' is missing a type definition and is not a common property. The
> type is 'uint32'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/panel/raydium,rm67191.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
