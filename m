Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9A4F222A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiDEEW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiDEEWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:22:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08C532CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69530B81B7D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85417C340F0;
        Tue,  5 Apr 2022 04:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649132310;
        bh=DA6uMLvp/9YEcI9TewrH+tVj6sA1lozPencPzepXYCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5dW1I05rgukaZq1vTHq5kXrq62Y9a6G+Lz8OxCfzky1ft9SSCDnDFexN9sKb6/iT
         rc9tnobefW7WAvK0XN5bVdKjPyL0YIKvtm1/TXyUNuDEsnPci/sJow4+xbBbKWRm2q
         Mh3igWR7KY3YbFFuOMSQCtHpOvZfA5V9Rxidq8jgGjyrB214SwwudkS9cj+mxVWwUw
         bsa8y0c2zni67nvZsEB5IZ7EBFNB9ZAUX8X3fKJGUYopb2qgrjeEJva8PaPiFN+G9P
         syIittDkBx7FOp3/D2Tigx+zKO5xEa7mVafgWp6rYu6FhUeJnH0Z8WxgVCrbIfaV3y
         /gVgDbdsVC1kg==
Date:   Tue, 5 Apr 2022 09:48:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xuqiang36@huawei.com
Subject: Re: [PATCH -next] soundwire: stream: Fix error return code in
 do_bank_switch()
Message-ID: <YkvDEvoWMZJn1fIQ@matsya>
References: <20220307074039.117488-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307074039.117488-1-wangwensheng4@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-22, 07:40, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.

Applied, thanks

-- 
~Vinod
