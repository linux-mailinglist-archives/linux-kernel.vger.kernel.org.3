Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9D475C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhLOPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:51:46 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37743 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbhLOPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:51:45 -0500
Received: by mail-ot1-f45.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so25393916otg.4;
        Wed, 15 Dec 2021 07:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EI5/xu3HRuxVvQCrOOs2Jq+uWFaixXp3BC8o15G0Bk=;
        b=EsZ8MIEUFnIqMohjaWam5uipT1YkKnM/00mwVXWKb3pgHdtr/DW5WiH6HSbSJbxUza
         A6oM6YpxIVi/j2SwmJMPO8mspqJ7Q3+bhzE1v3J8krp2ZEHao9VHp04T7jjmGvUV8UvY
         0pTKSG1ru5k2nY0X/15Kwg2XxxP44wW9wHZD66prx4Gbmizv1597y23Rza6dZJm8JyRJ
         BQzj3wpxt8W+SzZU1u9FExxHAnQCB9xt65/sS98mY4mDwzbG8MrlcxVqofR6pzSxQHmY
         pqH9kPn4+zX/hQy0E/mFY0Ty0mr+d66cBYVjowks99Ke7bBZWFndHMnX6j8nexGmH/zu
         gOcQ==
X-Gm-Message-State: AOAM533K3ftOEKmukPncC28z6t/smIQ0gZ9cgJDFt6ed9lQNPdYtWGJ8
        dhwulDqBXiJ6qXSk3mwmR6NmXWUtcg==
X-Google-Smtp-Source: ABdhPJxVJaEDlJRGLfiOsIms0K/FZNzUGKioyX1sHr84EuhIeLEPOlXdcwalaI0EMFncR1W5ppP6gA==
X-Received: by 2002:a9d:d68:: with SMTP id 95mr8970636oti.188.1639583504823;
        Wed, 15 Dec 2021 07:51:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bp11sm412082oib.38.2021.12.15.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:51:44 -0800 (PST)
Received: (nullmailer pid 1379298 invoked by uid 1000);
        Wed, 15 Dec 2021 15:51:43 -0000
Date:   Wed, 15 Dec 2021 09:51:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     wells.lu@sunplus.com, srinivas.kandagatla@linaro.org,
        vincent.shih@sunplus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: nvmem: Add bindings doc for Sunplus
 OCOTP driver
Message-ID: <YboPD4aSi8ZUdZH/@robh.at.kernel.org>
References: <1639568148-22872-1-git-send-email-vincent.sunplus@gmail.com>
 <1639568148-22872-3-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639568148-22872-3-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 19:35:48 +0800, Vincent Shih wrote:
> Add bindings doc for Sunplus OCOTP driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v3
>  - No change. It has been reviewed by Mr. Rob Herring
> 
>  .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 86 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

