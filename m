Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C898047C27C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhLUPNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:34 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:36846 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbhLUPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:28 -0500
Received: by mail-qv1-f52.google.com with SMTP id kc16so12700984qvb.3;
        Tue, 21 Dec 2021 07:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fKX6RjQUhNvXa9JrLg/s9KHiNm86tGB9N0wiK9CEnU=;
        b=Gz24N086qy/QbzSpalwOTOlBuzJckjqZvnNGbI5sTCeTtSV0Ivf/kXV9B1saufdBfs
         UKIAgUnWzKjAkL2aHLccoBZdDq2qOBlPYfAYsVpIJw6l9wU390lOJ19wtTwK7nHv2lQq
         SEZGcYfgVNoKejFbqpSmt9WZHJ13QSIkZRziewx3RmQIdZr/hCG7Mg1oRTzjrkKW+a+z
         mQb78SELGkD3O3ZZtnmxCf0mVgUL1GVc7AYRNlMJXn4B/R0GfV2e2ZLCep/3IZv8CHfZ
         WncN1njNC1Mcmf9vwGHjxmMOpMdKwmAEbx2o86u/e9DPjzGEQAMESRcpKZ1i4UK/djgN
         Y1EQ==
X-Gm-Message-State: AOAM5309QQ/tQLW9c+sE7++kEtHdOtUg0HSyMKvJ7or8B+deYWv3sHM5
        tqNhcBJoxypd/VVby1dUpg==
X-Google-Smtp-Source: ABdhPJx0O7vvxkTI9F1oGzIZmh7+nM/VkVa/kX86WP5ulF3qemPI+8XqcTEsOn7fE6VA95rN13Xybw==
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr2702941qvc.36.1640099607261;
        Tue, 21 Dec 2021 07:13:27 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id bm25sm14352057qkb.4.2021.12.21.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:13:26 -0800 (PST)
Received: (nullmailer pid 1427701 invoked by uid 1000);
        Tue, 21 Dec 2021 15:13:24 -0000
Date:   Tue, 21 Dec 2021 11:13:24 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     tglx@linutronix.de, Rob Herring <robh+dt@kernel.org>,
        sboyd@kernel.org, collinsd@codeaurora.org, subbaram@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        maz@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] bindings: spmi: spmi-pmic-arb: mark interrupt
 properties as optional
Message-ID: <YcHvFKG8NaXzKpgA@robh.at.kernel.org>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
 <1640071211-31462-9-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640071211-31462-9-git-send-email-quic_fenglinw@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 15:20:06 +0800, Fenglin Wu wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Mark all interrupt related properties as optional instead of
> required.  Some boards do not required PMIC IRQ support and it
> isn't needed to handle SPMI bus transactions, so specify it as
> optional.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

