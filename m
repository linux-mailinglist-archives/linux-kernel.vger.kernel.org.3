Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8382574A13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiGNKFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiGNKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4512A84;
        Thu, 14 Jul 2022 03:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A8661FC5;
        Thu, 14 Jul 2022 10:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E478C34114;
        Thu, 14 Jul 2022 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657793090;
        bh=6Wo2lauWSqSzZPuEfigVqWFvR1npFnzL7C4Q4ThZpXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cx9t63is/MGqRmMLHXQzImt2jC0BFgtDzUC5F4INwef6dT20K9pKUYOGn5GTAf5MO
         k9zfGrttf8mCXF2X63TM++Ttvf7H9wbXqpYRyLg4qG1F4TP9XLTudmKigJb1ym1jMI
         8twNrtCEjb9xYSQcxc6Xx1VSdU0rJoAhcua5l80g=
Date:   Thu, 14 Jul 2022 12:04:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <Ys/qP2y1oj1nFOkq@kroah.com>
References: <Ys/kruf8DE4ISo8M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys/kruf8DE4ISo8M@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:41:02AM +0100, Lee Jones wrote:
> Pavel, et al.,
> 
> Not sure what's going on behind the scenes, but it looks as though the
> LED subsystem has been left unmaintained for at least 2 months now.
> 
> Does anyone have any objection to me stepping in as temporary
> maintainer until the situation is resolved?

No objection from me, it would be nice to see LED patches flowing again
into the tree.

Pavel, any objections?

greg k-h
