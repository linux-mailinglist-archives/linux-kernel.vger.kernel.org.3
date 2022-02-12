Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2914B3740
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiBLSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:24:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiBLSYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:24:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2660077
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so9185547wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9OHuOKJbgH8itw9N7Okbk0KMW/V0yB0rDcvgbCzUOV0=;
        b=A7o0J6x2xfgsnZEqjw3jFbuYBBni4Tv+mlsISCbWTKTCGRdMPyC1txf4R148E4SF6h
         /cSII785FMECRtktBQiY7VW2WDOqPI4O1l6QkyE8gDfKOVGsJV7uy0kgZOLmkzb6eu7k
         NdOJBX68lVa5KpKEWGfK9ul/LuwblEI3mEKbUkqyysyt0xVUu1iLTp5b3j7WJ0B08Lv4
         4Hg8hQbfuZsaPFZiy6nW3fUbeTeBPu3D7pEGFlfyDoBmMg1aZD4BUWeWOt3v5YjP2EwF
         18l3LuMpXxpr2OaKU3lMyL1fNw47mI1Fb+wKyeMnuhkaO4s+9vIJTHFDXnMXNV7EcFMN
         mqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=9OHuOKJbgH8itw9N7Okbk0KMW/V0yB0rDcvgbCzUOV0=;
        b=HZuScwwjz4Id2SOLImXNGc0URuiHYi4K8UYtwUXxCDsEYrPz1gulIO7irqk+SoFAns
         5Sdeil8Rd5rixS9ea7zdZfr3ViEXSTdRWKs2hdMVDD0uKA1e+FMkezVZw29/MqicK2SE
         tFx3mkNH/82CDTIShvIvlPFG30prSnAlROfAJRrW+QemO1QyHVzrWn5qkk5YZKi1GmuW
         70L/+PUtBZCWUL8fpdreRugmxP30H0jTgR3Wr8+ONWetWlKV1ej9Hb17Jvd9IqZe0jdE
         k+dnL4PoOrr1ikZLYL76trI1JI34PGWW53Jn9i4mg8Yitb1lVUexlYRue2dcIuc0kSah
         gOiw==
X-Gm-Message-State: AOAM5315SJEQ1Kj0PcTaqMGvoepmH02pMBMpwrX6bsY1U68exRuubqXo
        UVhDJVucJpTa8h7qKLWyvOYBQXxozwvTPA==
X-Google-Smtp-Source: ABdhPJzxmTgOVXXFWsejdulN4FAuR4wJNcyd7X7eM/NZoFOfS9+zOBb6XM7tmDaofyQGvmR+rJEgQA==
X-Received: by 2002:a05:600c:4e16:: with SMTP id b22mr4832663wmq.31.1644690220157;
        Sat, 12 Feb 2022 10:23:40 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id c8sm8619122wmq.34.2022.02.12.10.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:39 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 12 Feb 2022 19:23:38 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Dominique Dumont <dod@debian.org>, 1005005@bugs.debian.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic in
 suspend (v2)") on suspend?
Message-ID: <Ygf7KuWyc0d4HIFu@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex, hi all

In Debian we got a regression report from Dominique Dumont, CC'ed in
https://bugs.debian.org/1005005 that afer an update to 5.15.15 based
kernel, his machine noe longer suspends correctly, after screen going
black as usual it comes back. The Debian bug above contians a trace.

Dominique confirmed that this issue persisted after updating to 5.16.7
furthermore he bisected the issue and found 

	3c196f05666610912645c7c5d9107706003f67c3 is the first bad commit
	commit 3c196f05666610912645c7c5d9107706003f67c3
	Author: Alex Deucher <alexander.deucher@amd.com>
	Date:   Fri Nov 12 11:25:30 2021 -0500

	    drm/amdgpu: always reset the asic in suspend (v2)

	    [ Upstream commit daf8de0874ab5b74b38a38726fdd3d07ef98a7ee ]

	    If the platform suspend happens to fail and the power rail
	    is not turned off, the GPU will be in an unknown state on
	    resume, so reset the asic so that it will be in a known
	    good state on resume even if the platform suspend failed.

	    v2: handle s0ix

	    Acked-by: Luben Tuikov <luben.tuikov@amd.com>
	    Acked-by: Evan Quan <evan.quan@amd.com>
	    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
	    Signed-off-by: Sasha Levin <sashal@kernel.org>

	 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
	 1 file changed, 4 insertions(+), 1 deletion(-)

to be the first bad commit, see https://bugs.debian.org/1005005#34 .

Does this ring any bell? Any idea on the problem?

Regards,
Salvatore
