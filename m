Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8F48267B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 05:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiAAEgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 23:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiAAEgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 23:36:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ADBC061574;
        Fri, 31 Dec 2021 20:36:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r5so25317729pgi.6;
        Fri, 31 Dec 2021 20:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gpKMMQn6Jo2a1SXx5hA6obprwYv9X7YlYc0fVgeLv08=;
        b=BHTMfXiVeeVzAzP5SnJ6Gf8hxQBk4ilUtVTmh5thQ8cV645ec6hgMkKC5mlJWVeRXe
         4B+xsRRBGAf6UhO1uGmpP8aM87+OWCNBXk6zjLz3AClg/Y6bT0aIJjpYV7jCti0DxORE
         agPU8CqCat5E0N/Dm5ys0VjSQQi1Kv2eRfdAR0zzFc1G53otbZkSpKULomBheDY2LS+D
         XPoDDchKHOw8XASGBvMO1UacXwm5XalrABjhEh77YCSl6qHeK+Kn2YsuW04OBMQanRz+
         iIKgZg0//fhezgaQ5Ui0sPkzDGRgLcoUkEG6uFDxZLpAFqkFUdmTRTN6LwbVTXO4xNEx
         cU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gpKMMQn6Jo2a1SXx5hA6obprwYv9X7YlYc0fVgeLv08=;
        b=PPo1botyjbJU2d99VOarS7g+k/e5OLbzhkhAN7I6yinAm+gAS7TXhw79Lpvf2yR587
         EjNplr4JW+Gvlk8GhG1FkBZcoKHdYOJ4TBw1SIWggkoJrIG8jlbjvSSwAQsDBKnRrPdz
         itdEIC5MBj5eGw37uvlFBJPzwBg0CbSSmHMNN4DbM/HgdpDrGgqQ32J+LYuiP6y9/nVs
         m5b2lWRbUpE92Xosq7Me5owSKHK8dtne6JhfpMJ+h1Iie2+QsNf4chXSPYXs0AGA4lK2
         Aec0Pm2RkMt3IcbBILDwkSnEbQuSCwvgA+xgt1RcxWtjkxruncvhneVQHa0q1FQJD3RC
         rkOw==
X-Gm-Message-State: AOAM530pn5X0M55O2x87XsG865CAqmLFiwMwt13krFyHzQ0iga34y8jQ
        QYvzQ/oBtgdI7TOwKFtoQKQ=
X-Google-Smtp-Source: ABdhPJzOtwbgzwkB32sW/Np8tW7hzswI7YRbizP8ASITiU+nY+6MURnTiWA+g2uVeJs2Abgs7zBGXA==
X-Received: by 2002:aa7:91c2:0:b0:4bc:6c97:401 with SMTP id z2-20020aa791c2000000b004bc6c970401mr6988081pfa.17.1641011813728;
        Fri, 31 Dec 2021 20:36:53 -0800 (PST)
Received: from google.com ([2620:15c:202:201:d687:7e27:2823:d142])
        by smtp.gmail.com with ESMTPSA id k18sm34184538pfc.155.2021.12.31.20.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 20:36:53 -0800 (PST)
Date:   Fri, 31 Dec 2021 20:36:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.16-rc7
Message-ID: <Yc/aYq9oWoj3byBe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get 2 small fixups
for spaceball joystick driver and appletouch touchpad driver.

Happy New Year!

Changelog:
---------

Leo L. Schwab (1):
      Input: spaceball - fix parsing of movement data packets

Pavel Skripkin (1):
      Input: appletouch - initialize work before device registration

Diffstat:
--------

 drivers/input/joystick/spaceball.c | 11 +++++++++--
 drivers/input/mouse/appletouch.c   |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

Thanks.


-- 
Dmitry
