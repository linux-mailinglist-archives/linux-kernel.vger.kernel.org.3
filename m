Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2137A4C8C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiCANCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCANCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:02:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C959A4ED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:01:33 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z4so14340400pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=i4OVRGoFkCkNde86gug8c9kHl9wCk8bIw4m5YLIN7XHsdz2jQ7o2wRjMLRdGy3n1Ym
         JnO0O4+hVkm/hktcZ2zfm/1unGF4jrWiy1RLhZqzV+rTA/O1Dw9J8PbHEJddoTmcMl2K
         /W9IQV8PguunKOlg+NiXofDeA8nreHNArqwm+c7OAwK7OtNqfZRSOCp+E+FeaFJqWUAk
         2zPqDjLgsfuRlK7nm63PmwH7HpxHgNFFMQCsifDmGC+NkjIYLOPHO7oRu2Fiad97/SeY
         2el0jSvK52BtZPTTP0BAJKR6NZPys66RMJJqxaj/lE/Ln0GcsaoeLsabyZp/2/Wt0KIL
         m4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=5kIBAAzZEbe290IGYX7+8SBOqoqtdgz53XPaCkzIFoSLgb13LXBkYZRL9QN6bgrTsL
         axPezXwUK8hUHNXpvJxAXsP6eTE3sd7eB7ewLarDgRsUs2J/bDTLrc/WcPqZhyi9jn6v
         43Qujgswcb62LQOQHSnc23MZIU0IrizJ+PTB0vNGjGEqlkNM2jukPD5pxKN6m6Ftm4rV
         8O1Pyuv4KubfUcQhjeeLaciMi+3mYaExDDpn485u2qVDnRnc6+jjaXJp3EvlERuXNiA6
         HW6/iIckK+fwSkkAnw8AATa3iAYKa5t3rg66fVcryCArvz6U4K48+gBJFy1LBK+tlHf+
         vF5w==
X-Gm-Message-State: AOAM531BgWxNJVzSQKdlBCfDd4Jw5sVPsntB0asj+1AUNXqXQJhpgj5g
        VWUkUA6S8dIY08xOwjyVTxtYs/h9aA8Dj3WasX2lgA==
X-Google-Smtp-Source: ABdhPJzEQEfDRhRPdM/rqM32LFVlYTzuM1o3AH3UQR0rfZLv3PeL3HjwR1NNVypuChzG33h12Nv13wZdzGFJaZEpTFw=
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id
 q9-20020a056a00088900b004e0dcc35e06mr27195834pfj.29.1646139693124; Tue, 01
 Mar 2022 05:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20220217024418.3780171-1-xji@analogixsemi.com>
 <CAJMQK-gDHsH=F=d+9W1-jOqKx6kveUtRRSG03W6KDVat=BzZhg@mail.gmail.com> <CAJMQK-j6Nm4xt0oA9332+3AbqZ9YJuAR7EAK2BZnob2EkKLH1A@mail.gmail.com>
In-Reply-To: <CAJMQK-j6Nm4xt0oA9332+3AbqZ9YJuAR7EAK2BZnob2EkKLH1A@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 1 Mar 2022 14:01:22 +0100
Message-ID: <CAG3jFyu_PmcvV7Btz-WQWQMS_GFDZnKgC8BJ+wrmax9CrP6Atg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix release wrong workqueue
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, andrzej.hajda@intel.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com,
        Xin Ji <xji@analogix.corp-partner.google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
