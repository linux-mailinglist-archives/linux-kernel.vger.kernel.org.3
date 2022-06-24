Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FC55A458
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFXWYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 18:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFXWYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:24:13 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECAB88590;
        Fri, 24 Jun 2022 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=wI3llXZ89/86O4qf5yhKKxw89rBdjGt6UL5y2
        /VdiRI=; b=Iz9v1P3z4/dW/cccl7Kyx37MsCCi1Ka1cZM6oeaVRwnw928ZqzIQP
        hXhTaHsUFn1PZGwe8GvBS8H88OpYle8+s8OjwIYzuJNJioVa9aXsbNkXWslBsqqY
        70VRj5UX9XAcaD1KDAjXIR4K2Y3BMqTasUYJxDx0z9nYkPlnvkwgSE=
Received: from bobwxc.mipc (unknown [120.242.121.172])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAn2GRuObZi_DEGAA--.16180S2;
        Sat, 25 Jun 2022 06:23:44 +0800 (CST)
Date:   Sat, 25 Jun 2022 06:23:42 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] docs: rename Documentation/vm to Documentation/mm
Message-ID: <YrSQhNYvcZfTRUnU@bobwxc.mipc>
References: <20220622132258.457734-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622132258.457734-1-rppt@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=bobwxc@yeah.net;
 h=from:subject:message-id; bh=VgmFHXt64+nXwE358/BSAtg1wDlAN/7IkKogMn+pOog=;
 b=owEB7QES/pANAwAKAbZbKBIigrCFAcsmYgBitae+1GspiO9tJ2PoZI2fglKFzyee8ot0neMYr9hQ
 UE4bG1yJAbMEAAEKAB0WIQRFujdTmQmloK0WXU+2WygSIoKwhQUCYrWnvgAKCRC2WygSIoKwhc8MDA
 CaoqWKkOIRasV9YGh+5x7pZ3j/IJD/kBk/VDRVJpHJY3AwtkW+JDXPjxZZIGG1fqy+dd5yLqjH8YS6
 kwMFQrmeogNqlfNXpE8IynlU7LqNAAaIoeSIEQE1LgdCFSsVNXcldBOnuZ8aiArlXPe0hdtL9GeifF
 o4i+GQfw7k88/VFpn3DrqfoWYu5n6SXVEth3812Z38he6W4cVMoYM9M1wNRzG87oZwL1vY2nh3ZcyY
 yYq+5Er6lzsJD3f+qewdiZckZTW1mLhspo5nNFL2y1ZY+K2ztn6NLOKn3cfvhmE2qQhOGICGWzEYMl
 U76kd5JV+yuRB9fNwZV34J1whhGqPR6VRl8mmXzP1VOIqmOG2rCYPLXaWCt900E0ldZ7EVzoESM/zD
 JztI2G8Y5daYSD+kWtRIhoVNTsn1Lfv9yGp0yMUCYJmOGfHvSMySVzd16lPbRY5Z3lc6JkQAu53Ah/
 zeW95ef1AQn9bdpaRS3a7Ck9suBSWcOKyW3xa9GMUXuRc=
X-Developer-Key: i=bobwxc@yeah.net; a=openpgp;
 fpr=2BF2A4AA2F0730C3279ED01D32684A40BCA7AEA7
X-CM-TRANSID: LCKnCgAn2GRuObZi_DEGAA--.16180S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5Kw1UAF1fGF4xJw1fWFg_yoWxKrb_ua
        yfJF1Iyr47AFW8KrsrWw4ayr1kXrZ29ayUXrn8tFWrAF9Fk397KF9Fkw1Fva15Xr4kury5
        W34rZrZ2kFyagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb0kYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42xK82
        IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUU3rc3UUUUU=
        =
X-Originating-IP: [120.242.121.172]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 08:22:58AM -0500, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> so it will be consistent with code mm directory and with
> Documentation/admin-guide/mm and won't be confused with virtual
> machines.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---

Hi Mike,

After applying this patch:

$ grep "/vm/" Documentation/translations/zh_CN/mm/memory-model.rst -n
132:  以允许设备驱动程序协调与设备内存相关的内存管理事件，通常是GPU内存。参见/vm/hmm.rst。

Please replace '/vm/hmm.rst' with 'Documentation/mm/hmm.rst'.

Thanks,
	Wu

