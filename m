Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51849ADD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbiAYIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448713AbiAYIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:09:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FA0C05A199
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:44:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so1811754pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+J7O81Yn6PJdF+eRC1IATHARSNrRlCx+oll/tKiMdc=;
        b=H/xV85Oe5nelkk/GU8IC9+vPAy5X0buwJGiu8v+sAKczJrVKauEKOvjIvNPLLnTWuO
         NDsx3RxJxaXeD58X3VAsw88r7M7qGe8wRESza7xx3uxdRqqyI97uVpDmt0yCme+I7CSi
         Jw5ho9zwWTkou7GIkZbm8jsfwMJdoyrJHlwLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C+J7O81Yn6PJdF+eRC1IATHARSNrRlCx+oll/tKiMdc=;
        b=a2FoECX2Zj4czQEfd+LlcEPQoWGPZDgdDUpE9at5NYplfh9qxNqSvWpqSzfdBzTBgk
         jZ2DFJE2Mb8Wfe1ZQexO/Kfk6P0X60F8z8UvRWV/WijW3cn9Z3QR2JHZdLmZduJZdYi0
         MRFW8F707iempYiEnUedczpZIt9BoS4OjlsjFHpt1Gw8bifEGJTxsuPYwWG8t5U59EKH
         PjEtJuVN4BtfgOrSwDjiJmlqMoBFzt9kIcBZHWDM4gTMzKLUtiTnewtPsMXelNxXKVKf
         VHxkfNs9TxtXa+duOYcHpmkkWqinG+WcJhm+uW/5AGOMOW6a17kDCaU0ssC6FViXxmWe
         vYtA==
X-Gm-Message-State: AOAM530tPelg/L4IHjyw+n2xH4skjbMVQIE01Izx27Aw29ybJKTbB9Jx
        Kcy023Zmm5yZri7GTLitf9D0oCIV1azWSg==
X-Google-Smtp-Source: ABdhPJwhaJ7KmthGm2/RTx5HpQiBhaJZVzzCK7PTko/uUigr5Iu1bMT7/JYCH5M8tlkFdM15LmEJRA==
X-Received: by 2002:a17:902:ab82:b0:14a:188a:cd1f with SMTP id f2-20020a170902ab8200b0014a188acd1fmr17611226plr.44.1643093046008;
        Mon, 24 Jan 2022 22:44:06 -0800 (PST)
Received: from 6facd6251e90 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id s23sm20181656pfg.144.2022.01.24.22.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 22:44:05 -0800 (PST)
Date:   Tue, 25 Jan 2022 06:43:58 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.16 0000/1039] 5.16.3-rc1 review
Message-ID: <20220125064358.GA2349358@6facd6251e90>
References: <20220124184125.121143506@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124184125.121143506@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:29:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.3 release.
> There are 1039 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

Looking good.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition: build tested on:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
