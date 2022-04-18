Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68207504D97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiDRINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiDRIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B8165BE;
        Mon, 18 Apr 2022 01:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 999AA61046;
        Mon, 18 Apr 2022 08:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CFC385A7;
        Mon, 18 Apr 2022 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650269450;
        bh=uDVHGLR+7FEpycAkRSMAIJLdA9Ly3JUX4oXF8BJ9DT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHeBUye4vdfRwtzPQJ4TYkf/bvAzXEjzSa7IvjHioLoFfg35jttsgTRjtFabro8lO
         HZVYBvI+BfGQoRAQwKpQHGs5uOavpvR6htUpJhtPjcOSWlakR4u0HGbVFxonIc/OP9
         EDTfP6SvFGHCduqtBqS55QB4YFiasKrwayjj0WB2M4GAX8EiFu86J6YJJ5OtLzI1fU
         0sHy188hcq83WgY7UfhxW9ojQwGNxjpApjDUv6mf9cxJ46TZWcdvd4CnHV7vywoEmT
         sJm1ejpRebKFthFdB5R1+G1oWjG6SixEcD8hNBXBoWJOppNxnV4kTk9vqk7YmHssx4
         vCd+S5+UfsSdQ==
Date:   Mon, 18 Apr 2022 16:10:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v20] arm64: dts: freescale: imx8q: add imx vpu codec
 entries
Message-ID: <20220418081043.GD391514@dragon>
References: <20220411065049.13188-1-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411065049.13188-1-ming.qian@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 02:50:49PM +0800, Ming Qian wrote:
> Add the Video Processing Unit node for IMX8Q SoC.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>

Applied, thanks!
