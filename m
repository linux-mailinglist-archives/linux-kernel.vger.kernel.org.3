Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F550A84D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391508AbiDUSqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386752AbiDUSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:46:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772324BFE7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WwmKCUcTVJEpKGDzOwZv9awvSAVxMAGshtSl28dGNP4=; b=IO+4yM+KPnMUxWhbuFB4k6qQbn
        zs7GTMIZWJAL1P+eK8Kodqy5RYbd4Ph2eKyRwRI9lwGXUdcq/UY/B7pnXS3NpJUz9/pysk6wCzXQo
        pmFLK9vyjfbauHpjhJ7w4tWyqvmjNY3yrK/llCEfzQ0aqcvXoB2U8GvnFnf+fC/4j9rp0CGSMYOhG
        ah80KFzP/Yr1sxddXY/UY6593zOv2XppTVB4KsOB/hbR/p3EgS2Y/OuTZjXprKy9zHlvU0l+9TAMZ
        HRcqI+znjVgz6SxTty2WdqC3jYtf1FhydXgojCgCeZktNBafCSnoUTieYw3f8qeK/S1YeMvw4gzpZ
        02uYJiaQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhbm6-00Egih-DG; Thu, 21 Apr 2022 18:43:30 +0000
Date:   Thu, 21 Apr 2022 11:43:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mcgrof:sysctl-testing 21/24] kernel/trace/ftrace.c:7884:9:
 error: 'saved_ftrace_func' undeclared
Message-ID: <YmGl0ugY3hLcqUIS@bombadil.infradead.org>
References: <202204161203.6dSlgKJX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204161203.6dSlgKJX-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 12:30:45PM +0800, kernel test robot wrote:

OK I've fixed thist thanks.

  Luis
