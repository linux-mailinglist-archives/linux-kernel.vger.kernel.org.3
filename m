Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9F534875
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245270AbiEZB5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbiEZB47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:56:59 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC44BC6F8;
        Wed, 25 May 2022 18:56:57 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f2a4c51c45so660110fac.9;
        Wed, 25 May 2022 18:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JcpVIfrmuD7j2oz/sjN13IeGVl7vyxQiSgTn0EgwppY=;
        b=A/5Ba+UxKzbz0MJcIPArS53ZI815+8fH18ib7RxtGgpPitEE2SCCxasYDXCznHDfhI
         Je/ejhE9uR4Xekk2dHFija4ZLAxCWEVjyeLSPJuixE7he2ZpljrCx4g0C7OJt2VraeE/
         PkNhtw15B48hR4oBmZMgTWGguSbo/1vHMdEmMHztwLQSztv7rS1fwKd8IlnbbcjRV4jT
         w8bYyeUPh9EyjT/BOz2kV9DzGdK6xYiN/gG6HFSOLVhuCLsx5ayEaIPvuMejyMA2O2AA
         W5Qa1c4sdLuCEI+3mpkejvYFm1De+hRbulIVQ2nN8/6bN1HfMgAPC0O6MkWCj6EmWDsB
         1DKA==
X-Gm-Message-State: AOAM530JfLjh1SSYmH/aVFbGy9uaFavXh6P6lnHdOb4OYEdqXky/Iu+z
        JhWEyX6k00y78HI7W+tzbOfJ5jW7iQ==
X-Google-Smtp-Source: ABdhPJwABXwW7ZLL7SGMOnCVFZ0SqXJLeBo/4cYGzeKaFOPbF2WxlA0Z+faXi2mzKv9iY/uT9h4fjA==
X-Received: by 2002:a05:6870:8911:b0:f2:985f:e639 with SMTP id i17-20020a056870891100b000f2985fe639mr20157oao.59.1653530216737;
        Wed, 25 May 2022 18:56:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z11-20020a056871014b00b000e686d13890sm161808oab.42.2022.05.25.18.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:56:56 -0700 (PDT)
Received: (nullmailer pid 2895310 invoked by uid 1000);
        Thu, 26 May 2022 01:56:55 -0000
Date:   Wed, 25 May 2022 20:56:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     David Airlie <airlied@linux.ie>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: Add compatible for Mali Valhall (JM)
Message-ID: <20220526015655.GA2895259-robh@kernel.org>
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
 <20220525145754.25866-2-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525145754.25866-2-alyssa.rosenzweig@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 10:57:46 -0400, Alyssa Rosenzweig wrote:
> 

Reviewed-by: Rob Herring <robh@kernel.org>
