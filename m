Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92C4BE756
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381286AbiBUQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:49:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381245AbiBUQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:49:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F087237C9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D6EB81370
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3745C340EC;
        Mon, 21 Feb 2022 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645462141;
        bh=VkOQJYc8KqiwNs/oTrD7br3BqrXi/+fD1K1jXWEAuBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt8UpGlpbXQ4np7cjjQBY9jbElRxQye+se+4ABxrRQF4su5+S3uiS1H3MBtnOGWJ7
         HY2epmlBnlzkp4l15uBeKDVXPc0j1A40fhYx6eq80S1+8MR7KleEmjRjeYAkQD7X1f
         ajaRs8MGgBqrjEuAnS5c4xUIJV/OxkrWKAfH7+1E=
Date:   Mon, 21 Feb 2022 17:48:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [GIT PULL] fsi: changes for v5.18
Message-ID: <YhPCRyv0ltprWsS1@kroah.com>
References: <CACPK8XeofS1jPtKcFgqmwaXfiH+GPCg7c8LhQx8N9m=xOwy=XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XeofS1jPtKcFgqmwaXfiH+GPCg7c8LhQx8N9m=xOwy=XA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:35:53AM +0000, Joel Stanley wrote:
> Hello Greg,
> 
> Here are some FSI changes that I would like you to pull through the
> drivers tree for v5.18.
> 
> They have been on the list for some time and all have had review.
> 
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.18

Pulled and pushed out, thanks.

greg k-h
