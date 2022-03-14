Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB04D87AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiCNPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiCNPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:04:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02E63E5DE;
        Mon, 14 Mar 2022 08:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3243B80E27;
        Mon, 14 Mar 2022 15:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E078C340E9;
        Mon, 14 Mar 2022 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647270225;
        bh=TOCa2Y+srhzXpGyLE0cjs/+WyeybMthKurMeliCpKbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iFb+nfJccPcZTK+rrovHHIol8KNikO/3HCWQPdrIy54REM/I9aeoI3ppdx3BVrYDP
         JfLsuKNNziHrIm9ajtjN0XoIBgoGmBPDvMeiKS3q/srl1ny0LJlnJSTHe7r6x+Ameq
         ipyW/YkV2OUq17PtPpZatHzddaMHMpMv/Oaipkn8=
Date:   Mon, 14 Mar 2022 16:03:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     johan@kernel.org, elder@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        elder@ieee.org
Subject: Re: [PATCH v4] staging: greybus: introduce pwm_ops::apply
Message-ID: <Yi9ZTdcZsdDjecC3@kroah.com>
References: <1646791174-30557-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646791174-30557-1-git-send-email-chensong_2000@189.cn>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:59:34AM +0800, Song Chen wrote:
> Introduce newer .apply function in pwm_ops to
> replace legacy operations,like enable, disable,
> config and set_polarity.

You can use the full 72 columns please.

> This guarantees atomic changes of the pwm
> controller configuration and also reduces the
> size of the driver.

The driver is bigger (more lines) with this change, so why do you say it
is smaller?

thanks,

greg k-h
