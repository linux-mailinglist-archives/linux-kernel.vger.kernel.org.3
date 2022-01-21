Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63E496811
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiAUXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:05:50 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:39661 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiAUXFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:05:48 -0500
Received: by mail-oi1-f169.google.com with SMTP id e81so15709048oia.6;
        Fri, 21 Jan 2022 15:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RN1PlPeJHCI4F7ORlXAuoTAl+I+ftCy1+niCC1rlCkY=;
        b=csdaDo5srNT3dXFZl2fr8mSORMGTShHWF4ZSNKEd2lMDk2PvcVb/iMmK0w/8KHQiCi
         2sq+plS+QZplYZD6D6aONnUZ41myVmSQj+lvFWuU5vSnvdz3FnwAYPfVgZ1Dah7nkM1u
         B7aBIzj3+q83+vA+n4Pu9k5ZpMs238AK/xDQDPURG9Wf5C5OzICOHTSdW/jAio17r1zm
         UeJzLTwvcPek/EnASlEgtFGE2bpSciN3sSBPwohhJ3osh3Cj6XG7fesi9Y6eoAWJiA5k
         sEWWxIsdk6ih8x3wU8M86FC81nCbH/xrvWkSdq8GXoELkEJeFiB6z6srd1ZN9rykhdVp
         JmPQ==
X-Gm-Message-State: AOAM531FfhaScyTdUEgNfDCXWCkQ5hB2Wjuq4axJkxjwxRIxiY1cmG9V
        qzXft3E69YfxwhoAqglfLA==
X-Google-Smtp-Source: ABdhPJxg+kJTfrdEMoJ2RPhH4/awPHWoZgmR50vnrKMk9V6UVZeKVUfwcfBU0Ncf2zWIBlgjnHORJA==
X-Received: by 2002:a05:6808:158e:: with SMTP id t14mr2315268oiw.31.1642806348159;
        Fri, 21 Jan 2022 15:05:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bo13sm1605874oib.43.2022.01.21.15.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:05:47 -0800 (PST)
Received: (nullmailer pid 1775815 invoked by uid 1000);
        Fri, 21 Jan 2022 23:05:46 -0000
Date:   Fri, 21 Jan 2022 17:05:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        ~okias/devicetree@lists.sr.ht, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: msm/mdp4: convert to yaml format
Message-ID: <Yes8SiV9SBF+S3OH@robh.at.kernel.org>
References: <20220109171814.16103-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109171814.16103-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jan 2022 18:18:13 +0100, David Heidelberg wrote:
> Convert mdp4 binding into yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/display/msm/mdp4.txt  | 114 ----------------
>  .../devicetree/bindings/display/msm/mdp4.yaml | 124 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 114 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/msm/mdp4.txt
>  create mode 100644 Documentation/devicetree/bindings/display/msm/mdp4.yaml
> 

Applied, thanks!
