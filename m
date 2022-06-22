Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5889F554AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiFVNTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiFVNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989F2F01F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4A161A39
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE751C34114;
        Wed, 22 Jun 2022 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655903988;
        bh=OhOTyLxShRkYuk3tq5f2dyvgfsUrl0xUbORq44uX4u8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fpq3FE4OJyOqFWuWfgkG4pYpYkxE+7NU7m5xPyHyGyrdShQg9OQbGZyzIgmaXhB72
         ThsvJKvsHc1H40J07daPKw8j3VgyQJCL5GZ41XM4QhOlxsLP4w0v3iD4yTfKOnvI9z
         KVzAs7Xr4E3nogpACxZrK4n71PoarW4J1/+66vE4XrZ9JrVYYOKlz78qRDo58/exhr
         9dpPbxTrdfcrQxYEL5SfGJHXgLlKFLSP1QcRcew/MBHKK3dHSLb119cpN8khhm+3TG
         DHK4kdUFCfWyUlkvX/NFHfXL4f8qcoMVvdPWyrfjTwpgztKAPSa67YeIVh1sCHvTyp
         JuGD2rK6bnUPg==
Message-ID: <81ebfa7d-e294-409c-a3a6-5acb6daeb03f@kernel.org>
Date:   Wed, 22 Jun 2022 21:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] resize.f2fs: add option to manually specify new
 overprovision
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12@xiaomi.com,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
 <20220620084810.24885-1-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220620084810.24885-1-qixiaoyu1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/20 16:48, qixiaoyu1 wrote:
> From: liuchao12 <liuchao12@xiaomi.com>
> 
> Make.f2fs supports manually specifying overprovision, and we expect
> resize.f2fs to support it as well.
> 
> This change add a new '-o' option to manually specify overprovision,
> and fix to check free space before grow. Otherwise, after grow,
> kernel may report below error message when we mount the image if -o
> parameter is specified during resize:
> 
> F2FS-fs (loop0): invalid crc_offset: 0
> F2FS-fs (loop0): Wrong valid_user_blocks: 16404, user_block_count: 13312
> F2FS-fs (loop0): Failed to get valid F2FS checkpoint
> mount(2) system call failed: Structure needs cleaning.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
