Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293D57F883
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiGYDsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGYDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:48:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4596EDFC9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658720895; x=1690256895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yrPMBC49XmeVUG2WSGDw9BJ3OkpEIJhO9CdsvJ1opGI=;
  b=Zz2GkEhYg0MVrgvTfOXWJFBYUIPOabFzazjtrbGt1uUyvcWz0dWdbzxF
   /TXbJtBWWLLCUwHOyBqDUGLWdseO+F+6az/rqXOKJfjK6QKYOVwIZv7cv
   FYXO9TwJZCoNoYdC+ZD4QC2CoOJZuVIF2xfq2VvRZaNF8rcDnxBkUT1Lj
   L+wcNc+6LhAnPefpAkRqxpt327NhdCTnTRhnLaVNaXMroNurFaBY717xf
   +/0FshzZnTTNxkOi8Xz76x8V+ApP0mkj+EV/v5mSqn0E/9YWePO41hFCn
   YLxfOwv9jvgRNtw2hA/Rd+o/jUcx3m+nziBzhG25LS7NkTPtJsteb4ZqX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288786471"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288786471"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 20:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="926734660"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 20:48:12 -0700
From:   kah.jing.lee@intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, furong.zhou@intel.com,
        pierre-louis.bossart@linux.intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: misc: intel_sysid: Add the system id binding for Altera(Intel) FPGA platform
Date:   Mon, 25 Jul 2022 11:47:14 +0800
Message-Id: <20220725034713.648414-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YtmmJawYXeO0uxLU@kroah.com>
References: <YtmmJawYXeO0uxLU@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

> You want me to maintain an Intel-only file?   Great, where do I send my
> billing rates to?  :)
Updated, and will resend.
Too bad that's beyond my paygrade to approve ;)

Regards,
Lee, Kah Jing
