Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC8563213
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiGALAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiGALAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:00:04 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8576949
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:00:03 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 520E78443A;
        Fri,  1 Jul 2022 13:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1656673202;
        bh=M1EhgAyXvbVicOWMZ9YHHs7MmwJjF/gKwPVVxzJfPxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=izMZ2u+dmRghwxZKSE6j0FX8RqJMXSzWIkXqz0GdWBcGX0JjP/vmhhkpu79m4Tz1T
         0NT7UNvMO37lsIHpibwUL1bdYv6VVzyxVIaSU24VH+QsMKOLFmyBSO+s1SZA1sM1kt
         lhdf8Hb7RCatVGPVWDBLVefe+2cg8lDsFWo9y0UvW0+j4z+Q7Jayf1elmt8uJxGeS0
         zkM2EXu3pF+VYgw73xXYzBuGaVIYNLOiWLLcZhVtULeKxT9oq/7fmMNznXRRhpxboy
         9ZqXCksbUSHp07LMsmJNd4ChMrG/q2n13D64+Ew6XcYE1v2DOTde+O1AFIHRP1C7Fi
         /LWC6zILHXQLA==
Message-ID: <66b6ed2f-a2db-e02d-503f-5bc736c4ee57@denx.de>
Date:   Fri, 1 Jul 2022 10:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] drm/bridge: fsl-ldb: Drop DE signal polarity
 inversion
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, sam@ravnborg.org, linux-imx@nxp.com
References: <20220701065634.4027537-1-victor.liu@nxp.com>
 <20220701065634.4027537-4-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220701065634.4027537-4-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 08:56, Liu Ying wrote:
> It's unnecessary to invert input data enable signal polarity
> according to the output one. Let's drop the inversion.
> Since ->atomic_check() does nothing more than the inversion,
> it can be dropped entirely as well.
> 
> Without this patch, 'koe,tx26d202vm0bwa' LVDS panel connected
> with i.MX8MP EVK board does not show any data on screen.

I send exactly the same change yesterday:
[PATCH] drm: bridge: ldb: Drop DE flip from Freescale i.MX8MP LDB bridge

So either can be applied.

Reviewed-by: Marek Vasut <marex@denx.de>
