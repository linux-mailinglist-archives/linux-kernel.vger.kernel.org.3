Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718C5A5F20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiH3JTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiH3JSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:18:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29AAD5701;
        Tue, 30 Aug 2022 02:18:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso4159288wmq.1;
        Tue, 30 Aug 2022 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=AGaSWYBJDgKfuNXBk/rMpd9HzYqxQJNCfvux8aOnciU=;
        b=OkWDZIa6FOObDPg4K064OvXgsu/npv0Y459BFnvrGpjZtayryIOXm//bV7VtE+O6Ku
         Z6wd2miesiJN/ppW2YMSP9cBRqmBKexlGpHQAjEv+y2Eu6lkXXKdYMdSo3EKWztpsW5n
         LDeMJBGtmITWQY6Ini2sc9A4VU7633IBYInTPbSFNVnazdFOhBgmWg49tISF8q2xXT3L
         zZhoSBvCa4634fkQJ++bWj41wbFXDwaxLDCo1mbSHQSoFPQTMB9SDOth0gHv/HUV/AWQ
         VsZZGRgDrYBEB/ip4uuvUBsJkrOnk9bvsp/Dtd8p6BMdIvup4DP62ymW9/8+WGIDGIxX
         zRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=AGaSWYBJDgKfuNXBk/rMpd9HzYqxQJNCfvux8aOnciU=;
        b=truJ8s3yLhtpS5qCWbrtXoEDl1SQ/kw7Lj8gQ8lquEl1chVEm1VUYv5U/tvIt1C94l
         q6njMxU8Pb09dEJoQy02U2FmkUbZ4Jvdmyc5+GlQ7osfORvzk4Sjv4iigPRS7sM1poZY
         oWTTE7bas8KYniKQnYtZ+GVERbIIsIyFdnYIuGDYBpPtgA24ymd3m0hrcPxWh0zfFNPX
         awdqN+g1i0WOSwiiZAjlsi0JqF29DyLHEd3nUsYEk4CXzOG2t4n5jlyOr209a/8w5I2o
         QmonfXta3ibp++Gx1x2QVk2JxbxHh0W7yy4p0i3lkA0x682wAiYr6fPtLP/tzEQsqG+d
         IVAg==
X-Gm-Message-State: ACgBeo3aK1Jnv139HH+CV/YfL5Nu4Uvq4ZPFePl3xiOsvrb5MYV6lGzb
        /p1FQdLg4AiWQFDgNVsNqHs=
X-Google-Smtp-Source: AA6agR5QPnPnzmdDQ8z8WSYvFsJyyoFZG9CQ43BYjg2K03qhgWNqHPOigcjYhoX/TqbT6IEa4NyRmQ==
X-Received: by 2002:a05:600c:1f05:b0:3a5:c789:1d9c with SMTP id bd5-20020a05600c1f0500b003a5c7891d9cmr9138971wmb.26.1661851125988;
        Tue, 30 Aug 2022 02:18:45 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d548f000000b0020e6ce4dabdsm9040737wrv.103.2022.08.30.02.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:18:45 -0700 (PDT)
Date:   Tue, 30 Aug 2022 10:18:43 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: build failure of next-20220830 due to 5f8cdece42ff ("drm/msm/dsi:
 switch to DRM_PANEL_BRIDGE")
Message-ID: <Yw3V8yJgAnPD8o6P@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of arm64 allmodconfig with clang have failed to build
next-20220830 with the error:

drivers/gpu/drm/msm/dsi/dsi_host.c:1903:14: error: variable 'device_node' is uninitialized when used here [-Werror,-Wuninitialized]
        of_node_put(device_node);
                    ^~~~~~~~~~~
drivers/gpu/drm/msm/dsi/dsi_host.c:1870:44: note: initialize the variable 'device_node' to silence this warning
        struct device_node *endpoint, *device_node;
                                                  ^
                                                   = NULL

git bisect pointed to 5f8cdece42ff ("drm/msm/dsi: switch to DRM_PANEL_BRIDGE")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
