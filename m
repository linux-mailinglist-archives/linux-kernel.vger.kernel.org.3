Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A22530244
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiEVKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEVKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802FD36175;
        Sun, 22 May 2022 03:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE1CB80AC0;
        Sun, 22 May 2022 10:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62A4C385AA;
        Sun, 22 May 2022 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653213988;
        bh=UPbiNgGAwL5aqC80FZUlkF31vbhQbeH7p2NfiK7RD2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eA61M92tHgqSHqaH2+zWhVTbhBium3ZcdMEvpGQ2mcCdkiV08IntwH/YZspjp9Y6p
         l77Ybc5invmaeox5YhBnkU/2tDJHj2cncl+YbuxTshEaZ+N6GINcx49jQsdTWe1NR4
         XYDq3wSJH2EqNJd1zRAWsoDSsAlSFCkpqeZMqOI+9qSkU7NtluM+Iee7bibENAYuaC
         pI4xjE4EWVvCDlPBGKaXFkskkpsoFyzNg7MsN7KowN/tFErtrwCzsGimQT77RUGAPI
         0pmfvuiGnjRRsCUGDwf0uPhz8j3sxgS35sQSbBDFmrqEs7wKFhm55JSHTrFxYEle8w
         Kb5FTKuQm3M4Q==
Message-ID: <30ab0c63-4576-a9a1-8dd2-aa0e79ddd59f@kernel.org>
Date:   Sun, 22 May 2022 18:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] f2fs: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-93-Julia.Lawall@inria.fr>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220521111145.81697-93-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/21 19:11, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
