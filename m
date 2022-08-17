Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C185059796B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiHQWCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiHQWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:02:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403B98CB2;
        Wed, 17 Aug 2022 15:02:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k9so467436wri.0;
        Wed, 17 Aug 2022 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=+rVwhS/v1efZjV9JaiQiNDDadLmE+6Njk1w34Ca9k3s=;
        b=XC0F6SDky0pcb1VFOdnxjJvPeVSDKqiNxcXX088bL9G9xhMK1RUTYCqAdWvq8uuuUY
         qYkeK9LRsDtuzj5t4FY+QSB+qq8qJ9XUEgRXU8MjsnJwAJo7M31TvvIeDkPDMjLpwyTr
         VLXnUD5T2htBN8gJPoLRHTzm5lVliCxJEKXY+K3E1oKsx/UzO/6kO1oD7DvAk8Rpmx5I
         jrrTHZI0lAo0s/iLg5hs5GnG1hFaWe0mQ59DkZFNQCQ6gYGgS/nj6liT8LGHSNitNQnL
         /6Ueqdr6iYCTreaneR32mEgIh+nLmdXMHoU1Zz2ZG2fCcESArQhPQVhVuYOCH6QGwmi+
         6ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=+rVwhS/v1efZjV9JaiQiNDDadLmE+6Njk1w34Ca9k3s=;
        b=7ccnjW1ExX12VLrAevTuQ/S6JEGhkfyYAsZhRx28dJEhewpsOGeVzc5TtmSYyeszu0
         SsVO83mGtMSY64K6Nv381c8rSAbnqR86HTZ25NRUUsiVVrJ/r9ZrVH3aOo58bDe5GQTW
         eE8YxWcOGeVnVPIdLEkK0jD2BGVcQIZilUXctHDVRPHbq3yYvjFVz0cNbmRNbBp+Slmc
         XyI+P4qJnOgZbkv/rfVMdkVbnQvqW7MsUHjkwzUBbqsIetSP2KzYXGSvItuWJcYehzdz
         5f2aSMMcPxMawXfmtLpBYvm5muiUy/SrlJY4VlLtaO1/X076M1oDy1OOcQDbus+YGSZH
         jKSA==
X-Gm-Message-State: ACgBeo0VMtEsf9CobZckxduZLsIab4L7AQgpzfpC5PJ0V8prwTDDAADa
        sgph3stN7hTQ+blhK1PnxYMIn52HHKkrNNq3
X-Google-Smtp-Source: AA6agR5cCdcYKHWI60JmXEIFfCQFOyocwmx57gVltGNwUl1UoanmElTicNY+iUpwS8YjycA/T/nesA==
X-Received: by 2002:a5d:4752:0:b0:225:1fb1:862f with SMTP id o18-20020a5d4752000000b002251fb1862fmr40442wrs.458.1660773757262;
        Wed, 17 Aug 2022 15:02:37 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a540fef440sm3666767wme.1.2022.08.17.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 15:02:36 -0700 (PDT)
Date:   Wed, 17 Aug 2022 23:02:34 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220817 for amdgpu
Message-ID: <Yv1lepjhg/6QKyQl@debian>
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

Not sure if it has been reported, build of next-20220817 fails with the
error:

ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

Trying to do a git bisect to find out the offending commit.

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
