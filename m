Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021A50A627
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiDUQtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiDUQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:49:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10C286E0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CEDW4QFVUVmRS1XivzuuB4o91aOMEyBw+0VZ8xctfhI=; b=XtDgtuGh/Adcz1oK9q/GOryKX3
        /BaMGnPBnmv2eRoUdXxQpAHjPSF8QEruXjM95Fw2S/gzb96X6blwfUG2iHdeieIyTZNT9If1+AWcl
        +7S0VUukVoQXtGOwh0mCzrs0bm/73aBjBrMPKAiuGXoX8esoEuF6rBKJejpDwUB+t1VuFSLPTQVZ5
        w5CLx9CWzAwdGwZ6b2SyJHOkaL7rL9Rw0PbGNBrpdsrb8xEdDMrINQiYTb82flFvhQYl40/q5PEll
        0pEJvxTCrrNe21vbJH10zEbBO252wUXIjXGWK3M5wqiz05lEaZwJhiKPucSt3cSOXKIZdspeCcra3
        pCWdUW0w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhZws-00EIh9-9M; Thu, 21 Apr 2022 16:46:30 +0000
Date:   Thu, 21 Apr 2022 09:46:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v4 4/8] firmware_loader: Add firmware-upload support
Message-ID: <YmGKZtdKqtNg1flU@bombadil.infradead.org>
References: <20220419231658.664388-5-russell.h.weight@intel.com>
 <202204201956.1mdJkUkr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204201956.1mdJkUkr-lkp@intel.com>
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

On Thu, Apr 21, 2022 at 02:32:00PM +0800, kernel test robot wrote:
> Hi Russ,

Russ, can you fix this with a new set?

  Luis
