Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6C476AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhLPG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLPG61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:58:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097AC061574;
        Wed, 15 Dec 2021 22:58:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s1so8159473wrg.1;
        Wed, 15 Dec 2021 22:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XpWcs0XbMlH4VQ6hw7+xSPVWX4q7iEBGmSQA5LzJK08=;
        b=KpLR7KdZfjR1YsZpZau7nel5Iov1BHZulmr50C0qi8+Nbz1/3tGosxKZWpnCjfDjJP
         cHrU29k1qR4/+2sv8mtbR0yh7GguxoRObfc8GfFRIdt0tlFlCe/H43MIO/9llMIQZR4a
         P/7cJFbA3QbWtEOfz9gQfoOROKeDZGs6cR/gCW5eRWCHkf6uMHyOQ754hi3SulDtn0zn
         8WHRgIar51da3O5T/pAZHFfYoMPu87tPxSTDnnDnLFAv3jliGB1etnUgN+1F5dLPv/hO
         WwgV/y7yAU7Pg2q3sziYrKd0g9/nbDkI+l3iRfHsoiSFVeShEEFi20gzh+PgEpx3pDye
         UEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XpWcs0XbMlH4VQ6hw7+xSPVWX4q7iEBGmSQA5LzJK08=;
        b=0yHh2de453oS7b7vGO7dw53D90lQbnh+cqOirG34Bonh7J/swwubBzGfesVl2CqZZJ
         mB3SFI9bHJg0BqBoRvTE5gcBMGJww98h6PLOU/UdI/91TgP/+eTNWQA7X9mWgtOnmXMb
         4ieFecATqJ2RwuV69UGk1vZETxeitwZl8d/NuLGtZku9+OUVyWCIVbqkSUVAAoKict1k
         bXrE+mvvoohcqG5Eu0tcUf9QBB56ok66Hg3ETdRW/l9zeZK9Zj/efzA5WMh0kRyvv0aN
         7Z9RH51od6wLxj25J0LaLqYW1lieSztYlugX36sZtMqZnt5sqd64knnxSNxJEo4WXDp7
         5ILg==
X-Gm-Message-State: AOAM532u1R2VoT5WlVBD+31W7/EX5zCb4Yn87obv17WlXsVAaD8pYSLi
        sE2X/DPgPKdxjzd1WdGiHKa8yS7zU6g=
X-Google-Smtp-Source: ABdhPJxp3ZXrPoJwzqsVZMOfkSKa2WxiAB5H8OKvSTfGLSvtRhguEnwUBykdSnxasAlAEmi4KJ+XCA==
X-Received: by 2002:adf:97c2:: with SMTP id t2mr7512331wrb.577.1639637905795;
        Wed, 15 Dec 2021 22:58:25 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:267b:1200:18af:bb55:aabf:94a8])
        by smtp.gmail.com with ESMTPSA id p12sm4718037wrr.10.2021.12.15.22.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 22:58:25 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <Konrad.wilk@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove typo from XEN PVUSB DRIVER section
Date:   Thu, 16 Dec 2021 07:55:47 +0100
Message-Id: <20211216065547.18619-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a92548f90fa6 ("xen: add Xen pvUSB maintainer") adds the new XEN
PVUSB DRIVER section, but one file entry contains an obvious typo.

Fortunately, ./scripts/get_maintainer.pl --self-test=patterns warns:

  warning: no file matches    F:    divers/usb/host/xen*

Remove this obvious typo.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies on next-20211215

Juergen, please ack.

Greg, please pick this minor clean-up on top of the commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97215d89df4e..a5df6e1219b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21007,7 +21007,7 @@ M:	Juergen Gross <jgross@suse.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	linux-usb@vger.kernel.org
 S:	Supported
-F:	divers/usb/host/xen*
+F:	drivers/usb/host/xen*
 F:	include/xen/interface/io/usbif.h
 
 XEN SOUND FRONTEND DRIVER
-- 
2.17.1

