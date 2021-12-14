Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D5473B52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhLNDNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232689AbhLNDNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639451596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/n9aD3d3fHxDG9Px4q5PGZku+eA71D79JAz4+k/9vSg=;
        b=I03Ni6bpMFmvufG1voFk2gB1egpLIS0bxw4zvB53lpTqFRdelSS9OJ8klARa+cnwPi7+9b
        Lm3vqRsd/KRIO90dRf2POldvs4ayhZ5QRD75EFEPvSfj4oqenxVEkB71htmWzluCbcee+x
        UbkbQGInXzFpiuUYC2ffP+yWymV4Xx0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-7MAQHQFoPGm7-QU6UUjgdg-1; Mon, 13 Dec 2021 22:13:14 -0500
X-MC-Unique: 7MAQHQFoPGm7-QU6UUjgdg-1
Received: by mail-oi1-f199.google.com with SMTP id t132-20020acaaa8a000000b002a819b21cc7so12021403oie.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/n9aD3d3fHxDG9Px4q5PGZku+eA71D79JAz4+k/9vSg=;
        b=s+1O34mUTFXDpUwCb0+ts7DSS6RDca5wfybfGYO82McW7VnRUZ2yK4aZDmq1UCJYYS
         iPiyI6zipFwAfCWV4emXHgVM1PFha6xEiqPDbZVvnhAPDOvbsDYGdsuJabMSdzMjrFxa
         Jp2tplr0AQYdPXLnvcHNBB74gom2Da3blN9t2tDB1j2QMRHcuP5AmcX8wbfOaw8s/Vtj
         FhaR0nlbaqB3cyJ6nhtwWaMXR9IjPOGHDR2yS6hPaTyVT2W6X9ruIDtJhc2WgRGv8xRG
         inmISNh9DIOvub8JDeCk0/lQam0gobDm2s/GQc+t5oIZD+SdoAHzIhST8HHFGLaVCA6P
         BxuQ==
X-Gm-Message-State: AOAM531c1yia9EieMQ7QJ6dUeA+hObPWfeYGuh0jS7dDywqdWbXmYEou
        /FpwixKmLih8pOnZHhDP03ihbbVi3i6XIRCGIVcNFDbRwW+mreIeSLv/LV+dgVqArwocToCs61T
        XZ8i0bRYeAgfM35dUvGgWy4ZO
X-Received: by 2002:a05:6830:195:: with SMTP id q21mr2069562ota.355.1639451594183;
        Mon, 13 Dec 2021 19:13:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2iz3hCs6r9lH/lXETVLAPnC49R3ZFNXhsPRQSXrmKaougoXLA3UjZIBo5VrH12Mh87hPjNg==
X-Received: by 2002:a05:6830:195:: with SMTP id q21mr2069533ota.355.1639451593954;
        Mon, 13 Dec 2021 19:13:13 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id 186sm2963571oig.28.2021.12.13.19.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:13:13 -0800 (PST)
Date:   Mon, 13 Dec 2021 19:13:10 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     pmladek@suse.com, linux-doc@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
        corbet@lwn.net, yhs@fb.com, songliubraving@fb.com
Subject: Re: [PATCH] livepatch: Fix leak on klp_init_patch_early failure path
Message-ID: <20211214031310.p6kmbvd73kn6j7x3@treble>
References: <20211213191734.3238783-1-void@manifault.com>
 <20211213201022.dhalhtc2bpey55gh@treble>
 <YbfQHjoUO5GTvImR@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbfQHjoUO5GTvImR@dev0025.ash9.facebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:58:38PM -0800, David Vernet wrote:
> > I don't think the fix will be quite that simple.  For example, if
> > klp_init_patch_early() fails, that means try_module_get() hasn't been
> > done, so klp_free_patch_finish() will wrongly do a module_put().
> 
> Ugh, good point and thank you for catching that. Another problem with the
> current patch is that we'll call kobject_put() on the patch even if we
> never call kobject_init on the patch due to patch->objs being NULL.
> 
> Perhaps we should pull try_module_get() and the NULL check for patch->objs
> out of klp_init_patch_early()? It feels a bit more intuitive to me if
> klp_init_patch_early() were only be responsible for initializing kobjects
> for the patch and its objects / funcs anyways.
> 
> Testing it locally seems to work fine. Let me know if this sounds
> reasonable to you, and I'll send out a v2 patch with the fixes to both the
> patch description, and logic.

Sounds reasonable to me.  Thanks.

-- 
Josh

