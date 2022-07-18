Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33003578BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiGRU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiGRU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:26:39 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B286C26AD8;
        Mon, 18 Jul 2022 13:26:38 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id v185so10241041ioe.11;
        Mon, 18 Jul 2022 13:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hA8wPICQRmlcXHR1RzZ5CqKuP+GtC1xmE/ODFavmP6c=;
        b=xoSvBlClBAIhdLG9Ak2mJdtUmWAh25DFdKKl5N5SyIHhkfN8TpQbxcjDuSC+hOcVLM
         DzRloORaIe0CDC0BXNhyJ498wEKtY8LYt86BOi3dCYAkm+NYxh7TtalX88ULAimOlSih
         KvzfXhRPtCZfikd/iUVSJ6DVXIgQrObAslZ6fipNYFiuMfbxIVGyzTMbOjVhRrmQdNct
         1uhS4trwmqZxfo7lV/8KBkyHyrIZQ0fRf8wFe84IDRBwRKP9nggK+RdSfDdmCanjDurA
         kEv1hI2Plk8BzufujlHLh0PyNvRqIlVx37JAGG+ntsONSIPJA2zNsnbPPUj/ZwXXTVSR
         vOfA==
X-Gm-Message-State: AJIora9m+QJr8MaM1n95WZTEPNPNjUnh2W/k0wj+FDG/RCMtl6PUBdQp
        zTY6bYg3FfofdnACF/MTCQ==
X-Google-Smtp-Source: AGRyM1u8CXgVK7SbcKzfOnatfAsltz8umYBH4M7Dtvr1DrKM21afkKFRpt9R9cj89m8hm13H4SgP4g==
X-Received: by 2002:a05:6602:2a4b:b0:67b:c364:34ee with SMTP id k11-20020a0566022a4b00b0067bc36434eemr13019034iov.180.1658175997936;
        Mon, 18 Jul 2022 13:26:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g7-20020a028507000000b0033f7e44904fsm5939172jai.134.2022.07.18.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:26:37 -0700 (PDT)
Received: (nullmailer pid 3490910 invoked by uid 1000);
        Mon, 18 Jul 2022 20:26:34 -0000
Date:   Mon, 18 Jul 2022 14:26:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, jamipkettunen@somainline.org,
        marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        angelogioacchino.delregno@somainline.org,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: apple,aic: Document A7-A11 compatibles
Message-ID: <20220718202634.GA3490849-robh@kernel.org>
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712160919.740878-1-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 18:09:18 +0200, Konrad Dybcio wrote:
> Document the compatibles for Apple A7-A11 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../bindings/interrupt-controller/apple,aic.yaml          | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
