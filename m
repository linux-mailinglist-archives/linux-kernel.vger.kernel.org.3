Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F64C4626
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiBYNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbiBYNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:24:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2528B1A6F81
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B310E61D40
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0B2C340E7;
        Fri, 25 Feb 2022 13:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645795418;
        bh=ld9Jc3A7mvcWAAT4SlTsx2l5buIvb2/d6/lQVL2Pd7o=;
        h=Date:From:To:Cc:Subject:From;
        b=Dwxetay/v3zkmdbSdyq7m3BNn0/BU3aQSxq1Am5IQ6wOe2TMAwkSZDbI2xseccZXI
         yn75va4jCr0hY5xRPkItPNOP2gOnG+NmrVSyttsdjn7cPhJpJq/4mhcKB1SyXNcj6t
         Q/qOOKcaLrr9r3u9ODlxNf6egOfTCJCpWhvmPdo4=
Date:   Fri, 25 Feb 2022 14:23:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fix for 5.17-rc6
Message-ID: <YhjYV3rG8Qy/oc0y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.17-rc6

for you to fetch changes up to d8f7a5484f2188e9af2d9e4e587587d724501b12:

  driver core: Free DMA range map when device is released (2022-02-22 08:40:02 +0100)

----------------------------------------------------------------
Driver core fix for 5.17-rc6

Here is a single driver core fix for 5.17-rc6.  It resolves a reported
problem when the DMA map of a device is not properly released.

It has been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Mårten Lindahl (1):
      driver core: Free DMA range map when device is released

 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)
