Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A284B1267
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiBJQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:10:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiBJQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:10:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09702EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9959C61CF3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62F0C004E1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:10:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NAY0waXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644509446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zMTJh73oixvK6Cy3gBc0hlrts0aw+f6jfhpzT+nsqEQ=;
        b=NAY0waXyNS81TVskAJwWZQ37GFWqduQzVTbOm731q8pjLPuohfvlW2sGYApr3ewRpm8eus
        MdoXqZehxY+L7m2AdjcCzpa/gB/bQ2/WWvGEdjW+m6qDJj5W/GwxjncNoQDr4Hvo9xa08J
        /6A0e0jCEiMWNLjQUT/Gj5d6w23I/LU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2618b095 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 10 Feb 2022 16:10:46 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id p19so16858497ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:10:46 -0800 (PST)
X-Gm-Message-State: AOAM531EWfeLY6qmIXseEObxpdN6iWhYFIKDuClOgHVKwqy3fYUBYFgz
        qUFBDHOYhdMwahZL/ek3ntaqiW2gfqwaVqV4mxQ=
X-Google-Smtp-Source: ABdhPJwOB3XG5SV9Pr+nhI+tynR9SeQZA2ma1nZnZ5QLP9zBAeFpRl+WcJtHCt0ZUWgT/usR2spp2AbkSaBIwAJ8nR4=
X-Received: by 2002:a25:c006:: with SMTP id c6mr7359036ybf.457.1644509445371;
 Thu, 10 Feb 2022 08:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20220210155012.136485-1-Jason@zx2c4.com> <20220210155012.136485-4-Jason@zx2c4.com>
In-Reply-To: <20220210155012.136485-4-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Feb 2022 17:10:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9pc5NRLW4wUy57bqd_gX01PBVoydOQp9Z0rWT+j+fAb+Q@mail.gmail.com>
Message-ID: <CAHmME9pc5NRLW4wUy57bqd_gX01PBVoydOQp9Z0rWT+j+fAb+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] random: add proper SPDX header
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somebody pointed out to me online that the original license here was
closer to BSD. I'll resubmit this, and also get linux-spdx on the
thread, as we should be careful about this.

Jason
