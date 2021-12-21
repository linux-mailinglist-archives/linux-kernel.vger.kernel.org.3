Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5647C2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbhLUPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhLUPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:23:20 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F50DC061574;
        Tue, 21 Dec 2021 07:23:20 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso17115854otf.0;
        Tue, 21 Dec 2021 07:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1i6caAzqA+gvrfiTEd1QuqpmIPOfQlX1D5IVEqe+W3k=;
        b=EUBO1lv+2YSXzIUoQfX5QZ4Yg5lMJQaOFNl/6SUs+gzgRJrQ+/RRx0Sx3GBgFxDn32
         gTJf7r2FPH8uVEvUfYSRrhMe1KgTxSvGVq/nqKnO+1hoaCusTHIFMyc0mf61V4jRLBgo
         XcoDk+1uOqROa4gokF+H70vr/VXrZkvntMXIiDhJSC4+kgN+0gF+9k2pZsh8ZmXhTOor
         QJ+EXz28B7OC6IEzmCyG3MNtS4hG2XO97kN6SsPRvMgsrYC6rcIriTfRBQQkvN0KreI9
         pz33uf6e2/lGzqZwO++VkXze/33RdsktJH84ckbUBiiNAA2tHvSUoZxCBBGQ+RRFhvs+
         7RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1i6caAzqA+gvrfiTEd1QuqpmIPOfQlX1D5IVEqe+W3k=;
        b=YxWAwQ+Hi9dvicWyuK+4+QFhe1Ww8lNmntkv9Lfg5UTAp7KOIjI5UwFMD06Qavdomh
         UE2mJ3dhAoTJSMRGwq1XzkjilD8ig/44kMkcHUzqsr52bhCuzHNTIvcUZ0stNpCIBH+5
         T1iMudmXnGJhBLPPX7J9zpZKee9XYtrZvReJfLhqF/9rs1JOnxyujnViZwKLe26Pocwg
         wRTGgO5c5hyKMDgjmzidT8j6BOouI7SvLqUlYO2kMs1FPRbMbpNqh8oyxfiMG1NVXLJT
         cQJ17g0C2vs33aq11OBZ6t171vNOuWrcCMpqbimYMUJkW9qUs6yIHS4X2Nlg8uxhqm0d
         Hwww==
X-Gm-Message-State: AOAM532r/iNENmN75G7aFsTxqHOOVi6bvx92uRCMRinYmlX2KmKZh5p1
        gl/7o7R/TBo3PPfHTlFLnkQ=
X-Google-Smtp-Source: ABdhPJxAi5GmDc8UzWdGKu/Em8Ha/Btk/L36nGvU801rqR+eHNBHrXTHNbMr+Lt3V34AcSqYawEFPg==
X-Received: by 2002:a9d:2216:: with SMTP id o22mr2439986ota.78.1640100199739;
        Tue, 21 Dec 2021 07:23:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm3530159ooq.36.2021.12.21.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:23:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Dec 2021 07:23:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/10] hwmon: adt7x10: remove attrs
Message-ID: <20211221152317.GC2753412@roeck-us.net>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
 <20211221123944.2683245-7-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221123944.2683245-7-demonsingur@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:39:41PM +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> These will be replaced by hwmon read and write callbacks.
> 

Again, this is a no-go. The driver is no longer operational
after this patch was applied.

The split into multiple patches is interesting, but it is confusing,
adds a lot of complexity, and makes it impossible to review the series.

Please combine all patches related to the with_info conversion into
a single patch.

Thanks,
Guenter
