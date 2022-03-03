Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDF4CC4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiCCSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiCCSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:12:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F41A3634
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:11:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so3735346wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LUNck2qOGIAZFIO08K9dH5K9dUeU/y3CCAiHWVsNaiU=;
        b=Kpcv05RipLSXMkEJacI2qWUGB8DGkLunNPOKAp6q407QfQqPXVYLHuh3tJVflMHewP
         dw0VCX6cq4WM83I5HFN4btHcgUbdKj7KQDUNZKYwjxyfF2HD55eObICGoJao+rnzWtVd
         ZXhNnp9caIWT09rwqvnyT9j7SZz0zUZt2Hpbf8mjXHUEVYoKQlm2CW9oC685CVG4HedG
         8JCNdi9JPUWR8pwtB294VW2E5MeQ4N2LCElCVvGUrnme7/IHs6uwSEghbydoBp4+74Ek
         x7735I3+orSjIhv48+JSmAWzwG36r8JqpjknG3FDuLbq9QxxBnrIsUlbF5fgog54XVja
         QN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LUNck2qOGIAZFIO08K9dH5K9dUeU/y3CCAiHWVsNaiU=;
        b=r3M7w9o0EdvU3OzdiGXnmjQZmogQtwiVdE1qluyWInN9sg8VAAjelbyZ/PUVSo4JPS
         RGWiqszrbESi9kpSIrmOR7rqByIvn21oH/t0gCO6RbqSPBg8H41ZU5b5oaicmdXmv2/R
         YOnBE80ku+gxW8/AxMJLw5jtPz98yD43Z1yS6eukEHV7LDsKA7VesHHFv3UE4GHrkUQS
         2sNdu5JASPun8pY2BY03bT6st2ECFGRFzX9JnfkFKHLiKbdZ7pbzpiav5MzsyzTFLf4W
         idKohQbkWk1ipDnx9B5Youl6L4i33QkYeBGFqpBLBDUEvN+a7rBzCrCgDrsLDJdQJBRU
         vSug==
X-Gm-Message-State: AOAM5319Pww289WO/N+6AeWjKnzOUWoWcpIWlVWBHdlG0rMDDPtxLZ//
        LhiP0lR7QpK/S3f7PbqtDM8=
X-Google-Smtp-Source: ABdhPJzRO7ZiUQqf2Fl/fQaFy6YVw9cLJ9bwUb90MHgEF3jGLGM6QNbhzaMywKv3HqVgyUo7ltZpKQ==
X-Received: by 2002:a7b:c455:0:b0:380:a646:eb0e with SMTP id l21-20020a7bc455000000b00380a646eb0emr4675939wmi.170.1646331108203;
        Thu, 03 Mar 2022 10:11:48 -0800 (PST)
Received: from elementary ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00380ee4a78fdsm3696436wmq.4.2022.03.03.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 10:11:47 -0800 (PST)
Date:   Thu, 3 Mar 2022 19:11:46 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     tomba@kernel.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, maxime@cerno.tech
Subject: Re: [PATCH] drm/omap: switch to drm_of_find_panel_or_bridge
Message-ID: <20220303181146.GA330174@elementary>
References: <20220220195212.1129437-1-jose.exposito89@gmail.com>
 <YhK0Y3D0O87T5fVW@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhK0Y3D0O87T5fVW@ravnborg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 10:36:35PM +0100, Sam Ravnborg wrote:
> Hi José,
> 
> On Sun, Feb 20, 2022 at 08:52:12PM +0100, José Expósito wrote:
> > Use the "drm_of_find_panel_or_bridge" function instead of a custom
> > version of it to reduce the boilerplate.
> Thanks for looking into this.

Hi Sam,

Thanks for your quick review, and sorry for the error in my patch.
I thought my toolchain was properly configured, but it wasn't and
I missed an include:

  #include <drm/drm_bridge.h>
 +#include <drm/drm_of.h>
  #include <drm/drm_panel.h>

I apologize for the mistake.

> From the documentation of drm_of_find_panel_or_bridge():
>
>  * This function is deprecated and should not be used in new drivers. Use
>  * devm_drm_of_get_bridge() instead.
>
> Are you OK to give this a second try with the above referenced function?
>
> There is a good chance the deprecation happened after you looked into
> this first, sometimes things moves fast in the drm sub-system.
>
>       Sam

I'm getting started in the DRM subsystem, so I might have overlooked
a function, but I think that in this case, since we need to store the
panel in "out->panel" we can not use "devm_drm_of_get_bridge".

"devm_drm_of_get_bridge" returns the bridge and I didn't find a way
to access the panel from it... But as I mentioned, I probably
overlooked the required function or pointer.

Thanks again for your review,
Jose
