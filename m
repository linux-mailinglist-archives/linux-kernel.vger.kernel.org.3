Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5609D48CB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356348AbiALSzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:55:14 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41934 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356379AbiALSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:54:56 -0500
Received: by mail-qk1-f174.google.com with SMTP id m2so4341941qkd.8;
        Wed, 12 Jan 2022 10:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/t7XYJprcGgT+MiFCmJFl5BViepilZLUR2LeW1J1da4=;
        b=VGP8d4WS0Ja6WsGKm2zSiZyHKfuZCbxs2YYx3Tok5/TAULHH6p1HPcZo33pimnXaNf
         C0JHEoOnw/lY0AFubWKyCx9lvkFVNq1U+0vlfB/dS83NfFOnk+Mkn1EmB6Uf4BBARzU2
         oh+4XWMdZSUTaKM0gXzNYnwr4spT+2NiwB08M22Hxd6nDrHSWOVuvvpzdduFtd7qTEZD
         vDe+W9/U1dhLKD5Aqw1MyF7B8WB3KnnvWo7Ep0SWeKdcnAk8ALDusE+/dXFEfPtVzMA6
         Z5Oqr01lznkrAuHzGhCGH6jrIvJXJ7s+zo9wR5BjtEWgBweVzCEo7TTIaZqVAbKlEh86
         71dA==
X-Gm-Message-State: AOAM533AcPEA8kizIH7jhJKhC+UG59DCk4bbZWIf1dxCrGhgojsQUwxM
        F2dZJ1JXC/3ssvCcmqABeqIfG7Ydfy6fvw==
X-Google-Smtp-Source: ABdhPJwB7ZQ3Ez708M5SrcKyvZSGOpUiRQlpgl9eKVbVtyBoKCrA7kpUVzVl7kQKiHahz0I/xsKxLg==
X-Received: by 2002:a05:620a:4501:: with SMTP id t1mr842754qkp.412.1642013695166;
        Wed, 12 Jan 2022 10:54:55 -0800 (PST)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id i22sm395088qko.53.2022.01.12.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:54:54 -0800 (PST)
Date:   Wed, 12 Jan 2022 10:54:53 -0800
From:   David Vernet <void@manifault.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: Re: [RFC PATCH v2 03/13] module: Move livepatch support to a
 separate file
Message-ID: <Yd8j/Q2H0zYrAA2c@dev0025.ash9.facebook.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <20220106234319.2067842-4-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106234319.2067842-4-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for doing this refactor. +1 to doing this, though Petr had some
suggestions in another thread that I'll wait on before Acking.

Aaron Tomlin <atomlin@redhat.com> wrote on Thu [2022-Jan-06 23:43:09 +0000]:
> diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
> new file mode 100644
> index 000000000000..e147f5418327
> --- /dev/null
> +++ b/kernel/module/livepatch.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * kernel/module/livepatch.c - module livepatch support
> + *
> + * Copyright (C) 2016 Jessica Yu <jeyu@redhat.com>
> + */

Should the copyright year (and possibly author) be updated? Or just removed
entirely?

- David
