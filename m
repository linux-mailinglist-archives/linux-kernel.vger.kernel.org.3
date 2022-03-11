Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B874D5D09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbiCKIIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbiCKIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:08:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173125E5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E0CDB829B8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B6C340E9;
        Fri, 11 Mar 2022 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646986045;
        bh=fF65DkD4a2bE9G4hkIRLwERxisrywH22WBfSghyp7H8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LEIMdtKH+RuJ1l5tLAQp9YsP70C0tUGa7IB8Km6d8FZuUdOTawMz/6SisPpisEx8c
         uk97ncsM6cskBpaJybtnYGu/REDwmCOqPgoYXOjKohj3qZ2iyoKDJLCV8IZc6u35bD
         24DL2Zyo/zp7Up4sgBwLALlP3UY8l4AMnhjbuMyG8dL9RZFC+Y0m3LVQSkpc7W4vJy
         lodEZPEfk79eXsfrZCWfNapNe6Eg4Itn3hi8G7RnmHkJZ8TDLXMVjqOlalYjifacaA
         C2tH6pZkHm835rHSWtDIzkuUPW6HyIlkueSJXJZWPr1PW1eUJBSQMcGvsvzW6Jcd5L
         BsyaP3muzyLrw==
Message-ID: <0e4102f4-2f3d-ac4c-a630-c6f6d24dc156@kernel.org>
Date:   Fri, 11 Mar 2022 16:07:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] erofs: get rid of `struct z_erofs_collector'
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/2 3:49, Gao Xiang wrote:
> Avoid `struct z_erofs_collector' since there is another context
> structure called "struct z_erofs_decompress_frontend".
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
