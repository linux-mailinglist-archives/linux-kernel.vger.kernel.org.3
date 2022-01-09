Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1008488B7B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiAIR7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiAIR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:59:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95FAC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 09:59:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v6so22444898wra.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+7rBCXzd17ZVgtiviUmOjQDT7b/TTvfvus0D8MSi41Q=;
        b=jyORGvlDSBym/qGogERMi5dS0YBWj5RmlkJWcEIQBB+vI4iUkadk0f0K2Gwvrj9ae7
         QZ0XteuuT6XypaP0z0DYf60or7smVrSsuboRXYP8LW7D/5cUaiuJTnfhkVEy2pUAasGF
         vX0EC3sP3qd0glzYL5+BpcJWUmOsvDN7wjMn5T17no9r68FVGRYC3kWEeEbghK/oMFdw
         4MJHsoeqPcSiyR2n5uSN1wMq+um2Dh2POzdQ0FQk3CysbxL7uC5ZQebHoTLSW/E3vM/L
         wdlNSw1pEUou+NEwM6Et886pRxyj7BreKAbZswfMjiUdP/u17ILbYfVHOuCaF3SwoMIz
         cfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+7rBCXzd17ZVgtiviUmOjQDT7b/TTvfvus0D8MSi41Q=;
        b=mqQmnpa/Bp/lyFtyo+OBg+dEx/Eih8VKPrbD/JhsTOMEB6g3Fca2wfdr0rxD08ZNWZ
         5Y1FevXtdqSFyC4lMimvdFuVMKTGZepwjWXH/aGaUh5eQxbZXCwOwnS1wVpAkF3udevZ
         wthZOjViel3kRapNqRribRBoVReEqnPTTFaMgjuWWePuY+AGaPkuNssk1bPoNBANdTrq
         gRryKu22oYWcYdsfaXYnS/+TwWFhRd8dWbF/SGBsoddXMg6aUPM51qme3t6GDeLdZ0ja
         XrmK0tyq/p9cBbwqMxEl9/6qrF0olmE0bHziNpB0qILkk7Q5gGjZj+ySdRrQ9BsML5Sc
         k81g==
X-Gm-Message-State: AOAM532ehqJOiMfsPibo5eq+LunsRFwS+R5DvDeB5PvGLDIdpaVVfUhB
        HcxdNyjIElycoQUa+M3rl08=
X-Google-Smtp-Source: ABdhPJxmlC5Y8dmmx1TuM5H5dp5Ep30gmqIb9P1pEhZ0iV18nQetZ8PObFG+bW9Ugu0jSaWl+0E0TQ==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr31774653wrn.201.1641751182155;
        Sun, 09 Jan 2022 09:59:42 -0800 (PST)
Received: from elementary ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g9sm4932377wmq.22.2022.01.09.09.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 09:59:41 -0800 (PST)
Date:   Sun, 9 Jan 2022 18:59:31 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     melissa.srw@gmail.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/3] drm/vkms: add support for multiple overlay
 planes
Message-ID: <20220109175931.GA11065@elementary>
References: <20220107182809.141003-1-jose.exposito89@gmail.com>
 <20220107182809.141003-2-jose.exposito89@gmail.com>
 <20220109165933.sa6kpgrzdzj5r3ho@mail.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220109165933.sa6kpgrzdzj5r3ho@mail.igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Melissa,

Thanks for reviewing and applying the series :)

Now [1] should apply cleanly on drm-misc-next. Do you want me to resend
it with the appropriate prefix?

On Sun, Jan 09, 2022 at 03:59:55PM -0100, Melissa Wen wrote:
> I checked that several testcases from kms_cursor_crc are failing after
> recent changes in the test. However, this regression is not caused by
> these changes and need futher investigation for fixing.

I didn't include the results for kms_cursor_crc because some of the
tests cause issues on my PC. However, if you want to share the list of
regressions, I'll have a look into the test as well.

Thanks again,
José Expósito

[1] https://lore.kernel.org/all/20211226111219.27616-2-jose.exposito89@gmail.com/
