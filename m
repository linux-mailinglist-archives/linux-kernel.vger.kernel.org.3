Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2244E2C61
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350318AbiCUPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350325AbiCUPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:35:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205714021
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:34:17 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id u103so28707109ybi.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrzf+wQzaUyINddaHGR9lP5hOlC3S86og95o5h4xVUc=;
        b=Qodq+LsDrQAgYzP1Ma9xTtf3vXjcBRAEZHNU0RQKNpX520gF92zDAV+AbY8H4UT4p9
         ahu/stIxIxyd5j89pAsE1eoaluAmrvAw2TJwH0dqRi4wxuK88VCSAsBXjJY3YOjtSMCi
         gQag/ryFc5T/BT4vNB3ZsDzgKzsYM2YA/t+dIEFt5J/ZKsYCf0AtX+RGZ67v8wqC4aEs
         EfRlidkiGIw6/4MFxiv3bFftzRQiFhw/z8kIAKmHedJ0us6dzlH9Vz3wmFSvMnQj0U5R
         cTCpkoJbygkHpAxTIARBlazK+iARiuk2Mrm46LTmJnylmT0psG9LRgGgCsDMWRMM7WM0
         JvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrzf+wQzaUyINddaHGR9lP5hOlC3S86og95o5h4xVUc=;
        b=2W1tH/IRsJZiLLroMyZBJH6p+u4jywLZ16/5bHyV1KZ1E4+nIMvx8OWv5f12SCAQvu
         4fn4iZ1oSMO7DF7Ue3v0EVAVQ9hpQqfuw9T3tgplr7z9o6OjyYhOoMV9kSzsmYDQGutI
         vL5+L7elYVny4rIat2YVhUmBfubkgA6Mib0/K1joz59vawz8Ixyd2IJYH5446/biJmyu
         5StOtg4CeQthqkprktYXulPmVouMRDOyO9RbEJDPycU4/P7JfRbSZBDhDgc/2tzQ1/i5
         WlzounPGb9lEmJ31d0CayXioeNKlPzIHwifbJBowjMf0TeA3ZcbrsZC8OqTV32pjFsHW
         U61g==
X-Gm-Message-State: AOAM533fRB+1DQPvYlnGRhsaNuvbjCGdFzeVt0ZeLBKg+e0Lal0eKwTr
        p06STVvKh6ztcizo5K7tNPsezSl1H0S0hvQqi9KpfYcFR+s=
X-Google-Smtp-Source: ABdhPJznlQOBPmTpXspXCVCZMlv4ebzYSeypfjSsuGs5DtX1XtP5m78Z1q1k2RopWFzfy0pvSFDFZ8UKKYL8pwaJFQA=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr22292996ybr.295.1647876856663; Mon, 21
 Mar 2022 08:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <202203200849.3dFXVKxt-lkp@intel.com>
In-Reply-To: <202203200849.3dFXVKxt-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Mar 2022 16:34:05 +0100
Message-ID: <CACRpkdaorR-mhZ9g2SraJJJ3sVw9yR5PgzGZOP16scQTC8+D8Q@mail.gmail.com>
Subject: Re: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for 'ixp4xx_pci_write'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 1:07 AM kernel test robot <lkp@intel.com> wrote:

> FYI, the error/warning still remains.

As I have repeated three times, this file goes away in the next merge window.

I suppose I am talking to an AI, because the hammering seems pretty dumb.

Linus Walleij
