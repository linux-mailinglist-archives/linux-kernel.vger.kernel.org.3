Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8B48E1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiANAp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:45:56 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiANApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:45:55 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhCq4-1mdniy0CUU-00eLMS; Fri, 14 Jan 2022 01:45:54 +0100
Received: by mail-wm1-f44.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso5808385wmj.0;
        Thu, 13 Jan 2022 16:45:53 -0800 (PST)
X-Gm-Message-State: AOAM530IseZt5Cd1ojFne4E5sd3mKnagXNvf0T7o892i5AZ0w/nXKVHp
        U/8z0swTeoPudeNshluO69zLnG7JNaGgA/8vQCs=
X-Google-Smtp-Source: ABdhPJwV4G3A5mpFnAW11HwlY/Tf7y1xRC36rwdQkkqDkkOWfKAxxiuv8Puk8O7tRRiiu1Ah39q+R3OAJUeOa6nnmfM=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr6081734wmk.98.1642121153661;
 Thu, 13 Jan 2022 16:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20220113171921.17466-1-philippe.cornu@foss.st.com> <20220113171921.17466-2-philippe.cornu@foss.st.com>
In-Reply-To: <20220113171921.17466-2-philippe.cornu@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Jan 2022 01:45:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Nn3fwEMtb9f0DZhbyY+mLva5XR332XfXqX=WSmB9a8w@mail.gmail.com>
Message-ID: <CAK8P3a0Nn3fwEMtb9f0DZhbyY+mLva5XR332XfXqX=WSmB9a8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update Benjamin Gaignard maintainer status
To:     Philippe Cornu <philippe.cornu@foss.st.com>
Cc:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        SoC Team <soc@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:214a73NjFh8gp4Qg1UmUh7s6YWPisKC8VfpqQQIsyvQo2AMqWLk
 W/actafV9S3p75x8tZatcLm14aHoiMZhR8FQlwUD0Rhlpyd1kv941DI6jlQIKkJRCrp+d1q
 QQ5QEO+M/S6XXtDG9R6CLA9SxKLVqRlMBTwFtKDe2aEBwCF69EP1XzptR354JSr7W7XQzKE
 hNOesE61wS96qOWn4zJnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AhqHA3kxghE=:tAvJ+cxH3TRypMG55ZoCYd
 k1ow0WoWlgKdWm5oSimoYfDnHNrYdgK7G02EnKrdcnDvioHFwFpkjfReYrAnJDS4BIhKWijuD
 WTPGHNZY/OeZH0zfXQadcZ30HtcYdTXKojw/SYtawbbrOwu9herpAEWLMRpIPwDVDsUCIK5Y9
 g9B6NXd/Np1fQWTEQoLhnicjuc3WdbSNC1MLd3hmF7TddO3YKi/W4TiUJaYK03PDab4N0zdJ6
 PjxNVtEzw85tgYiXTcfmD+yZU1tkaVWYYXnArRlqKLUNQhDmFvinKMui/4W0Yn+Nei5BnbEGY
 Y8bXEzvsfCj35FgEaKfuYaL74dsS3jVUYbmrnnGxI1z+FNAWWqE/l017bAT7BhyOO+JdkfEDp
 zU4uBw/meBUaGXIldeSeLNHUoIPjdJwLVUju1hpAPddrxIWuWGBk5/spN9ISua4Dr4GC7xGk7
 bq5cvCirqHytAIIsostIHvH24F8eOmT7EzrrAb8ToNMyP8IWl2vE1ZuuU3tdTGby6y2t+uTK5
 JB07uXKIRkxq4HxpHkstsQyfuAW6d8qhIQuVqkrArzz8T3cQZcelI6CQREg/Y/EkKPue8epdu
 aGdsqkIWQbZiBnl0IbyU+xNYefJKVZneIl/HNiWaqDSljuzECYa1pDwUK3nFg1dLoNO8l2YDQ
 lWeCdMw2RowWM5/Jgs95iMw3EAUtDIgIMlNwQBQ8LCQTSouZfnvLcCaBkzr9st76a70Glqvxr
 rLNnr7uL9osHrFkATxNKv+HkuOC1bf09dJYeDsmFC/7/1eiEzBiLewx5I37UH+QMEAWXOxtuP
 nM9pnz3+3RXmVOdGYJWBE99aqeJMe+8iEQW0y/CbDGc7ro9Crw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:19 PM Philippe Cornu
<philippe.cornu@foss.st.com> wrote:
>
>  DRM DRIVERS FOR STI
> -M:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
>  L:     dri-devel@lists.freedesktop.org
>  S:     Maintained
>  T:     git git://anongit.freedesktop.org/drm/drm-misc

If there is no longer a maintainer, I suppose it should also be marked as

S: Orphaned

         Arnd
