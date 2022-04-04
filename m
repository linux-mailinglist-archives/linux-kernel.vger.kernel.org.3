Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05574F11EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353814AbiDDJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiDDJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:28:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCCE3BA56
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:26:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s21so198233pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LQIPC102LBY8jsfQ5+qALRGAiWnT6kIWTeL9/Fu7QJM=;
        b=DGlTsrmu7goQJGUavSpKmdPrHp4B3llVMMT9zPOcTCKW48MU5eANIbfNI6xaq+bBI1
         ZSA9YgagXDwZ3x/XpDDJOhM1Sv1c2U3f7Wml/5OB1BISYzYoQJaz8eVID13M4hORLISy
         M7xV6Q1ofulxLqcdzyY5FcVIW/Qf0jGRxRhnCzCzVJmA1wwd386MDsf1JsAVfZ+5Ucvs
         mgRPt4lGK4NH0/1JeDUEggRZ7v8Bm3pTMQuIEB9MXPGVPQ+SabeecNq6/OlQJisxJwPs
         cQeW8kKo2xzKRubHX4lO6ZU8GYY0QNamW1KyyLJndgs9s4ENkybMhM6RfW3GOqYDmso0
         YFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LQIPC102LBY8jsfQ5+qALRGAiWnT6kIWTeL9/Fu7QJM=;
        b=QdG4RnLNXV57CC16+BUPSFLXhI3ii5U5lVvfF1gYLKWHR/9NiLFuRd00vsP0hHHNPa
         i4XpfgKSG4vSIcJNAX3KfccGqhncGQzTIEMo8gw1WQ8kVpxW2gjkE5ZQzN9Sgre1Nezm
         NBnsfymwIIKhXfFuSkqtyPnTCbjmu8sk5fxBKRjFqVgndlTJlU4kuOfqUmpOAxoWW1an
         btnjoeaQkIu4oWp3Y9Q1k5jMXHmlo85SuA/qByKE9gdfKJO9r9aWDR+5ErrngSE14Rbe
         22nCdYtEmFV+xcOgpSMJ8vAZJ8NABYE09uXaiCPifFG3OeE+VQMgzknZDfKdimWOy5HE
         bPYQ==
X-Gm-Message-State: AOAM531gxWF+LPFHdvMqDNvCeDSNYPe5WTIOznxkXuqMEAnFKgg8u4Eh
        Y8JM0M9o4oG8vbPWPs1i09ojjPpsfTQT1iEHoBzl1Q==
X-Google-Smtp-Source: ABdhPJw6OzrP/tqzilx2s0kEtrxnMuJo9dLpMBCZ0dCkwT/JEhpzNRmDgzrjJwTn1Q6SB9b0/nSi9vG/C105lJ9DU7Q=
X-Received: by 2002:a63:5747:0:b0:381:54b9:b083 with SMTP id
 h7-20020a635747000000b0038154b9b083mr24763452pgm.178.1649064417542; Mon, 04
 Apr 2022 02:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220401015828.2959505-1-victor.liu@nxp.com> <CAMty3ZC6pLJXP=kxwFeZj6CF87ASvoxz9+8Z-7O+DCNwtcLHcQ@mail.gmail.com>
In-Reply-To: <CAMty3ZC6pLJXP=kxwFeZj6CF87ASvoxz9+8Z-7O+DCNwtcLHcQ@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 4 Apr 2022 11:26:46 +0200
Message-ID: <CAG3jFys1O2ZT8_kf_VPQ7kCQAED13qNCfe8oqjgF9EsC4LX43g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Drop the drm_of_panel_bridge_remove()
 function call
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 at 16:52, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Apr 1, 2022 at 7:26 AM Liu Ying <victor.liu@nxp.com> wrote:
> >
> > Since this driver has been changed to use the resource managed
> > devm_drm_of_get_bridge() to get bridge from ->attach(), it's
> > unnecessary to call drm_of_panel_bridge_remove() to remove the
> > bridge from ->detach().  So, let's drop the drm_of_panel_bridge_remove(=
)
> > function call.  As nwl_dsi_bridge_detach() only calls
> > drm_of_panel_bridge_remove(), it can also be dropped.
> >
> > Cc: Robert Foss <robert.foss@linaro.org>
> > Cc: Guido G=C3=BCnther <agx@sigxcpu.org>
> > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

Applied to drm-misc-next.
