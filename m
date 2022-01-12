Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4442848C82A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355114AbiALQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbiALQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:21:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8FC06173F;
        Wed, 12 Jan 2022 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZxcrON9hmC2vN9kK0ta7qXEERljr+W7CEPSKNLlGTFQ=; b=DAZZmE8Uziug6hEBJNjgFgGgRM
        Aqj0mQPPYan0L97NlnSkMOhrqiLQZdHao/4m9272YgxxjWJltHglGk1Yioo3Tixmj8v4LS9k/x+P4
        RSD9Y6GQ5kJCI6SB5dJj3DyUanj1VnHdH0f+cPSrK73/ecwoc5e37E/7/+ls57+K3i/zlVovEj6np
        45ol+r4kAUtPWrmgz+NEda0EIeJSG4UavObk9GMyH6U/+nGjbvtM+PKzRONcwisGhNMb/es/MAE+H
        KpKJefbS3CMxe4HhfppAs77j9vF1jb2UB8K/K6XLk6qZLScf4MM2icBLXnjTKe132eXG9+xLdH5I7
        4McXnGjA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7gNF-00352z-Cf; Wed, 12 Jan 2022 16:21:21 +0000
Date:   Wed, 12 Jan 2022 08:21:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH 00/12] module: core code clean up
Message-ID: <Yd8AAd/mj5MX6CFE@bombadil.infradead.org>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 09:30:29PM +0000, Aaron Tomlin wrote:
> Hi Luis, Allen,
> 
> I had some free time so decided to make a quick start.
> There is more outstanding; albeit, I wanted to share what
> was accomplished thus far. Unfortunately, nothing has been
> thoroughly tested yet. Please let me know your thoughts.
> 

This is looking good!

  Luis
