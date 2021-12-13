Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86647205A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhLMFU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhLMFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:20:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EADC06173F;
        Sun, 12 Dec 2021 21:20:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so13816682pjb.2;
        Sun, 12 Dec 2021 21:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYNZee22XbkwXg1taiKBO3ZWqciR+IbR7q5WucxbMWY=;
        b=Jy/fsc+d4epQNjGtp7iVz37bvhv+yrKOWHIJ3q7YWsZVCtdTn3xgnByqbh2VwnFBiM
         OgDjXUhR4mWEEC+rWmMdu+rzn+12n6ilC6kcHHs5T6tIouyzYqzN+zVcG8Q8b2v+LVp5
         zgCsv0grMjikrO+r/2Ggyg0lvte5lF8sh9gKRWdXvcSZYQQzIuQdCXDPzd+8bpBkPyJ2
         HteVY96KR0A4EvUD73wzIJGYhchxBTOEmmKTp/Uh0yTc3mqkI8fKB6shfkw/wLJRuewK
         cAHi20rRBWBgprXOYfuagRlIJLIYgWI56YZTUuq9NvvaGmzagf8KJdczXwGH/ENIFHsG
         6MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYNZee22XbkwXg1taiKBO3ZWqciR+IbR7q5WucxbMWY=;
        b=DZMgOl4wBgr8aGKZRpY1HlscVirwR0rnDv+56P3DoUEC0H97G+beIIDQgaWGng2T1j
         yCjV8P/8pHRyrbMlHfXx/AH5DgpOPiifMUMKs4HSnOK/MOs9QE9uVBnPXTHCHgDjzKFW
         vhz2NuitqDDOp4IJdt1MGLbVJfG0MTB5xmNfz4YFdoT77Xzbn5JG3muBK4p8dPPlZGJH
         5MU9fFya43zn5JuTajzcuoQB7s70FUpAYhlXeZEwFvtl6vKYkf8h9WE1fGbXEAHek3YW
         fTVMpNpI+4QLDJ29tAet6cn13uYtiZXF0L4Ba+lCzgVTDEuy3P7U/F0lrwQi0i1b45su
         uDGg==
X-Gm-Message-State: AOAM530wzn69dH4nwLluwL52jZj1co2jzY2BD6BaWN7nMKE5faykWHN/
        J9b7w9PD//VEpNVluN3gDINrKGxUEng=
X-Google-Smtp-Source: ABdhPJzbxLwcUsNy36h8YtA2ItwOld6HAjYU2c7I1vzBDCu/k0bSBQb5TTzE1qPsRhDT6swE+TweEQ==
X-Received: by 2002:a17:903:2305:b0:142:1bca:72eb with SMTP id d5-20020a170903230500b001421bca72ebmr93274358plh.67.1639372854567;
        Sun, 12 Dec 2021 21:20:54 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e537:8856:7d40:7c6])
        by smtp.gmail.com with ESMTPSA id md6sm5481358pjb.22.2021.12.12.21.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 21:20:53 -0800 (PST)
Date:   Sun, 12 Dec 2021 21:20:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ucb1400_ts: remove redundant variable penup
Message-ID: <YbbYM/P1d6eMd0nW@google.com>
References: <20211205000525.153999-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205000525.153999-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 12:05:25AM +0000, Colin Ian King wrote:
> Variable penup is assigned a value but penup is never read later, it
> is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry
