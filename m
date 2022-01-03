Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562F1483161
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiACN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiACN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:29:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D8C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 05:29:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA7E1B80EA9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 13:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EA5C36AEB;
        Mon,  3 Jan 2022 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641216582;
        bh=6/apdMsn/SOByxPv6kfP2aGLU5Tnss4W3E1xfNqRJwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yRW8KTCN2Q+qL4tY3dnK5fSFgjHRAg3tMUDbsrLR37H3G8OIL4Zi9gnLCG4GuF15Q
         /u6YhO4cv6vDMDnznyMj/Bp5D0TR71B0UawF+woKd8/NSDeQCY3G4xnO13Mhj11GmS
         js0j2tbjEMEk0Ybs1Ei3Sj0xmZd4l6HV7WZutBF4=
Date:   Mon, 3 Jan 2022 14:29:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: pi433: add comment to rx_lock mutex
 definition
Message-ID: <YdL6QzDK26W5WnaD@kroah.com>
References: <20211230152931.GA6157@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230152931.GA6157@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 04:29:31AM +1300, Paulo Miguel Almeida wrote:
> Checkpatch reports: CHECK: struct mutex definition without comment.
> Fix this by documenting what rx_mutex struct is used for in pi433 driver.

Please wrap your changelog comments at 72 columns.

thanks,

greg k-h
