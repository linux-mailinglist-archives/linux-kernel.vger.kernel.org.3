Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14B56B530
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiGHJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiGHJRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:17:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD328E2D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:17:22 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LfSKS3djjzhZbX;
        Fri,  8 Jul 2022 17:14:52 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:17:19 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:17:18 +0800
Subject: Re: [PATCH -next] ubifs: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Abaci Robot" <abaci@linux.alibaba.com>
References: <20220602055233.26161-1-yang.lee@linux.alibaba.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2df4d326-c59a-52d2-c5aa-02954ddca97a@huawei.com>
Date:   Fri, 8 Jul 2022 17:17:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220602055233.26161-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/6/2 13:52, Yang Li Ð´µÀ:
> Remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> fs/ubifs/journal.c:1221: warning: Function parameter or member
> 'old_inode' not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member 'old_nm'
> not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member
> 'new_inode' not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member 'new_nm'
> not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member
> 'whiteout' not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Excess function parameter 'old_dentry'
> description in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Excess function parameter 'new_dentry'
> description in 'ubifs_jnl_rename'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   fs/ubifs/journal.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 75dab0ae3939..16857d4e9aa8 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1201,9 +1201,12 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
>    * ubifs_jnl_rename - rename a directory entry.
>    * @c: UBIFS file-system description object
>    * @old_dir: parent inode of directory entry to rename
> - * @old_dentry: directory entry to rename
> + * @old_inode: parent inode to rename
> + * @old_nm: name of old inode to rename
>    * @new_dir: parent inode of directory entry to rename
> - * @new_dentry: new directory entry (or directory entry to replace)
> + * @new_inode: new inode to rename
> + * @new_nm: name of new inode to rename
> + * @whiteout: whiteout inode
>    * @sync: non-zero if the write-buffer has to be synchronized
>    *
>    * This function implements the re-name operation which may involve writing up
> 
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

