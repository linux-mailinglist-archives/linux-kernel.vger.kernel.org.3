Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B54679FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381611AbhLCPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352696AbhLCPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:11:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EEAC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B8D6CE272D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C68C53FAD;
        Fri,  3 Dec 2021 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638544070;
        bh=lGlWskb+ohmBP+KnDzbN0ob8ExRxek+/Edt3jRgh6TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cc1X8INK21wvbGeAJlK8Mj5xr3V/qvmwEBoMrFluT3QYuBJtXRyoqxF2aiakbnxcP
         SraZ5sneHADzfgXaop0RRMRZLgqH5o6hyDO4OvJipHKJRFUwnGvA922zwGnEKBd7w4
         +dDGqQMaJJCUqQ0OSwgsfrlPb5pnvV/csvSCcYuRvuGCdvP4gJOP5boanRNLkIxaug
         8dOpYKy0EWDlsgFo7jWchvY2Glw5NO8yCTykF4XnprBuiUgu+e1WVBsji9DLskVSQY
         rTNw07wap2OB+YcKWTUAiiB9uAzF9qIYqc9IP41AlrTsrNI0n4ur3Fuu8L/a5EZ99+
         aXfbrG0hCsZAw==
Date:   Fri, 3 Dec 2021 07:07:47 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     =?utf-8?B?5pu55Yab?= <caojun@uniontech.com>
Cc:     axboe <axboe@fb.com>, hch <hch@lst.de>, sagi <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add Intel 760p/Pro 7600p nvme disk
Message-ID: <20211203150747.GB3839336@dhcp-10-100-145-180.wdc.com>
References: <20211202030230.17507-1-caojun@uniontech.com>
 <20211202175539.GC3836713@dhcp-10-100-145-180.wdc.com>
 <tencent_5722FB4254C69E931F449D17@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_5722FB4254C69E931F449D17@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 09:37:45AM +0800, 曹军 wrote:
> When I use two Intel 760p/Pro 7600p nvme hard disks under the 4.19 kernel system, there are two problems, sometimes only one hard disk is recognized, sometimes two hard disks are recognized, but the serial of the two hard disks in sysfs is the same
> 
> 
> &nbsp;I looked at the latest 4.19 kernel and did not fix this problem，so I want to merge this patch into the latest 4.19 kernel

Please see the rules for posting patches to stable:

  https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
