Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2A4A7277
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbiBBOA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBBOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:00:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:00:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z4so40899576lft.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RfWPagEh50UG5AQsw4YG/NPcNcgAiuaDDHKAvh28Pfo=;
        b=gWuBXj+qXx0RfDEcvw60W9ulUvSlUlHE8bFwjkCfpL4a47/GFof5cDKoPsXVQOVdfv
         EoO/yOcOEOxWxZ+MjVdX7iyZPFgVwM02RaYqc2bEldH7dNpAk8Gz7W8FP+iIox80alGi
         ki+u1RmCp17bDsTFYcmQTQih55MQLrYSwxFrcA4IxoD4E9dIIAwpfYriXo1sCRgdWBYN
         Xaaq1tg/2s9jh+qpLM4o79OewjUhdEwvIJoUI42zNqiwAcbE0jU17Q/h7u1dRGdK/dUc
         1zc/YOEkzjGJLcIWNOwDw5RydsIi2qQrrtwGpClnqtKYbpzyMK8KHPOjxihh0nCbMYXH
         ue4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfWPagEh50UG5AQsw4YG/NPcNcgAiuaDDHKAvh28Pfo=;
        b=tMHQF7JK2W8pq/FT9+Li6VU5cWOrGUs3wex5DsD35oVORcvui+FTPQn1s4FUth5G5h
         fDv+yL6chSoE5oa+Pxonsgw5pvzOOqRwi99trtcisuX5p4FB5W5jNDVrczJpr34ELc4R
         kwYsq4+UVyDa7cbGg1koBe8jYqdwIziLFytG23zc8p45ocTXLaiIGwnIV+wbNouILUfx
         Q+Hxj5tqFWN7L2E5oB2+UMjVXDCObzMQXGBP+KGscovp9pRxeJwum6vwi7oftWHwR639
         dJ7enlIlWPmL0HQeSff7O263y2LaKy0DLJ7CECOFPrqXU7ynajuCCgzfyeWT+TPdD1EB
         Znjg==
X-Gm-Message-State: AOAM531NQXADGdkOxGvf3RvAfTU9I2pIZRtuu0Zu5xaBUpayGcSHIeol
        uaFFuhNU/iHMRGfRNnU6Dg9NsjmfOwTJ5VIk17gN8Q==
X-Google-Smtp-Source: ABdhPJyStv54EPifbmyjjo5mPhJzT0KvmzQ4l/aBbOIzs2lV1jYzKtxILnikfpnxSP/qWf4MckalpLs8F3T1He52QnI=
X-Received: by 2002:a05:6512:2342:: with SMTP id p2mr23187896lfu.382.1643810422358;
 Wed, 02 Feb 2022 06:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20220202091134.3565514-1-lucas.demarchi@intel.com>
 <514cdee2-655e-7e52-d6a5-a7176ee603cc@amd.com> <20220202093814.i5z2nmlunrwm2n6c@ldmartin-desk2>
In-Reply-To: <20220202093814.i5z2nmlunrwm2n6c@ldmartin-desk2>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 2 Feb 2022 19:30:10 +0530
Message-ID: <CAO_48GGeZqzAMEBfspWAR5N1RWh0QAdQFSxgyhrPQHiE3ooJsA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf-map: Rename to iosys-map
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, srinivas.kandagatla@linaro.org,
        gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        airlied@linux.ie, lyude@redhat.com, tzimmermann@suse.de,
        linux-media@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lucas,

On Wed, 2 Feb 2022 at 15:08, Lucas De Marchi <lucas.demarchi@intel.com> wro=
te:
>
> On Wed, Feb 02, 2022 at 10:25:28AM +0100, Christian K=C3=B6nig wrote:
> >Am 02.02.22 um 10:11 schrieb Lucas De Marchi:
> >>[SNIP]
> >>diff --git a/MAINTAINERS b/MAINTAINERS
> >>index d03ad8da1f36..112676f11792 100644
> >>--- a/MAINTAINERS
> >>+++ b/MAINTAINERS
> >>@@ -5675,7 +5675,6 @@ T:      git git://anongit.freedesktop.org/drm/drm=
-misc
> >>  F:  Documentation/driver-api/dma-buf.rst
> >>  F:  drivers/dma-buf/
> >>  F:  include/linux/*fence.h
> >
> >Oh, that is not correct to begin with.
>
> right, include/linux/dma-fence*
>
> >
> >>-F:   include/linux/dma-buf*
> >
> >That here should probably be changed to point directly to
> >include/linux/dma-buf.h, but that can come later on.
>
> thanks for catching that. I will change it on next version and add your
> (and any additional) ack.
>
> Lucas De Marchi
>
> >
> >Feel free to add an Acked-by: Christian K=C3=B6nig
> ><christian.koenig@amd.com> to the patch.
> >
> >If nobody objects I'm going to push it drm-misc-next and provide a
> >follow up to cleanup the MAINTAINERS file a bit more.
Thank you for the patch; apologies for not being able to respond
earlier (was out due to covid, just getting back slowly).

With Christian's suggestions, looks good to me as well - feel free to add a=
n
Acked-by: Sumit Semwal <sumit.semwal@linaro.org> to the same.

> >
> >Regards,
> >Christian.
Best,
Sumit.

> >
> >>  F:  include/linux/dma-resv.h
> >>  K:  \bdma_(?:buf|fence|resv)\b
> >>@@ -9976,6 +9975,13 @@ F:     include/linux/iova.h
> >>  F:  include/linux/of_iommu.h
> >>  F:  include/uapi/linux/iommu.h
> >>+IOSYS-MAP HELPERS
> >>+M:   Thomas Zimmermann <tzimmermann@suse.de>
> >>+L:   dri-devel@lists.freedesktop.org
> >>+S:   Maintained
> >>+T:   git git://anongit.freedesktop.org/drm/drm-misc
> >>+F:   include/linux/iosys-map.h
> >>+
> >
