Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177F57F4AF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiGXKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGXKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:24:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178C13F20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 03:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1114AB80D49
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B23C3411E;
        Sun, 24 Jul 2022 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658658270;
        bh=5DOYKUlvLL6Z7uuzGBjXxGmpXeL6qIJ3XVc6PX9tsnk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Raxrsc+7mEDMv1BPbOuxpY1ikf40AGeqxzLOhCWKvMRfAeMNYYjCWwom7iCE6HYge
         yCeIuerQeACmZThQiy8QO7C1Uc1K6S1DQnJKcHbcCRfNAsmQWl2ItUMj692FYX0JEa
         WidPt1v+r9lgWif+qvaLagiOUmI67i6js3d11NsoSGo2qeEB6PSWCrmKM4zVORhs89
         41YKv+IxoTnpyWgX1YQkewyqyudCpDdhCboRL2JouQs8evZzWrGQQ3Dyvhnr7Saovm
         m5QmSUKHSmWhWrFnoSYKPFxtjO/Ii4pwW5p58p1lMcnR46IJH6LeHUFUjC1TXtadei
         Ntz/HYtxJ0PWQ==
Message-ID: <722deaed-6595-f6e8-b7d3-348a94719620@kernel.org>
Date:   Sun, 24 Jul 2022 18:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce memory mode
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220620173843.1462198-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220620173843.1462198-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 1:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Introduce memory mode to supports "normal" and "low" memory modes.
> "low" mode is to support low memory devices. Because of the nature of
> low memory devices, in this mode, f2fs will try to save memory sometimes
> by sacrificing performance. "normal" mode is the default mode and same
> as before.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
