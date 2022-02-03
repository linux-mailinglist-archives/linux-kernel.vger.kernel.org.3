Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465614A8F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354187AbiBCVGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiBCVGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:06:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE62C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:06:45 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t199so6015126oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rLIfM+XnZ6jdUjbJAUN7qGu3432B0un81GJS7eaWnlI=;
        b=eA0NHkz7c3q8gtxI29i0+MeN3//KbH2XueW5bFR8xOW4M0+IX+6ob3m59CCwqZ2jUF
         zioo2hgbQU1A4dv0HZbu6kYqSWzJ8cMzCE9yAmCcg+RneQemw0QUkHtuNkuVILRvO5Ug
         7KfsMIwSiTmqsu58vY09Oc2RwYOFSWRFFvtG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rLIfM+XnZ6jdUjbJAUN7qGu3432B0un81GJS7eaWnlI=;
        b=qOCNygW4VsUTMFPUjWORCyYK6cTEu5EFO/2u9rQHPCMYorsWZ4csIB9aPpCdHr5dGP
         VEaorUwkhHLoEVfhURZCbi0Jm9HvUH/sotMa1N46xNHjrtDNFyPt3JcFK5QWt4QxPEXW
         x3+L8bnNTssoLFwsO4j4JsVruH4UZY5ozY4iUxqLfTfZuaLq1yX+uVG4NKRnlgWJbunO
         cBY6M6gNhS6525PhR6NQgwL6wbJGJvwfgIU6GF6etp9sTDy25jlhddM3ZHTCa7/RrzQb
         LzpgJZoTifCyJ6alfGEWODXpqKl/8QyeePWr0RkDazcH01HFidntC7YDU0YdZoWbfWen
         nDpg==
X-Gm-Message-State: AOAM531hxFbV4ux7Nv63Msit0F07AFeUO/egWCaaTKU0M0cYx8vFL7BD
        LN/7TwWY0Zp1EaVy4wDYph3tg55nh8vJI9X77ew9+w==
X-Google-Smtp-Source: ABdhPJz9Y9Mi3IXo901kpkyN0YnNUq6zgmnLxMlp5JawWeOl4ZU0ovx9WI8tfAGzYsk8NvHQ99xNDuMhABwMKt/Nus0=
X-Received: by 2002:aca:df82:: with SMTP id w124mr8744227oig.112.1643922403532;
 Thu, 03 Feb 2022 13:06:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:06:43 +0000
MIME-Version: 1.0
In-Reply-To: <0b81d146-05fa-390e-5afc-cb29909cba3e@linaro.org>
References: <1643240768-7869-1-git-send-email-quic_khsieh@quicinc.com> <0b81d146-05fa-390e-5afc-cb29909cba3e@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:06:42 +0000
Message-ID: <CAE-0n538cYD-F_FDib=RN_vdDy71HkY-ybQhMzK_BNoEQtpnmw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: add connector type to enhance debug messages
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-01-31 18:34:47)
> On 27/01/2022 02:46, Kuogee Hsieh wrote:
> > DP driver is a generic driver which supports both eDP and DP.
> > For debugging purpose it is required to have capabilities to
> > differentiate message are generated from eDP or DP.
> > This patch do:
> > 1) add connector type into debug messages within dp_display.c
> > 2) revise debug messages related to DP phy within dp_ctrl.c
> > 3) replace DRM_DEBUG_DP marco with drm_dbg_dp
>
> You list three items here. This patch should be split into respective
> three parts.
>
> >
> > Changes in V2:
> > -- replace DRM_DEBUG_DP marco with drm_dbg_dp
>
> I suppose that Stephen's idea was to pass proper drm_device to this
> function rather than always passing NULL.
>

The idea was to pass 'struct something' and then have a 'dev' named
member inside that's a struct device.

	struct something {
		struct device *dev;
		...
	};

Then the macro will extract the device out of it and use it to print
messages. It may be an abuse of the macro though because initially I
thought it needed to be a drm device but that doesn't seem to be the
case?
