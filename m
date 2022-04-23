Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A250C650
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiDWCGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiDWCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:06:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF5392D13;
        Fri, 22 Apr 2022 19:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B06BBB83241;
        Sat, 23 Apr 2022 02:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A40EC385A4;
        Sat, 23 Apr 2022 02:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650679398;
        bh=LyyLXju/U8yIek5c5heUbEsX0vPDdKgnKPoWKhsvV2o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P2A1r6Fc7+VFfyYfl0PKDzul8sxpllOobQa/6M6JIBqd+sui3v/hpDhmodfnj5AQo
         6Zqd7cJk5PwBKXXWl4Sv9Rm5sXTwDABesa67ORguyfNa00p9Fl4xWAFDQN4qNqd1QB
         WUFqh7PpOVjdwahQjnktX0S8VcDDTUA6f2LiNegNRpEwus9CMFOSPKtLeoH/ELFZb6
         hFyfrJHfX9p8xsBwkRR1hxW4u2GqF/lJCJeOXEoEfEbbphKL7LKzaUF6zCDIyYBvUI
         JKJmsqPwjPj/iUJtNLBftpSsPwYUn6jsFDGIjwkOPDuTIy+UBA10G2+C6vGqdq28qc
         682e0KYkapo6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220418110455.2559264-1-chi.minghao@zte.com.cn>
References: <20220418110455.2559264-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] clk: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, mturquette@baylibre.com
Date:   Fri, 22 Apr 2022 19:03:16 -0700
User-Agent: alot/0.10
Message-Id: <20220423020318.6A40EC385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-04-18 04:04:55)
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---

Applied to clk-next
