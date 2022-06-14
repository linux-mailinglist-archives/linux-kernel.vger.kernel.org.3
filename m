Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F454BDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiFNWfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiFNWfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:35:13 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3734EF7C;
        Tue, 14 Jun 2022 15:35:12 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id d6so7638278ilm.4;
        Tue, 14 Jun 2022 15:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aemasrqfwaW0xVRSjSqdQ4JfxZy0TQey0iT9bogvqO4=;
        b=JWuvFMI/Z3Mc3ACnfAb06u9UajEkyQ6Jy8d8E4zP8g7g6pSLuZ9DVh5A7EPHVOmc1m
         ebTQDi4KDa6bayFZGMcQWKDK2WbV4mLBr6T/VZ8XkTLR6FPaQfW4H3dcOxDKm2cnQzri
         VR6y7VTt1GTbjb3IDmIrZRyu0fJtQk2c7E1kMRwnyLZ1cF5dIAvDui3llAMJe9JXpkM0
         dd02xh6YxvQopNbj3ZAzhbeCY5anErxlGhWBDW0WQRg9iS5alh0aUkvMIazuPR22Bpff
         w8C7iPXBNW/r52ns6lo26hz3SV8uXM6nFNiKRWqjOSo8iez3l+TBWkk6HvRoQBdrp0Gz
         ALZQ==
X-Gm-Message-State: AJIora+mzzRcNl/oOVGTABuHqPKNXpL+gXKg1NA90M0+2nKQOPJUaFTz
        NtEU4gi/fIUpdRreJY5ANg==
X-Google-Smtp-Source: AGRyM1u3MB5UawW2+wt5tCmnlp/5KvqCGJhKl2Um3Et1tsrwULWDyKeKydmmaAcZFCt/295nVoKx5g==
X-Received: by 2002:a05:6e02:1448:b0:2d3:c5c2:fbbe with SMTP id p8-20020a056e02144800b002d3c5c2fbbemr4528164ilo.188.1655246111376;
        Tue, 14 Jun 2022 15:35:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z4-20020a92d184000000b002d3c1859791sm6040316ilz.60.2022.06.14.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:35:11 -0700 (PDT)
Received: (nullmailer pid 2855592 invoked by uid 1000);
        Tue, 14 Jun 2022 22:35:09 -0000
Date:   Tue, 14 Jun 2022 16:35:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     swboyd@chromium.org, bgoswami@quicinc.com, lgirdwood@gmail.com,
        judyhsiao@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, quic_plai@quicinc.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        tiwai@suse.com, broonie@kernel.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, quic_rohkumar@quicinc.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: sc7280: Add boolean
 param for ADSP bypass platforms
Message-ID: <20220614223509.GA2855511-robh@kernel.org>
References: <1654921357-16400-1-git-send-email-quic_srivasam@quicinc.com>
 <1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com>
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

On Sat, 11 Jun 2022 09:52:36 +0530, Srinivasa Rao Mandadapu wrote:
> Add boolean param qcom,adsp-bypass-mode to support adsp bypassed sc7280
> platforms. Which is required to make clock voting as optional for ADSP
> bypass platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
