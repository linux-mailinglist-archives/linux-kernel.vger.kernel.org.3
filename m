Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB144D4ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiCJQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242274AbiCJQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:20:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D983265B;
        Thu, 10 Mar 2022 08:18:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8563461B6B;
        Thu, 10 Mar 2022 16:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A64C340E8;
        Thu, 10 Mar 2022 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646929092;
        bh=RL6LWXRaaVwckNt7HfefIcDqliQpIbRJZYvaKxx3k+w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=igtxKHRC+lYvIQv2mKpJ29IQ8z849L4f7oaALvJSIfI0Vo79K8sJiMFKVg3l4n+LT
         Lg7kwiqCGpNxlnoOkLiDtWl7pItY4mIwTPsoGBrAAeOAHOrtIdAENDQfrwhlCMCI1j
         3IgXM9AId4n3F+zo8+0dlUHbNKnTrQA5xZaWVBGi6AtIAl/xknQ+Xl6HB2NlvP0l/O
         bqEpoiOVb8ptq4eRlyfMObNL43eKwE0AG3AKGHZ845hPxI0pUGwzMJRJ1o4tpmpxNx
         /P4s17QgUcDYs6oxYP3jBR+ObB81HFvm5P9HI29z31rP9+L5R8E3cH4ESvV4UCS1xN
         xVMkvAhJOPQNg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: gpio: remove redundant re-assignment of chip->owner
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220303085841.1124766-1-colin.i.king@gmail.com>
References: <20220303085841.1124766-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164692908978.6056.13110647210803354793.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 16:18:11 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.i.king@gmail.com> wrote:

> There are two identical assignments of chip->owner to the same value,
> the second assignment is redundant and can be removed.
> 
> Cleans up cppcheck warning:
> drivers/bcma/driver_gpio.c:184:15: style: Variable 'chip->owner' is
> reassigned a value before the old one has been used. [redundantAssignment]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Patch applied to wireless-next.git, thanks.

857f837d856a bcma: gpio: remove redundant re-assignment of chip->owner

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220303085841.1124766-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

