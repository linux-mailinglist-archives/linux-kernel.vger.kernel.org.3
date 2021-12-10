Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0498470CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbhLJWTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:19:02 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38745 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:19:01 -0500
Received: by mail-ot1-f54.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso11053049ota.5;
        Fri, 10 Dec 2021 14:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIqrSy1sLiBnnkiC9H3jd0iv6yMg9WmbKsGc1t9lov0=;
        b=oMah1NUGlh1BGRobxejWHabTgV5EU/93sh3ARxUNNl2eerm52jTgJsEWtdlXR+kyE9
         9f8IsCP2fpCM+ry8WPd1xsRxanX+iLg66qYnhhYC1n+TAKqi3+VSdfwIke8E+sY9QPB7
         YZ866Rem3pvpdJq2B5qCkJ01feQDxgmcN/iYXmQpDAcX+T3UEDaRQaA2FMKOBKZ7TXTv
         GDXd5hY0smYcO7SI5fCGs2yhIpwOWhEAoRFS/tTFy/6gM39MJeusiBTwLUJS2Hr+nhIT
         SsC9iLr9DWtiFm3OLuG/y/mtAzwwUrUtB8i5olGBbRgIi1EDh9ds7ZTb4RF5LvuMNE+c
         BbLQ==
X-Gm-Message-State: AOAM532CakQ4I/8dIsQkeV4pBhtxJkYdfRizlzkX4vYHLjEdu/Vh89wb
        hwZdDxZwrd5FnZJUA7QMTtC4Ul4wTw==
X-Google-Smtp-Source: ABdhPJwa50Gb4HdlXxt0u9oVuWKl3rU/TtUZEQA7Kms4L0z16q4bAfSFEMZ0JPoU3CWJNk909BeO+w==
X-Received: by 2002:a9d:12a6:: with SMTP id g35mr13277472otg.61.1639174525793;
        Fri, 10 Dec 2021 14:15:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm1089298oiv.49.2021.12.10.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:15:25 -0800 (PST)
Received: (nullmailer pid 2025207 invoked by uid 1000);
        Fri, 10 Dec 2021 22:15:24 -0000
Date:   Fri, 10 Dec 2021 16:15:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, Vincent Shih <vincent.sunplus@gamil.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: rtc: Add Sunplus RTC json-schema
Message-ID: <YbPRfCw/qm0giJaN@robh.at.kernel.org>
References: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
 <1638517579-10316-3-git-send-email-vincent.sunplus@gamil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638517579-10316-3-git-send-email-vincent.sunplus@gamil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 03:46:19PM +0800, Vincent Shih wrote:
> Add Sunplus RTC json-schema
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gamil.com>

typo

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> ---
> Changes in v3:
>  - Addressed the comments from Mr. Rob Herring
> 
>  .../bindings/rtc/sunplus,sp7021-rtc.yaml           | 56 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
