Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0564CA7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbiCBOZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCBOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:25:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC26C085C;
        Wed,  2 Mar 2022 06:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 045B2B81F16;
        Wed,  2 Mar 2022 14:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18369C004E1;
        Wed,  2 Mar 2022 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646231097;
        bh=Qv/tJVn7ZbngpF/h/3ssMrEwwL4QaG+fVThe66+ImAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ato+Hb7fhiU8P5IZC5OH0GkTLqv8bglJEfQJP+DHJZPCEH1o/DQFI0C+ITckzOdLB
         Nxukx97EROpYbWSPW/3iA3uh2zjUtaow8ztKuyT13ZQKouyEuxWnlzOILuG89e84km
         jZJ2JoX3tQoX74fq6m9aolY7LBSe5DQkdGbWjjiy78ihtHuNqCv+vtF+8cXd9Bb04n
         IeORHBLvQcWZ4jfH/36fUV1d3aBaCLYe3Ni00ZYJGRlPT80FjI3/4Jc1GDNv+SFy/k
         HIHr8lsKqNeeVKmZm5mR1p0gaIAj/Bop9a7+y/SgiX1hAz4y9HElT3Bj44i1dgwy/S
         it1nx6xDfKM2A==
Date:   Wed, 2 Mar 2022 19:54:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v10 0/4] Rx mode support for Cadence DPHY
Message-ID: <Yh9+Ncc2DulmBpXr@matsya>
References: <20220301111621.2992275-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301111621.2992275-1-p.yadav@ti.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-22, 16:46, Pratyush Yadav wrote:
> Hi,
> 
> This series adds support for Cadence DPHY Rx driver. It has been split
> off from [0] to facilitate easier merging. I have still kept the version
> number to maintain continuity with the previous patches. The earlier
> version used the same binding for Tx and Rx DPHY. With the separate
> driver, I have added a separate binding. But I am still keeping the old
> conversion patch in this series since I have already done the work in
> converting the binding to yaml, might as well get it merged.
> 
> Tested on TI's J721E with OV5640 sensor.

Applied, thanks

-- 
~Vinod
