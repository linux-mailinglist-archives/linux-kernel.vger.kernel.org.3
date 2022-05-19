Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F6C52C899
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiESA1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiESA1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72402106A78;
        Wed, 18 May 2022 17:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 104B36179F;
        Thu, 19 May 2022 00:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A00C385A5;
        Thu, 19 May 2022 00:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920057;
        bh=uLA2B3JdtuKfmczgP+XIweYLbIcpKI/kfdimMYr3uVs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AJb4BTc2uFwAXCCKwPjc1pyzCc66nl82NeqQAY8kya/dCQmC2z1cN4HWCLVXhhlDA
         5ccjPa3h5Fn0spnoWwRE/dLWKAoia77J4LhpogK7XTvPBCMGGjfup0yVol150t+BWn
         ICt3K9fcasYC1oJ2l5nClR+VBQ9wFEeIbZSyhZlCMpUGc2s9KMAQpjl8aO4ujCNqZ6
         c6gCOy82jsApzi0JdaU9bN44pvNfuzYVc4VXRttOu6PvY0/Gl/KKGCPkAjD+o6W7pf
         f18qt6qP6CAr1UYv2GL3D+Iukc1A23brwONtn+bn91JIn+h6c1SoBFg0Y465Z3k7EH
         xDs8evEzH8MlQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220509090939.845-2-sam.shih@mediatek.com>
References: <20220509090939.845-1-sam.shih@mediatek.com> <20220509090939.845-2-sam.shih@mediatek.com>
Subject: Re: [PATCH 1/1] clk: mediatek: update compatible string for MT7986 ethsys
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 18 May 2022 17:27:35 -0700
User-Agent: alot/0.10
Message-Id: <20220519002737.64A00C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2022-05-09 02:09:39)
> Update compatible string of mt7986 ethsys clock driver to fit the
> devicetree bindings document.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Is it=20

Fixes: ec97d23c8e22 ("clk: mediatek: add mt7986 clock support")

?
