Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64855450F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiFIPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbiFIPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:37:14 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427991498C7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:37:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 20F78732;
        Thu,  9 Jun 2022 15:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 20F78732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654789028; bh=jXFbEEfMo94jqkW6tuNpH8AsDAPWTArR6H5stWd/n8g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kgRtuxKiWJBVN9UT+ESqsqC2HeVBDChFxPwYco0a3vXwOXGghtp62gbO8MYnC2AS/
         VrYk+eYdw3eS0ZOOYyU7EDtni7hQNZFA2PpB0/NbDM5fyQtoaBWHIfNM8EaktE7/qJ
         /57smUCigcNIbTNal9ngJEEWqc9nQ9omtFNToWqwfe+pTqi4udNP+lbQ+arN16D0C0
         qPeRx9ETKeB/LKQ01bRS9U0TIUQ7Sc952gvek8UwoRCCxnfNTreVpBwRXZmyo7fePY
         cXQPTj1KqzCTkUJSP/unN/hua8S9FCDiDVcq51hgng//JR3cvF+UpdL4SxEZVis63X
         iVQT2HuTCpD/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     chenhuacai@kernel.org, kernel@xen0n.name, deller@gmx.de,
        linux-parisc@vger.kernel.org, vincent.whitchurch@axis.com,
        richard@nod.at, linux-um@lists.infradead.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, vgupta@kernel.org,
        sergey.matyukevich@synopsys.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com, zhengzengkai@huawei.com
Subject: Re: [PATCH] Documentation/features: Update the arch support status
 files
In-Reply-To: <20220609025656.143460-1-zhengzengkai@huawei.com>
References: <20220609025656.143460-1-zhengzengkai@huawei.com>
Date:   Thu, 09 Jun 2022 09:37:07 -0600
Message-ID: <87pmjh4zmk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Zengkai <zhengzengkai@huawei.com> writes:

> The arch support status files don't match reality as of v5.19-rc1,
> use the features-refresh.sh to refresh all the arch-support.txt files
> in place.
>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>

I've applied this, but added a note to the changelog saying that the
main change is to add the loong architecture.

Thanks,

jon
