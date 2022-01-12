Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31A48BCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347988AbiALBsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:48:35 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40488 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347980AbiALBse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:48:34 -0500
Received: by mail-ot1-f43.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso892714otl.7;
        Tue, 11 Jan 2022 17:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cUty9fNQLUFbhjCDCZUxiV3yvWgMbjHkj6auv9/shMY=;
        b=ZQFR14upWmhJG/Lbcj4B2aaDeYax9KrH5R5GVtyvqp1RNualZReQOS32sMVTbfYVlr
         4SjuwyBnciMXcIcIs7i8rQafT9TCcbm1vtSEMHuSbAs7H1yarVvJT3w6HtmKpi/jYAnq
         N4biL+J6CUs9z4myJRhmFEuA/PEycwVELIufhcpiHJaRNDpJ+Fu0ZUphpqz/mnP9yN8R
         BO9TN+Lv1g3YPAs1FEIiSJkAWRGhodFTXLc6BF/o72ZuzeGifPXqWiL8YhHsuCebOSlA
         waneg1s3kPPGjoMMzjOWlRbXORXGU/MvcNeFFENiBlVSNZ5GkfL41qN3SvSTls9q4sPS
         pagQ==
X-Gm-Message-State: AOAM532adf8/vgmT6sBWJYDnGB77fPXWpICBw9NSYD8+gpC36/sk6nXt
        FDWrpRJ/55B/btcD0i2DnQ==
X-Google-Smtp-Source: ABdhPJyNoHwHxRvMowkk4XMvIcs0XWUlxsNKgpFHMaWJ8SnTQmMcxFP7hQVT00CDE3e213sqaNJXLA==
X-Received: by 2002:a05:6830:3489:: with SMTP id c9mr5451305otu.206.1641952113557;
        Tue, 11 Jan 2022 17:48:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q189sm1375079oib.8.2022.01.11.17.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:48:33 -0800 (PST)
Received: (nullmailer pid 3895404 invoked by uid 1000);
        Wed, 12 Jan 2022 01:48:31 -0000
Date:   Tue, 11 Jan 2022 19:48:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: panel:
 feiyang,fy07024di26a30d: make reset gpio optional
Message-ID: <Yd4zb/psD6vzwIli@robh.at.kernel.org>
References: <20220107051335.3812535-1-pgwipeout@gmail.com>
 <20220107051335.3812535-2-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107051335.3812535-2-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 00:13:32 -0500, Peter Geis wrote:
> Some implementations do not use the reset signal, instead tying it to dvdd.
> Make the reset gpio optional to permit this.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../bindings/display/panel/feiyang,fy07024di26a30d.yaml          | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
