Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB147E68E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbhLWQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349310AbhLWQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:57:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E340C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:57:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so6024320wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x19kNH14ExPsQ28C6SlBYVGa8akiQhXJZ1zBC3AV6iQ=;
        b=M227YuJRwIPX/CPb7Lg+WOaaHsKzAMYXB/Da0yMQGvxGa0saRVV+di4RqWZbiRK50Q
         trtNNAA5U+lBSeLSDkBTYNHzvTkoRut7yqBa7TwaK2JiNuabxmv5BOwtUV4KRi5pR2ah
         +So40Cr4Iob4Tt6iSivBaTYonKePYDmJoO96G2315qHEemCOzvUnpTMv67mZ828dG624
         KlLSAQZAPCK0t6oW5/w0P/ratE8Q/gOGGcfxxVQgmWw9mxWxwPnvkTDBy6VlAIJ/qwC5
         FqwkC9EauN7+/9F2aBN7XWx0UBUkBy4Fy8msCrRtBKZG4HbI823JZ/pJxnGPdlZrGi+r
         XB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x19kNH14ExPsQ28C6SlBYVGa8akiQhXJZ1zBC3AV6iQ=;
        b=UNnrsTfYjrzkHOCfDvFMqj3vJoWV2las/jzyw5GRmP9+31D3hmt619Rste9ALvIBY5
         w3bpr6hmIIoau/2cmqj1ZbeXU4gb/Vj0oWsbCwFvM0kANDcHVYuBG5g6DY+WDM9CLqG5
         rA9BAXEjd6RJ2/NRWq1QUNpqBE3ILaDb0xaXsJXxh8PvmxBz0ksW8ZTIb9aK+E+Ya/Ii
         vmDA5LgUE8lLlp6sO0BE1hHiEem1sB2cxXgwgGONFFq+MOuyvEQBrsqAxsPLGGkKiahH
         u9lXWcxK6VXUYm6zfjLjmqCmmhFqBgvu45/uH9SQsYebsil88e7DJGu+kgNP+YgTmddz
         IxTg==
X-Gm-Message-State: AOAM533rCoPL7Zny1Qr5wBaSBQYqLP/TNCL06hmdqFf4DUhrT/kn4B67
        1q43ADDmS0lxixZXCioVtnY=
X-Google-Smtp-Source: ABdhPJx0hYSOm4vDZR/gdV0QEOZLF2E0+HdDedp9MlR3fSt42MKgNwt3bY/4NeUgqZTjBr+NJEe+5g==
X-Received: by 2002:a1c:1d0d:: with SMTP id d13mr2448580wmd.78.1640278632133;
        Thu, 23 Dec 2021 08:57:12 -0800 (PST)
Received: from elementary ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id u23sm4893233wmc.7.2021.12.23.08.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 08:57:11 -0800 (PST)
Date:   Thu, 23 Dec 2021 17:57:06 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Simon Ser <contact@emersion.fr>, airlied@linux.ie,
        alexandre.torgue@foss.st.com, benjamin.gaignard@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, marex@denx.de,
        linux-imx@nxp.com, intel-gfx@lists.freedesktop.org,
        tzimmermann@suse.de, s.hauer@pengutronix.de,
        rodrigo.vivi@intel.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, yannick.fertre@foss.st.com,
        linux-kernel@vger.kernel.org, philippe.cornu@foss.st.com,
        mcoquelin.stm32@gmail.com, dmitry.baryshkov@linaro.org,
        shawnguo@kernel.org
Subject: Re: [PATCH v2 1/6] =?iso-8859-1?Q?drm=2Fpl?=
 =?iso-8859-1?Q?ane=3A_Make_format=5Fmod=5Fsupported_truly=A0optional?=
Message-ID: <20211223165706.GA11019@elementary>
References: <20211222090552.25972-1-jose.exposito89@gmail.com>
 <20211222090552.25972-2-jose.exposito89@gmail.com>
 <YcRkB7uWyt4EbcZm@intel.com>
 <PIq2EEI7giz2rOuv2cfySbdxwht8AaCye140X5C7NejjXT6kD67E3E28uvg4Ebhob12EJUBtAxGPFNOgZwSWLYEfMtdhRNt3mR8bBGBJmU4=@emersion.fr>
 <YcSPt+81fuzteeCu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcSPt+81fuzteeCu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reviews :) I'll wait a couple of days to see
if somebody else wants to comment and I'll send v3 adding the
reviewed by tags and fixing the compiler warning.

On Thu, Dec 23, 2021 at 05:03:19PM +0200, Ville Syrjälä wrote:
> Another related thing that might be worth checking is whether
> drivers generally do anything to validate the modifiers in
> the addfb2 ioctl. Looks like i915 and amdgpu are the only ones
> to use drm_any_plane_has_format() for that, so all the other
> drivers must either be checking it manually (or they're just
> potentially broken when handed unexpected modifiers by evil
> userspace).

I'm pretty new to this subsystem, so please correct me if I'm 
wrong, but after looking into a couple of drivers I think you
are right, this check is missing in some drivers.

This possible bug reminds me of this ToDo task [1]:

> Many drivers wrap drm_gem_fb_create() only to check for valid formats. For
> atomic drivers we could check for valid formats by calling
> drm_plane_check_pixel_format() against all planes, and pass if any plane
> supports the format. For non-atomic that's not possible since like the format
> list for the primary plane is fake and we'd therefor reject valid formats.

I had a look to the Raspberry Pi driver (mainly because I'm trying
to understand it) and it looks like the check is missing. Other
drivers, for example Mali, are checking the format modifier manually.

I'll try to do some actual testing during Christmas and see
how it goes.

José Expósito

[1] https://www.kernel.org/doc/html/latest/gpu/todo.html#drm-framebuffer-funcs-and-drm-mode-config-funcs-fb-create-cleanup
