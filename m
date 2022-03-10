Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF58C4D53C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbiCJVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiCJVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:45:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094D141E3E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1F37CE2532
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEFFC340E8;
        Thu, 10 Mar 2022 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646948654;
        bh=kpKY8cciXNYimz6VGZ+XcsAyRK4WuV83/ktm+3A9FbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ov8bG98Kf+j0TkMWz028+pgyCyEAvqzTWyGFQaFtD/sQ0KBq2RzTG0QiAWyCe8hw9
         6n/LrQ6DSrkh6wlOCeviORnY73c7EEMFNR/3KVIK90DwF0ypqRJ6QciJVKd4bPxY0j
         2e9JQTL+i8f0ZPuxzuj44oJEkv2rN4LYJkXxGnsQ=
Date:   Thu, 10 Mar 2022 22:44:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] coresight changes for v5.18
Message-ID: <YipxKx+P7Dyc70vS@kroah.com>
References: <20220303230301.255049-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303230301.255049-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:03:01PM +0000, Suzuki K Poulose wrote:
> Hi Greg
> 
> Please find the pull request for coresight subsystem for v5.18.
> 
> Suzuki
> 
> The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:
> 
>   Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.18
> 
> for you to fetch changes up to b54f53bc11a584713f79a704c70c488489f524b8:
> 
>   coresight: Drop unused 'none' enum value for each component (2022-02-28 09:51:40 -0700)

I have the following errors when pulling this tree and having the
scripts check the commits:

Commit 5340bf5df9d2 ("coresight: syscfg: Fix memleak on registration failure in cscfg_create_device")
	committer Signed-off-by missing
	author email:    linmq006@gmail.com
	committer email: suzuki.poulose@arm.com
	Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
	Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Commit 91a2f2941df2 ("coresight: Fix TRCCONFIGR.QE sysfs interface")
	committer Signed-off-by missing
	author email:    james.clark@arm.com
	committer email: suzuki.poulose@arm.com
	Signed-off-by: James Clark <james.clark@arm.com>
	Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Commit 7f4cd3375906 ("coresight: trbe: Work around the trace data corruption")
	committer Signed-off-by missing
	author email:    anshuman.khandual@arm.com
	committer email: suzuki.poulose@arm.com
	Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
	Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Commit 0ecf2c747437 ("coresight: trbe: Work around the invalid prohibited states")
	committer Signed-off-by missing
	author email:    anshuman.khandual@arm.com
	committer email: suzuki.poulose@arm.com
	Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
	Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Commit 8b6927d0adad ("coresight: trbe: Work around the ignored system register writes")
	committer Signed-off-by missing
	author email:    anshuman.khandual@arm.com
	committer email: suzuki.poulose@arm.com
	Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
	Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>


What went wrong???

linux-next didn't complain about this already?

greg k-h
