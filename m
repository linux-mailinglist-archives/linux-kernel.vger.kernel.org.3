Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395A4FBF19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiDKObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbiDKOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:31:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7399DEC0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0FWx0HZsH0sPQtYt0bY61ZA24d5GnyNIZ60QyVBhFHs=; b=hIbGH2gyk3jPjRzQLxHaxOWQ/n
        yXBYxxo8uEdUr3LWoythvjbnshPmcT1LeP68kZRKJzGoAUkCUDM6KRaLcI2ZCLVXCH5nHm8Ccw/Tc
        xoEtMs/AT0SznA8u2cqJv2TWtOT57qYnEgqefXTIc0Qy3MnFDgcITlBrgAeQKjSp4+HrpFbgqem2G
        1gxp5FzfHMH+DasRlv1AvhIdOsefeMb76N/mCFz07m/f6na1y7GUIwwo0Xib8kBAi7l9WLc/kK+kV
        xKNW74kI1YMooWE3CcMHXmChgSjbMB/B+lu9OW3AlIe/O4EvaZe4XwcTS/UEUQz8rzyOqYUr5Pj8Q
        2ZxxJRWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndv2K-009OjY-3n; Mon, 11 Apr 2022 14:29:00 +0000
Date:   Mon, 11 Apr 2022 07:29:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Liu Junqi <liujunqi@pku.edu.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leonardo Araujo <leonardo.aa88@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, sparmaintainer@unisys.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove D. Kershner from Unisys S-PAR
 maintainers
Message-ID: <YlQ7LBO5xS8ZmsEQ@infradead.org>
References: <20220409205857.32083-1-fmdefrancesco@gmail.com>
 <YlJ3ot74ZwfGx53i@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlJ3ot74ZwfGx53i@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 08:22:26AM +0200, Greg Kroah-Hartman wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ba405f6ec31a..3b7497359c2b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20188,7 +20188,6 @@ F:	include/linux/cdrom.h
> >  F:	include/uapi/linux/cdrom.h
> >  
> >  UNISYS S-PAR DRIVERS
> > -M:	David Kershner <david.kershner@unisys.com>
> >  L:	sparmaintainer@unisys.com (Unisys internal)
> >  S:	Supported
> 
> If so, then that means this list needs to be dropped and the entry
> changed to orphaned :(

It might also be a good time to drop the staging part of it, which
has been sitting there without progress for years.
