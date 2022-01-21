Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4B496818
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiAUXGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:06:42 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35663 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiAUXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:06:38 -0500
Received: by mail-ot1-f43.google.com with SMTP id n22-20020a9d2016000000b0059bd79f7777so13214896ota.2;
        Fri, 21 Jan 2022 15:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3KFtSOIoFQkJaMXpVUGbHma41rNEP+UMGRX2A7AnZ8=;
        b=8FBdshQ9DnvHSGwl9dcc85d04wbzK6BCAWfszWyIMCK/9UJGoM9G2n3oc6JqjUtl2X
         xng/ymADYwn15YXxk5gQt7gsjrNDAFjiBhOrh2a6oPbN8uS2p7jrGH9tSVWm/wtqAzLG
         duzYExToKZbfZbnpWpAxmKAiCqF3bCkkHQtXvTxPQi28f/azLtJL0uPZ7m0BG1x7ps/2
         usqbUADkg6LjlJVnOixcqf/smGUb2eImNFSqp/HwLf7wav/C5cy4TCAE9uwe6yq6xYpv
         FnOxc5zMMWHXayaQsqgS2bD2bOYr0sLL5Cqt0Nkzo+jRJDPM3PfBukIKirMbBFPlfGu6
         9HJw==
X-Gm-Message-State: AOAM531eVMZf5yziCHEqyqvE5p5fJoG6A8eTR9t8mSj3H60eU0z5vHiJ
        FodxpFB7TrH1oeN2lsEqhg==
X-Google-Smtp-Source: ABdhPJzwprq+qaYkBUXeGWOp4u401K45nG3rji4PuYIE9gxcgDj1Hw4ccnC1n7QVjxWm1RDH4j6Cbg==
X-Received: by 2002:a05:6830:8c:: with SMTP id a12mr4317805oto.153.1642806398105;
        Fri, 21 Jan 2022 15:06:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj19sm2111505oib.9.2022.01.21.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:06:37 -0800 (PST)
Received: (nullmailer pid 1777253 invoked by uid 1000);
        Fri, 21 Jan 2022 23:06:36 -0000
Date:   Fri, 21 Jan 2022 17:06:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     quic_lsrao@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        ulf.hansson@linaro.org, quic_rjendra@quicinc.com,
        devicetree@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 05/10] dt-bindings: soc: qcom: Update devicetree binding
 document for rpmh-rsc
Message-ID: <Yes8fLEld8i66ZWB@robh.at.kernel.org>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
 <1641749107-31979-6-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641749107-31979-6-git-send-email-quic_mkshah@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jan 2022 22:55:02 +0530, Maulik Shah wrote:
> The change documents power-domains property for RSC device.
> This optional property points to corresponding PM domain node.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
