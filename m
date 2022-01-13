Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9348D992
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiAMOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:16:58 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:43913 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiAMOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:16:57 -0500
Received: by mail-qt1-f180.google.com with SMTP id q14so6927587qtx.10;
        Thu, 13 Jan 2022 06:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJnOW0r4XvWzKJWyXxLLNdK9vGFIkKRXsum6p3nqYyI=;
        b=nmbW0t/B4479V1IjC1H6B8MU0tyYqNzOX4Cm1Yz5GaxU5ins6vM07qkWr9wReNQGBL
         w6l+otFYHHBStLnNbCyxtuk7l/WgQPa2M1LXLEW1Qtwg3mOtPPzaVEdMZNx/k1ASPZwC
         bTMWTmBWkMVLGjh4ImfeIfPZWqc8GRw8mLalqZjPTXGIGUYfB+3XDe6nnZCpRoB8Wfm1
         HFB9fX+76gRz+cKNbBHtN9pTXTd7RwVNoHPVut5gpLJhEtY+cwknbn5FIXo2BbkTL/au
         OWpjSgkRqc48DhnngHI02ce3jq3b2eLxaGerEehQDG6l8O3ysxzX7cTC9S6q6TwBArC+
         UODQ==
X-Gm-Message-State: AOAM533Du1qjT3lECitFneqyCLR2c5p+2lj6eBGjfeddgeFLvZYIE05H
        7QRgfrfRj+Aq3eZ7PL6wLuk=
X-Google-Smtp-Source: ABdhPJxVwcGpaCxh8DWMtA3SvUFeANGoxh+RxoPbtyAizpP5m77mbHmrNea8AMP1I6hO6D4q/dhYIA==
X-Received: by 2002:ac8:57d3:: with SMTP id w19mr1865035qta.658.1642083416642;
        Thu, 13 Jan 2022 06:16:56 -0800 (PST)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-021.fbsv.net. [2a03:2880:20ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id br32sm1877272qkb.79.2022.01.13.06.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:16:56 -0800 (PST)
Date:   Thu, 13 Jan 2022 06:16:54 -0800
From:   David Vernet <void@manifault.com>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, mcgrof@kernel.org, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, ghalat@redhat.com,
        allen.lkml@gmail.com
Subject: Re: [RFC PATCH v2 03/13] module: Move livepatch support to a
 separate file
Message-ID: <20220113141654.74lllshgujatnopg@dev0025.ash9.facebook.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <20220106234319.2067842-4-atomlin@redhat.com>
 <Yd8j/Q2H0zYrAA2c@dev0025.ash9.facebook.com>
 <20220113103531.sn76g34tfkxscs4e@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113103531.sn76g34tfkxscs4e@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tomlin <atomlin@atomlin.com> wrote on Thu [2022-Jan-13 10:35:31 +0000]:
> Who should I specify? I'm not entirely sure. If I understand correctly,
> Jessica was the original author of the majority.

Personally I would just remove the whole copyright as the SPDX identifier
should be sufficient. I'll let Luis weigh in here as the Modules
maintainer, though.
