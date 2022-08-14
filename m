Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D16C592002
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiHNOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHNOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C432DFD;
        Sun, 14 Aug 2022 07:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A586260010;
        Sun, 14 Aug 2022 14:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37B4C433D6;
        Sun, 14 Aug 2022 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660486266;
        bh=9shFH31XM8hIAAKc3p+cdv3PxrsibqT5kKAI+7Qh+eM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z60U9uONuwv0QlTtvVbWT7H0C6yGZyCbd14ryoTfYtIbZJQAi+g32Zw2e1i3MHiXT
         XTKcW32jGXRGr1ha8cb/gf6zUsSrJ/vS4yQ8bTEibPRkMboRf+Ex6VO5+rbMop56xR
         HOtX2cVUZYUWCnBr7qWtzkJxhgASu94HgiBKWC7+tVxjGqAJ1NYBW+o5uLJhoE+mGM
         /HnHSUlS3gogs5nJ+7KaSNYk+hL0H1eI06LpSNuc5yPRacuVrNU4iYTBGDRwjPo6V1
         KFa6xl3wfCtsWcEgaNV3evNbDDidAigwW0yhgOVDoPwTAZPSt5kHkR23bGqCxvvXja
         HRhoEr13Vf1Nw==
Date:   Sun, 14 Aug 2022 15:21:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/2] iio: temperature: mlx90632: Add supply regulator
Message-ID: <20220814152135.6ac36cfb@jic23-huawei>
In-Reply-To: <20220808144804.1558849-1-cmo@melexis.com>
References: <20220808144804.1558849-1-cmo@melexis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Aug 2022 16:48:04 +0200
Crt Mori <cmo@melexis.com> wrote:

> Add supply regulator to the sensor as initial update before proper power
> management is presented. This will reduce the diff for the following
> patches.
> 
Hi Crt,

Series applied to what will be the togreg branch of iio.git after I've
rebased on rc1.  Until then pushed out as testing for 0-day to see
if it can find anything we missed.

btw,  your series are not coming through as threads which makes them (slightly)
harder to apply.  For whatever reason the reply-to header field on
the emails isn't set.

Thanks,

Jonathan

> Changes in v3:
> 
>  - Style changes of few more arguments in one line
> 
> Changes in v2:
> 
>  - Regulator voltage was removed as per comments from Jonathan Cameron
>    and Lars-Peter Clausen
>  - Style handling for the error reporting of the regulator DT binding
>    was adjusted
>  - NEW: Delay function was created and grouped together with call from
>    the reset command, to ensure consistency and reduce the amount of
>    code.
> 
> Crt Mori (2):
>   iio: temperature: mlx90632 Add supply regulator to sensor
>   dt-bindings: iio: mlx90632 Add supply regulator documentation
> 
>  .../iio/temperature/melexis,mlx90632.yaml     |  4 ++
>  drivers/iio/temperature/mlx90632.c            | 61 +++++++++++++++++--
>  2 files changed, 60 insertions(+), 5 deletions(-)
> 

