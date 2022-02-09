Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1834AFCCF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiBITCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:02:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbiBITBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:01:30 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A37C05CBA2;
        Wed,  9 Feb 2022 11:01:28 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id r27so3478867oiw.4;
        Wed, 09 Feb 2022 11:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fDo1r/oAxqHfurPzGBlPl/YM20/6x7pAbjkKdww5OT0=;
        b=0yLaFH6B+xvF5x0zDMpfxrXKEn+My5FXlbg9tbHjKWnEkauf1aRI2fRIPxJNtlObL/
         ANqjwGR1CiFh+ToKyOmqJavi4ubMsz8t95Bzlq8FEPrhkVYpduajXUe5ykNht6nbW1PV
         D+KJgcE+o0+VVRtDO01oRFA7lijZ+yxWFppPuPQ5UHXXeYCQzt2h8AXmvelrWZZvGQmQ
         EBDvSVWr5TW794bYwW6PyhHVWIgVcXVGT92XW6L/NN8Ym/JmFFvWw9Cvl0e6Wx3h0xH2
         U4CNhZNeG5uUByrVqbky85uuUIXJ5QnWaZHuEV1Kc4KHD56p1XMfCnOtaDGBhjm9Ls0f
         WVQw==
X-Gm-Message-State: AOAM533tLyakAOl4kbj0iz5u+HITQ08lO9fHPohihgoZasn6lUVMdMky
        ZBqlVq5LH6TDWTGpJucfriuTXR+Dqg==
X-Google-Smtp-Source: ABdhPJxY15c+Da0fY768XqjzQDsA/HiWOQkQlmhD90QefobfGlPxX1T6V1OdfxBgFpFqi87Fbg1h3Q==
X-Received: by 2002:a05:6808:120c:: with SMTP id a12mr2145418oil.118.1644433208827;
        Wed, 09 Feb 2022 11:00:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a128sm7069142oob.17.2022.02.09.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:00:07 -0800 (PST)
Received: (nullmailer pid 695621 invoked by uid 1000);
        Wed, 09 Feb 2022 19:00:06 -0000
Date:   Wed, 9 Feb 2022 13:00:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     seanpaul@chromium.org, robh+dt@kernel.org, swboyd@chromium.org,
        quic_khsieh@quicinc.com, agross@kernel.org,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sam@ravnborg.org, daniel@ffwll.ch,
        bjorn.andersson@linaro.org, robdclark@gmail.com,
        thierry.reding@gmail.com, freedreno@lists.freedesktop.org,
        quic_kalyant@quicinc.com, linux-kernel@vger.kernel.org,
        dianders@chromium.org, quic_abhinavk@quicinc.com,
        quic_vproddut@quicinc.com, airlied@linux.ie,
        krzysztof.kozlowski@canonical.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: display: simple: Add sharp
 LQ140M1JW46 panel
Message-ID: <YgQPNlBtHNbu7FKG@robh.at.kernel.org>
References: <1644396932-17932-1-git-send-email-quic_sbillaka@quicinc.com>
 <1644396932-17932-2-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644396932-17932-2-git-send-email-quic_sbillaka@quicinc.com>
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

On Wed, 09 Feb 2022 14:25:29 +0530, Sankeerth Billakanti wrote:
> Add support for sharp LQ140M1JW46 display panel. It is a 14" eDP panel
> with 1920x1080 display resolution.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> 
> Changes in v3:
>   None
> 
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
