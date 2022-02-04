Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4864AA42E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378019AbiBDXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:17:42 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37772 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378008AbiBDXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:17:41 -0500
Received: by mail-oi1-f169.google.com with SMTP id r27so10310618oiw.4;
        Fri, 04 Feb 2022 15:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h80UoHlKwvo3NQa72LtjSndJO3TSfq+x4h8BGbi0L6A=;
        b=b+7hKxvfFr3/kTRUN7opMyAlzeu1ngY2eZnEYrRLA9Bq1YIzLQQYxrAmBJDYBoCrGm
         f4Kbt7xWVrCNWN7y6y8ZkEPxEP8jLI3zEUej4jmCEPdDU3ljyhJSb6+AjURFhNqGCpwL
         sCvJlVt8kZrTkNf3oF7F/FW5YHaZbsnneA3xnqdUEo69Jf/4g+oDMoCbN6dlaDtxC+RI
         jGuik039k+JicH1QqjuI9yorITg+gXnFI0CohTPTa+Id5MsuCv6085sLXLuPB0KjcOoB
         RcGZ7+HxhkJ8/YXip0z7lmVjhvvDctO5dy+0JfxGawFMh4KOgMgf4aTMepCGB71/wvjY
         BEsg==
X-Gm-Message-State: AOAM532gUnA2IZJ5yrI68FEfOlU+NnlFXYN9lrcIms+Lm8pjesOfqiX4
        b57tsMJHuFPhh4FgrbAo/w==
X-Google-Smtp-Source: ABdhPJwXWBWhQCMJVfASwzfKmauHN7xUXSradyKBOHDqIC4tTOWl8ihrLBZI+hSmjfWqGXJM5lhggg==
X-Received: by 2002:a05:6808:1184:: with SMTP id j4mr2453009oil.119.1644016660453;
        Fri, 04 Feb 2022 15:17:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w9sm1227614ool.31.2022.02.04.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:17:39 -0800 (PST)
Received: (nullmailer pid 3367314 invoked by uid 1000);
        Fri, 04 Feb 2022 23:17:38 -0000
Date:   Fri, 4 Feb 2022 17:17:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add YAML schemas for LPASS
 clocks on SC7280
Message-ID: <Yf20EjfKhZ2BBZvU@robh.at.kernel.org>
References: <20220126081236.25255-1-tdas@codeaurora.org>
 <20220126081236.25255-2-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126081236.25255-2-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 13:42:35 +0530, Taniya Das wrote:
> The LPASS(Low Power Audio Subsystem) clock provider have a bunch of generic
> properties that are needed in a device tree. Also add clock ids for
> LPASS core clocks and audio clock IDs for LPASS client to request for
> the clocks.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../clock/qcom,sc7280-lpasscorecc.yaml        | 172 ++++++++++++++++++
>  .../clock/qcom,lpassaudiocc-sc7280.h          |  43 +++++
>  .../clock/qcom,lpasscorecc-sc7280.h           |  26 +++
>  3 files changed, 241 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
>  create mode 100644 include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
