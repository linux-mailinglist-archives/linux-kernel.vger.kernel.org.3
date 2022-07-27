Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737A6582A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiG0QGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiG0QGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901B2CDF8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93FD6198A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D9C433C1;
        Wed, 27 Jul 2022 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658937966;
        bh=R2p0of76K8a2ZHcxkNUvLgEJAOqcDlPPdWFYl5pfpn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+tfQY0Je0Ydf+R9oOH9HgmZYYW5++5a6jmKQ/bX/yFvQ9opacM49gpQj9VVkHMBs
         Bb5GQTfbi3UwefOKBhzmOMc76Qxuc10xCc2XQAWRhm3LQ6HjIer5SI4x5ERU6iWk3d
         VZyWC1XSPzBh9bSa54RabWnPEzlo8f8jLNJB/lHc=
Date:   Wed, 27 Jul 2022 18:06:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6655: Rename byOrgValue to reg_value in a
 macro
Message-ID: <YuFia1Z7tJrxbIwQ@kroah.com>
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
 <83920d919acd7596488943182f37132e479d70f4.1658333350.git.philipp.g.hortmann@gmail.com>
 <YuDfjwHJN6n/CZ4i@kroah.com>
 <4d1e2294-a3b7-972b-f021-cecee8779f1b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d1e2294-a3b7-972b-f021-cecee8779f1b@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 05:54:04PM +0200, Philipp Hortmann wrote:
> On 7/27/22 08:47, Greg Kroah-Hartman wrote:
> > On Wed, Jul 20, 2022 at 06:24:32PM +0200, Philipp Hortmann wrote:
> > > Fix name of a variable in a macro that uses CamelCase which is not
> > > accepted by checkpatch.pl
> > 
> > Why rename something you are about to delete in a later patch?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I need to rename this variable. Does it matter if I do it in first or last
> patch? When doing it first I do not have to review so much checkpatch
> warnings.
> 
> Or is it OK to convert the macro to a function and rename the variable in
> one patch?

Convert and rename at the same time, that makes it easier and simpler
overall.

thanks,

greg k-h
