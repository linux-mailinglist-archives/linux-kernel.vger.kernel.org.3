Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FE84BD471
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbiBUDwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:52:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbiBUDwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:52:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E464263D8;
        Sun, 20 Feb 2022 19:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7C29B80E4C;
        Mon, 21 Feb 2022 03:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1073CC340E9;
        Mon, 21 Feb 2022 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645415500;
        bh=OUk4/Yoim2CeD2hyJhADGGMXmo8qoCE8DZiEMBdjUss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVxhuqrWEjk+KhJFJgIpUrPg23bKNbTk/sKTxevAvJDy3+C2AFOMY8CLfVgDRw35k
         EFQpj8ING3ecFBEghVB0jzjyvQnxqbR9cHTUeqGgJKlzWmmvfqCpITRySvXVo0uYfz
         ThVrEjTv4i/dRvVQeRnt7EH63ZLrRGtSufZtY7fY4xuOB3tzKGzSXm2OXO2Pp9zPHx
         srmTr3DUk0aegOzslIk/DzBJdRva4jODLhh+/s6xZqXYHzAtesK1RQqbLSTnBSUWbM
         ijcVdQyXGQbN6gGkTE4hLb206RThkjBjop6/JoAZiy3P3uexHVIsVZwXuIS/+yNHjR
         3aEskPFkPmEWg==
Date:   Mon, 21 Feb 2022 11:51:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: ls1028a: add efuse node
Message-ID: <20220221035134.GH2249@dragon>
References: <20220214115529.662948-1-michael@walle.cc>
 <20220214115529.662948-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214115529.662948-4-michael@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:55:29PM +0100, Michael Walle wrote:
> Layerscape SoCs contain a Security Fuse Processor which is basically a
> efuse controller. Add the node, so userspace can read the efuses.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
