Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8E51B955
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiEEHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiEEHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:45:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F86B19001;
        Thu,  5 May 2022 00:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EFE3CCE2B58;
        Thu,  5 May 2022 07:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4F7C385A4;
        Thu,  5 May 2022 07:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651736483;
        bh=74ezfr/w0KPipHAnnDo94/lRplVZheOxjXtKUicNzPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAS0wwFRvDF+I6bSDns0bzizbwPcGziTroPYUuRL3JtrFwY3XWbcOgwQgT7WqYL+g
         ouWzXy+6Mbq/1QKXygsv6ez/CA+vTJ3Zq9jlqAuN7Ha1jqF+PEwOtrad7GxgChPtv9
         dYqkAjwe3+3HERl07kFwzYzjbT3FNDD58f0zrVBStlhYPT6cIzHkOX8vi/K5KlYENO
         UQGnUtO+3RiquNZ1nPK5p+iHT6H0fNpoY3b/DZvMucSmf3WeSCRl7KKTY7bsFwVRLa
         9N0dmQ3Aj5+FM5Zae8giBmsyEgLB/DHQ4xs0DpPkV+lTHo07buBEKW+bAp27WOxDTM
         WJro4eI4TVa3w==
Date:   Thu, 5 May 2022 15:40:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8m*venice: add missing clock-names to
 pcie_phy
Message-ID: <20220505074059.GA14615@dragon>
References: <20220429161629.8297-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429161629.8297-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:16:29AM -0700, Tim Harvey wrote:
> Define the missing clock-names property for the pcie_phy required by
> the fsl,imx8-pcie-phy dt bindings.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
