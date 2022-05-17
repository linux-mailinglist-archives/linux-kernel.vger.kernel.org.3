Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208B5299B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiEQGqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiEQGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65684205C7;
        Mon, 16 May 2022 23:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1BD76147F;
        Tue, 17 May 2022 06:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53613C385B8;
        Tue, 17 May 2022 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652769959;
        bh=005Cq1wFvYS3aEWbca+TxQNtYui1BArspQR2qt7J64I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mLWNjEdrU4oTHgBJBK7baKTFX8Kt5UkODV1Cf3lqIuACyULiVt/xhA17MwMUWF87N
         9zSL3rOuDttFBHlqiGlM2SmpGxjEtQF/b2Sb8qMEKUqnzJ3D4EfuEWUpGbf0QiVeOV
         pokEknhi5Aq65O/xw/1VnD/0jFy9ziccj0paDEyHPSeY6bISXbAYHMwC3eygRs7cMj
         YmYLBTEzb89QXz7mQAlyTu+tIzjOQwJduEUJbDEBVwkGASM4EYam6AtUbuF6e3jvg7
         gj0avql0fElJo6BLDiBcZjkpRQ9zY9Bv/epOTsY/FI1pW6Wq5CYPiCgtoNAFi/BpW1
         Jun/6D8tpFuDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220509092102.140520-1-lizhengyu3@huawei.com>
References: <20220509092102.140520-1-lizhengyu3@huawei.com>
Subject: Re: [PATCH] clk: fixed-rate: Remove redundant if statement
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, mturquette@baylibre.com
To:     Li Zhengyu <lizhengyu3@huawei.com>
Date:   Mon, 16 May 2022 23:45:57 -0700
User-Agent: alot/0.10
Message-Id: <20220517064559.53613C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Zhengyu (2022-05-09 02:21:02)
> (np) is always true when (dev || !np) is false, so just remove
> the check.
>=20
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---

Applied to clk-next
