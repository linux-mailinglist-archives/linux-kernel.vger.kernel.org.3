Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AAF4AD225
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbiBHHZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiBHHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:25:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F2C0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A0FB81871
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C49BC004E1;
        Tue,  8 Feb 2022 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644305150;
        bh=5UMPgP3FCgOcckOEl4rLqJUApkfH1cOpstnmc2Ib2fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15esu/r8BwlpYdys2vW2Ra58+OHO/vhZE03SaMDiJNmk1hRmjtdHiLYM4GeleHrgj
         CwVr1NzW5bZWDWndy7okY4ZGsYo146vzDw1sCPFl3vDXm7aLSAZSfzewthCpdRAzoW
         XvBuaIkceIjgggD4/XdOM+5b0/PBaDkH1MRgCm28=
Date:   Tue, 8 Feb 2022 08:25:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref to improve
 performance
Message-ID: <YgIa+W6kAsWMUdj3@kroah.com>
References: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:19:20PM +0800, Guixin Liu wrote:
> This patch includes a modification to repace mutex info_lock with
> percpu_ref, in order to improve uio performance.

How does it improve performance?  What benchmark are you using and what
are the results?

These changes are quite complex, you need to better describe these in
order to be able to have them accepted.

thanks,

greg k-h
