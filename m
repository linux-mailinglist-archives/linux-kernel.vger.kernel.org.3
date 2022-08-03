Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356658936B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiHCUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiHCUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:44:03 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3019FC5;
        Wed,  3 Aug 2022 13:44:02 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id g18so9071476ilk.4;
        Wed, 03 Aug 2022 13:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5ihkIh4wV1fLXjf3U2JooUONElLr3RHi6M3ZqoiMU1c=;
        b=UuN5xGmUyP3ssVu+e40gt2vuozli/tKcwHNdC2Kq9v2V3ipsf+NF91v0FUUIPUOil2
         uPubgaedIGWxXCuAVhZ2cd11biiFSDmZE/gZYKMf1KEjmpxTYGP+tO/Fmue67KfJ9Ouf
         MHd6wAZkNED/5zt9ed4W2kUl56BwpXHT25uyOrW79TiFRjmcXnqftgbuYJa8DhQ2SaeN
         4Dl3DFbzNQvi+k1zSZjyUyE1Fo5bDYCB/1v6ZVWUc9eX8IQ4Hy/Ddefml5uo2DXg2xjv
         BPcybb8HtoKFMmgkY3jgBmDDoKyab526nYy8wbo0gA2UjRqco9IQk1CftzDGt4g58e0D
         s/rA==
X-Gm-Message-State: AJIora9WMyUbo3vILpbTMTcH2g+FzKwuIkiGvfMf/h6U4vPM5LBWGV00
        t+By59l3XABPhxdefqBADUz7gfJ3Lw==
X-Google-Smtp-Source: AGRyM1tBRJ9MpqM0nDRf8tCJ080e9rYHNY/c2FkMyOFX/aZRufmggHz0JsQQ23h/hJREgb+v8jolfw==
X-Received: by 2002:a92:c544:0:b0:2dc:f222:9fba with SMTP id a4-20020a92c544000000b002dcf2229fbamr11586142ilj.270.1659559441945;
        Wed, 03 Aug 2022 13:44:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u133-20020a02238b000000b0033f4a1114a6sm8130652jau.178.2022.08.03.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:44:01 -0700 (PDT)
Received: (nullmailer pid 2590318 invoked by uid 1000);
        Wed, 03 Aug 2022 20:43:59 -0000
Date:   Wed, 3 Aug 2022 14:43:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: remoteproc: qcom: adsp: Add compatible
 name for SC7280
Message-ID: <20220803204359.GA2586715-robh@kernel.org>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659536480-5176-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:51:14PM +0530, Srinivasa Rao Mandadapu wrote:
> Add compatible name and update max reg items for SC7280 base platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
> index 9f11332..147996f 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
> @@ -17,11 +17,12 @@ properties:
>    compatible:
>      enum:
>        - qcom,sdm845-adsp-pil
> +      - qcom,sc7280-adsp-pil
>  
>    reg:
> -    maxItems: 1
> +    maxItems: 2

sdm845 has 2 entries too?

>      description:
> -      The base address and size of the qdsp6ss register
> +      The base address and size of the qdsp6ss register and mcc register

Better expressed as:

minItems: 1
items:
  - description: qdsp6ss register
  - description: mcc register

Though the descriptions could expand on what those registers are.

Rob
