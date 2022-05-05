Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F051B95E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbiEEHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiEEHq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:46:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E975488A0;
        Thu,  5 May 2022 00:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B62D5B80CF6;
        Thu,  5 May 2022 07:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9576C385A4;
        Thu,  5 May 2022 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651736566;
        bh=6hUW2QEhlICqnm63mEBed3O8GGy+qF3cx5dBJWFHR7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnuWyL1n3Vn+LWGSkAaHn6FG41/jM+MOL2th9LNpIdwZaDbwCXHda7Bu9Ku0lRGVs
         Z4lIgY2B2MrY9d0KnCaJf1FGVN2buFnzeAnZxjjorjJbBzlaZPjMtXX4p5nRcTtkwh
         K5yB5e0nrwoEmM1W3tYg9JXntv6ZNWuFRHFxbundTKHqSREN+hncomqjiDRB/GYnUA
         qHHxpxcFJRQ3ZByjPCfY5YKO/r5zfjBPEKfQOEJz70eBe29eHoytu7kksGv1SXySJe
         NjM4UoMAkE6k9XdChZa2GqNUCmGX3kWErP1YrI/knDK1whZzFq3Aqi/t2slxyTC/Cq
         Bpg+mLNvTNd5w==
Date:   Thu, 5 May 2022 15:42:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7902: add vdd_5p0 ADC channel
Message-ID: <20220505074240.GB14615@dragon>
References: <20220429161944.9403-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429161944.9403-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:19:44AM -0700, Tim Harvey wrote:
> Add missing vdd_5p0 ADC channel for the GW7902 boards.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
