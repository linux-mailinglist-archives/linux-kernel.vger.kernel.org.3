Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740950934F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383056AbiDTXGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383042AbiDTXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:06:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367F1E3EF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:04:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so3306325pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iskMN1l8MoJsVLKb/tR5RqLTdjqV96Epo8o46Hl8L3Q=;
        b=jR4GgNTqrzZbSJz2PEKhD0EzgZW1lPN/LYzCX9SJe2w/eUpq2KAJLv/eBWwX+Il8hN
         w6gdmz4C/bakoJGpyCj3MqKYQsWXweonbOahCr9Vlk+faVot+srOZUjISELuWEnWgK3E
         5w5Tlf+x3k5xwkogDouSMCIyicqhQRfPtER1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iskMN1l8MoJsVLKb/tR5RqLTdjqV96Epo8o46Hl8L3Q=;
        b=KAYVUu8i6H6H5k6KUrah58N3wBXiIglKoral3bPUCdHva9jZem/4qiJLzQl9fKKo6A
         DRgyswK/7F5O6TC50a0VymywrdYnSH41oJn99PGKD468jJESUlYZy8Hq7ch6TWIkRTsB
         cANnPdXRqMyrlEHuHTRQQpisA1NPQNOsx0XlXhPsp0dKXXYl1V5x+IQ0ET4pNIKMFkNa
         LR9trP2tHNzsLQZVelF/s4LDnEKmbUKVe+/DyhwCcc6Ubclxz8B4ZLrwZSdIG9+8k4mj
         poI81QkLSplz6fA6FyBACSwG0xGLLUU1N+zaLw005bscnf1KUeihEplTbS3gG0w50meg
         0mFA==
X-Gm-Message-State: AOAM533WBDLHwit7BYjAtdYJURZDunqxWNaphV7d7XuweC5UNGeg6HKc
        9F+XYKItj2Gw+HjBFjF+3VwWqQ==
X-Google-Smtp-Source: ABdhPJzKaJN8JZfBosvPW28423daqc6l6+bMNX8syAvTCgjSRwsi1KCnvz5G+bgHHL089kLo97RTfw==
X-Received: by 2002:a17:90b:4f48:b0:1d2:d1fa:4dbd with SMTP id pj8-20020a17090b4f4800b001d2d1fa4dbdmr6906367pjb.246.1650495841437;
        Wed, 20 Apr 2022 16:04:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b003810782e0cdsm20993213pga.56.2022.04.20.16.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:04:00 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:04:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
Message-ID: <202204201601.8291F550@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-12-joao@overdrivepizza.com>
 <202204191946.2843CF71@keescook>
 <06435f0b44681588052d145a17d60316@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06435f0b44681588052d145a17d60316@overdrivepizza.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:28:20PM -0700, Joao Moreira wrote:
> > Where/why is the mismatch happening?
> 
> Mismatch happens in dev_attr_show from drivers/base/core.c. There, kobject *
> is cast to device * before the call, probably because attr is also cast to
> device_attribute, which may have a mismatching hook prototype, I guess.

Ah-ha, thanks. I think this will fix it, but I haven't tested it:

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 4954800b9850..d97f496bab9b 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -68,7 +68,7 @@ static int evaluate_odvp(struct int3400_thermal_priv *priv);
 struct odvp_attr {
 	int odvp;
 	struct int3400_thermal_priv *priv;
-	struct kobj_attribute attr;
+	struct device_attribute attr;
 };
 
 static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
@@ -311,7 +311,7 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
-static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
+static ssize_t odvp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct odvp_attr *odvp_attr;


-- 
Kees Cook
