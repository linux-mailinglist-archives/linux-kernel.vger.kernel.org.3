Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525214A2AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352019AbiA2BR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiA2BR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:17:26 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF5C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:17:26 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m6so23470750ybc.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vXfhLTzwkX2Ql8jE1kA+Fg8IBmphCmNOL2Od072PNQ=;
        b=ai26aBXVcvu829e6rc5immIC0deK3D4XyZCsokmwGgB4pLjj20sDp5HAtjAdyYvHSH
         z94qxbA9+fTZmaYHDDwvFzVa3BgDR5nRqj8+Ml7KaoPutRwaLgldUoX0qZ/Bm0iNSqtr
         gcmfMQjYfWJuQBeVSYCJL82HpeuKjfzkRT/TNjIcWPLmwZmVdIU3/iFNze0isGNBk4H3
         An+KlsI1uaRXlYExkj2cUcIKPRTbbwHhaBtA2pNXfqJt4AFDioyzD9OL8KFL7o4WxUrW
         3CbOwYk0xD59SIH8uJ5rL/7JGAhgE7ScCXTe3yMIJf8UZxPGLX9tuRluJaI8ha9awcyB
         iF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vXfhLTzwkX2Ql8jE1kA+Fg8IBmphCmNOL2Od072PNQ=;
        b=hV5T29OvK+8b5ThD9+ojruhWEOgu0lWWLLBlzgyAcyGhqoe9H7TvFtQOhvBAeN39SE
         kv/rV8jSe95sDwsjMffeIOhXlGwsERKnGqN33e5EpJeunyIWrbVONw+LGbR6fC15KSyL
         dmAo9BBIbf2/Fi3npdhn6VyVRNbHARpn1Mile3bRWf/j8EHyVz7cvh8z9JkQnnFmcnLg
         2QqyHfWcc6/vVZTgwPSdcm3wxVdfGeNEQgAG+u+JWSxOJ49cSrUGksfL7/tnmBvmFTPr
         WYepzCpGd68X6sXLcxeEPcOglORLIy7q/WGH32+EN5v4Fg5t7ORsiJgvv2AE9w7aiVdx
         bbXg==
X-Gm-Message-State: AOAM5300sodriAcxRczTRTbnnv+4za6o1XnP/fdIZCPK4reFoc6XO34o
        M9f3HwrrNq1I9hJJUFLeb3THvkkjZgMwVqdaS0S2xg==
X-Google-Smtp-Source: ABdhPJxa49q2IXeQWC8WC5VY9MQGB7cGZWXhIF5GgN/7pFo83Mb9zj70/h9j+JKi5D55uHShrymT5YftwgnI12S+HOQ=
X-Received: by 2002:a05:6902:124a:: with SMTP id t10mr14984784ybu.634.1643419045307;
 Fri, 28 Jan 2022 17:17:25 -0800 (PST)
MIME-Version: 1.0
References: <202201160420.v9oG29Pi-lkp@intel.com>
In-Reply-To: <202201160420.v9oG29Pi-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Jan 2022 02:17:14 +0100
Message-ID: <CACRpkdZDGOU4j2X5x2o26xaFD7wXfJKucFk+EnYebCj98qwa-A@mail.gmail.com>
Subject: Re: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for 'ixp4xx_pci_write'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 9:33 PM kernel test robot <lkp@intel.com> wrote:

> FYI, the error/warning still remains.

This driver is getting deleted in this kernel cycle.

Yours,
Linus Walleij
