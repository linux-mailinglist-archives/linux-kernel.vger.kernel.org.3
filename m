Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D94A9A4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359004AbiBDNtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358974AbiBDNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:49:44 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F5C061714;
        Fri,  4 Feb 2022 05:49:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id x6so4843745ilg.9;
        Fri, 04 Feb 2022 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDivMS+R3wRgbfvv5KdwSS+OOaGla1Hngqzf/2B/UyM=;
        b=TdrGjLFiOh3Tsr1dbbQgwstXuPBI8fQpm7mKNCWwmEXxubaeLu40JnPtxuC3wu6Cun
         ABrFE/nbMaKQ6Xi7CkQS9xBxjVpOCnhx4WEdnntX1pyTEXcL0EdIqOsyTUtdeBhf3YBW
         ZBYkbWbIdZxKOaglG56lRDF6Y9/AbWENQTzr1bN7P1O8x3YYaTFMMDsdIytuVTZjoFh+
         k+IHxGWlzM9JXuhdQmcTr1QG5kFb0rNhl2TKzThjBaz+K4//8DDMP1R2IVQcI0Tpjg6S
         1ULpCnIvEyCealyR5YpaoXlO7aDKOLU8fD79SUHiJ3tbRYxK08cLoTvdSNWHO9W7t6gO
         hRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDivMS+R3wRgbfvv5KdwSS+OOaGla1Hngqzf/2B/UyM=;
        b=Vel4etfpfjWQE9byQm2ixSnlQDD+I3bjeIWpZRNXkBNCepDewf94i67VSM0p5DU9rQ
         HdqN9SqIHKs+3XZAKdynzAXawmPo+hOI6QSnSy6E5rkChxbumoxA/tF2uePo2xcrRXOR
         VoazZ6P2tE2m84cgaORsMvQacA+d+fcWTejUKrohogBOvcvRsXPIazaXgFuas5flKY1/
         ouovGkV9Q6SvEBN/td2Eg2pVYSQketDsWLiI2rg7VWDFQ/Nv6ky+9a4tbbUM9JbAZZvY
         wpoX6dXAtt75t0dKf7oBFdm96lTS2B/jOWN8GiAdVx/mX7aK24NHxvfOR1wS/BRmU1WI
         g66Q==
X-Gm-Message-State: AOAM5327giEbndY7MXtd7zXlFu9Kkwbp7U4by3cfvrzXaGpVP1vSVNB9
        DuVemE85B376tM4deqh/7RQLP+t2HSTXSJ86DN4=
X-Google-Smtp-Source: ABdhPJwTBmXQ9PU+NTWkgrnaLoYIM7nlHkfMIVD2BM3G3kLGoxow3Mvcu1IcjLoLDVJF9BhB3y2tlF2BOW3gGqsUBdw=
X-Received: by 2002:a05:6e02:19c5:: with SMTP id r5mr1455540ill.164.1643982583014;
 Fri, 04 Feb 2022 05:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20220204052258.556667-1-eugene.shalygin@gmail.com> <40c67c87-3929-b042-0cdd-429bb002d864@roeck-us.net>
In-Reply-To: <40c67c87-3929-b042-0cdd-429bb002d864@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 4 Feb 2022 14:49:31 +0100
Message-ID: <CAB95QASywzktCq_vM8esmuSktPErLzKUVsqSTLV-f3sDOoY2bQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: fix documentation index
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 at 06:35, Guenter Roeck <linux@roeck-us.net> wrote:
> I already did that in the original patch, and I undid the removal of
> asus_wmi_ec_sensors.

Thank you and sorry for the mistake!

Regards,
Eugene
