Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86945882E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiHBUEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiHBUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:04:36 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509B52FE1;
        Tue,  2 Aug 2022 13:04:35 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id v3so18235192wrp.0;
        Tue, 02 Aug 2022 13:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GVUs+QSi7eRzqzPaiptheuyohg5wVNG8R4iP24zVoI=;
        b=0sDQyBYCb1tTHQm/FGM8LQdIqnClQjjesHduzzDk4CftIJFNpKOOXPPKalPVJ6tNKX
         smiZemcdP76OFAGpqv7P2ATtw6roOjaVFxszqWq85fCCYwE+tBCo5QHLW3z2H3XpDW5G
         9PGu6kZvYaQBVMMy2zH6x17MEWPr8HeruisjtLi0B1vvHryj725m4/MFUfS78pww5UWG
         9DXwhchg5mki4290LDNQfqCIBKA5WOFG9xCQVJmKXkttKbySh9/1jGH71Evp6xbx3H5H
         toiIKtsNtHA5sfHix8oqZ89KbEpjtEx6lxViJyLzwzavbx8aq8f+GqqaCWKzprSeM+rL
         /Y1Q==
X-Gm-Message-State: ACgBeo2R3vAzes3N3deRXVaRj5+lGJBSYg+9NbzmR4JF4WUEzcrva+cR
        uvAHhWkbfoMOFBgezPA/aUw=
X-Google-Smtp-Source: AA6agR4LjVRosNcFgQ0KXv+SeDQ6ihaov87I87aolTGGyOFkq7dqTr/AfqxhAqXsXp38sd1qbi+ITQ==
X-Received: by 2002:adf:fb03:0:b0:21d:70cb:d6b5 with SMTP id c3-20020adffb03000000b0021d70cbd6b5mr13459341wrr.548.1659470673490;
        Tue, 02 Aug 2022 13:04:33 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b002205cbc1c74sm10281991wrk.101.2022.08.02.13.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:04:33 -0700 (PDT)
Date:   Tue, 2 Aug 2022 20:04:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v8 28/31] samples: add Rust examples
Message-ID: <20220802200430.qiyy2utts4lai3ac@liuwe-devbox-debian-v2>
References: <20220802015052.10452-29-ojeda@kernel.org>
 <YukvvPOOu8uZl7+n@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YukvvPOOu8uZl7+n@yadro.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:07:56PM +0300, Konstantin Shelekhin wrote:
> > +module! {
> > +    type: RustSemaphore,
> > +    name: b"rust_semaphore",
> > +    author: b"Rust for Linux Contributors",
> > +    description: b"Rust semaphore sample",
> > +    license: b"GPL",
> > +}
> 
> A minor neat, but ain't it possible to use &str here in order to drop
> this ugly binary string prefix?

Their types are different. One is for u8. The other is for UTF-8.

Thanks,
Wei.
