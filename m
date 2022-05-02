Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA04516E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384536AbiEBKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiEBKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591B136;
        Mon,  2 May 2022 03:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F77061251;
        Mon,  2 May 2022 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C2CC385AF;
        Mon,  2 May 2022 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651487604;
        bh=uInsqV5BbF1hPLVD4K6DOp7gnW8sCVYRtV1ONPWaw3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUulD2gXfQRbTqbLi8zEhJCtzft3nldTQw73H5suSvw9gzMU2NixVVr7zd3uOMR0z
         I+lZGawqROAd1Qz5qzuI/OfQuHsTJ+k92FjTZG6088pEIOGHk2kFNPUI5dQxgN45Lr
         fiQBJCUlsbwOwf+GFi5aJ1lTRjltcV5eNSwadh917X5U2ILpNBBQ1Kp5smrcaXnXBY
         5pkBZKEtk21p6aYJ2EJJN9MXGc9ttdL9WVutp1IixBipeZGmLEnP+enq3K2Qy1pcTp
         V6Lsq0voaalT51W4/EQPgePLsSotmVEogyHWuD+1juAAuSZM1fNMwii2QljIEmnpJX
         sDVMRfTetKwmw==
Date:   Mon, 2 May 2022 16:03:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: marvell,armada-3700-utmi-host-phy: Fix
 incorrect compatible in example
Message-ID: <Ym+zb4dUTM8vwgL7@matsya>
References: <20220422192054.2591093-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422192054.2591093-1-robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-22, 14:20, Rob Herring wrote:
> Fix the example using the incorrect compatible string.

Applied, thanks

-- 
~Vinod
