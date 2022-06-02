Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38F653BB16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiFBOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiFBOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:40:08 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4E2853B5;
        Thu,  2 Jun 2022 07:39:56 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id r65so6734885oia.9;
        Thu, 02 Jun 2022 07:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQafOfh6w1zgJTmzD2zQY13Qf3DW1fvEsip3dg2JStY=;
        b=k99fCZMkmZORBxEaQTgJo+eZlXg11mAcpnApWw3eHTYDNPzwI3EOxcOfbdJz3vzNL1
         T+U1hjSgg5tg1QfWsQBCEgXhoeUh+sSIVznXDa4UPfE9gQJIZQqWjaIBe+1W0N/IXFpi
         xprZLPfC+32a0XURUtD/JlmzjyiPQmNxMrYSZ3wRNkdeiaApnXYOtK3qERCWIuTX8+b3
         GrqeNhBH4Z1syY12y/+KAWcHg5TCreJ4ad6k1KRruMcd/hU5Bl9ZS+enB9SJL6fdC8yO
         B98NVL1KWhePxVC57QFoDiVQOLUxx2dXOwTH3xg935BjX+tZQTE0Ip+Ta5Au8IJkINoT
         Ygyg==
X-Gm-Message-State: AOAM532uxRewmxvUoM409NSufUZPTvBn3WlzZ+jgu9OnEmbe9u3YzUvO
        uzeKUcwkhM01sLtwglQSaISV0gfUxA==
X-Google-Smtp-Source: ABdhPJz9ABWeYunYGC8P6oMorLnRa1Wqwh+S+NSe3YLquZiEo3N6mncOaKkPwcL4sEwBEn9F67hu2g==
X-Received: by 2002:a05:6808:1381:b0:32b:2afb:bf93 with SMTP id c1-20020a056808138100b0032b2afbbf93mr2756432oiw.192.1654180796058;
        Thu, 02 Jun 2022 07:39:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 1-20020aca0701000000b00328e70cae5csm2453396oih.43.2022.06.02.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:39:55 -0700 (PDT)
Received: (nullmailer pid 2277443 invoked by uid 1000);
        Thu, 02 Jun 2022 14:39:55 -0000
Date:   Thu, 2 Jun 2022 09:39:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: Update my email address
Message-ID: <20220602143955.GA2277333-robh@kernel.org>
References: <1654118992-4026-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654118992-4026-1-git-send-email-quic_jhugo@quicinc.com>
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

On Wed, 01 Jun 2022 15:29:52 -0600, Jeffrey Hugo wrote:
> Update my email address from the defunct codeaurora.org domain to the
> current quicinc.com domain.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,mmcc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
