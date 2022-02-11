Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE24B2682
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350344AbiBKMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:52:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbiBKMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:52:33 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0BB49;
        Fri, 11 Feb 2022 04:52:32 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id u3so9355485oiv.12;
        Fri, 11 Feb 2022 04:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReCSt+gc5O4xPxJ6njktSf/55bpAlgC7gK1VsbMWF74=;
        b=RnoV1B9Upp4c03gkHs6Um2o2Sjlo4uRMm3g8YpzsXVq+POVeH6y0589YbP9V7co8P8
         TpEKMtOtNPi2DnQWGUGR3Z45ah6JLQSL614bvBmHSeWZbztD0rJPSwuFiNdMmpW8k80c
         /jlrkrFmQuy21zAuK6dfhzxlRPcbLHyfCCdT3f4aDLiWVcc4qVQeftD0MF5tBVH+jkSO
         qAZeXtuKihlBqfyEQfPmxz6oopxYN/SSmsKpEPZypJygZcGosRKOD2ZAbSsk0ssl8sB+
         QqU5IPKIgdjWXs/0T3hcD5gyr0Jt8LihF0aX7xbZ0YeJNG6JdTy6tCtZ84+3FIAxjjE/
         JXwQ==
X-Gm-Message-State: AOAM533WAyZlDn6K9U1UlhB+pIGlMi6nC79SltO26cvmvFocIdavRf9C
        sECpLXqkRBy/OYb+UU4IGQ==
X-Google-Smtp-Source: ABdhPJyCuITLULUuoALxqJ8sDeLpq/POnnlnAurqRRvfOrB2Qd8ZmUeT8T8kSmeMJ+iLG1tJFalNZQ==
X-Received: by 2002:aca:6509:: with SMTP id m9mr95100oim.76.1644583952214;
        Fri, 11 Feb 2022 04:52:32 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d6:be1d:4768:430e:f56b:6866])
        by smtp.gmail.com with ESMTPSA id o36sm10229317oap.41.2022.02.11.04.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:52:31 -0800 (PST)
Received: (nullmailer pid 203927 invoked by uid 1000);
        Fri, 11 Feb 2022 12:52:29 -0000
Date:   Fri, 11 Feb 2022 06:52:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: nvmem: add fsl,layerscape-sfp binding
Message-ID: <YgZcDd+xwXqTVlAv@robh.at.kernel.org>
References: <20220127163728.3650648-1-michael@walle.cc>
 <20220127163728.3650648-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127163728.3650648-2-michael@walle.cc>
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

On Thu, 27 Jan 2022 17:37:26 +0100, Michael Walle wrote:
> The Security Fuse Processor provides efuses and is responsible for
> reading it at SoC startup and configuring it accordingly.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
