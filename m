Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E17470CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbhLJWQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:16:25 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44651 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhLJWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:16:24 -0500
Received: by mail-ot1-f42.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso11001606otj.11;
        Fri, 10 Dec 2021 14:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWbbA7nY0ksBd7XqBRCsia9vtX8CakskxVmlYdvH+s8=;
        b=fKqH3+iN8ja7C8xhtLltoot5+Fa/03FjvYGFpMgI1aPXQ2aQdZ7capt7+KkHH91i30
         74f7h1fjRwkse+lmCSZpt5wyfig+a83mP4RoJOCE+gQO6WU/K/qWHKBl2z9aFhOQ2wEo
         77vpd/4Yy2YIsW1y96RtYoZ6ekue6iqcw5/jrvqYqEnTX3q4yZw8eafqXeovhNC7k/ra
         dpqAQAlR+I9qCdFbUc63gGWzG2qY+/d7YTPgthOvXnxE29ErHLZBnxA3Kv60+CJNURbC
         FMDV0MA+eqikpdfu72X6aw/i7pHoRRbHQofwcVWpt6pTUFp2oSY0RsbfZkp5aCNg041A
         2WQA==
X-Gm-Message-State: AOAM531T/iyVVKg/LjRJU1dQoytfg0ngd7dKlk/UsMvh2x7qJQznoG5S
        EoHBvBD6vetWDhSZMIctgg==
X-Google-Smtp-Source: ABdhPJzW7P9jnUmX63btC5aF6tG+xlyp70F0haV6yryaswJF2clhmzaYcHnTwV5fscc742g4krX5Hw==
X-Received: by 2002:a05:6830:1d49:: with SMTP id p9mr13162076oth.108.1639174368521;
        Fri, 10 Dec 2021 14:12:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm1063215oiv.35.2021.12.10.14.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:12:47 -0800 (PST)
Received: (nullmailer pid 2021380 invoked by uid 1000);
        Fri, 10 Dec 2021 22:12:46 -0000
Date:   Fri, 10 Dec 2021 16:12:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, collinsd@codeaurora.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        tglx@linutronix.de, subbaram@codeaurora.org, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>, maz@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH v3 10/10] dt-bindings: convert qcom,spmi-pmic-arb
 binding to YAML format
Message-ID: <YbPQ3mA4QsxKCppg@robh.at.kernel.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-11-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638403212-29265-11-git-send-email-quic_fenglinw@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 08:00:12 +0800, Fenglin Wu wrote:
> Convert the SPMI PMIC arbiter documentation to JSON/yaml. While at it,
> update SPMI bus "reg" items constraint for SPMI PMIC arbiter to carry
> it and update it with a smaller range.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 -----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++++++++
>  Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
>  3 files changed, 130 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
