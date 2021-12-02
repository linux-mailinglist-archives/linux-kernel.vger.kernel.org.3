Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D772446661D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbhLBPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347008AbhLBPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:08:00 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F07C06174A;
        Thu,  2 Dec 2021 07:04:37 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v138so339644ybb.8;
        Thu, 02 Dec 2021 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pl0nAfjk1TSrUviC9/QCJWglO+edfavXx4c3uYPas+o=;
        b=O0DK71/wp/8p9M3iH1OFQVamnzskCfmhGrDlcLXoSjSGAqj3thu25HTWMBzVfgi7IW
         vdKfH7vwGpU/uACoKOAQ3syuazicL2QGtrXSEvi9n1spO1QrfOBewpYQHNvyZW97QSVJ
         CqoZNpuYl+QznaX/q91DyAOGULHBOxc5zmWzevuEw8wn6ADXiMHrIiR1IcvHQj7WmRWS
         6sAW+CGBWlWkz/MtVXtn6UPhXMneKV5G4O9Xsn9oBrxi11TVQmdC7zJX237lekae3Gvn
         XoIzcjEwCM3eJiIDXERm6IX8THjtPuD4Fa8nE9pS13r58Lbz2HWpDZ7bsQ9sliSXoojf
         Jg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pl0nAfjk1TSrUviC9/QCJWglO+edfavXx4c3uYPas+o=;
        b=qYe3lnuDAtXrd4IibsaqHGYQ+iQQ2LkdoMhkjTVZhWT4dudT6jSPgQpBEjiw83qx85
         N4e+29WW4tItSgQ5mGw+dnA/4iIf3pCdzmAuoWy+JvGqwP7VzTmI8F6xBoMWKVoOcgAJ
         CIyAP7SaWiSbzC+uTNNR3zJcZGq0Xz7oH5Ik5704dssUxO3ndg0cYgsaHzkNdiALp4yv
         rcG9Y5ATAaEnyqflqjQRhCOYeLVu+zxWkIn0AxcZABou72Xi9eefweJol9IfmuYbvk8h
         3GNOS4tLWxNI8OSmPvQA3YCtYZcOX2LEnF5vlFliCdfO/Udp6O0gW6rxmataltrwOzYN
         FSIA==
X-Gm-Message-State: AOAM532os6ESg66fkx+E4NPfrfhDHFJ7Dk1OohVuU1GZ//tJrsQYQ9Xj
        jqOpBxH7JtlKosBkpEzYuyyUk4TMB2Ic9iddUy/w0Azs/58=
X-Google-Smtp-Source: ABdhPJx4Sql4F07K4d5ulW3QHpaSQivBHXdD1kDwWVT9hUqZd9EweegbwcutptcTSeXDsDMxouNf2wKRmPFsjeP1lDw=
X-Received: by 2002:a25:cf0e:: with SMTP id f14mr15380836ybg.236.1638457476949;
 Thu, 02 Dec 2021 07:04:36 -0800 (PST)
MIME-Version: 1.0
From:   Olli Asikainen <olli.asikainen@gmail.com>
Date:   Thu, 2 Dec 2021 17:04:26 +0200
Message-ID: <CAK9yiZAJRL9_Hj1zuuEEM4ngM7GVCgx56m1E5h_QzzXV255NGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
To:     pauk.denis@gmail.com
Cc:     andy.shevchenko@gmail.com, eugene.shalygin@gmail.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested the patch on my ASUS MAXIMUS VII HERO and it works, as
far as I can tell.
