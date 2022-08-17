Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E3596772
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiHQCbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiHQCbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:31:44 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF46999B7B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:31:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660703502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlTzxQqE79Q9RIB87dn43uL+LcDuOAdW5kHAEE4gy6Y=;
        b=nxffWsIkVsRMwm8+MLmB1eInSqSCenUn1OL2lHjSZ2nOUF1nvW860KUZQLwxLTWwbj/DqV
        lZaWwAHxmI+ynG7yXWoI1ehTWxeklbr7T+FFjnrtyCx6hva+YLt/sBInMBR1ch30Hp3V56
        uH3eVsEhviSym7raqyBosK2Guc5np70=
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] mm/hugetlb: fix WARN_ON(!kobj) in
 sysfs_create_group()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220816130553.31406-3-linmiaohe@huawei.com>
Date:   Wed, 17 Aug 2022 10:31:07 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA374889-2C8B-4D8B-9542-A760267F00E4@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-3-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> If sysfs_create_group() fails with hstate_attr_group, hstate_kobjs[hi]
> will be set to NULL. Then it will be passed to sysfs_create_group() if
> h->demote_order !=3D 0 thus triggering WARN_ON(!kobj) check. Fix this =
by
> making sure hstate_kobjs[hi] !=3D NULL when calling =
sysfs_create_group.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

It=E2=80=99s better to add a Fixes tag here.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

