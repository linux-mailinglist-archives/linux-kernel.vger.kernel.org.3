Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EE4DA774
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbiCPBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbiCPBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:46:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDA39BB1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE493B81A0C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26EC340E8;
        Wed, 16 Mar 2022 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647395106;
        bh=vpvK34JgD/Hy/2DxTDfEm3ZyCtrp5fVfbCVJ8tXBe64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=btTYa+moocnIpxfd6M3ua1Ui/3qo56O73y3EK1nfHY6J0VlbzlrFeZEm1HkkkFf9A
         QQnyFsy+uPwFep4tJ6Y8wE6FEXPDwv2o2UiDo6WmGDlA3sDqRekXvMgHdC6XiBtpeS
         VANx2NwbeoEjQQiAeGf2gitivxQ3QHwUxMEYIF/Bof48OE3fVUr6ePEVG0nDy73twq
         nTnMppfZ/ZkDG6FnDhcn5w5Juf1aQc+9nF1WtzpP1lrICW5gUrompjZaax8KSbWZgH
         yq/TTDxp3KigoU+RyoWea27Nz+FluMsS1yT685nortjh9K0KPcJ93Fk0x0GdyN2i6f
         AYSocb0EQ7O8g==
Message-ID: <871e075f-9c11-7baf-c3c4-8541fafa101b@kernel.org>
Date:   Wed, 16 Mar 2022 09:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] fs: erofs: add sanity check for kobject in
 erofs_unregister_sysfs
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220315132814.12332-1-dzm91@hust.edu.cn>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220315132814.12332-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/15 21:28, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> is triggered by injecting fault in kobject_init_and_add of
> erofs_unregister_sysfs.
> 
> Fix this by adding sanity check for kobject in erofs_unregister_sysfs
> 
> Note that I've tested the patch and the crash does not occur any more.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
