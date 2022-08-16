Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD5595A86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiHPLqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiHPLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:45:32 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBEB99E5;
        Tue, 16 Aug 2022 04:18:37 -0700 (PDT)
Date:   Tue, 16 Aug 2022 19:18:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660648715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Slj6KW7j+aRbwOvxR1ThXixlcUq7nqFr9P+t/YYZJcc=;
        b=BaliCKMl2s0UI1dHshRH3V+gFHeYLfnKcoPFxFMXm334CdYAlO10KFTqyU9eSp2RrP2ZWK
        UUBxhaSPJ3z2xQPRRcyUAUlZOOZLkNVx7odMzN7qSKxppDpX1xK8qvU/443eFSatnLKSIk
        1kEUjoDdnI7A9PV9lr6jpvbMPxgUB7Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     alexlzhu@fb.com
Cc:     corbet@lwn.net, bobwxc@email.cn, rppt@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH v2] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Message-ID: <Yvt88zVAtuCvxGZP@bobwxc.mipc>
References: <20220816022621.253778-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220816022621.253778-1-alexlzhu@fb.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

话说 alexlzhu@fb.com 于 2022-08-15 (一) 19:26:21 -0700 曰过：
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> Improve grammar on MM concepts documentation.
> 
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>

I have no authorization for this document, so only

Acked-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,

> ---
>  Documentation/admin-guide/mm/concepts.rst | 138 +++++++++++-----------
>  1 file changed, 68 insertions(+), 70 deletions(-)

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

