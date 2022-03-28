Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4F4EA3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiC1XoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiC1XoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:44:20 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B515FC8;
        Mon, 28 Mar 2022 16:42:39 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-df02f7e2c9so4522981fac.10;
        Mon, 28 Mar 2022 16:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/bMD5XJK9ZeZ9JMXaFrOnemeInZdC+WRoQ/+0h/V9wY=;
        b=NkHW4PgdiouECeJTgoy7OWQAoJ0sRIKyUWxMpVu0ckQMNHrQSNyrRVt2rXBRadlGrk
         hDTecDWSKppBt7/DNMKfFon/MYc0I6oMFwXbWm06uPdeInnNWLBJNxqoxrV39VozHR4n
         KVnm0e3riJFUgdvOmupN0ziGtInJn4vqSXfzvPeUV2OCbkSIT08lS1kpUdzOuti7lz+7
         aH6+zUkgzf23vtfpqaGPAGrSVvMVqmgMdglRX0C8KdpErwzeUi4Hmnm2WE5hK4hxg2oN
         pmEYRp6BrcRESJVzO3o15iG0C6TW58gD84jra56PxCk1DybZTRAjy+fPXj3rRbx1pLmi
         sy3w==
X-Gm-Message-State: AOAM533Yr0VEDUXAJCtTMq3RNACwRQcHFwD1CD7oPu/cgF7nLCphxAJ1
        5lA9Yl4yp/XPO/FLbZOUCg==
X-Google-Smtp-Source: ABdhPJzw+lAN1qKaN0d03io7vTQ2/YLq7E4IIiFYE2pFuJh6CZ1aVJn0WUpuqZjVOxM8u1TOPM2Mig==
X-Received: by 2002:a05:6871:694:b0:dd:a43e:fca4 with SMTP id l20-20020a056871069400b000dda43efca4mr842188oao.77.1648510958312;
        Mon, 28 Mar 2022 16:42:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y143-20020aca4b95000000b002d9b530a96esm7922037oia.44.2022.03.28.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:42:38 -0700 (PDT)
Received: (nullmailer pid 3269333 invoked by uid 1000);
        Mon, 28 Mar 2022 23:42:37 -0000
Date:   Mon, 28 Mar 2022 18:42:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        krzysztof.kozlowski@canonical.com, agross@kernel.org,
        swboyd@chromium.org, broonie@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        dianders@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: wcd938x: Add mic bias supply
 property
Message-ID: <YkJH7eRooyZ6aulW@robh.at.kernel.org>
References: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
 <1647852981-27895-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647852981-27895-3-git-send-email-quic_srivasam@quicinc.com>
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

On Mon, 21 Mar 2022 14:26:20 +0530, Srinivasa Rao Mandadapu wrote:
> Add vdd mic bias supply, which is required to provide bias
> for wcd938x codec.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
