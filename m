Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AE4CE036
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiCDWXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCDWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:23:37 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D3119F28;
        Fri,  4 Mar 2022 14:22:48 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so11023812ooa.10;
        Fri, 04 Mar 2022 14:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FK6O8iZYd30gBa2H7oi4DqRG0FOU8lUzNheBx5but+U=;
        b=34DDPIZm6A13OrvsLvs1Vpvdvsol7L8TBwB+z9w3vaQXTt+WXKEOw/jYBp7NZUKhXz
         yOEHa785GzXTIxOHYOgnLqBy8eqBaQcr3hKZcvBeoZHwP2fjNgB0QlGVYTVRPNokb2I3
         AtgQyeAKaA7nUTG39OrlNPtNbbumJVkAqvm5ybnt2HBG+anYCL1iIA2OfXORtOgHE1GO
         24H8RYPKSnzvoqYuPD5x5f+tOd7mqUMcOS6JbR2ok57bz/qJDR2RdIW3LGI7Fk5Jyl3M
         2U0QaWFab83eaMaxY6z5LDz4DpwxOD7duoL3nXciBuyvoZMVzhMqKQUfyAcHLBqf0NMC
         RZsg==
X-Gm-Message-State: AOAM533HuUuj5pQfxfamRggTDuS5X0mIcyZQ5xMkrOat4V768Bx8Lug1
        WfEPb5dQnBExdu5iMegtwA==
X-Google-Smtp-Source: ABdhPJw1skblzO/l37y1Ad9RMSdf/uLpokD28+b8ny8V7h1Wyw+1qpcXIpCmOYkOFGCjdu8+ICChTw==
X-Received: by 2002:a4a:d415:0:b0:31c:3fc0:74ce with SMTP id n21-20020a4ad415000000b0031c3fc074cemr238974oos.47.1646432567688;
        Fri, 04 Mar 2022 14:22:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e13-20020a9d490d000000b005b029275a9csm2945058otf.58.2022.03.04.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:22:46 -0800 (PST)
Received: (nullmailer pid 546919 invoked by uid 1000);
        Fri, 04 Mar 2022 22:22:44 -0000
Date:   Fri, 4 Mar 2022 16:22:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        perex@perex.cz, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, judyhsiao@chromium.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        quic_plai@quicinc.com, sanyog.r.kale@intel.com, tiwai@suse.com,
        broonie@kernel.org, rohitkr@codeaurora.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        bgoswami@codeaurora.org, robh+dt@kernel.org,
        yung-chuan.liao@linux.intel.com, agross@kernel.org,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v7 2/2] dt-bindings: soundwire: qcom: Add bindings for
 audio clock reset control property
Message-ID: <YiKRNFONirytK+4X@robh.at.kernel.org>
References: <1646316128-21082-1-git-send-email-quic_srivasam@quicinc.com>
 <1646316128-21082-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646316128-21082-3-git-send-email-quic_srivasam@quicinc.com>
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

On Thu, 03 Mar 2022 19:32:08 +0530, Srinivasa Rao Mandadapu wrote:
> Update description for audio clock reset control property, which is required
> for latest chipsets, to allow rx, tx and wsa bus clock enabling in software
>  control mode by configuring dynamic clock gating control registers.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
