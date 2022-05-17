Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E253952AC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352857AbiEQTlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352796AbiEQTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:40:56 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F143B1F2;
        Tue, 17 May 2022 12:40:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 20EDD6D6;
        Tue, 17 May 2022 19:40:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 20EDD6D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652816453; bh=Ou3j1RZTWr1/UBk0cg2Xc8HDIM1ea9rwGBB7aE9tYM4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n8dDpy1wBhxilRAqt63x6M2c2B5S2avBy3MUM10FT1ViZETaXOQRoV4O4ysYyHTRW
         wrZ6g6AoW90lnwq6JG/BReKFY6G4IeQvpy+O2GsIy4gwux+mDNMUhJZkH9ER4tyEXu
         2Ko1yCLsWvjKPFLxxWkwN4qq3kvma+T+ClBvhGyEOHdFvvaQqs0pdkkyo1//vCUyjb
         3kZtd3JnxcxyCG+H6S42JCwi2oSBxgWH2Nr4AOnwRoB4E3WhGHhDBj5rYkMjWLHlTK
         Icxfakwb0rYzLsLCPGe/aFvT/oS72cqQR8Ejxsus3a/WFinHjvA3fKag6KmXP/+lZn
         07Q5QVAgWzzZA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     gaochao <gaochao49@huawei.com>, alexs@kernel.org
Cc:     siyanteng01@gmail.com, bobwxc@email.cn, src.res@email.cn,
        wanjiabing@vivo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] docs/zh_CN: Add
 dev-tools/gdb-kernel-debugging.rst Chinese translation
In-Reply-To: <20220514100046.1683-1-gaochao49@huawei.com>
References: <20220513061035.605-1-gaochao49@huawei.com>
 <20220514100046.1683-1-gaochao49@huawei.com>
Date:   Tue, 17 May 2022 13:40:52 -0600
Message-ID: <87lev0ueuz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gaochao <gaochao49@huawei.com> writes:

> Translate dev-tools/gdb-kernel-debugging.rst into Chinese.

I've applied this, but one potential concern:

> Signed-off-by: gaochao <gaochao49@huawei.com>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

When you posted this, XiangCheng's Reviewed-by had not been seen in any
public place.  It was later offered, so no harm done here, but please be
sure not to add such tags unless they have been explicitly given to you.

Thanks,

jon
