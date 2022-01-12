Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97548BC51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbiALBSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:18:15 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38726 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347624AbiALBSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:18:13 -0500
Received: by mail-oi1-f175.google.com with SMTP id g205so1458208oif.5;
        Tue, 11 Jan 2022 17:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVB/LbZ1J1wXE1Ii7isZsxNxi0pCiy7X8EJYggCNLlQ=;
        b=vJ3WcaYZ/hsd01LRyoyvBHvVowP4hYi0zpRGqrCQSPGojD0J35L5sAwlCk5HiqHB1o
         W3zcpYd+UZWqc8axaScY08e52P+VmKsGf04eOlNnLQfkGUL8tdzBK2hxUpphYlH6LiJq
         gnnGLEWpv3VO9Avt3q1SghPCwygNBt+r/JqjG8NTEMfEGnA6edcu5mtv4p96E7CqhEDk
         MIfcsOPFRvY11RZegELOl7v1pbojK/FiEpnPnwH7lWjWb7XFZjXyg3pK19tF8uatf3H9
         FfJiEiqcMRetmd1OBgUv+LIR3MfjWPJw6O0cb9Xbo/AuzWZpoJ9Sr/MHgK8ax7eFE2ib
         MOEQ==
X-Gm-Message-State: AOAM531kiXFsHa4w08zIAsHZ2ieBaQy+Sbj2746ODLm/7gjJBI2eiDyM
        zhvTDyft4nfiWGVZLlGG7A==
X-Google-Smtp-Source: ABdhPJx6mGfS5+9C7D0U2P0swDthn7OrA6qrQoWt0cx5oB5/GfiM3kkjHoeXE3QkHv9gVOBbERy6HQ==
X-Received: by 2002:a05:6808:f13:: with SMTP id m19mr3675906oiw.125.1641950293228;
        Tue, 11 Jan 2022 17:18:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v26sm2278862oos.13.2022.01.11.17.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:18:12 -0800 (PST)
Received: (nullmailer pid 3851632 invoked by uid 1000);
        Wed, 12 Jan 2022 01:18:11 -0000
Date:   Tue, 11 Jan 2022 19:18:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Nishanth Menon <nm@ti.com>, Niklas Cassel <nks@flawful.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: power: avs: qcom,cpr: Convert to DT
 schema
Message-ID: <Yd4sU6xS0A7Suvcv@robh.at.kernel.org>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
 <20220104132618.391799-8-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104132618.391799-8-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 13:30:03 +0000, Yassine Oudjana wrote:
> Convert qcom,cpr.txt to DT schema format.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v1:
>  - Remove allOf from compatible.
> 
>  .../bindings/power/avs/qcom,cpr.txt           | 130 --------------
>  .../bindings/power/avs/qcom,cpr.yaml          | 160 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 161 insertions(+), 131 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
