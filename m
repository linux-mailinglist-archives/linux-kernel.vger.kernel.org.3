Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008D5503165
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiDOWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDOWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:00:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534C35DCF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c1FZCxRnGrJRubQTHg0gxw7lJJkUpVb13+tAV+wVPp4=; b=F4bXuotjQ+ssHvTmcX+QOYUpg0
        cyl53WDqm5KTR6JDiqEIysmuDYH/KRRqoIp8EGMXxmPcHpDbHNvu+IRsmG53sGvLDIM4GistcD8+6
        aqfa895ezHtgwMzfI8ODX7WIXiSntzmzef4tMIZL5FneyaWt714rUo4psi0y8Qz+WJFxXDDcvfhNM
        sI15VUVnkSB1UZJ9GJ2oHF3hf2fKW5ZKPyMRTrTGsuBY4TWM4Jn5Wvki1zTOkc8o+uIiz8PA+H1g8
        2iYs1BFEdyy2r+dRAivrHpVGp7TcNGCKCKO/CkgkBh3SBgE2T1uctDUPF+E3RqPcR71M/VuoSDHxv
        3MIDepXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfTxQ-00BRsE-Kj; Fri, 15 Apr 2022 21:58:24 +0000
Date:   Fri, 15 Apr 2022 14:58:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Wei Xiao <xiaowei66@huawei.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mcgrof:sysctl-testing 18/18] kernel/trace/ftrace.c:3068:13:
 warning: unused function 'ftrace_startup_sysctl'
Message-ID: <YlnqgBmtLhrgTlR/@bombadil.infradead.org>
References: <202204160113.5Pvywod8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204160113.5Pvywod8-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just posted a fix fo this.

  Luis
