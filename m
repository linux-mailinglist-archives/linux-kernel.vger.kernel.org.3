Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284495B2977
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIHWkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:40:14 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A782D2D;
        Thu,  8 Sep 2022 15:40:12 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127dca21a7dso21028707fac.12;
        Thu, 08 Sep 2022 15:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q/93ntx0X7AK2yC4ktW4fNpwToT6s2GUldlVNQU7dGE=;
        b=XyJOfzNhOs6RVo5qnWAlaUiXXzm4tg6pN/WAGGe+7fJV1oar/NjA9VlE5D5iow4TEA
         qy2Opsflwok5bGixiSa17GTIWG2hPRsTvkSuf2FIkFqFHF6DVyHcP5svX5CKpwxgA0YK
         noeL67Xh+P1El5lvS1NIeLmm2K0bX6RTdG1k0dtLp2qIbULAgeopXrt9CpE/NBuG8OKu
         v7r2uwItvB49WgMSyxSE5GdBz4eWwaK3GT48DjXrP1lIJ01ilqxVT4HRyHQMU9oB9ZXG
         Kt3fOqWI02t/q7D4IaUDaq2vX0ZDk0Zy8TcycBAKfYXOgNc0QjDvcMgWphW7Abuwhgl5
         2iOQ==
X-Gm-Message-State: ACgBeo0/azQWKJdU6UlA8+7suEXUq/QXxqIC3HrQ2SIlWoZEnHPc+y65
        9e4ke04e9PA0HTaRRwZqKg==
X-Google-Smtp-Source: AA6agR6Nx8mduApFnaQ6tdsjWr/59CX5qJEV3IsS9vGsz7CiJCX+tAzHbZs2RmAjjVZjE35Uhz3UWQ==
X-Received: by 2002:a05:6870:d391:b0:11d:ca1b:dc49 with SMTP id k17-20020a056870d39100b0011dca1bdc49mr3072922oag.125.1662676811554;
        Thu, 08 Sep 2022 15:40:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e37-20020a9d2aa8000000b00638cea5947esm172643otb.25.2022.09.08.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:40:11 -0700 (PDT)
Received: (nullmailer pid 3472381 invoked by uid 1000);
        Thu, 08 Sep 2022 22:40:10 -0000
Date:   Thu, 8 Sep 2022 17:40:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     linux-hwmon@vger.kernel.org, rtanwar@maxlinear.com,
        andriy.shevchenko@intel.com, robh+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, jonnyc@amazon.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux@roeck-us.net, hhhawa@amazon.com
Subject: Re: [PATCH v4 08/21] dt-bindings: hwmon: (mr75203) add description
 for Moortec's PVT controller
Message-ID: <20220908224010.GA3472324-robh@kernel.org>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-9-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-9-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Sep 2022 08:33:43 +0000, Eliav Farber wrote:
> This changes adds a detailed description for the mr75203 controller and
> for some of the analog IPs controlled by it.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - New patch to add description.
> 
>  .../bindings/hwmon/moortec,mr75203.yaml       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
