Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D194818DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhL3DLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3DLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:11:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FECC061574;
        Wed, 29 Dec 2021 19:11:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so21880449pjb.5;
        Wed, 29 Dec 2021 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=7Nem74KuuHseAPVfu0c2z21Jh9upLuJ739RMkcYrDuI=;
        b=m1hlT5NXkg7Q8ztFBHfeXU+BIUXPLiEbuQSEpD+tQKsyAQVw+hONr8MBie7VxG7NTw
         sliMIIank2mko3YrM3o6xy1JjX4x3c8wtHO/UK7FYVwsXMs48N4pvQorj4dHKdMNcLX7
         x+NtUr5b5+fQfeGV54CigUj0QXIwmjAIMmERox858v9L+TSLPfhQ1ikWQUsnEVHS1b2q
         XbX2CvUVYLMLxOv8HXO+LOAXraPBQNM7uWqc4AZewDSsvlZGlGJbClme1nz0VVRAtccp
         WWxE8YVrBAnSLm5hUUnceIDP4Jo43Xr6ZW6kT+UKiXmBo9tFrxcyILYcPUClz893GZmd
         B8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=7Nem74KuuHseAPVfu0c2z21Jh9upLuJ739RMkcYrDuI=;
        b=KfPK3BXD2hhiXl51KO8ayVfMXnPWxg9Q8tPaL5uFapVrCfMuffiZfesr3JM7BgNppw
         80iKscPQ+FnOPsm0LgR4wY0P7VY5pRBW2YWRn8kxt57Pqnw6JsZ9KJgvKSPxJb8vAysE
         n1vO2wlZt0bjJJqBwJAAuXho2WnK45lrK5wPwMWgWA3k/mtgmh4nCCnAj8yLtnekE390
         O6Lk6ev0hxrVSnA4ECu0ZDU2ellfdYVuWMuGffCpYhtO0jK3IKRhfHRk7tRwTRCHKVK8
         g4KbZonG4tidX+kiMQ57sGXQZkxGSDlKPgc+j6cnNK1qHkP5VAIVZiP6R1vT+lRrF0VH
         dIWQ==
X-Gm-Message-State: AOAM531JeS0ctrAHO/gq/J5GVlrNWkUSLRFZ6kQcO4jIqTabUWckeVz6
        yENWmuHxSsRSIAJE8ymOd3XX8lvi1HZ8jghq
X-Google-Smtp-Source: ABdhPJy7nO/NEQDTzk7fINXBvC7u0Bl4YumSta1Nsck7xoPQgGu87mRm4OevzDtWH7jmTe+apLttkg==
X-Received: by 2002:a17:902:a404:b0:148:b897:c658 with SMTP id p4-20020a170902a40400b00148b897c658mr29322287plq.71.1640833896223;
        Wed, 29 Dec 2021 19:11:36 -0800 (PST)
Received: from [30.135.82.251] ([23.98.35.75])
        by smtp.gmail.com with ESMTPSA id b21sm23720026pfv.74.2021.12.29.19.11.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 19:11:35 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.56.21121100
Date:   Thu, 30 Dec 2021 11:11:33 +0800
Subject: Missing closing files in linux/scripts/kconfig/confdata.c
From:   Ryan Cai <ycaibb@gmail.com>
To:     <masahiroy@kernel.org>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <1B559478-D266-4D77-B9D5-F6F21D9EFB83@gmail.com>
Thread-Topic: Missing closing files in linux/scripts/kconfig/confdata.c
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel maintainers,

          1. In linux/scripts/kconfig/confdata.c (conf_write_autoconf_cmd), the file opened at Line 946 may not closed when going to Line 981.
          Location: https://github.com/torvalds/linux/blob/e851dfae4371d3c751f1e18e8eb5eba993de1467/scripts/kconfig/confdata.c#L964-L981
         
         2. In linux/scripts/kconfig/confdata.c (__conf_write_autoconf), the file opened at Line1081 may not closed when going to Line 1095,
           Location: https://github.com/torvalds/linux/blob/e851dfae4371d3c751f1e18e8eb5eba993de1467/scripts/kconfig/confdata.c#L1081-L1095

           I think, the fix is inserting fclose before the returning. Should it be a bug? I can send a patch for these.


Best,
Ryan


