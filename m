Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE41563C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGAVyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGAVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:54:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14B6F37D;
        Fri,  1 Jul 2022 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kwaV21aI98J9eQWnMTeGY4/ZCRsVEnaxnrHura0TvR0=; b=J6tNZrlo5hXk9SCHaMlucvUinC
        Gj0utyF0ftc2HMNo+NNQ7dcF3FRTw/BeYfL0Ef1QMF0fpuDG+nuZKfW+mQ+fD4qVg4u8LrDGelg3q
        IOOV5eJsVt8ChzS/qwtDZkZBQ9GRtqQQRv+NkptTQy4IxI+18n2kMwwbmmrAGZp0skPsW00OLXo7P
        3RBlLN3sqdZ2eUqrxeb4Z0nabCpbZ6bFHSUQQnQs5Pb2Vq98cxHcZ5h5/pUSPhp58DBj74zQcMuUZ
        0yp1STiTzrVimsk99B1bAU6WK21NoVvpYI1hunqFWq+7YCFnNqGojSccs8Ye4giYcJ2XhXpIpNT7q
        6DcJV3iA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7Oah-0076wh-Cd; Fri, 01 Jul 2022 21:54:19 +0000
Date:   Fri, 1 Jul 2022 14:54:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] module: Add support for default value for module
 async_probe
Message-ID: <Yr9tC2TDVKiJVTgY@bombadil.infradead.org>
References: <20220604010101.719508-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604010101.719508-1-saravanak@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 06:01:00PM -0700, Saravana Kannan wrote:
> Add a module.async_probe kernel command line option that allows enabling
> async probing for all modules. When this command line option is used,
> there might still be some modules for which we want to explicitly force
> synchronous probing, so extend <modulename>.async_probe to take an
> optional bool input so that async probing can be disabled for a specific
> module.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Queued up thanks!

  Luis
