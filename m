Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAC4AA38E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353776AbiBDWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:52:22 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35664 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiBDWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:52:21 -0500
Received: by mail-oi1-f169.google.com with SMTP id m10so10272880oie.2;
        Fri, 04 Feb 2022 14:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkRwT5vTr5trZ7OlFaXIOT1f/2bIjwXJbkGKDps38u8=;
        b=JUfOF0fs2XK6WGmZXYTa70poIvs9neBLH6p+LTPxT553B20eYmemVapUiyPhnzboT9
         /bEAE/DR66g+lvvqI2mlKSegFi2AJxkZ35alGk4ZI0end4xNRZ1GyTNTpe0nZKW9RUPY
         yyAudUXNlWY7TAtYWhCCtH9gQGsfRmCPVKFRwS1/qsnP7+I2gcVUaZ9IyHJ+WFUQ7fLa
         AV4SNkWOkqyrCWairUeM1/cnc4/r6TxUHkyT41JrQ2u98/4VUVuLjbrkVFy8GvkeGfJd
         TEbGO2nBqoSvE0IlDDJ/scFWZ36qoTCGI8FW45tJucoiUCXlXyiKXJq3MK2zNIfng12x
         4ppw==
X-Gm-Message-State: AOAM531MpQ8uyYP/rWclSxuB/No0TitBFHvv+uYuRk8Ult3WLgniADxb
        1eo2+cWgFHQ90RmZXf7AJQ==
X-Google-Smtp-Source: ABdhPJzBO4tpnDTk1J+Zd9wXNTaQ0+sR4QrGfIYxxmEgpmeyJnur5G41kuH9qfXLuUFAe7o0kl2kZg==
X-Received: by 2002:a05:6808:189d:: with SMTP id bi29mr602254oib.323.1644015140912;
        Fri, 04 Feb 2022 14:52:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a4sm568162oaa.42.2022.02.04.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:52:20 -0800 (PST)
Received: (nullmailer pid 3332795 invoked by uid 1000);
        Fri, 04 Feb 2022 22:52:19 -0000
Date:   Fri, 4 Feb 2022 16:52:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lh.kuo@sunplus.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v4 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Message-ID: <Yf2uI12fZcQROKnH@robh.at.kernel.org>
References: <cover.1642127137.git.lhjeff911@gmail.com>
 <3667a4d5f55699c344c6c114a2a5575fb896dd9e.1642127137.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3667a4d5f55699c344c6c114a2a5575fb896dd9e.1642127137.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 10:46:27 +0800, Li-hao Kuo wrote:
> Add bindings for Sunplus SP7021 thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v4:
>  - Modify yaml file remove reg name and change nvmem name
> 
>  .../bindings/thermal/sunplus_thermal.yaml          | 49 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
