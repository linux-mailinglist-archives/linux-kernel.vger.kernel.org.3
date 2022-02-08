Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C684A4AD117
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiBHFeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiBHF3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:29:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60165C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:29:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y9so7547412pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dlzrIFj91NwpxBiaHLZyR8n4A+siJQYBxRzBvCpxADs=;
        b=f1A+JdaZYaY9TWvyitqUfomLKyN2Ijxhve4UQQSJLaacJbCjx+wVi6Uy6nmNDiHUOd
         4YIXosi1ceigyNMn3eeyZiOzfsSSE3sx3UVK2AiQWY4bFM/q6eVbg+85DUzen4pL9caa
         klG6o9KLF9naFuXa62145JAo4nWYB3NMSotHVwpfZl8IUkQTwBdbdVXtu1T5qful/Wdn
         9uaI+J+q8rbBYdchz3mFcg/YuVXctbF04Hbzca1tzqpfQtzJ6ZAxft5j24r9uTA90gZJ
         VShW5M3qAsh1oFJqsD2zh1js6gdJIF+tZqMN7y10q7r4OCQypCn2BmFJGODtW9maz341
         mGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dlzrIFj91NwpxBiaHLZyR8n4A+siJQYBxRzBvCpxADs=;
        b=A2kp50WpbGFjEQFFH0tV4X77DbZFwWDUi4kWp4Eeo4yHzxFK4beOi69S9AhDdGtoL0
         yaPHxP+WE7SEVlLXlvlpTfRNjfQwe0IynK9V84zx4mAPzF20Pki3FwTaEQcrBOfcIId3
         m7SNOLMpNAvylXI5hm4Ic9WjwHQFhHxwKx1sK9fGTdo9wPmOBrmJhkrbiH5cVIDRbjyC
         yjF43WVnPYSDAGqwAF49Q3DoUyge2MXdq39rYLwskvilbNvWudTr4BHMY3S7ICwLDYfk
         5+Yh/N0E/5S+bduyU/eM6XZSxrnHgqTn1yGZAPEKlq+xyDpAWHHD4m7CgGe6sqfH4z3k
         J7pg==
X-Gm-Message-State: AOAM531WQAdsg9qle0tKtidGtQVdC6qCrFLPQIQSArlBaeCj9mta6J/e
        mUMSSkrjemKf12nxowiZy5A=
X-Google-Smtp-Source: ABdhPJxw4EpP+UL7eYdf9x7CQ7NfimeR1q/caB9hXrpzphn1gdnPcw2V2aK1jjeRagrMqvE8Vtfd4Q==
X-Received: by 2002:a17:903:4052:: with SMTP id n18mr3189182pla.124.1644298186718;
        Mon, 07 Feb 2022 21:29:46 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id j8sm14806278pfc.48.2022.02.07.21.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:29:45 -0800 (PST)
Date:   Tue, 8 Feb 2022 14:29:44 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Christoph Hellwig' <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: Re: [PATCH] openrisc: remove CONFIG_SET_FS
Message-ID: <YgH/yC42RRbeJkiv@antec>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <YgC/8ng5WX6Nt104@infradead.org>
 <3744dcbbf2874875b023548aacdd8b41@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3744dcbbf2874875b023548aacdd8b41@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 05:14:43PM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 07 February 2022 06:45
> > 
> > On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> > > Remove the address space override API set_fs() used for User Mode Linux.
> > 
> > This ain't UML :)
> > 
> > > +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> > 
> > No need for the inner braces.
> 
> Since TASK_SIZE is actually an address wouldn't be better to
> swap the condition around (in every architecture).
> 
> 	return addr <= TASK_SIZE && size <= TASK_SIZE - addr;

Hi David,

I like that, it is more clear, I will update to that in v3.

-Stafford
