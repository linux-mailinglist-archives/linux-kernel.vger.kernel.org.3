Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C2F4BDDE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378370AbiBUOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378339AbiBUOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:48:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471F22B11;
        Mon, 21 Feb 2022 06:47:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 750971F390;
        Mon, 21 Feb 2022 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645454877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=heGPXg3qCO+EHfdnC1k1H6nfU9ikF3EWDrl36av25yM=;
        b=WKd70t30A83h2o7eESCsU6rZx/lGi1pXNF6fxBnDCFLBM5zakJCfLoOC1jVpjrQoHi2hZC
        peU1X6Id+dN+8HzVubuFcyh2AcaEQS55V72XnHc1YJdgvHT+uy4mjNcJnMs4NJEI37d0DZ
        0iAVvr5iAXVZe6Ob2wwcpwUGDuLgE+4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19AE7A3B83;
        Mon, 21 Feb 2022 14:47:57 +0000 (UTC)
Date:   Mon, 21 Feb 2022 15:47:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Docs: printk: add 'console=null|""' to
 admin/kernel-parameters
Message-ID: <YhOmG9MxXMeAL+Db@alley>
References: <20220216203745.980-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216203745.980-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-16 12:37:45, Randy Dunlap wrote:
> Tell about 'console=null|""' and how to use it.
> 
> It can be helpful to set (enable) CONFIG_NULL_TTY so that the ttynull
> driver is available. This avoids problems with stdin/stdout/stderr of
> the init process. Howevere, CONFIG_NULL_TTY cannot be enabled by default
> because it can be used by mistake [see commit a91bd6223ecd ("Revert
> "init/console: Use ttynull as a fallback when there is no console").]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

The patch is committed in printk/linux.git, branch for-5.18.

Best Regards,
Petr
