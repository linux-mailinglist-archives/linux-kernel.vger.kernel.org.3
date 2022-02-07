Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B473D4AB603
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiBGHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiBGHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:24:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A6C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:24:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u130so11504657pfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 23:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXSlfVDKwMF6om0Lh75ktdNJu0SBDC/xJ2BOT9KSvbk=;
        b=IiY88wbW2bT/FKAhO9Q8+pXHoM8+Dm0ujhhZ7LHC7ZD3usBEdT4zDn2jtqSa0lk7Xv
         OtuYgOHMaOUcDsRnosOy/m7eE13l9AHe5wi/LtmOJwIELfkZnOCYXHCe41RFppwRGQKa
         oWdOcrlq9Bal6R8rnmj84oRYXVyv9OhR1potY2CBx6QsYD89IHuDbkwpFrIN8lbeWKyR
         jv9ALex9BZ65VHyqtNrg+q1/vBF0CGpcOWv9lJuLFW8w72W296lCZfEXk4k16fhTWAhD
         8QGEWAXg2tE0fLDpXEPXnISzSt9BHzpXiHKmkAgZeAZ+02CFG1JN+ddQwMfwzlluGz+5
         xszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXSlfVDKwMF6om0Lh75ktdNJu0SBDC/xJ2BOT9KSvbk=;
        b=4vOGHiQm5ZwGgrAHz2AY1viBaUqz5owTpT1uABX7HkTNENFay+hKkzYAUqgFouoK4N
         Hk8fXzXppsUs4Awrn7QRaDdEvZgwG10kzpQO3RiJTqUmF6kixqu9pyFZNBuKTrVPpFcy
         uwhrEcCy/XempmfxIy3DjeaMeJt7YKgoX3jqKYyxtCApHkP7t1auL0j66/mPpxOHuOCs
         N4aWkPqVDeQSeZXKcZOcgKCDVH9XlWZAXCGfCZ/ZG/p19HrkuM9PCXA3hehYg+alSgoI
         heKRJECX8jAlUtk5ODEfba2JxjlXJMeHVZ1mmy2uj439WcJRdjyE8gywLZ404VJLxOza
         BVwQ==
X-Gm-Message-State: AOAM532PNQgStFrDKnbFcvuIMF5ZPrJNUE4wlaGSMJmo7fVBuY2oenks
        S+Ioq5fK2qJ0AIAsSrjfUCA=
X-Google-Smtp-Source: ABdhPJx4yZeZ0Ph+3g4I1Y5TX7BY5YJn3N60mofH9h2it4LUr2NriDhiawvWGFDK+vaEhvRUpjEISA==
X-Received: by 2002:a63:6c84:: with SMTP id h126mr8363072pgc.456.1644218641581;
        Sun, 06 Feb 2022 23:24:01 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id s17sm10258932pfk.156.2022.02.06.23.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 23:24:00 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:23:59 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: remove CONFIG_SET_FS
Message-ID: <YgDJD4jEA+f2hsHg@antec>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <YgC/8ng5WX6Nt104@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgC/8ng5WX6Nt104@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 10:45:06PM -0800, Christoph Hellwig wrote:
> On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> > Remove the address space override API set_fs() used for User Mode Linux.
> 
> This ain't UML :)

Yes, Geert also brought that up.  As I mentioned there I took the text from your
commit message in commit 8bb227ac34c0 ("um: remove set_fs").

I didn't realize arch/um is for User Model Linux, I always thought um was just
some other processor!  Next, I thought your comment 'used for User Mode Linux'
was just referring to userpsace.

Now I get it!

I will fix this up in v2.

> > +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> 
> No need for the inner braces.

You mean to just write as:

	return size <= TASK_SIZE && addr <= TASK_SIZE - size;

I prefer keeping the braces around (TASK_SIZE - size).

-Stafford
