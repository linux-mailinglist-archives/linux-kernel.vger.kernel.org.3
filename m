Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC6572196
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGLRNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGLRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1025591
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9EF617C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC56CC3411C;
        Tue, 12 Jul 2022 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657645989;
        bh=8mG46t3TuVyKPlLiLBSw4LoS7dMnhCqizqMq7SkWiDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9jmsa9y3YMNxAPfVRqN+3IqC4WPktDuJfU9VkMxUI6w1CF0jClLhGmBVg0CA5q8A
         PC9M8aSw6xiC3gEJrNgP4hudJV0njN9FUXx2vqZwh7lNWk48vfVUa6+PlT7ZCtftHg
         n6y5wiC38XdhIkhEmIdtkxCGKisqlBdf1NQTYQDZuUZYtB7OSlCxW3c8UaOtaa2ilv
         riJUrj16Nq9cjpPTVAq3rpjCRnidyd5Pr0zU0NgLdOsvAuAwfwxkDegKEk4aZe7M1Y
         Csy420H0TJ5SuddSFTfBmK58oAsnF61lDHzQei0Hc6Ee9aLSpl35PJPFslEN7/1NHB
         o3z8nEE9HAL7g==
From:   SeongJae Park <sj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     SeongJae Park <sj@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [sj:damon/next 20/20] drivers/block/xen-blkback/xenbus.c:184:38: error: use of undeclared identifier 'feature_persistent'
Date:   Tue, 12 Jul 2022 17:13:06 +0000
Message-Id: <20220712171306.75486-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202207121401.8Yis7IHm-lkp@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 14:22:23 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   40d1ef717dd762939c0a8734fd901ee517b50334
> commit: 40d1ef717dd762939c0a8734fd901ee517b50334 [20/20] xen-blkback: fix persistent grants negotiation
> config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220712/202207121401.8Yis7IHm-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?id=40d1ef717dd762939c0a8734fd901ee517b50334
>         git remote add sj https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
>         git fetch --no-tags sj damon/next
>         git checkout 40d1ef717dd762939c0a8734fd901ee517b50334
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/block/xen-blkback/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/block/xen-blkback/xenbus.c:184:38: error: use of undeclared identifier 'feature_persistent'
>            blkif->vbd.feature_gnt_persistent = feature_persistent;
>                                                ^
>    1 error generated.

Thank you for the report.  I fixed it as below and pushed:

    +/* Enable the persistent grants feature. */
    +static bool feature_persistent = true;
    +module_param(feature_persistent, bool, 0644);
    +MODULE_PARM_DESC(feature_persistent, "Enables the persistent grants feature");
    +
     static struct xen_blkif *xen_blkif_alloc(domid_t domid)
     {
            struct xen_blkif *blkif;
    @@ -474,12 +479,6 @@ static void xen_vbd_free(struct xen_vbd *vbd)
            vbd->bdev = NULL;
     }
    
    -/* Enable the persistent grants feature. */
    -static bool feature_persistent = true;
    -module_param(feature_persistent, bool, 0644);
    -MODULE_PARM_DESC(feature_persistent,
    -               "Enables the persistent grants feature");
    -
     static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
                              unsigned major, unsigned minor, int readonly,
                              int cdrom)

Note: The commit is only for my personal test at the moment.

[...]
