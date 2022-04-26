Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3A50ED39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiDZAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDZAPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47B45504;
        Mon, 25 Apr 2022 17:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E616166E;
        Tue, 26 Apr 2022 00:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4623C385A4;
        Tue, 26 Apr 2022 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931924;
        bh=2cinohATxPD5jIOjLzdaNPIP5C9FIyAkI8AzF3YNoaU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iOUDS1uCgZ5NV/o6YT3TLhIpF/e/JOfqlNY+wqwbvekbkOfCGbRdqFAQlNxegWOOr
         3xrDpswREEqCUCQVwldihOvYkz+1z3yMWoYH/ZDXBFE2MBu+6b4L0LX+Easoyi+J/S
         11MIu6JC1QxSpkyxdDm4g8MiKYtDLgirl3T+MDqDCjz3u85UPOu6gYbMgCPkO3+zy/
         D5XBmvavXxSXG+TnKHQTNQCDlDSKznkWpdD9pHcOyGEmwiJg1k5iULEuJndtOyUYCY
         OUxZiJxs0mFMPQEDXHkYLzeRIGNc7Vq3xfmfqO8luOKrctWacHzt1NjguVJA1KNq94
         bQQhhRgTblFoQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-2-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-2-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 01/15] dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Apr 2022 17:12:01 -0700
User-Agent: alot/0.10
Message-Id: <20220426001203.E4623C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:37)
> This patch adds the new binding documentation for system clock
> and functional clock on MediaTek MT8186.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
