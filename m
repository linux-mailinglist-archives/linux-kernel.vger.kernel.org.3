Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFDF5880C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiHBRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHBRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:09:54 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61BD33E30
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:09:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b7so9803481qvq.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=K9kEd2GPyCLccFvieYdAFisgtz04Q+n9mP7468SvJiY=;
        b=UBJRjzHxcQ0IqTf/Q1+Zfvr6T8kYy0ryJicFBsczPkuPf3ir2NPfb17F4aqq0wc3ta
         LWckoUkU+hsO+iqA8avS/mpqxGRr+gGUvON4M9wcD0gZxjGfWVdhxzJWGzJVgHOv1dAL
         prZQd3uukKks9AmWOHKO+gF/OTW2tf8+mL4BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=K9kEd2GPyCLccFvieYdAFisgtz04Q+n9mP7468SvJiY=;
        b=tdfRhfqL/zX7tOEoQP91n2eOQblRS6WouJ6cAjs7HtefRUVQmoiuCEs3CrEsa6cDHY
         FXet2YLOjRvx1HjttjMuDotzGf2rX2v11UTFCi6JY5JD5fJdImA+qI/NDUakj1SNPJV8
         C6OvfnpKWPNFtpSDfhXMA3eJ/Xt8lAgpTNhLcSDEtlizRNKa1XSyhC3XRLUI97F031yR
         XRNOqPHLKs+QHRs94q5l/Ejomuvnu5Bp53a+EkLVjhMr7C9f/g8+rNcnapgej/NPULGT
         32ZcKreJcA8zMqHm5JePqAE2h3OldoAoqtfrf8TcAmxC2tfjI+Xz7MgaJeGrqJ7dRqCG
         LlIA==
X-Gm-Message-State: ACgBeo0aZfYdktKCvYc8xg57J0g/ggCe6VQ7+6/aAbuFX+2fbT3yNWk8
        cXo0/MEEIlOw3nYChjTUf/x8mA==
X-Google-Smtp-Source: AA6agR7eM3+Gbg5TiO3WTJi++AGoF3I0zAKD7cvf9rBlDvf6omVmi8ylchUBe7S4Ysrt8kYJXcwgVw==
X-Received: by 2002:a05:6214:20a2:b0:476:9071:2e60 with SMTP id 2-20020a05621420a200b0047690712e60mr9234833qvd.110.1659460192878;
        Tue, 02 Aug 2022 10:09:52 -0700 (PDT)
Received: from nitro.local (host-142-67-156-76.public.eastlink.ca. [142.67.156.76])
        by smtp.gmail.com with ESMTPSA id x29-20020a05620a0b5d00b006b5652edb93sm10776025qkg.48.2022.08.02.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:09:52 -0700 (PDT)
Date:   Tue, 2 Aug 2022 13:09:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 5/5] maintainer-pgp-guide: minor wording tweaks
Message-ID: <20220802170950.l4xs6r5c6nfqlop5@nitro.local>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <20220727-docs-pgp-guide-v1-5-c48fb06cb9af@linuxfoundation.org>
 <7107b5c5-d392-db1f-d5cb-6cae638c0b31@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7107b5c5-d392-db1f-d5cb-6cae638c0b31@infradead.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 03:55:45PM -0700, Randy Dunlap wrote:
> >  The files in our home directory are not as well protected as we like to
> > -think.  They can be leaked or stolen via many different means:
> > +think. They can be leaked or stolen via many different means:
> 
> One or 2 spaces after a period is one of the things that we historically
> don't care about (can go either way).

Hm... I didn't know that applied within the context of a single file. Anyway,
I'm happy to drop this change -- pretty sure it's only there because my vim is
configured to replace ".  " with ". " on "gq" operations.

-K
