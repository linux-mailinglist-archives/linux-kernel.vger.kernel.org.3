Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915D4ACFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiBHD5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiBHD5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:57:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290FC0401E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:57:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso1415340pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 19:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YAAGEC4mtQgehGhRBxSWPNV/ixDQrX/TJPLjD1uwYuw=;
        b=N+pXg7HxURr5h7/2FeoEzeb/HQTtFUPcnvKaFm9GuOZ7/hpjqnW8AAYcCl1uo4XyKH
         8AMYTSZBMvyeVQBxwzV4IJYH4SUv201rUnv1VF0kNxAHiLxnTtWlMN5To4rdLDPGpjLi
         QW96FN0Qk9w4P0Pr11wyf8FGiCRgMDJlu6zrVk7I6LX+kUah0zPQqEJYITDOKZ0fSrYD
         Bu1t9UgZtK+UNNqUiHXVYXDmxefT4DDyNdwY+AdJOM/h8rOsUZsqOySaAbh/dg/NyUVU
         0QP0URDn5xd+wQFGoCL4MFLqalHVIGpNOh/c0tJMbwT4JXUcHYVL6cObCsVRI4HmbHqL
         fZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAAGEC4mtQgehGhRBxSWPNV/ixDQrX/TJPLjD1uwYuw=;
        b=EgsOiONj2OTBw7xXE0uXoBiR2yT4L1nKu4Ca9kRu2P4+9MWBUw1EgegJLlDygwpJTe
         zk8q3BhtZABeuaxI6qgEazVfRIYgk3MEHUMyWGvqBLBAlWLmFSkV9s7qpZIoE9U5VjtC
         OWZnnGR7mEYI1a/A8JfVOOHwvcrZp1Wd4jdB+8FKU4g/8Zb6wPOVZb+OQZYwjkmoekkG
         nMvithMouTVyFagIxjJ7rbpG55J4b/tH2QrhcWSApsY8BtQeAYScr7lC9wADMJqgX88n
         4661jfOwRFZx5mvbboFCtZqEexLtjzxIrmWL2sOOtkNLXzNL+4IwDUlZqbhZ4dvYgpRa
         MCyA==
X-Gm-Message-State: AOAM531soi5kgpogCRCVCXFErDl1o/WF54k0dWDr1TtKk1kAVIaNORF6
        vO1vxJpJOhcrf69FWlC/dMJ3a/7fzNJ/0zmV
X-Google-Smtp-Source: ABdhPJxSTiMQVE6NwGg0rJ19aZ0pF8F2J5f94lIkrCMugk+QWpmysGVRV3aUe1uz9u+/ojcNeccDjA==
X-Received: by 2002:a17:90a:744a:: with SMTP id o10mr2299408pjk.39.1644292623929;
        Mon, 07 Feb 2022 19:57:03 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id g2sm13531007pfj.83.2022.02.07.19.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:57:03 -0800 (PST)
Date:   Tue, 8 Feb 2022 16:56:58 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove need to recompile code to debug
 fifo content
Message-ID: <YgHqCpet2TMQAz9L@mail.google.com>
References: <YgCj2P59AbFFmnbA@mail.google.com>
 <20220207100601.GF1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207100601.GF1951@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 01:06:01PM +0300, Dan Carpenter wrote:
> > #2
> > In the past, it's been pointed out to me during code review that I tend
> > to add code comments which could be omitted. In this case, the for-loop
> > seemed a bit odd without explaining why it's in there. Let me know if
> > you think I should keep/remove it.
> 
> Remove.  Everyone knows what dev_dbg() does and the "read from fifo"
> vs "written from[sic] fifo" is built into the function name.
> 

fair enough

> >  int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
> >  {
> > -#ifdef DEBUG_FIFO_ACCESS
> >  	int i;
> > -#endif
> >  	struct spi_transfer transfer;
> >  	u8 local_buffer[FIFO_SIZE + 1];
> 
> You did not introduce this but we are potentially printing out
> uninitialized data if spi_sync_transfer() fails.  Please initialize this
> with:
> 
> 	u8 local_buffer[FIFO_SIZE + 1] = {};
> 
> Do that in a separate patch, though.
> 

good point, will do. Thanks a lot :)

thanks,

Paulo Almeida

