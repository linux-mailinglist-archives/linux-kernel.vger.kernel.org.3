Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F905389EB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiEaC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiEaC1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:27:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0462C7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B020CE128D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0555BC385B8;
        Tue, 31 May 2022 02:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653964036;
        bh=/jTuVM6LQOkDhYQ27dssQ0//PORfYGXznbKphQM81yI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MSKhoeU16oCEC9qsEukm6XYeEDtlPNhEB4f5h2JakvKL0ViqAbiL86SalCB2FUl7S
         PZ6Vw1sOqqsN71xlZ4RVeWicxejcyLgMmEJTW4eFemhd7sby0Jze+vREkAl4b5V2Wk
         2yOAJ4KsIFH9q6aysnWsFDrSPioyNSqy5Nw2YnswOxIoqOkxg908kS6CJ53mscqefI
         3hMkSbZoUreqOJu4qZJUQy3bHIsozgCkuxzi2SXPC3l61zs8InoTJIoZ3OHM0hqmVw
         L8NTmJEXMLLoA0Oic7pa0zNjGxkswgpi6iLHOvnB4kGHxRvik2SxnhdvpkIjM+8MZV
         4yKxm5XuAnJ4Q==
Message-ID: <474be4e3-59e7-b90f-0bde-642c2c67f272@kernel.org>
Date:   Tue, 31 May 2022 10:27:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: fix 'backmost' member of
 z_erofs_decompress_frontend
Content-Language: en-US
To:     Weizhao Ouyang <o451686892@gmail.com>,
        Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220530075114.918874-1-o451686892@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220530075114.918874-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/30 15:51, Weizhao Ouyang wrote:
> Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.
> 
> Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
