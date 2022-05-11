Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62B523FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiEKV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346685AbiEKV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B05DA37
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCBCB82634
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0078DC340EE;
        Wed, 11 May 2022 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652306209;
        bh=kqUEltR8EfFcnVZnB5G3XK4LKAszfFkkPhLBrSO6fJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WFxU5RkioUjugDVCyRcINEMq8I9Lkd9Xtvf8iCdrazJRyFFmr46s7WRTiuxgk3ohe
         a/ruZM4hWAtJqclYV5YAE+5lXAeAXZYq+JhrZBqoLdV6Qvv+mStC467fLQat9pRlIg
         MDLQP3rsxVzAgDMxlBY4RIJPxXuzOnDd91dLjMLo=
Date:   Wed, 11 May 2022 14:56:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Add config option for default panic_on_oom value
Message-Id: <20220511145648.3c421ff592df32766319ea2d@linux-foundation.org>
In-Reply-To: <20220511183400.47940-1-eajames@linux.ibm.com>
References: <20220511183400.47940-1-eajames@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 13:34:00 -0500 Eddie James <eajames@linux.ibm.com> wrote:

> Add the option to kconfig and set the default panic_on_value.

Why?  What are the use-cases and how does this benefit our users?
