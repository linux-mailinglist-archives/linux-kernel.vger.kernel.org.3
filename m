Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4464BAD61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiBQXqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:46:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBQXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:46:00 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75336D7BD;
        Thu, 17 Feb 2022 15:45:06 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id v5so3943268qkj.4;
        Thu, 17 Feb 2022 15:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aX1kOLRLqUi/fD/S8s57gBL+mbXnx1KA4IaN6Y1oZro=;
        b=m3Tob+sehDJD3ZweuIGnRinbzBFkl2+nV+uRhBW4yQ4OGZIbsWDP+4ktnQdNx5bjfW
         hwSMtE7iCyYiZ1wm8fYsSxCDCmhp9RUMz7rkQMWD0HsqFznkfLdwwa1pZnJI7GmBfFLT
         eb/d1AqvRPMaTvl83o07WjyV864zTHUyi3WR6O3ip7N+vSIbfeyjHLdwg6AXFnTQ5ZPd
         wLhP1NLJcrOMMjjSUxDC4P7P2JVKNXHxhj38gYoY5tNcPEadvo159MpIqRltpvMNHE1p
         9q54yoJl6eTZPwgV48eTIZolvJEZAR+CYk0Jx7G9KwbTzNJvV2ULn+hTqNegjFr1AfKT
         aFaA==
X-Gm-Message-State: AOAM5315rRiIMpB02XZJrB9oflqcerPzX3cjuCZLVyl+fDzvuIzHZLG1
        3JoAsqmXqsnb2NGggf4uKffASBMaSw==
X-Google-Smtp-Source: ABdhPJwNBKIbdb8tbNk9wdDVdH7TrVuLhZsRST5q2MMUQdUuOJCTRscINn7gvB8ntANpuN1jIv+aMg==
X-Received: by 2002:a02:5b0a:0:b0:30f:60e4:b9ab with SMTP id g10-20020a025b0a000000b0030f60e4b9abmr3337571jab.189.1645140675081;
        Thu, 17 Feb 2022 15:31:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y6sm2740212ilv.3.2022.02.17.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:31:14 -0800 (PST)
Received: (nullmailer pid 3975113 invoked by uid 1000);
        Thu, 17 Feb 2022 23:31:12 -0000
Date:   Thu, 17 Feb 2022 17:31:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Chad Wagner <wagnerch42@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add osmc prefix
Message-ID: <Yg7awMmMNfU/D8wM@robh.at.kernel.org>
References: <20220211105311.30320-1-christianshewitt@gmail.com>
 <20220211105311.30320-2-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211105311.30320-2-christianshewitt@gmail.com>
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

On Fri, 11 Feb 2022 10:53:09 +0000, Christian Hewitt wrote:
> Open Source Media Centre (Sam Nazarko Trading Ltd.) are a manufacturer
> of Linux Set-Top Box devices.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
