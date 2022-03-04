Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD74CD46C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiCDMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiCDMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:45:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5615B3CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:44:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AF36B8244F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D531EC340F0;
        Fri,  4 Mar 2022 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646397857;
        bh=OpQ85b3JAsEhdT+r2q1H5T9vrFCJWeJXydq8Z3mbW3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw+Rh64KF3z/CVNOexYjBsO1YNmGx1ABJ8jBpNd9OFEJo2x3doinDQMTU/QDhxVte
         x7uJjWgOjLI6BdocmPyD97JG8B5CCw77hzXASdzH740LDG/TbtRLtjgkblEAeoDQTD
         ApMCde7tgkrAKLNtGrAgZ049spBfAHMNFFPSWk1qXd/E1VHegjU5GCEQiKrtObdMgM
         e5Q8TJVeUXO/JD3mt450cGJq/EYUHSgDd+GRKNNGMHBh7dA7o+kK2lU1O6m092GigS
         +qizHxZBuMOHvdygKjXpZSw2SvVCjLs6srcnm1N3xwnwyjL6s3A4HiczoN6A/h5LTu
         +iXKgM/ZXLi9Q==
Received: by pali.im (Postfix)
        id 8BF04830; Fri,  4 Mar 2022 13:44:13 +0100 (CET)
Date:   Fri, 4 Mar 2022 13:44:13 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <20220304124413.6glsh4wyooveajku@pali>
References: <20220218212526.16021-1-pali@kernel.org>
 <87o82r0zjh.fsf@BL-laptop>
 <875yoz0wpw.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yoz0wpw.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 February 2022 17:42:03 Gregory CLEMENT wrote:
> Waiting for your confirmation I tried to applied it but it failed.
> 
> Did you base this patch on v5.17-rc1 ?

This patch is based on top of the patch which increase size of IO space
from 64 kB to 1 MB:
https://lore.kernel.org/linux-arm-kernel/878rv95umu.fsf@BL-laptop/

You have wrote that this patch was applied to mvebu/fixes but I do not
see it applied in that branch. So I this is the reason why applying
failed.
