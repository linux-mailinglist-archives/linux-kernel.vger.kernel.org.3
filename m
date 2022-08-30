Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0395A6F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiH3VV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiH3VVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3076763
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB343618AC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E18C433D6;
        Tue, 30 Aug 2022 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661894483;
        bh=7xaKDiojYzx9iBHJXJylC/t0ZCDarTRURXqPZlbq7h8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WEpTPO0Q81zt/qmL/JRvXRVfdpPxoMIeq3E8aMeqgKlRlEti7LH+Dk37pGFW4GhLQ
         osK1hi3raC2EAe8RYfFArFE0SoiD11HyaMfL6Ousxebap5lt90pISgY0+SH+9gqV2u
         Nmqd+5x6C8s5VBqAT/iBa9JpPWsI27QEyki1ILliPnZDijyVDV/GIFBzmXWP7KLq+R
         0oiCjCzRqpYs9Z/ff+XvCJbQs1e5DswfooV39Xp9pf6R5gP81xxaZCDnSHkNBXUBWn
         FItwH41G7BGZBY/TLkQ7oDG52gsjvaoW4++qVpg6iBeDUMiYXFMu+7jjV+QAGX9sli
         /ySjD8GY0LZtg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220527071338.2359733-1-liuke94@huawei.com>
References: <20220527071338.2359733-1-liuke94@huawei.com>
Subject: Re: [PATCH] drivers: spmi: Directly use ida_alloc()/free()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     keliu <liuke94@huawei.com>
To:     keliu <liuke94@huawei.com>, linux-kernel@vger.kernel.org
Date:   Tue, 30 Aug 2022 14:21:21 -0700
User-Agent: alot/0.10
Message-Id: <20220830212123.26E18C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting keliu (2022-05-27 00:13:38)
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
>=20
> Signed-off-by: keliu <liuke94@huawei.com>
> ---

Applied to spmi-next
