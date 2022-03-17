Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA544DD0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiCQWgY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Mar 2022 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCQWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:36:22 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3ACE885E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:35:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9F3756081112;
        Thu, 17 Mar 2022 23:35:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nVRRisT8TJYL; Thu, 17 Mar 2022 23:35:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3C6A56081110;
        Thu, 17 Mar 2022 23:35:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r1KNl6A7pLtB; Thu, 17 Mar 2022 23:35:01 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 180AA6089354;
        Thu, 17 Mar 2022 23:35:01 +0100 (CET)
Date:   Thu, 17 Mar 2022 23:35:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     libaokun <libaokun1@huawei.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>,
        chengzhihao1 <chengzhihao1@huawei.com>
Message-ID: <2008739324.156347.1647556500875.JavaMail.zimbra@nod.at>
In-Reply-To: <a4f8bfff-26ee-95f8-db3c-91ca860a32bd@huawei.com>
References: <20220215040736.2839939-1-libaokun1@huawei.com> <dc55e8b3-7d22-6024-374d-4ed126e18c42@huawei.com> <157336576.152785.1647468012272.JavaMail.zimbra@nod.at> <a4f8bfff-26ee-95f8-db3c-91ca860a32bd@huawei.com>
Subject: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size
 computing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: rename_whiteout: correct old_dir size computing
Thread-Index: CY5uA77SPI4VOph1RsZDxVqHFhcrLg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "libaokun" <libaokun1@huawei.com>
>>>> +
>>>> +		/* Add the old_dentry size to the old_dir size. */
>>>> +		old_sz -= CALC_DENT_SIZE(fname_len(&old_nm));
>> So you basically reset old_sz back to 0?
> Yes, reset old_sz to 0 here.

Okay, makes sense. Patch applied.

Thanks,
//richard
