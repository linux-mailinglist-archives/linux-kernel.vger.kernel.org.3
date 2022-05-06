Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6806851D41F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390393AbiEFJV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345115AbiEFJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:21:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36268633BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9092DCE34FB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F20C385A8;
        Fri,  6 May 2022 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651828690;
        bh=awhJ8l5JhhFRjUh0c9LRCv6B5z8ZgUJuu/w8ZSvtqEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVx9nKIuoqCAexlyssWHy47LWX5AWtJSf8LaQhYmhhqnJUuKZlEZ9kCbMdBElxSyr
         fL0tOWCyfjM6U8u3T440fzbXgjezwFvLYzba7zCw2KYT+KiswhLak7LaBnt3p9UeN3
         CJyEioVM91DUSvshTFfj7JmiHXUjtSmnU0PnxliE=
Date:   Fri, 6 May 2022 10:00:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/2] Documentation/process: Add Ampere contact to
 embargoed HW issues
Message-ID: <YnTVs0k8wNeBaGfm@kroah.com>
References: <cover.1650995848.git.darren@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650995848.git.darren@os.amperecomputing.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:29:56AM -0700, Darren Hart wrote:
> Do some trivial cleanup and add Darren Hart as Ampere Computing's contact for
> embargoed hardware issues.

Thanks for agreeing to do this, now applied.

greg k-h
