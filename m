Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5157570BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiGKUay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:30:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B180517;
        Mon, 11 Jul 2022 13:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67E15B810AB;
        Mon, 11 Jul 2022 20:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1599DC34115;
        Mon, 11 Jul 2022 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571274;
        bh=KFfgfdwRrL4GHtkmhwSXYDkk8SgLMJGPbwToeltW0lA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I/fngGt1+pWcPHOtUDae+NDCx2d6oqdGupTpVb8kqKvQD9kzsP4vCcDEjhjGn/9im
         TugGlIbGKrrfrROgzQ92WA6m6vVsNSlb1UpxOCCvX7zkPCKzfu1Nu5KcXswpmUmd/C
         WlKjj0JFudPtGUP3+3Yi3Tg3OY7PTFJ+X+KCMvBPXXBYOyIVD+rrIbAlQRqNhLG+MB
         rtLsee/bsMoen5gLe5fv8ePQDOIFCX0bVnSxIj8//f525g9+AXdtbpe/mglEBXeVDj
         eLAolm5+aVxNb0umyFaKCxbx7e82kho9uOG/zQibvxuR/t0GZr+NpXjnDBV6C/Dhc2
         4/6MTha2ixu+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220505101433.1575096-4-gengcixi@gmail.com>
References: <20220505101433.1575096-1-gengcixi@gmail.com> <20220505101433.1575096-4-gengcixi@gmail.com>
Subject: Re: [PATCH v5 3/4] clk: sprd: Add dt-bindings include file for UMS512
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Cixi Geng <gengcixi@gmail.com>, baolin.wang7@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        mturquette@baylibre.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        zhang.lyra@gmail.com
Date:   Mon, 11 Jul 2022 13:27:52 -0700
User-Agent: alot/0.10
Message-Id: <20220711202754.1599DC34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cixi Geng (2022-05-05 03:14:32)
> From: Cixi Geng <cixi.geng1@unisoc.com>
>=20
> This file defines all UMS512 clock indexes, it should be included in the
> device tree in which there's device using the clocks.
>=20
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next
